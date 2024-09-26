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
Tunnel.bindInterface("deliver",Hensa)
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
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork(Work).."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKREQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckRequest(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Service == "Ballas" then
			if vRP.Request(source, Service, "Deseja entregar <b>"..ItemName(BallasItem).."</b>?") then
				return true
			end
		elseif Service == "Families" then
			if vRP.Request(source, Service, "Deseja entregar <b>"..ItemName(FamiliesItem).."</b>?") then
				return true
			end
		elseif Service == "Vagos" then
			if vRP.Request(source, Service, "Deseja entregar <b>"..ItemName(VagosItem).."</b>?") then
				return true
			end
		elseif Service == "Aztecas" then
			if vRP.Request(source, Service, "Deseja entregar <b>"..ItemName(AztecasItem).."</b>?") then
				return true
			end
		elseif Service == "Bloods" then
			if vRP.Request(source, Service, "Deseja entregar <b>"..ItemName(BloodsItem).."</b>?") then
				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckReputation()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local UnLikes = vRP.GetUnLikes(Passport)
		if UnLikes > 0 then
			return true
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não possúi reputação suficiente.", "Atenção", 5000)
		end

		return false
	end
end