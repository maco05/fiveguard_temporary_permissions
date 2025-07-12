local function getFiveguardName()
    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        if resource then
            local files = GetNumResourceMetadata(resource, 'ac')
            for j = 0, files - 1 do
                local x = GetResourceMetadata(resource, 'ac', j)
                if x and (string.find(string.lower(x), "fg") or string.find(string.lower(x), "fiveguard")) then
                    return resource
                end
            end
        end
    end
    return nil
end

local function getPlayerIdentifiers(src)
    local identifiers = {
        steam = "N/A",
        discord = "N/A",
        license = "N/A"
    }

    if src and GetNumPlayerIdentifiers then
        for i = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, i)
            if id then
                if id:find("steam:") then
                    identifiers.steam = id
                elseif id:find("discord:") then
                    identifiers.discord = "<@" .. id:gsub("discord:", "") .. ">"
                elseif id:find("license:") then
                    identifiers.license = id
                end
            end
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

    if json and json.encode and PerformHttpRequest then
        PerformHttpRequest(webhookURL, function() end, "POST", json.encode({
            username = "FiveGuard Logger",
            embeds = embed
        }), {
            ["Content-Type"] = "application/json"
        })
    else
        print("\27[31m[FIVEGUARD ERROR]: json.encode or PerformHttpRequest not found. Cannot send Discord webhook.\27[0m")
    end
end

local function isEmpty(value)
    return value == nil or value == ""
end

local requiredFields = { "EventPrefix", "EventForStarting", "EventForStopping", "Category", "Permission" }

local Fiveguard = nil
local fiveguardFound = false
local fiveguardLinkedSuccessfully = false

if Config and Config.FiveguardName then
    if Config.FiveguardName == "auto" then
        Fiveguard = getFiveguardName()

        if not Fiveguard then
            local attempts = 0
            while not Fiveguard and attempts < 20 do
                Wait(100)
                Fiveguard = getFiveguardName()
                attempts = attempts + 1
            end

            if not Fiveguard then
                for _, cfg in pairs(Config) do
                    if type(cfg) == "table" and cfg.enable then
                        cfg.enable = false
                    end
                end
                print('This is an addon for FiveGuard, but it was not found. Purchase it at https://fiveguard.net/#pricing')
                return
            end
        end
    else
        Fiveguard = Config.FiveguardName
    end
end

if Fiveguard then
    fiveguardFound = true
    print(string.format('Fiveguard is: ^3%s^0', Fiveguard))
    SetConvar('ac', Fiveguard)

    local attempts = 1
    ::recheckFG::
    if GetResourceState and GetResourceState(Fiveguard) == 'started' then
        print('Fiveguard linked ^2successfully^0!')
        fiveguardLinkedSuccessfully = true
    else
        if StartResource then
            StartResource(Fiveguard)
        end
        print(('Seems like you didn\'t start ^3%s^1 before this resource\nMake sure to start ^3%s^1 as first resource in your server.cfg for better compatibility with your scripts!'):format(Fiveguard, Fiveguard))
        print(('Trying to start ^3%s^0 (attempt: %d)^0'):format(Fiveguard, attempts))
        attempts = attempts + 1
        if attempts < 3 then goto recheckFG end

        if type(Config) == "table" and type(Config.PreconfiguredPermissions) == "table" then
            for key, value in pairs(Config.PreconfiguredPermissions) do
                if type(value) == "boolean" then
                    Config.PreconfiguredPermissions[key] = false
                end
            end
        end
        print(('Failed to start ^3%s^1 (attempts: %d)'):format(Fiveguard, attempts))
        fiveguardLinkedSuccessfully = false
        return
    end
end

local currentResourceName = GetCurrentResourceName()
local isResourceNamedTemporary = false
if currentResourceName == "fiveguard_temporary_permissions" then
    isResourceNamedTemporary = true
    if Citizen and Citizen.CreateThread then
        Citizen.CreateThread(function()
            Wait(120000)
            print(string.format("\n\27[33m[WARNING]: This resource is named '%s'. Please change it to something less obvious!\27[0m", currentResourceName))
        end)
    end
end

if Citizen and Citizen.CreateThread then
    Citizen.CreateThread(function()
        Wait(100)

        print("\n============= Fiveguard Temporary Permissions =============")
        if fiveguardFound then
            local statusColor = fiveguardLinkedSuccessfully and "\27[32m" or "\27[31m"
            print(string.format("Fiveguard was found and name: %s%s\27[0m", statusColor, Fiveguard))
        else
            print("\27[31mFiveguard not found.\27[0m")
        end

        print("============= Preconfigured Permissions =============")
        local errorsFound = {}

        if type(Config) ~= "table" then
            table.insert(errorsFound, "\27[31mCRITICAL ERROR: The 'Config' table was not found or is not a table. Ensure it's defined globally in another script and loaded before this resource.\27[0m")
        else
            if type(Config.PreconfiguredPermissions) == "table" then
                for key, value in pairs(Config.PreconfiguredPermissions) do
                    if type(value) == "boolean" then
                        local statusText = value and "ENABLED" or "DISABLED"
                        local colorCode = value and "\27[32m" or "\27[31m"
                        print(string.format("%s IS %s%s\27[0m", string.upper(key), colorCode, statusText))
                    end
                end
            else
                print("\27[33m[WARNING]: Config.PreconfiguredPermissions table not found or is not a table. Preconfigured permission status will not be displayed.\27[0m")
            end
            print("===========================================")

            local resourcePath = GetResourcePath(GetCurrentResourceName()) or ""

            for key, cfg in pairs(Config) do
                if key == "FiveguardName" or key == "PreconfiguredPermissions" then
                    goto continue_main_loop
                end

                if type(cfg) == "table" then
                    local hasError = false
                    local missingFields = {}

                    for _, field in ipairs(requiredFields) do
                        if isEmpty(cfg[field]) then
                            table.insert(missingFields, field)
                            hasError = true
                        end
                    end

                    if hasError then
                        table.insert(errorsFound, string.format("Configuration '%s' is missing required fields or has empty values: %s", key, table.concat(missingFields, ", ")))
                    end

                    if not hasError then
                        local fiveguardName = Fiveguard
                        local webhook = cfg.Webhook or false

                        if RegisterServerEvent and AddEventHandler then
                            RegisterServerEvent(cfg.EventPrefix .. ":enabletemppermissions")
                            AddEventHandler(cfg.EventPrefix .. ":enabletemppermissions", function(src)
                                local name = GetPlayerName(src) or "Unknown"
                                local ids = getPlayerIdentifiers(src)

                                if fiveguardLinkedSuccessfully and exports and exports[fiveguardName] and type(exports[fiveguardName].SetTempPermission) == 'function' then
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
                                else
                                    print(("\27[31m[FIVEGUARD ERROR]: Fiveguard export 'SetTempPermission' not found or Fiveguard not linked. Is Fiveguard properly started and named '%s'?\27[0m"):format(tostring(fiveguardName)))
                                end
                            end)

                            RegisterServerEvent(cfg.EventPrefix .. ":disabletemppermissions")
                            AddEventHandler(cfg.EventPrefix .. ":disabletemppermissions", function(src)
                                local name = GetPlayerName(src) or "Unknown"
                                local ids = getPlayerIdentifiers(src)

                                if fiveguardLinkedSuccessfully and exports and exports[fiveguardName] and type(exports[fiveguardName].SetTempPermission) == 'function' then
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
                                else
                                    print(("\27[31m[FIVEGUARD ERROR]: Fiveguard export 'SetTempPermission' not found or Fiveguard not linked. Is Fiveguard properly started and named '%s'?\27[0m"):format(tostring(fiveguardName)))
                                end
                            end)
                        else
                            print("\27[31m[FIVEGUARD ERROR]: RegisterServerEvent or AddEventHandler not found. Cannot register permission events.\27[0m")
                        end
                    end
                elseif not string.find(resourcePath, "server/addon") then
                    table.insert(errorsFound, string.format("Section '%s' is not a valid table for a custom permission configuration, nor is it a recognized predefined boolean flag. Please check your Config file.", tostring(key)))
                end
                ::continue_main_loop::
            end
        end

        if #errorsFound > 0 then
            print("\n============= Configuration Errors =============")
            for i, errorMsg in ipairs(errorsFound) do
                print(string.format("[ERROR]: %s", errorMsg))
            end
            print("===========================================")
        else
            print("\nNo configuration errors found for custom permissions.")
        end

        if isResourceNamedTemporary then
            print(string.format("\n\27[33m[WARNING]: This resource is named '%s'. Please change it to something less obvious!\27[0m", currentResourceName))
        end
    end)
end