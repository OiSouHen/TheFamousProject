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
				TriggerClientEvent("Notify",source,"amarelo","Rádio exclusiva para <b>"..Reserved[Number].."</b>.","Atenção",5000)
			end
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckRadio()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.InventoryItemAmount(Passport,"radio")
		if Consult[1] <= 0 then
			return true
		end
	end

	return false
end