-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("radio",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESERVED
-----------------------------------------------------------------------------------------------------------------------------------------
local Reserved = {
	[911] = "Policia",
	[912] = "Policia",
	[913] = "Policia",
	[914] = "Policia",
	[915] = "Policia",
	[916] = "Policia",
	[917] = "Policia",
	[918] = "Policia",
	[919] = "Policia",
	[920] = "Policia",
	[112] = "Paramedico",
	[113] = "Paramedico",
	[114] = "Paramedico"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Frequency(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		if Reserved[Number] then
			if vRP.HasService(Passport,Reserved[Number]) then
				return true
			else
				TriggerClientEvent("Notify",source,"Radiofrequência","Frequência exclusiva para <b>"..Reserved[Number].."</b>.","roxo",5000)
			end
		else
			return true
		end
	end

	return false
end