if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.LunarGarage == true then
    RegisterServerEvent("lunar_garage:enabletemppermissions")
    AddEventHandler("lunar_garage:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassVehiclePlateChanger",
            true,
            false
        )
    end)

    RegisterServerEvent("lunar_garage:disabletemppermissions")
    AddEventHandler("lunar_garage:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassVehiclePlateChanger",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.LunarGarage == false then
end