-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("hud", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Work"] = 0
GlobalState["Points"] = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIME
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Hours"] = 7
GlobalState["Minutes"] = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBOS
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Roubos"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUPOM
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Cupom"] = { "HENSA.STORE", "Adquira já a sua Base" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		GlobalState["Work"] = GlobalState["Work"] + 1
		GlobalState["Points"] = GlobalState["Points"] + 1
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1

		if GlobalState["Points"] >= 30 then
			GlobalState["Points"] = 0
		end

		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0

				GlobalState["Roubos"] = "Sul e Norte"
			end

			if GlobalState["Hours"] >= 7 then
				GlobalState["Roubos"] = false
			end
		end

		Wait(10000)
	end
end)