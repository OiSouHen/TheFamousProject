-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting",function(_,_,deferrals)
	deferrals.defer()

	deferrals.handover({
		["socials"] = Socials,
		["playlist"] = Playlist,
		["theme"] = Theme,
		["autoplay"] = Autoplay
	})

	deferrals.done()
end)