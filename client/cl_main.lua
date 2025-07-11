for key, Cfg in pairs(Config) do
    if type(Cfg) == "table" and Cfg.NameOfScript and Cfg.EventForStarting and Cfg.EventForStopping then
        AddEventHandler(Cfg.NameOfScript .. ":" .. Cfg.EventForStarting, function(...)
            if Cfg.Debug then
                print("[DEBUG] Starting event triggered for resource:", Cfg.NameOfScript)
            end
            TriggerServerEvent(Cfg.NameOfScript .. ":enabletemppermissions")
            if Cfg.RecordScreen then
                TriggerServerEvent(Cfg.NameOfScript .. ":startScreenRecording", Cfg.RecordScreenDuration, Cfg.RecordScreenWebhook)
                if Cfg.Debug then
                    print("[DEBUG] Screen recording started for", Cfg.RecordScreenDuration, "seconds.")
                end
            end
        end)

        AddEventHandler(Cfg.NameOfScript .. ":" .. Cfg.EventForStopping, function(...)
            if Cfg.Debug then
                print("[DEBUG] Stopping event triggered for resource:", Cfg.NameOfScript)
            end

            if Cfg.WaitForStopping and tonumber(Cfg.WaitForStopping) and tonumber(Cfg.WaitForStopping) > 0 then
                if Cfg.Debug then
                    print("[DEBUG] Waiting for", tonumber(Cfg.WaitForStopping), "second(s) before disabling permissions.")
                end
                Citizen.Wait(tonumber(Cfg.WaitForStopping) * 1000)
            end

            TriggerServerEvent(Cfg.NameOfScript .. ":disabletemppermissions")
        end)
    end
end
