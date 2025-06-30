---@return string | nil
local function getFiveguardName()
    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        local files = GetNumResourceMetadata(resource, 'ac')
        for j = 0, files, 1 do
            local x = GetResourceMetadata(resource, 'ac', j)
            if x and string.find(x, "fg") then
                return resource
            end
        end
    end
    return nil
end

if Config.FiveguardName == "auto" then
    Config.FiveguardName = getFiveguardName()

    if not Config.FiveguardName then
        local attempts = 0
        while not Config.FiveguardName and attempts < 20 do
            Wait(100)
            Config.FiveguardName = getFiveguardName()
            attempts = attempts + 1
        end

        if not Config.FiveguardName then
            for _, cfg in pairs(Config) do
                if type(cfg) == "table" and cfg.enable then
                    cfg.enable = false
                end
            end
            print('This is an addon for FiveGuard, but it was not found. Purchase it at https://fiveguard.net/#pricing')
            return
        end
    end
end

local Fiveguard = Config.FiveguardName
if Fiveguard then
    print('Fiveguard is: ^3' .. Fiveguard .. '^0')
    SetConvar('ac', Fiveguard)

    local attempts = 1
    ::recheckFG::
    if GetResourceState(Fiveguard) == 'started' then
        print('Fiveguard linked ^2successfully^0!')
    else
        StartResource(Fiveguard)
        print(('Seems like you didn\'t start ^3%s^1 before this resource\nMake sure to start ^3%s^1 as first resource in your server.cfg for better compatibility with your scripts!'):format(Fiveguard, Fiveguard))
        print(('Trying to start ^3%s^0 (attempt: %d)^0'):format(Fiveguard, attempts))
        attempts = attempts + 1
        if attempts < 3 then goto recheckFG end

        for _, cfg in pairs(Config) do
            if type(cfg) == "table" and cfg.enable then
                cfg.enable = false
            end
        end
        print(('Failed to start ^3%s^1 (attempts: %d)'):format(Fiveguard, attempts))
        return
    end
end

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

local requiredFields = { "NameOfScript", "EventForStarting", "EventForStopping", "Category", "Permission" }

Citizen.CreateThread(function()
    Wait(1000)

    local resourcePath = GetResourcePath(GetCurrentResourceName()) or ""

    for key, cfg in pairs(Config) do
        if key ~= "FiveguardName" and type(cfg) == "table" then
            local hasError = false

            for _, field in ipairs(requiredFields) do
                if isEmpty(cfg[field]) then
                    print(("\27[31m[FIVEGUARD CONFIG ERROR]: '%s' is missing in section '%s'\27[0m"):format(field, key))
                    hasError = true
                end
            end

            if not hasError then
                local fiveguardName = Config.FiveguardName
                local webhook = cfg.Webhook or false

                RegisterServerEvent(cfg.NameOfScript .. ":enabletemppermissions")
                AddEventHandler(cfg.NameOfScript .. ":enabletemppermissions", function()
                    local src = source
                    local name = GetPlayerName(src) or "Unknown"
                    local ids = getPlayerIdentifiers(src)

                    exports[fiveguardName]:SetTempPermission(src, cfg.Category, cfg.Permission, true, cfg.IgnoreStaticPermissions)

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

                    exports[fiveguardName]:SetTempPermission(src, cfg.Category, cfg.Permission, false, cfg.IgnoreStaticPermissions)

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
        elseif key ~= "FiveguardName" and type(cfg) ~= "boolean" then
            if not string.find(resourcePath, "server/addon") then
                print(("\27[33m[FIVEGUARD CONFIG WARNING]: Section '%s' is not a valid table!\27[0m"):format(tostring(key)))
            end
        end
    end

    local presetConfigs = {
        JGDealerships = Config.JGDealerships,
        JGAdvancedGarages = Config.JGAdvancedGarages,
        RcorePrison = Config.RcorePrison,
        LunarGarage = Config.LunarGarage,
        RcoreClothing = Config.RcoreClothing,
        RcoreLunarPark = Config.RcoreLunarPark,
        RTXThemePark = Config.RTXThemePark
    }

    print("\n ============= FiveGuard Temporary Permissions  =============")
    for name, status in pairs(presetConfigs) do
        local statusString = ""
        local color = ""
        if status == true then
            statusString = "Enabled"
            color = "\27[32m"
        else
            statusString = "Disabled"
            color = "\27[31m"
        end
        print(string.format("  %s%s: %s\27[0m", color, name, statusString))
    end
    print("===========================================\n")
end)