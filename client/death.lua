------------------------------------------------------------
-- Death
------------------------------------------------------------
IsDead = false
local seconds = 150

function IsPedDeath()
    TriggerServerEvent('ARP_Core:UpdateDeath', IsDead)
    local player = GetEntityCoords(PlayerPedId())
	if seconds > 1 then 
        ARP.Draw3DTxt(player.x, player.y, player.z, 255, 255, 255, '~w~You are dead! and also ~r~' .. seconds .. '~w~ Can be resurrected in seconds')
	end
   	if seconds < 1 then 
        ARP.Draw3DTxt(player.x, player.y, player.z, 255, 255, 255, '~w~Press ~w~[~r~E~w~] Revival')
    end 
    if IsControlJustReleased(1, 38) and seconds < 1 then 
        local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
        IsDead = false
        DoScreenFadeOut(1500)
        Citizen.Wait(1500)
        NetworkResurrectLocalPlayer(playerPos, true, true, false)
        SetPlayerInvincible(GetPlayerPed(-1), false)
        ClearPedBloodDamage(GetPlayerPed(-1))
        SetEntityHealth(GetPlayerPed(-1), 200) 
        DoScreenFadeIn(1500)
        seconds = 150
        TriggerServerEvent('ARP_Core:UpdateDeath', IsDead)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if seconds > 0 and IsDead == true then 
            seconds = seconds -1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local health = GetEntityHealth(GetPlayerPed(-1))
        if health < 2 then
            IsDead = true  
        end
        if IsDead == true then
            exports.spawnmanager:setAutoSpawn(false)                
            IsPedDeath()         
 	    end
	end
end)

------------------------------------------------------------
-- Death when Offline
------------------------------------------------------------
RegisterNetEvent('ARP_Core:PlayerIsDead')
AddEventHandler('ARP_Core:PlayerIsDead', function()
    ARP.Notify('You are offline during ~r~ death ~w~, please call ~g~ medical staff')
    SetEntityHealth(GetPlayerPed(-1), 0)
end)
