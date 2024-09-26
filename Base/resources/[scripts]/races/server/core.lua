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
Tunnel.bindInterface("races",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Daily = {}
local Active = {}
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Finish(Number,Points)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] then
		if Active[Passport] then
			local Experience = vRP.GetExperience(Passport,"Runner")
			local Level = ClassCategory(Experience)
			local Valuation = Races[Number]["Price"] + (Percentage(Races[Number]["Price"],Level) * 3)

			Active[Passport] = nil
			exports["markers"]:Exit(source,Passport)
			vRP.PutExperience(Passport,"Runner",ExperienceRaces)
			vRP.GenerateItem(Passport,"dollars2",Valuation,true)

			if Daily[Passport] and Daily[Passport] > 0 then
				Daily[Passport] = Daily[Passport] - 1

				if Daily[Passport] <= 0 then
					Daily[Passport] = 0
				end
			end
		end

		local Vehicle = vRPC.VehicleName(source)
		local Consult = vRP.Query("Races/User",{ Race = Number, Passport = Passport })
		if Consult[1] then
			if Points < Consult[1]["Points"] then
				vRP.Query("Races/Update",{ Race = Number, Passport = Passport, Vehicle = Vehicle, Points = Points })
			end
		else
			vRP.Query("Races/Insert",{ Race = Number, Passport = Passport, Vehicle = Vehicle, Points = Points })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Start(Number)
	local Return = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] and vRP.TakeItem(Passport,"races",1,true) then
		Active[Passport] = true

		if Cooldown[Passport] and Cooldown[Passport] >= os.time() then
			Cooldown[Passport] = Cooldown[Passport] + 1800
		else
			Cooldown[Passport] = os.time() + 1800
		end

		Return = Races[Number]["Explosive"]
		exports["markers"]:Enter(source,"Corredor")

		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("Notify",Sources,"default","Encontramos um veículo participando de uma corrida clandestina e todos os policiais foram avisados.","Circuitos",10000)
			end)
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] then
		Active[Passport] = nil
		exports["markers"]:Exit(source,Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Ranking(Number)
	local Ranking = {}
	if Races[Number] then
		local Consult = vRP.Query("Races/Consult",{ Race = Number })

		for _,v in pairs(Consult) do
			Ranking[#Ranking + 1] = {
				["Runner"] = vRP.FullName(v["Passport"]),
				["Points"] = NumberHours(v["Points"] / 1000),
				["Vehicle"] = VehicleName(v["Vehicle"])
			}
		end
	end

	return Ranking
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Cooldown",function(Passport)
	if Cooldown[Passport] and Cooldown[Passport] >= os.time() then
		if not Daily[Passport] then
			Daily[Passport] = 0
		end

		Daily[Passport] = Daily[Passport] + 1

		return Daily[Passport]
	end

	return false
end)