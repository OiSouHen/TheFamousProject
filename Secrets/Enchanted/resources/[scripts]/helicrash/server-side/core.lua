-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helibox"] = 0
GlobalState["Helifire"] = 0
GlobalState["Helicrash"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("helicrash",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and not GlobalState["Helicrash"] and vRP.HasGroup(Passport,"Admin") and Message[1] then
		local Selected = parseInt(Message[1])
		if Components[Selected] then
			for Number = 1,CountTable(Components[Selected]["Coords"]) do
				TriggerEvent("chest:Cooldown","Helicrash:"..Number)
				vRP.MountContainer(Passport,"Helicrash:"..Number,Loots,math.random(3,5))
			end

			TriggerClientEvent("Notify",-1,"Queda da Aeronave","Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.","ilegal",30000)
			GlobalState["Helibox"] = CountTable(Components[Selected]["Coords"])
			GlobalState["Helifire"] = GlobalState["Work"] + 60
			GlobalState["Helicrash"] = Selected
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Helibox",nil,function(Name,Key,Value)
	if Value <= 0 then
		GlobalState["Helicrash"] = false
	end
end)