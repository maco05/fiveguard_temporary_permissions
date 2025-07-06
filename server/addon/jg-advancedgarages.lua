if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGAdvancedGarages == true then
    RegisterServerEvent("jg-advancedgarages:enabletemppermissions")
    AddEventHandler("jg-advancedgarages:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassVehicleModifier",
            true,
            false
        )
    end)

    RegisterServerEvent("jg-advancedgarages:disabletemppermissions")
    AddEventHandler("jg-advancedgarages:disabletemppermissions", function()
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