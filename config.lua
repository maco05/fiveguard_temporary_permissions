Config = {}

-- Replace with the actual resource name for the FiveGuard export (e.g., "fiveguard")
Config.FiveguardName = ""

-- Replace with the name of your script (used as event prefix)
Config.NameOfScript = ""

-- Client-side event that starts the action that requires temp permissions (e.g., "openShowroom")
Config.EventForStarting = ""

-- Client-side event that stops the action (e.g., "closeShowroom")
Config.EventForStopping = ""

-- The permission category to set (e.g., "Client", "AdminMenu", etc.). All categories can be found here: https://docs.fiveguard.net/permission-system/ace-permissions
Config.Category = ""

-- The specific permission within the category (e.g., "BypassNoclip", "AdminMenuAccess", etc.) All permissions can be found here: https://docs.fiveguard.net/permission-system/ace-permissions
Config.Permission = ""

-- Keep false unless you know what you are doing
Config.IgnoreStaticPermissions = false

-- Debug
Config.Debug = false  -- Set to true to enable debug output/logging

test