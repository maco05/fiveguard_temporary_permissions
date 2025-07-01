if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGAdvancedGarages == true then
    RegisterServerEvent("jg-adcancedgarages:enabletemppermissions")
    AddEventHandler("jg-adcancedgarages:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassVehicleModifier",
            true,
            false
        )
    end)

    RegisterServerEvent("jg-adcancedgarages:disabletemppermissions")
    AddEventHandler("jg-adcancedgarages:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassVehicleModifier",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGAdvancedGarages == false then
end