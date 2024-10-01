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
Tunnel.bindInterface("dynamic", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Animals = {}
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
-- REGISTERANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RegisterAnimal(Hash)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Animals[Passport] = Hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ClearAnimal()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("DeletePed", Animals[Passport])
		Animals[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {
			["Caçador"] = vRP.GetExperience(Passport, "Hunter"),
			["Taxista"] = vRP.GetExperience(Passport, "Taxi"),
			["Jardineiro"] = vRP.GetExperience(Passport, "Cleaner"),
			["Lenhador"] = vRP.GetExperience(Passport, "Lumberman"),
			["Correios"] = vRP.GetExperience(Passport, "PostOp"),
			["Transportador"] = vRP.GetExperience(Passport, "Transporter"),
			["Caminhoneiro"] = vRP.GetExperience(Passport, "Trucker"),
			["Reciclagem"] = vRP.GetExperience(Passport, "Garbageman"),
			["Pescador"] = vRP.GetExperience(Passport, "Fisherman"),
			["Motorista"] = vRP.GetExperience(Passport, "Driver"),
			["Reboque"] = vRP.GetExperience(Passport, "Tows"),
			["Desmanche"] = vRP.GetExperience(Passport, "Dismantle"),
			["Entregador"] = vRP.GetExperience(Passport, "Delivery"),
			["Corredor"] = vRP.GetExperience(Passport, "Runner")
		}

		return Experiences
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDSTATS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PedStats()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Stats = {
			["Likes"] = vRP.GetLikes(Passport),
			["Unlikes"] = vRP.GetUnLikes(Passport)
		}

		return Stats
	end
end
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
-- DYNAMIC:SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Service")
AddEventHandler("dynamic:Service",function(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.ServiceToggle(source, Passport, Permission, false)

		TriggerClientEvent("dynamic:Close", source)
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
		vRP.ServiceLeave(source, Passport, Permission, false)

		TriggerClientEvent("dynamic:Close", source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Animals[Passport] then
		TriggerEvent("DeletePed", Animals[Passport])
		Animals[Passport] = nil
	end
end)