if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcorePrison == true then
    RegisterServerEvent("rcore_prison:enabletemppermissions")
    AddEventHandler("rcore_prison:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassFreecam",
            true,
            false
        )
    end)

    RegisterServerEvent("rcore_prison:disabletemppermissions")
    AddEventHandler("rcore_prison:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassFreecam",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcorePrison == false then
end