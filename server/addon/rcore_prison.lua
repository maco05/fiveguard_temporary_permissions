if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcorePrison == true then
    RegisterServerEvent("rcore_prison:enabletemppermissions")
    AddEventHandler("rcore_prison:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassFreecam",
                true,
                false
            )
        end
    end)

    RegisterServerEvent("rcore_prison:disabletemppermissions")
    AddEventHandler("rcore_prison:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassFreecam",
                false,
                false
            )
        end
    end)
end