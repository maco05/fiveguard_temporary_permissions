AddEventHandler(Config.NameOfScript .. ":" .. Config.EventForStarting, function()
    if Config.Debug then
        print("[DEBUG] Starting event triggered for resource:", Config.NameOfScript)
    end
    TriggerServerEvent(Config.NameOfScript .. ":enabletemppermissions")
end)

AddEventHandler(Config.NameOfScript .. ":" .. Config.EventForStopping, function()
    if Config.Debug then
        print("[DEBUG] Stopping event triggered for resource:", Config.NameOfScript)
    end
    TriggerServerEvent(Config.NameOfScript .. ":disabletemppermissions")
end)
