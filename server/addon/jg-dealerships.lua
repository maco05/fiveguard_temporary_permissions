if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGDealerships == true then
    RegisterServerEvent("jg-dealerships:enabletemppermissions")
    AddEventHandler("jg-dealerships:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassInvisible",
                true,
                false
            )
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassTeleport",
                true,
                false
            )
        end
    end)

    RegisterServerEvent("jg-dealerships:disabletemppermissions")
    AddEventHandler("jg-dealerships:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassInvisible",
                false,
                false
            )
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassTeleport",
                false,
                false
            )
        end
    end)
end