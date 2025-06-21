AddEventHandler("rcore_prison:server:prologStarted", function()
    TriggerServerEvent("rcore_prison:enabletemppermissions")
end)

AddEventHandler("rcore_prison:server:prologFinished", function()
    TriggerServerEvent("rcore_prison:disabletemppermissions")
end)