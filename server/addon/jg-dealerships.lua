if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGDealerships == true then
    RegisterServerEvent("jg-dealerships:enabletemppermissions")
    AddEventHandler("jg-dealerships:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassInvisible",
            true,
            false
        )
         exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassTeleport",
            true,
            false
        )
    end)

    RegisterServerEvent("jg-dealerships:disabletemppermissions")
    AddEventHandler("jg-dealerships:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassInvisible",
            false,
            false
        )
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassTeleport",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.JGDealerships == false then
end