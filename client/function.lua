ARP = {}

------------------------------------------------------------
-- 3D 文字
------------------------------------------------------------
function ARP.Draw3DTxt(x, y, z, r, g, b, text)
    SetTextScale(0.4, 0.4)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

RegisterNetEvent('ARP:Draw3DTxt')
AddEventHandler('ARP:Draw3DTxt', function(x, y, z, r, g, b, text)  
    ARP.Draw3DTxt(x, y, z, r, g, b, text)
end)

------------------------------------------------------------
-- 通知
------------------------------------------------------------
function ARP.Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(true, true)
end

RegisterNetEvent('ARP:Notify')
AddEventHandler('ARP:Notify', function(text)  
    ARP.Notify(text)
end)

------------------------------------------------------------
-- 物品庫
------------------------------------------------------------
function ARP.GiveInventory(item)
    TriggerServerEvent('ARP:UpdataInventory', tiem)
end