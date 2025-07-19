if Config.RcoreLunarPark == true then

    RegisterServerEvent("rcore_lunarpark:enabletemppermissions")
    AddEventHandler("rcore_lunarpark:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassNoclip",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("rcore_lunarpark:disabletemppermissions")
    AddEventHandler("rcore_lunarpark:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassNoclip",
            false,
            false
        )
    end)
end

if Config.RcoreLunarPark == false then
end    
