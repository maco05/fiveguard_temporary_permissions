if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreLunarPark == true then
    RegisterServerEvent("rcore_lunarpark:enabletemppermissions")
    AddEventHandler("rcore_lunarpark:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassNoclip",
            true,
            false
        )
    end)

    RegisterServerEvent("rcore_lunarpark:disabletemppermissions")
    AddEventHandler("rcore_lunarpark:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassNoclip",
            false,
            false
        )
    end)
end

if type(Config.PreconfiguredPermissions) == "table" and Config.PreconfiguredPermissions.RcoreLunarPark == false then
end