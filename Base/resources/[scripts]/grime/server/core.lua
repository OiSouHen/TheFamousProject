-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("grime",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIME:PACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("grime:Package")
AddEventHandler("grime:Package",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.CheckWeight(Passport,Item,1) then
			vRP.GenerateItem(Passport,Item,1,true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","roxo",5000)
			exports["inventory"]:Drops(Passport,source,Item,1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vRPC.LastVehicle(source,Model) then
			TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Go Postal</b>.","amarelo",5000)

			return false
		end

		if vRP.TakeItem(Passport,Item,1,true) then
			Active[Passport] = true

			local Coords = vRP.GetEntityCoords(source)
			if not Selected or #(Coords - Locations[Selected]) > 2.5 then
				exports["discord"]:Embed("Hackers","**Passaporte:** "..Passport.."\n**Função:** Payment do Grime",0xa3c846,source)
			end

			local GainExperience = 3
			local Amount = math.random(175,275)
			local Experience,Level = vRP.GetExperience(Passport,"Grime")
			local Valuation = Amount + Amount * (0.05 * Level)

			if exports["inventory"]:Buffs("Dexterity",Passport) then
				Valuation = Valuation + (Valuation * 0.1)
			end

			if vRP.UserPremium(Passport) then
				local Bonification = 0.05
				local Hierarchy = vRP.LevelPremium(source)

				if Hierarchy == 1 then
					Bonification = 0.100
				elseif Hierarchy == 2 then
					Bonification = 0.075
				end

				GainExperience = GainExperience + 2
				Valuation = Valuation + (Valuation * Bonification)
			end

			vRP.GenerateItem(Passport,"dollar",Valuation,true)
			vRP.PutExperience(Passport,"Grime",GainExperience)
			vRP.UpgradeStress(Passport,3)

			Active[Passport] = nil

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)