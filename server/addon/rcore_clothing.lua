if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreClothing == true then
    RegisterServerEvent("rcore_clothing:enabletemppermissions")
    AddEventHandler("rcore_clothing:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassStealOutfit", true, false)
        end
    end)

    RegisterServerEvent("rcore_clothing:disabletemppermissions")
    AddEventHandler("rcore_clothing:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassStealOutfit", false, false)
        end
    end)
end
