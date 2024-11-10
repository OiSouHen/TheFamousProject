-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Work"] = 0
GlobalState["Hours"] = 10
GlobalState["Players"] = 0
GlobalState["Minutes"] = 00
GlobalState["Weather"] = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		GlobalState["Work"] = GlobalState["Work"] + 1
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1

		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Keyboard = vKEYBOARD.Timeset(source,"Hora","Minuto",{ "EXTRASUNNY","CLEAR","NEUTRAL","SMOG","FOGGY","OVERCAST","CLOUDS","CLEARING","RAIN","THUNDER","SNOW","BLIZZARD","SNOWLIGHT","XMAS","HALLOWEEN" })
		if Keyboard then
			local Hours = parseInt(Keyboard[1])
			local Minutes = parseInt(Keyboard[2])

			if Hours >= 24 or Hours <= 0 then
				Hours = 0
			end

			if Minutes >= 60 or Minutes <= 0 then
				Minutes = 0
			end

			GlobalState["Hours"] = Hours
			GlobalState["Minutes"] = Minutes
			GlobalState["Weather"] = Keyboard[3]
		end
	end
end)