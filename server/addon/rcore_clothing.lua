if Config.RcoreClothing == true then

    RegisterServerEvent("rcore_clothing:enabletemppermissions")
    AddEventHandler("rcore_clothing:enabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,                         -- Player source
            "Client",                    -- Category
            "BypassStealOutfit",         -- Permission
            true,                        -- Allow?
            false                        -- Ignore static permissions
        )
    end)

    RegisterServerEvent("rcore_clothing:disabletemppermissions")
    AddEventHandler("rcore_clothing:disabletemppermissions", function()
        local src = source
        exports[Config.FiveguardName]:SetTempPermission(
            src,
            "Client",
            "BypassStealOutfit",
            false,
            false
        )
    end)
end

if Config.RcoreClothing == false then
end    
