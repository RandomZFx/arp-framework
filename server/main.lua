------------------------------------------------------------
-- 登入
------------------------------------------------------------
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local identifier
    deferrals.defer()

    for _, id in ipairs(identifiers) do 
        if string.match(id, 'steam:') then
            identifier = id
            break
        end
    end

    Wait(0)

    if not identifier then
        deferrals.done('您尚未連接到Steam')
    else
        deferrals.done()
        PlayerJoin(source)
    end
end)

------------------------------------------------------------
-- 註冊 Steam
------------------------------------------------------------
function PlayerJoin(playerId)
    local identifier

    for _, id in ipairs(GetPlayerIdentifiers(playerId)) do 
        if string.match(id, 'steam:') then
            identifier = id 
            break
        end
    end

    if identifier then
        MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result then
            else
                MySQL.Async.execute('INSERT INTO users (identifier) VALUES (@identifier)', {
                    ['@identifier'] = identifier
                })
            end
        end)
    end
end

------------------------------------------------------------
-- 紀錄玩家位置/生成
------------------------------------------------------------
RegisterServerEvent('ARP:UpdatePosition')
AddEventHandler('ARP:UpdatePosition', function(PosX, PosY, PosZ)
    MySQL.Async.execute('UPDATE users SET position = @position WHERE identifier = @identifier', {
        ['@identifier'] = GetPlayerIdentifier(source),
        ['@position'] = '{' .. PosX .. ', ' .. PosY .. ', ' .. PosZ .. '}',
    })
end)

RegisterServerEvent('ARP:SpawnPlayer')
AddEventHandler('ARP:SpawnPlayer', function()
    local source = source
    MySQL.Async.fetchScalar('SELECT position FROM users WHERE identifier = @identifier', {
        ['@identifier'] = GetPlayerIdentifier(source),
    }, function(result)
        if result then
            local Spawnpos = json.decode(result)
            TriggerClientEvent('ARP:lastPosition', source, Spawnpos[1], Spawnpos[2], Spawnpos[3])
        end
    end)
end)