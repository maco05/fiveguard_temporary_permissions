if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.WasabiPolice == true then
    RegisterServerEvent("wasabi_police:enabletemppermissions")
    AddEventHandler("wasabi_police:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassInvisible", true, false)
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassTeleport", true, false)
        end
    end)

    RegisterServerEvent("wasabi_police:disabletemppermissions")
    AddEventHandler("wasabi_police:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassInvisible", false, false)
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassTeleport", false, false)
        end
    end)
end
