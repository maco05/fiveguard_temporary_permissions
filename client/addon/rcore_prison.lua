AddEventHandler("rcore_prison:server:prologStarted", function(playerId)
    TriggerServerEvent("rcore_prison:enabletemppermissions")
end)

AddEventHandler("rcore_prison:server:prologFinished", function(playerId)
    TriggerServerEvent("rcore_prison:disabletemppermissions")
end)