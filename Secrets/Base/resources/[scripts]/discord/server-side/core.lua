-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	["Connect"] = "",
	["Disconnect"] = "",
	["Airport"] = "",
	["Deaths"] = "",
	["Gemstone"] = "",
	["Rename"] = "",
	["Roles"] = "",
	["Skins"] = "",
	["Marketplace"] = "",
	["Pause"] = "",
	["Boxes"] = "",
	["Hackers"] = ""
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,Color,source)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		embeds = {
			{ color = (Color or 0xa3c846), description = Message }
		}
	}),{ ["Content-Type"] = "application/json" })

	if source then
		TriggerClientEvent("megazord:Screenshot",source,Discord[Hook])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Content",function(Hook,Message)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Webhook",function(Hook)
	return Discord[Hook] or ""
end)