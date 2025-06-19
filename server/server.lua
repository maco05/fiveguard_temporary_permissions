local currentResourceName = GetCurrentResourceName()

if currentResourceName == "fiveguard_temporary_permissions" then
    Citizen.CreateThread(function()
        Wait(120000)
        print("\27[31m[FIVEGUARD WARNING]: Your resource name is 'fiveguard_temporary_permissions'. Please change it to something less obvious!\27[0m")
    end)
end

local function isEmpty(value)
    return value == nil or value == ""
end

local requiredFields = {
    "NameOfScript",
    "EventForStarting",
    "EventForStopping",
    "Category",
    "Permission"
}

Citizen.CreateThread(function()
    Wait(120000)

    for key, cfg in pairs(Config) do
        if key ~= "FiveguardName" then
            if type(cfg) == "table" then
                local hasError = false

                for _, field in ipairs(requiredFields) do
                    if isEmpty(cfg[field]) then
                        print(string.format(
                            "\27[31m[FIVEGUARD CONFIG ERROR]: '%s' is not set properly in section '%s'!\27[0m",
                            field, key
                        ))
                        hasError = true
                    end
                end

                if not hasError then
                    local fiveguardName = Config.FiveguardName or "fiveguard"

                    RegisterServerEvent(cfg.NameOfScript .. ":enabletemppermissions")
                    AddEventHandler(cfg.NameOfScript .. ":enabletemppermissions", function()
                        local src = source
                        exports[fiveguardName]:SetTempPermission(
                            src,
                            cfg.Category,
                            cfg.Permission,
                            true,
                            cfg.IgnoreStaticPermissions
                        )
                    end)

                    RegisterServerEvent(cfg.NameOfScript .. ":disabletemppermissions")
                    AddEventHandler(cfg.NameOfScript .. ":disabletemppermissions", function()
                        local src = source
                        exports[fiveguardName]:SetTempPermission(
                            src,
                            cfg.Category,
                            cfg.Permission,
                            false,
                            cfg.IgnoreStaticPermissions
                        )
                    end)
                end
            else
                print(string.format(
                    "\27[33m[FIVEGUARD CONFIG WARNING]: Section '%s' is not a valid config table!\27[0m",
                    tostring(key)
                ))
            end
        end
    end
end)
