if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreClothing == true then
    RegisterServerEvent("rcore_clothing:enabletemppermissions")
    AddEventHandler("rcore_clothing:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassStealOutfit",
            true,
            false
        )
    end)

    RegisterServerEvent("rcore_clothing:disabletemppermissions")
    AddEventHandler("rcore_clothing:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassStealOutfit",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreClothing == false then
end