for key, Cfg in pairs(Config) do
    if type(Cfg) == "table" and Cfg.NameOfScript and Cfg.EventForStarting and Cfg.EventForStopping then
        AddEventHandler(Cfg.NameOfScript .. ":" .. Cfg.EventForStarting, function(...)
            if Cfg.Debug then
                print("[DEBUG] Starting event triggered for resource:", Cfg.NameOfScript)
            end
            TriggerServerEvent(Cfg.NameOfScript .. ":enabletemppermissions")
        end)

        AddEventHandler(Cfg.NameOfScript .. ":" .. Cfg.EventForStopping, function(...)
            if Cfg.Debug then
                print("[DEBUG] Stopping event triggered for resource:", Cfg.NameOfScript)
            end
            TriggerServerEvent(Cfg.NameOfScript .. ":disabletemppermissions")
        end)
    end
end
