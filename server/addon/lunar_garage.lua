if Config.LunarGarage == true then

    RegisterServerEvent("lunar_garage:enabletemppermissions")
    AddEventHandler("lunar_garage:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Vehicle",                    -- Category
            "BypassVehiclePlateChanger",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("lunar_garage:disabletemppermissions")
    AddEventHandler("lunar_garage:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Vehicle",                    -- Category
            "BypassVehiclePlateChanger",         -- Permission
            false,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)
end

if Config.LunarGarage == false then
end    
