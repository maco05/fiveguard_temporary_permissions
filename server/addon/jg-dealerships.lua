if Config.JGDealerships == true then

    RegisterServerEvent("jg-dealerships:enabletemppermissions")
    AddEventHandler("jg-dealerships:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassInvisible",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
         exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassTeleport",
            true,
            false
        )
    end)

    RegisterServerEvent("jg-dealerships:disabletemppermissions")
    AddEventHandler("jg-dealerships:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassInvisible",         -- Permission
            false,                        -- Allow?
            false                        -- Ignore static permissions
        )
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassTeleport",
            false,
            false
        )
    end)
end

if Config.JGDealerships == false then
end    
