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
Tunnel.bindInterface("trucker",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Delay = {}
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDELAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckDelay()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Delay[Passport] then
			if vRP.UserPremium(Passport) then
				if Delay[Passport] >= 2 then
					TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite diário.","Atenção",5000)
					return true
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite diário.","Atenção",5000)
				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckWork(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetWork(Passport) == Work then
			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork(Work).."</b> para conseguir trabalhar aqui.","Atenção",5000)
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Payment(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if Delay[Passport] == nil then
			Delay[Passport] = 0
		end

		local Coords = vRP.GetEntityCoords(source)
		if not vRPC.LastVehicle(source,"packer") or #(Coords - vec3(1256.59,-3239.63,5.17)) > 25 then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Trucker",0xa3c846)
		end

		local Experience = vRP.GetExperience(Passport,"Trucker")
		local Level = ClassCategory(Experience)
		local Valuation = math.random(1825,2525)

		if Level == 2 then
			Valuation = Valuation + 150
		elseif Level == 3 then
			Valuation = Valuation + 250
		elseif Level == 4 then
			Valuation = Valuation + 350
		elseif Level == 5 then
			Valuation = Valuation + 450
		elseif Level == 6 then
			Valuation = Valuation + 550
		elseif Level == 7 then
			Valuation = Valuation + 650
		elseif Level == 8 then
			Valuation = Valuation + 750
		elseif Level == 9 then
			Valuation = Valuation + 850
		elseif Level == 10 then
			Valuation = Valuation + 950
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
		vRP.PutExperience(Passport,"Trucker",1)

		if Service == "Vehicles" then
			vRP.GenerateItem(Passport,"lockpick",math.random(3),true)
		elseif Service == "Diesel" then
			vRP.GenerateItem(Passport,"oilgallon",math.random(3),true)
		elseif Service == "Fuel" then
			vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",math.random(150,300),true)
		elseif Service == "Wood" then
			vRP.GenerateItem(Passport,"woodlog",math.random(5,10),true)
		end

		Delay[Passport] = Delay[Passport] + 1
		Active[Passport] = nil
	end
end