AddEventHandler("lunar_garage:lunar_garage:setVehicleProperties", function()
    TriggerServerEvent("lunar_garage:enabletemppermissions")
end)

AddEventHandler("lunar_garage:lunar_garage:takeOutVehicle", function()
    Wait(5000)
    TriggerServerEvent("lunar_garage:disabletemppermissions")
end)