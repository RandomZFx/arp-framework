------------------------------------------------------------
-- Delete Vehicle
------------------------------------------------------------
RegisterCommand("dv", function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)

        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)

            if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent('ARP_Core:UpdateVehicleStatu', plate)
                DeleteEntity(vehicle)
                ARP.Notify("The vehicle has been ~g~ successful ~s~ towed!")
            else 
                ARP.Notify("You ~r~ must ~s~ in the driver's seat!")
            end
        else
        ARP.Notify("You ~r~ must ~s~s sit in the car!")
        end 
    end
end, false)
