-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(1104312373378031716)
	SetDiscordRichPresenceAsset("connectrj")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetText("Hype")
	SetDiscordRichPresenceAssetSmall("connectrj")
	SetDiscordRichPresenceAssetSmallText("Hype")
	SetDiscordRichPresenceAction(0,"Discord","https://discord.gg/connecthype")
	SetDiscordRichPresenceAction(1,"Instagram","https://www.instagram.com/connecthyperp/")
end)