if Config.RcorePrison == true then

    RegisterServerEvent("rcore_prison:enabletemppermissions")
    AddEventHandler("rcore_prison:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassFreecam",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("rcore_prison:disabletemppermissions")
    AddEventHandler("rcore_prison:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassFreecam",
            false,
            false
        )
    end)
end

if Config.RcorePrison == false then
end    
