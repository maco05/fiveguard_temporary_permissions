if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RTXThemePark == true then
    RegisterServerEvent("rtx_themepark:enabletemppermissions")
    AddEventHandler("rtx_themepark:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassNoclip",
            true,
            false
        )
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Misc",
            "BypassSpoofedWeapons",
            true,
            false
        )

        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Vehicle",
            "BypassBulletproofTires",
            true,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RTXThemePark == false then
end