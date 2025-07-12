AddEventHandler("jg-advancedgarages:client:open-garage", function()
    TriggerServerEvent("jg-advancedgarages:enabletemppermissions")
end)

AddEventHandler("jg-advancedgarages:client:store-vehicle", function()
    TriggerServerEvent("jg-advancedgarages:disabletemppermissions")
end)