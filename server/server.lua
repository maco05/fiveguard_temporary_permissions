local currentResourceName = GetCurrentResourceName()

if currentResourceName == "fiveguard_temporary_permissions" then
    Wait(120000)
    print("\27[31m[FIVEGUARD WARNING]: Your resource name is 'fiveguard_temporary_permissions'. Please change it to something less obvious!\27[0m")
end

RegisterServerEvent(Config.NameOfScript .. ":enabletemppermissions")
AddEventHandler(Config.NameOfScript .. ":enabletemppermissions", function()
    local src = source
    exports[Config.FiveguardName]:SetTempPermission(
        src,                -- Player source
        Config.Category,    -- Category
        Config.Permission,  -- Permission
        true,               -- Allow?
        Config.IgnoreStaticPermissions               -- Ignore static permissions
    )
end)

RegisterServerEvent(Config.NameOfScript .. ":disabletemppermissions")
AddEventHandler(Config.NameOfScript .. ":disabletemppermissions", function()
    local src = source
    exports[Config.FiveguardName]:SetTempPermission(
        src,                -- Player source
        Config.Category,    -- Category
        Config.Permission,  -- Permission
        false,              -- Allow?
        Config.IgnoreStaticPermissions               -- Ignore static permissions
    )
end)
