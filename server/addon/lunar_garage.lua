if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.LunarGarage == true then
    RegisterServerEvent("lunar_garage:enabletemppermissions")
    AddEventHandler("lunar_garage:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Vehicle",
                "BypassVehiclePlateChanger",
                true,
                false
            )
        end
    end)

    RegisterServerEvent("lunar_garage:disabletemppermissions")
    AddEventHandler("lunar_garage:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Vehicle",
                "BypassVehiclePlateChanger",
                false,
                false
            )
        end
    end)
end