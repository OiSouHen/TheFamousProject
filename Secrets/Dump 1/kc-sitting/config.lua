Config                              = Config or {}

-- Base
Config.Precision                    = 0.04  -- This determines the precision at which the system will attempt to detect a seat. If set too low, it may cause severe lag. If set too high, player placement may be slightly off (The default value is 0.04)
Config.MaxHeight                    = 0.20  -- This determines the maximum height a player can sit at. A higher value allows for higher seating positions (The default value is 0.20)
Config.Distance                     = 0.5   -- This determines the distance at which the system will search for a seat. If set too low, it may not accurately detect seats. If set too high, it may produce unexpected detections (The default value is 0.5)
Config.GroundDistance               = 0.8   -- This determines the distance at which the system will search for a seat on the ground. If set too low, it may not accurately detect seats. If set too high, it may produce unexpected detections (The default value is 0.8)
Config.StairsDistance               = 1.0   -- This determines the distance at which the system will search for stairs. (The default value is 1.0) ## DO NOT MODIFY THIS SINCE IT ISN'T BUGPROOF ##
Config.MaxRetryBeforeSeated         = 10    -- This determines how many attempts the system will make to detect a seat. A higher value means the player will wait longer before being seated, while a lower value reduces the likelihood of finding a seat (The default value is 10)
Config.DistanceCheckPed             = 0.6   -- This determines the distance at which the system need to check for the closest ped to avoid 2 players sitting inside each other (The default value is 0.6)
-- I would advise to not change anything in this category, I've still left those options if anyone really need to modify such things.

-- Detection
Config.DetectWorld                  = true  -- This value determines whether the system should detect seats in the world (The default value is true)
Config.DetectProps                  = true  -- This value determines whether the system should detect seats on props (The default value is true)
Config.DetectVehicles               = false -- This value determines whether the system should detect seats on vehicles (The default value is false)
-- I would advise to not change anything in this category, I've still left those options if anyone really need to modify such things. Be aware of DetectVehicles, it doesn't work for every vehicles, thats why it's false by default!

-- Sit Bind Config
Config.CommandTitle                 = 'Sit Anywhere'    -- Key title in GTA 5 control settings
Config.CommandInputMapper           = 'KEYBOARD'        -- Input Mapper (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.CommandInputParameter        = 'J'               -- Input Parameter (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.CommandUseKey                = false              -- This value determines if you want to use the set keys above or not
Config.CommandName        		    = 'sit'             -- If you use another sitting script, you can change the command name to avoid any issue

-- Get Up Config
Config.GetUpFromSitKey              = 73                -- This value determines the control key to get up from a seat (The default value is 73 - X) -- https://docs.fivem.net/docs/game-references/controls/
Config.GetUpFromSitKeyName          = 'INPUT_VEH_DUCK'  -- This value determines the name of the control key to get up from a seat (The default value is 'INPUT_VEH_DUCK') -- https://docs.fivem.net/docs/game-references/controls/
Config.UseMoveKeyToGetUp            = false             -- This value determines whether the system should use the key set above or use the move keys to get up from a seat (32, 33, 34, 35)
Config.GetUpChecks                  = {                 -- This table determines the condition that must be met for a player to get up from a seat (You can't add new condition that the default ones)
    ["Health"] = false,
    ["Ragdoll"] = false
}

-- List
Config.EnabledList = { -- This list allow you to able/disable certain sit type.
    ['Stairs'] = true,
    ['Chair'] = true,
    ['Sit'] = true,
    ['Wall'] = true,
    ['Ledge'] = true,
    ['Ground'] = false,
    ['Seat'] = true,
    ['Seat (chair)'] = true
}

-- Misc
Config.Language						= 'en'		-- Currently Available: fr, en
Config.Debug        				= false   	-- If you think something is not working properly, you can set 'Config.Debug' to true. It will then print a lot of debug information in your console or above radar
Config.UpdateChecker                = false     -- Set to false if you don't want to check for resource update on start (No need to change this if you're using fivem-checker)
Config.ChangeLog					= false		-- Set to false if you don't want to display the changelog if new version is find (No need to change this if you're using fivem-checker)

-- Custom condition to sit
function CanSit(player)
    return true -- Example: " return GetSelectedPedWeapon(player) == GetHashKey('weapon_unarmed')"
end

function SittingNotification(message, type) -- type: 0 refer to nothing special, 1 could refer to "success", 2 could refer to "error", 3 could refer to "in progress"
    local ShouldBeep = {
        [0] = false,
        [1] = true,
        [2] = true,
        [3] = false
    }

    DrawText2D(message, ShouldBeep[type])
end