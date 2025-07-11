for key, Cfg in pairs(Config) do
    if type(Cfg) == "table" and Cfg.EventPrefix and Cfg.EventForStarting and Cfg.EventForStopping then
        AddEventHandler(Cfg.EventPrefix .. ":" .. Cfg.EventForStarting, function(...)
            if Cfg.Debug then
                print("[DEBUG] Starting event triggered for resource:", Cfg.EventPrefix)
            end
            TriggerServerEvent(Cfg.EventPrefix .. ":enabletemppermissions")
            if Cfg.RecordScreen then
                TriggerServerEvent(Cfg.EventPrefix .. ":startScreenRecording", Cfg.RecordScreenDuration, Cfg.RecordScreenWebhook)
                if Cfg.Debug then
                    print("[DEBUG] Screen recording started for", Cfg.RecordScreenDuration, "seconds.")
                end
            end
        end)

        AddEventHandler(Cfg.EventPrefix .. ":" .. Cfg.EventForStopping, function(...)
            if Cfg.Debug then
                print("[DEBUG] Stopping event triggered for resource:", Cfg.EventPrefix)
            end

            if Cfg.WaitForStopping and tonumber(Cfg.WaitForStopping) and tonumber(Cfg.WaitForStopping) > 0 then
                if Cfg.Debug then
                    print("[DEBUG] Waiting for", tonumber(Cfg.WaitForStopping), "second(s) before disabling permissions.")
                end
                Citizen.Wait(tonumber(Cfg.WaitForStopping) * 1000)
            end

            TriggerServerEvent(Cfg.EventPrefix .. ":disabletemppermissions")
        end)
    end
end
