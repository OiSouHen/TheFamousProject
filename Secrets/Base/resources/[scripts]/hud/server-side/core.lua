-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
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
	if Passport and vRP.HasGroup(Passport,"Admin",2) then
		GlobalState["Hours"] = parseInt(Message[1])
		GlobalState["Minutes"] = parseInt(Message[2])

		if Message[3] then
			GlobalState["Weather"] = Message[3]
		end
	end
end)