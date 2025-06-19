local currentResourceName = GetCurrentResourceName()

if currentResourceName == "fiveguard_temporary_permissions" then
    Citizen.CreateThread(function()
        Wait(120000)
        print("\27[31m[FIVEGUARD WARNING]: Your resource name is 'fiveguard_temporary_permissions'. Please change it to something less obvious!\27[0m")
    end)
end

local function getPlayerIdentifiers(src)
    local identifiers = {
        steam = "N/A",
        discord = "N/A",
        license = "N/A"
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if id:find("steam:") then
            identifiers.steam = id
        elseif id:find("discord:") then
            identifiers.discord = "<@" .. id:gsub("discord:", "") .. ">"
        elseif id:find("license:") then
            identifiers.license = id
        end
    end

    return identifiers
end

local function sendToDiscord(webhookURL, title, message, color, footer)
    if not webhookURL or webhookURL == false or webhookURL == "false" then return end

    local embed = {{
        ["title"] = title,
        ["description"] = message,
        ["color"] = color or 16753920,
        ["footer"] = {
            ["text"] = footer or "FiveGuard Permissions Logger"
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(webhookURL, function() end, "POST", json.encode({
        username = "FiveGuard Logger",
        embeds = embed
    }), {
        ["Content-Type"] = "application/json"
    })
end

local function isEmpty(value)
    return value == nil or value == ""
end

local requiredFields = {
    "NameOfScript", "EventForStarting", "EventForStopping", "Category", "Permission"
}

Citizen.CreateThread(function()
    Wait(1000)

    for key, cfg in pairs(Config) do
        if key ~= "FiveguardName" then
            if type(cfg) == "table" then
                local hasError = false

                for _, field in ipairs(requiredFields) do
                    if isEmpty(cfg[field]) then
                        print(("\27[31m[FIVEGUARD CONFIG ERROR]: '%s' is missing in section '%s'\27[0m"):format(field, key))
                        hasError = true
                    end
                end

                if not hasError then
                    local fiveguardName = Config.FiveguardName or "fiveguard"
                    local webhook = cfg.Webhook or false

                    RegisterServerEvent(cfg.NameOfScript .. ":enabletemppermissions")
                    AddEventHandler(cfg.NameOfScript .. ":enabletemppermissions", function()
                        local src = source
                        local name = GetPlayerName(src) or "Unknown"
                        local ids = getPlayerIdentifiers(src)

                        exports[fiveguardName]:SetTempPermission(
                            src,
                            cfg.Category,
                            cfg.Permission,
                            true,
                            cfg.IgnoreStaticPermissions
                        )

                        sendToDiscord(
                            webhook,
                            "🟢 Temporary Permission Granted",
                            ("**Player:** %s\n**Steam:** `%s`\n**Discord:** %s\n**License:** `%s`\n\n**Permission:** `%s`\n**Category:** `%s`\n**Action:** Granted Temporary Access")
                                :format(name, ids.steam, ids.discord, ids.license, cfg.Permission, cfg.Category),
                            65280
                        )

                        if cfg.Debug then
                            print(("[DEBUG] Granted %s:%s to %s (%d)"):format(cfg.Category, cfg.Permission, name, src))
                        end
                    end)

                    RegisterServerEvent(cfg.NameOfScript .. ":disabletemppermissions")
                    AddEventHandler(cfg.NameOfScript .. ":disabletemppermissions", function()
                        local src = source
                        local name = GetPlayerName(src) or "Unknown"
                        local ids = getPlayerIdentifiers(src)

                        exports[fiveguardName]:SetTempPermission(
                            src,
                            cfg.Category,
                            cfg.Permission,
                            false,
                            cfg.IgnoreStaticPermissions
                        )

                        sendToDiscord(
                            webhook,
                            "🔴 Temporary Permission Revoked",
                            ("**Player:** %s\n**Steam:** `%s`\n**Discord:** %s\n**License:** `%s`\n\n**Permission:** `%s`\n**Category:** `%s`\n**Action:** Revoked Temporary Access")
                                :format(name, ids.steam, ids.discord, ids.license, cfg.Permission, cfg.Category),
                            16711680
                        )

                        if cfg.Debug then
                            print(("[DEBUG] Revoked %s:%s from %s (%d)"):format(cfg.Category, cfg.Permission, name, src))
                        end
                    end)
                end
            else
                print(("\27[33m[FIVEGUARD CONFIG WARNING]: Section '%s' is not a valid table!\27[0m"):format(tostring(key)))
            end
        end
    end
end)
