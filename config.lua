Config = {
    [""] = { -- Replace this with a unique name
        NameOfScript = "", -- Replace with the name of your script (used as event prefix)
        EventForStarting = "", -- Client-side event that starts the action that requires temp permissions (e.g., "openShowroom")
        EventForStopping = "", -- Client-side event that stops the action (e.g., "closeShowroom")
        Category = "", -- The permission category to set (e.g., "Client", "AdminMenu", etc.). All categories can be found here: https://docs.fiveguard.net/permission-system/ace-permissions
        Permission = "", -- The specific permission within the category (e.g., "BypassNoclip", "AdminMenuAccess", etc.) All permissions can be found here: https://docs.fiveguard.net/permission-system/ace-permissions
        IgnoreStaticPermissions = false, -- Keep false unless you know what you are doing
        Debug = false, -- DEBUG (Set to true to enable debug output/logging)
        Webhook = false -- Replace with your Discord webhook URL to log permission changes (e.g., "ttps://discord.com/api/webhooks/WEBHOOK_ID/WEBHOOK_TOKEN")
    },
}

-- Leave auto if you want automatic detection otherwise replace with Fiveguard name
Config.FiveguardName = "auto"

-- Preconfigured temporary permissions
Config.JGDealerships = false -- Set true if using jg-dealerships
Config.JGAdvancedGarages = false -- Set true if using jg-advancedgarages
Config.RcorePrison = false -- Set true if using rcore_prison
Config.RcoreClothing = false -- Set true if using Rcore_Clothing
Config.RcoreLunarPark = false -- Set true if using Rcore_LunarPark
Config.RTXThemePark = false -- Set true if using RTX_Theme_Park
