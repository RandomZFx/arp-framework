------------------------------------------------------------
-- Inventory
------------------------------------------------------------
local inventory = {}

RegisterNetEvent('ARP_Core:InentoryMenu')
AddEventHandler('ARP_Core:InentoryMenu', function(items)
    for i = 1, #inventory do 
        table.remove(inventory, i)
    end
    Citizen.Wait(10)

    table.insert(inventory, items)
end)

------------------------------------------------------------
-- Inventory Menu
------------------------------------------------------------
RMenu.Add('Intmenu', 'main', RageUI.CreateMenu('Backpack', 'Backpack Menu'))
local IntMenu = {
    action = {
        'Give',
        'Throw away'
    },
    list = 1,
}

RageUI.CreateWhile(1.0, RMenu:Get('Intmenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('Intmenu', 'main'), true, true, true, function()
        for _, item in pairs(inventory) do 
            RageUI.List(item, IntMenu.action, IntMenu.list, nil, {}, true, function(hovered, active, selected, index)
                if selected then
                    if index == 1 then
                        local clsped, distance = ARP.GetClosestPlayer()
                        if (distance ~= -1 and distance < 5) then
                            TriggerServerEvent('ARP_Core:GiveInventory', clsped, item)
                        else
                            ARP.Notify('~r~ no ~s~ players nearby')
                        end
                    elseif index == 2 then
                        TriggerServerEvent('ARP_Core:ThrowInventory', item)
                    end
                end
                IntMenu.list = index
            end)
        end
    end, function()
    end)
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if IsControlJustReleased(0, 289) then
            RageUI.Visible(RMenu:Get('Intmenu', 'main'), not RageUI.Visible(RMenu:Get('Intmenu', 'main')))
            TriggerServerEvent('ARP_Core:LoadInventory')
        end
    end
end)
