if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RTXThemePark == true then
    RegisterServerEvent("rtx_themepark:enabletemppermissions")
    AddEventHandler("rtx_themepark:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == 'function' then
            exports[Fiveguard]:SetTempPermission(
                src,
                "Client",
                "BypassNoclip",
                true,
                false
            )
            exports[Fiveguard]:SetTempPermission(
                src,
                "Misc",
                "BypassSpoofedWeapons",
                true,
                false
            )
            exports[Fiveguard]:SetTempPermission(
                src,
                "Vehicle",
                "BypassBulletproofTires",
                true,
                false
            )
        end
    end)
end