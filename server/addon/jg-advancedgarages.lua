if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGAdvancedGarages == true then
    RegisterServerEvent("jg-advancedgarages:enabletemppermissions")
    AddEventHandler("jg-advancedgarages:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Vehicle",
                "BypassVehicleModifier",
                true,
                false
            )
        end
    end)

    RegisterServerEvent("jg-advancedgarages:disabletemppermissions")
    AddEventHandler("jg-advancedgarages:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Vehicle",
                "BypassVehicleModifier",
                false,
                false
            )
        end
    end)
end