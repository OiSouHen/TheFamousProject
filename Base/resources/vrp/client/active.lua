-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active", function(Passport, Name)
	SetDiscordAppId(1104088666655178852)
	SetDiscordRichPresenceAsset("hensa")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetSmall("hensa")
	SetDiscordRichPresenceAssetText("Hensa")
	SetDiscordRichPresenceAssetSmallText("Hensa")
	SetDiscordRichPresenceAction(0, "Hensa", ServerLink)
end)