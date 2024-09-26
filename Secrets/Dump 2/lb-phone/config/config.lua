Config = {}
Config.Debug = false -- Set to true to enable debug mode

Config.DatabaseChecker = {}
Config.DatabaseChecker.Enabled = true -- if true, the phone will check the database for any issues and fix them if possible
Config.DatabaseChecker.AutoFix = true

--[[ FRAMEWORK OPTIONS ]] --
Config.Framework = "standalone"
--[[
    Supported frameworks:
        * auto: auto-detect framework (ONLY WORKS WITH THE ONES LISTED BELOW)
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * ox: ox_core, https://github.com/overextended/ox_core
        * vrp2: vrp 2.0 (ONLY THE OFFICIAL vRP 2.0, NOT CUSTOM VERSIONS)
        * standalone: no framework, note that framework specific apps will not work unless you implement the functions
]]
Config.CustomFramework = true -- if set to true and you use standalone, you will be able to use framework specific apps
Config.QBMailEvent = false -- if you want this script to listen for qb email events, enable this.
Config.QBOldJobMethod = false -- use the old method to check job in qb-core? this is slower, and only needed if you use an outdated version of qb-core.

Config.Item = {}
Config.Item.Require = false -- require a phone item to use the phone
Config.Item.Name = "cellphone" -- name of the phone item

Config.Item.Unique = false -- should each phone be unique? https://docs.lbscripts.com/phone/configuration/#unique-phones
Config.Item.Inventory = "auto" --[[
    The inventory you use, IGNORE IF YOU HAVE Config.Item.Unique DISABLED.
    Supported:
        * auto: auto-detect inventory (ONLY WORKS WITH THE ONE LISTED BELOW)
        * ox_inventory - https://github.com/overextended/ox_inventory
        * qb-inventory - https://github.com/qbcore-framework/qb-inventory
        * lj-inventory - https://github.com/loljoshie/lj-inventory
        * core_inventory - https://www.c8re.store/package/5121548
        * mf-inventory - https://modit.store/products/mf-inventory?variant=39985142268087
        * qs-inventory - https://buy.quasar-store.com/package/4770732
        * codem-inventory - https://codem.tebex.io/package/5900973
]]

Config.ServerSideSpawn = true -- should entities be spawned on the server? (phone prop, vehicles)

Config.PhoneModel = `lb_phone_prop` -- the prop of the phone, if you want to use a custom phone model, you can change this here
Config.PhoneRotation = vector3(0.0, 0.0, 180.0) -- the rotation of the phone when attached to a player
Config.PhoneOffset = vector3(0.0, -0.005, 0.0) -- the offset of the phone when attached to a player

Config.DynamicIsland = true -- if enabled, the phone will have a Iphone 14 Pro inspired Dynamic Island.
Config.SetupScreen = true -- if enabled, the phone will have a setup screen when the player first uses the phone.

Config.AutoDeleteNotifications = true -- notifications that are more than X hours old, will be deleted. set to false to disable. if set to true, it will delete 1 week old notifications.
Config.MaxNotifications = 25 -- the maximum amount of notifications a player can have. if they have more than this, the oldest notifications will be deleted. set to false to disable
Config.DisabledNotifications = { -- an array of apps that should not send notifications, note that you should use the app identifier, found in config.json
    -- "DarkChat",
}

Config.WhitelistApps = {
    -- ["test-app"] = {"police", "ambulance"}
}

Config.BlacklistApps = {
    ["DarkChat"] = {"Policia"}
}

Config.ChangePassword = {
    ["Trendy"] = true,
    ["InstaPic"] = true,
    ["Birdy"] = true,
    ["DarkChat"] = true,
    ["Mail"] = true,
}

Config.DeleteAccount = {
    ["Trendy"] = false,
    ["InstaPic"] = false,
    ["Birdy"] = false,
    ["DarkChat"] = false,
    ["Mail"] = false,
    ["Spark"] = false
}

Config.Companies = {}
Config.Companies.Enabled = true -- allow players to call companies?
Config.Companies.MessageOffline = false -- if true, players can message companies even if no one in the company is online
Config.Companies.DefaultCallsDisabled = false -- should receiving company calls be disabled by default?
Config.Companies.AllowAnonymous = false -- allow players to call companies with "hide caller id" enabled?
Config.Companies.SeeEmployees = "everyone" -- who should be able to see employees? they will see name, online status & phone number. options are: "everyone", "employees" or "none"
Config.Companies.DeleteConversations = true -- allow employees to delete conversations?
Config.Companies.Services = {
    {
        job = "Policia",
        name = "Polícia",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
        canCall = false, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" }, -- ranks that can manage the company
        location = {
            name = "Servir e proteger",
            coords = {
                x = 416.02,
                y = -982.65
            }
        }
    },{
        job = "Paramedico",
        name = "Paramedico",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
        canCall = false, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = { "Chefe","Médico","Enfermeiro","Residente" }, -- ranks that can manage the company
        location = {
            name = "Pillbox Centro Médico",
            coords = {
                x = 337.65,
                y = -1393.64
            }
        }
    }
}

Config.Companies.Contacts = { -- not needed if you use the services app, this will add the contact to the contacts app
    -- ["police"] = {
    --     name = "Police",
    --     photo = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png"
    -- },
}

Config.Companies.Management = {
    Enabled = false, -- if true, employees & the boss can manage the company

    Duty = true, -- if true, employees can go on/off duty
    -- Boss actions
    Deposit = true, -- if true, the boss can deposit money into the company
    Withdraw = true, -- if true, the boss can withdraw money from the company
    Hire = true, -- if true, the boss can hire employees
    Fire = true, -- if true, the boss can fire employees
    Promote = true, -- if true, the boss can promote employees
}

Config.CustomApps = {} -- https://docs.lbscripts.com/phone/custom-apps/

Config.Valet = {}
Config.Valet.Enabled = false -- allow players to get their vehicles from the phone
Config.Valet.Price = 100 -- price to get your vehicle
Config.Valet.Model = `S_M_Y_XMech_01`
Config.Valet.Drive = false -- should a ped bring the car, or should it just spawn in front of the player?
Config.Valet.DisableDamages = false -- disable vehicle damages (engine & body health) on esx
Config.Valet.FixTakeOut = false -- repair the vehicle after taking it out?

Config.HouseScript = "auto" --[[
    The housing script you use on your server
    Supported:
        * loaf_housing - https://store.loaf-scripts.com/package/4310850
        * qb-houses - https://github.com/qbcore-framework/qb-houses
        * qs-housing - https://buy.quasar-store.com/package/5677308
]]

--[[ VOICE OPTIONS ]] --
Config.Voice = {}
Config.Voice.CallEffects = false -- enable call effects while on speaker mode? (NOTE: This may create sound-issues if you have too many submixes registered in your server)
Config.Voice.System = "pma"
--[[
    Supported voice systems:
        * pma: pma-voice - HIGHLY RECOMMENDED
        * mumble: mumble-voip - Not recommended, update to pma-voice
        * salty: saltychat - Not recommended, change to pma-voice
        * toko: tokovoip - Not recommended, change to pma-voice
]]

Config.Voice.HearNearby = false --[[
    Only works with pma-voice

    If true, players will be heard on instagram live if they are nearby
    If false, only the person who is live will be heard

    If true, allow nearby players to listen to phone calls if speaker is enabled
    If false, only the people in the call will be able to hear each other

    This feature is a work in progress and may not work as intended. It may have an impact on performance.
]]

Config.Voice.RecordNearby = false --[[
    Should video recordings include nearby players?
]]

--[[ PHONE OPTIONS ]] --
Config.Locations = { -- Locations that'll appear in the maps app.
    {
        position = vector2(416.02,-982.65),
        name = "Departamento Policial",
        description = "Departamento de Policia",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
    },{
        position = vector2(337.65,-1393.64),
        name = "Pillbox",
        description = "Pillbox Centro Médico",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
    }
}

Config.Locales = { -- languages that the player can choose from when setting up a phone [Check the docs to see which languages the phone supports]
    {
        locale = "en",
        name = "English"
    },
    {
        locale = "de",
        name = "Deutsch"
    },
    {
        locale = "fr",
        name = "Français"
    },
    {
        locale = "es",
        name = "Español"
    },
    {
        locale = "nl",
        name = "Nederlands"
    },
    {
        locale = "dk",
        name = "Dansk"
    },
    {
        locale = "no",
        name = "Norsk"
    },
    {
        locale = "th",
        name = "ไทย"
    },
    {
        locale = "ar",
        name = "عربي"
    },
    {
        locale = "ru",
        name = "Русский"
    },
    {
        locale = "cs",
        name = "Czech"
    },
    {
        locale = "sv",
        name = "Svenska"
    },
    {
        locale = "pl",
        name = "Polski"
    },
    {
        locale = "hu",
        name = "Magyar"
    },
    {
        locale = "tr",
        name = "Türkçe"
    },
    {
        locale = "pt-br",
        name = "Português (Brasil)"
    },
    {
        locale = "pt-pt",
        name = "Português"
    },
    {
        locale = "it",
        name = "Italiano"
    }
}

Config.DefaultLocale = "pt-br"
Config.DateLocale = "pt-br" -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat

Config.FrameColor = "#39334d" -- This is the color of the phone frame. Default (#39334d) is SILVER.
Config.AllowFrameColorChange = true -- Allow players to change the color of their phone frame?

Config.PhoneNumber = {}
Config.PhoneNumber.Format = "({3}) {3}-{3}" -- Don't touch unless you know what you're doing. IMPORTANT: The sum of the numbers needs to be equal to the phone number length + prefix length
Config.PhoneNumber.Length = 6 -- This is the length of the phone number WITHOUT the prefix.
Config.PhoneNumber.Prefixes = { -- These are the first numbers of the phone number, usually the area code. They all need to be the same length
    "055"
}

Config.Battery = {} -- WITH THESE SETTINGS, A FULL CHARGE WILL LAST AROUND 2 HOURS.
Config.Battery.Enabled = false -- Enable battery on the phone, you'll need to use the exports to charge it.
Config.Battery.ChargeInterval = { 5, 10 } -- How much battery
Config.Battery.DischargeInterval = { 50, 60 } -- How many seconds for each percent to be removed from the battery
Config.Battery.DischargeWhenInactiveInterval = { 80, 120 } -- How many seconds for each percent to be removed from the battery when the phone is inactive
Config.Battery.DischargeWhenInactive = true -- Should the phone remove battery when the phone is closed?

Config.CurrencyFormat = "$%s" -- ($100) Choose the formatting of the currency. %s will be replaced with the amount.
Config.MaxTransferAmount = 9999999 -- The maximum amount of money that can be transferred at once via wallet / messages.

Config.TransferLimits = {}
Config.TransferLimits.Daily = false -- The maximum amount of money that can be transferred in a day. Set to false for unlimited.
Config.TransferLimits.Weekly = false -- The maximum amount of money that can be transferred in a week. Set to false for unlimited.

Config.EnableMessagePay = true -- Allow players to pay other players via messages?
Config.EnableVoiceMessages = true -- Allow players to send voice messages?

Config.CityName = "Creative Network" -- The name that's being used in the weather app etc.
Config.RealTime = false -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.
Config.CustomTime = false -- NOTE: disable Config.RealTime if using this. you can set this to a function that returns custom time, as a table: { hour = 0-24, minute = 0-60 }

Config.EmailDomain = "creativenetwork.dev.br"
Config.AutoCreateEmail = false -- should the phone automatically create an email for the player when they set up the phone?
Config.DeleteMail = true -- allow players to delete mails in the mail app?

Config.DeleteMessages = true -- allow players to delete messages in the messages app?

Config.SyncFlash = true -- should flashlights be synced across all players? May have an impact on performance
Config.EndLiveClose = false -- should InstaPic live end when you close the phone?

Config.AllowExternal = { -- allow people to upload external images? (note: this means they can upload nsfw / gore etc)
    Gallery = true, -- allow importing external links to the gallery?
    Twitter = true, -- set to true to enable external images on that specific app, set to false to disable it.
    Instagram = true,
    Tinder = true,
    TikTok = true,
    YellowPages = true,
    MarketPlace = true,
    Mail = true,
    Messages = true,
    Other = true -- other apps that don't have a specific setting (ex: setting a profile picture for a contact, backgrounds for the phone etc)
}

-- Blacklisted domains for external images. You will not be able to upload from these domains.
Config.ExternalBlacklistedDomains = {
    "imgur.com",
    "discord.com",
    "discordapp.com",
    "discordapp.net"
}

-- Whitelisted domains for external images. If this is not empty/nil/false, you will only be able to upload images from these domains.
Config.ExternalWhitelistedDomains = {}

-- Set to false/empty to disable
Config.UploadWhitelistedDomains = {}

Config.WordBlacklist = {}
Config.WordBlacklist.Enabled = true
Config.WordBlacklist.Apps = { -- apps that should use the word blacklist (if Config.WordBlacklist.Enabled is true)
    Birdy = true,
    InstaPic = true,
    Trendy = true,
    Spark = true,
    Messages = true,
    Pages = true,
    MarketPlace = true,
    DarkChat = true,
    Mail = true,
    Other = true
}
Config.WordBlacklist.Words = {
	"zap",
	"macaco",
	"preto",
	"arrombado",
	"viadinho",
	"urugutango",
	"gorila",
	"gorilla",
	"mongoloide",
	"bixa",
	"bicha",
	"traveco",
	"veveco",
	"boiola",
	"pau",
	"buceta",
	"gay",
	"piranha",
	"monkey",
	"vagabunda",
	"puta",
	"escroto",
	"piranha",
	"pretinho",
	"escurinho",
	"negrinho",
	"piranha"
}

Config.AutoFollow = {}
Config.AutoFollow.Enabled = false

Config.AutoFollow.Birdy = {}
Config.AutoFollow.Birdy.Enabled = true
Config.AutoFollow.Birdy.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoFollow.InstaPic = {}
Config.AutoFollow.InstaPic.Enabled = true
Config.AutoFollow.InstaPic.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoFollow.TikTok = {}
Config.AutoFollow.TikTok.Enabled = true
Config.AutoFollow.TikTok.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoBackup = true -- should the phone automatically create a backup when you get a new phone?

Config.Post = {} -- What apps should send posts to discord? You can set your webhooks in server/webhooks.lua
Config.Post.Birdy = true -- Announce new posts on Birdy?
Config.Post.InstaPic = true -- Anmnounce new posts on InstaPic?
Config.Post.Accounts = {
    Birdy = {
        Username = "Birdy",
        Avatar = "https://loaf-scripts.com/fivem/lb-phone/icons/Birdy.png"
    },
    InstaPic = {
        Username = "InstaPic",
        Avatar = "https://loaf-scripts.com/fivem/lb-phone/icons/InstaPic.png"
    }
}

Config.BirdyTrending = {}
Config.BirdyTrending.Enabled = true -- show trending hashtags?
Config.BirdyTrending.Reset = 3 * 24 -- How often should trending hashtags be reset on birdy? (in hours)

Config.BirdyNotifications = false -- should everyone get a notification when someone posts?

Config.PromoteBirdy = {}
Config.PromoteBirdy.Enabled = true -- should you be able to promote post?
Config.PromoteBirdy.Cost = 2500 -- how much does it cost to promote a post?
Config.PromoteBirdy.Views = 100 -- how many views does a promoted post get?

Config.TikTok = {}
Config.TikTok.TTS = {
    {"English (US) - Female", "en_us_001"},
    {"English (US) - Male 1", "en_us_006"},
    {"English (US) - Male 2", "en_us_007"},
    {"English (US) - Male 3", "en_us_009"},
    {"English (US) - Male 4", "en_us_010"},

    {"English (UK) - Male 1", "en_uk_001"},
    {"English (UK) - Male 2", "en_uk_003"},

    {"English (AU) - Female", "en_au_001"},
    {"English (AU) - Male", "en_au_002"},

    {"French - Male 1", "fr_001"},
    {"French - Male 2", "fr_002"},

    {"German - Female", "de_001"},
    {"German - Male", "de_002"},

    {"Spanish - Male", "es_002"},

    {"Spanish (MX) - Male", "es_mx_002"},

    {"Portuguese (BR) - Female 2", "br_003"},
    {"Portuguese (BR) - Female 3", "br_004"},
    {"Portuguese (BR) - Male", "br_005"},

    {"Indonesian - Female", "id_001"},

    {"Japanese - Female 1", "jp_001"},
    {"Japanese - Female 2", "jp_003"},
    {"Japanese - Female 3", "jp_005"},
    {"Japanese - Male", "jp_006"},

    {"Korean - Male 1", "kr_002"},
    {"Korean - Male 2", "kr_004"},
    {"Korean - Female", "kr_003"},

    {"Ghostface (Scream)", "en_us_ghostface"},
    {"Chewbacca (Star Wars)", "en_us_chewbacca"},
    {"C3PO (Star Wars)", "en_us_c3po"},
    {"Stitch (Lilo & Stitch)", "en_us_stitch"},
    {"Stormtrooper (Star Wars)", "en_us_stormtrooper"},
    {"Rocket (Guardians of the Galaxy)", "en_us_rocket"},

    {"Singing - Alto", "en_female_f08_salut_damour"},
    {"Singing - Tenor", "en_male_m03_lobby"},
    {"Singing - Sunshine Soon", "en_male_m03_sunshine_soon"},
    {"Singing - Warmy Breeze", "en_female_f08_warmy_breeze"},
    {"Singing - Glorious", "en_female_ht_f08_glorious"},
    {"Singing - It Goes Up", "en_male_sing_funny_it_goes_up"},
    {"Singing - Chipmunk", "en_male_m2_xhxs_m03_silly"},
    {"Singing - Dramatic", "en_female_ht_f08_wonderful_world"}
}

-- ICE Servers for WebRTC (ig live, live video). If you don't know what you're doing, leave this as it is.
-- see https://developer.mozilla.org/en-US/docs/Web/API/RTCPeerConnection/RTCPeerConnection
-- Config.RTCConfig = {
--     iceServers = {
--         { urls = "stun:stun.l.google.com:19302" },
--     }
-- }

Config.Crypto = {}
Config.Crypto.Enabled = false
Config.Crypto.Coins = {"bitcoin","ethereum","tether","binancecoin","usd-coin","ripple","binance-usd","cardano","dogecoin","solana","shiba-inu","polkadot","litecoin","bitcoin-cash"}
Config.Crypto.Currency = "usd" -- currency to use for crypto prices. https://api.coingecko.com/api/v3/simple/supported_vs_currencies
Config.Crypto.Refresh = 5 * 60 * 1000 -- how often should the crypto prices be refreshed (client cache)? (Default 5 minutes)
Config.Crypto.QBit = false -- support QBit? (requires qb-crypto & qb-core)

Config.KeyBinds = {
    -- Find keybinds here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Open = { -- toggle the phone
        Command = "phone",
        Bind = "K",
        Description = "Navegar no telefone"
    },
    Focus = { -- keybind to toggle the mouse cursor.
        Command = "togglePhoneFocus",
        Bind = "LMENU",
        Description = "Toggle cursor on your phone"
    },
    StopSounds = { -- in case the sound would bug out, you can use this command to stop all sounds.
        Command = "stopSounds",
        Bind = false,
        Description = "Stop all phone sounds"
    },
    FlipCamera = {
        Command = "flipCam",
        Bind = "UP",
        Description = "Flip phone camera"
    },
    TakePhoto = {
        Command = "takePhoto",
        Bind = "RETURN",
        Description = "Take a photo / video"
    },
    ToggleFlash = {
        Command = "toggleCameraFlash",
        Bind = "E",
        Description = "Toggle flash"
    },
    LeftMode = {
        Command = "leftMode",
        Bind = "LEFT",
        Description = "Change mode"
    },
    RightMode = {
        Command = "rightMode",
        Bind = "RIGHT",
        Description = "Change mode"
    },
    AnswerCall = {
        Command = "answerCall",
        Bind = "RETURN",
        Description = "Answer incoming call"
    },
    DeclineCall = {
        Command = "declineCall",
        Bind = "BACK",
        Description = "Decline incoming call"
    },
    UnlockPhone = {
        Bind = "SPACE",
        Description = "Open your phone",
    }
}

Config.KeepInput = true -- keep input when nui is focused (meaning you can walk around etc)

--[[ PHOTO / VIDEO OPTIONS ]] --
-- Set your api keys in lb-phone/server/apiKeys.lua
Config.UploadMethod = {}
-- You can edit the upload methods in lb-phone/shared/upload.lua
-- We recommend Fivemanage, https://fivemanage.com
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
-- If you want to host uploads yourself, you can use LBUpload: https://github.com/lbphone/lb-upload
-- We STRONGLY discourage using Discord as an upload method, as uploaded files may become inaccessible after a while.
Config.UploadMethod.Video = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom"
Config.UploadMethod.Image = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom
Config.UploadMethod.Audio = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom"

Config.Video = {}
Config.Video.Bitrate = 400 -- video bitrate (kbps), increase to improve quality, at the cost of file size
Config.Video.FrameRate = 24 -- video framerate (fps), 24 fps is a good mix between quality and file size used in most movies
Config.Video.MaxSize = 25 -- max video size (MB)
Config.Video.MaxDuration = 60 -- max video duration (seconds)

Config.Image = {}
Config.Image.Mime = "image/webp" -- image mime type, "image/webp" or "image/png" or "image/jpg"
Config.Image.Quality = 0.95