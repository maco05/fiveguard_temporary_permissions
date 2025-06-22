if Config.JGAdvancedGarages == true then

    RegisterServerEvent("jg-dealerships:enabletemppermissions")
    AddEventHandler("jg-dealerships:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Vehicle",                    -- Category
            "BypassVehicleModifier",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("jg-dealerships:disabletemppermissions")
    AddEventHandler("jg-dealerships:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Vehicle",                    -- Category
            "BypassVehicleModifier",         -- Permission
            false,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)
end

if Config.JGAdvancedGarages == false then
end    
