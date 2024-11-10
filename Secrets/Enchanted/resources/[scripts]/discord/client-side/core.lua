-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(1234645296026484747)
	SetDiscordRichPresenceAsset("reserva")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetText("Reserva")
	SetDiscordRichPresenceAssetSmall("reserva")
	SetDiscordRichPresenceAssetSmallText("Reserva")
	SetDiscordRichPresenceAction(0,"Discord","http://reservarj.com/")
end)