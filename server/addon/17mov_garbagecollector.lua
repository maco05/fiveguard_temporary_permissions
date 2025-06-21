if Config.GarbageCollector == true then

    RegisterServerEvent("17mov_GarbageCollector:enabletemppermissions")
    AddEventHandler("17mov_GarbageCollector:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Misc",                    -- Category
            "BypassClearTasks",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("17mov_GarbageCollector:disabletemppermissions")
    AddEventHandler("17mov_GarbageCollector:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Misc",                    -- Category
            "BypassClearTasks",         -- Permission
            false,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)
end

if Config.GarbageCollector == false then
end    
