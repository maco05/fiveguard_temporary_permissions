if Config.WasabiPolice == true then

    RegisterServerEvent("wasabi_police:enabletemppermissions")
    AddEventHandler("wasabi_police:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassTeleport",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("wasabi_police:disabletemppermissions")
    AddEventHandler("wasabi_police:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassTeleport",         -- Permission
            false,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)
end

if Config.WasabiPolice == false then
end    
