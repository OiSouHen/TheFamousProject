-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CODES
-----------------------------------------------------------------------------------------------------------------------------------------
local Codes = {
	["13"] = {
		["Message"] = "Oficial desmaiado/ferido",
		["Blip"] = 6
	},
	["20"] = {
		["Message"] = "Localização",
		["Blip"] = 6
	},
	["38"] = {
		["Message"] = "Abordagem de trânsito",
		["Blip"] = 6
	},
	["78"] = {
		["Message"] = "Apoio com prioridade",
		["Blip"] = 6
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Tencode")
AddEventHandler("dynamic:Tencode",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") and Codes[Number] then
		local FullName = vRP.FullName(Passport)
		local Coords = vRP.GetEntityCoords(source)
		local Service = vRP.NumPermission("Policia")

		for Passports,Sources in pairs(Service) do
			async(function()
				if Number == "13" then
					TriggerClientEvent("sounds:Private",Sources,"deathcop",0.5)
				else
					vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				end

				TriggerClientEvent("NotifyPush",Sources,{ code = Number, title = Codes[Number]["Message"], x = Coords["x"], y = Coords["y"], z = Coords["z"], name = FullName, color = Codes[Number]["Blip"] })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ENTERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EnterService")
AddEventHandler("dynamic:EnterService",function(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Permission == "Policia" then
			if vRP.HasPermission(Passport,"LSPD") then
				vRP.ServiceEnter(source,Passport,"LSPD")
			elseif vRP.HasPermission(Passport,"BCPR") then
				vRP.ServiceEnter(source,Passport,"BCPR")
			elseif vRP.HasPermission(Passport,"BCSO") then
				vRP.ServiceEnter(source,Passport,"BCSO")
			end
		else
			vRP.ServiceEnter(source,Passport,Permission)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EXITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:ExitService")
AddEventHandler("dynamic:ExitService",function(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Permission == "Policia" then
			if vRP.HasPermission(Passport,"LSPD") then
				vRP.ServiceLeave(source,Passport,"LSPD")
			elseif vRP.HasPermission(Passport,"BCPR") then
				vRP.ServiceLeave(source,Passport,"BCPR")
			elseif vRP.HasPermission(Passport,"BCSO") then
				vRP.ServiceLeave(source,Passport,"BCSO")
			end
		else
			vRP.ServiceLeave(source,Passport,Permission)
		end
	end
end)