-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Disconnect"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Services"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Salary"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Admin"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Garages"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Paramedic"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Payments"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Airport"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Deaths"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Gemstone"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Rename"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Roles"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Skins"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Marketplace"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Pause"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Boxes"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE",
	["Hackers"] = "https://discord.com/api/webhooks/1293563732814856192/dvz03qWc3yTxbKKZn217-DZv13y5XksT2oTMDHS2hxg0HGt6pY3ztDQrSEcvGyuMs3NE"
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