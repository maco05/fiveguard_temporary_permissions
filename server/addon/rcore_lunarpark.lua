if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreLunarPark == true then
    RegisterServerEvent("rcore_lunarpark:enabletemppermissions")
    AddEventHandler("rcore_lunarpark:enabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassNoclip", true, false)
        end
    end)

    RegisterServerEvent("rcore_lunarpark:disabletemppermissions")
    AddEventHandler("rcore_lunarpark:disabletemppermissions", function()
        local src = source
        if Fiveguard and exports[Fiveguard] and type(exports[Fiveguard].SetTempPermission) == "function" then
            exports[Fiveguard]:SetTempPermission(src, "Client", "BypassNoclip", false, false)
        end
    end)
end
