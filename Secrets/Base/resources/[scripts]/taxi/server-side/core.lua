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
Creative = {}
Tunnel.bindInterface("taxi",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Locations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"taxi") or #(Coords - Locations[Selected]["Vehicle"]) > 5 then
			exports["discord"]:Embed("Hackers","**Passaporte:** "..Passport.."\n**Função:** Payment do Taxista",0xa3c846,source)
		end

		local GainExperience = 3
		local Amount = math.random(275,325)
		local Experience,Level = vRP.GetExperience(Passport,"Taxi")
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
		vRP.PutExperience(Passport,"Taxi",GainExperience)
		vRP.UpgradeStress(Passport,3)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)