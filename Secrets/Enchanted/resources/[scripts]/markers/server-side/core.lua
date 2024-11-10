-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("markers",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timers = {}
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Users()
	local Markers = {}

	for Source,v in pairs(Players) do
		local Passport = v["Passport"]
		if Timers[Passport] and not Timers[Passport]["Stop"] and os.time() >= Timers[Passport]["Timer"] then
			exports["markers"]:Exit(Source,Passport)
		else
			local Ped = GetPlayerPed(Source)
			if DoesEntityExist(Ped) then
				Markers[Source] = {
					["Coords"] = GetEntityCoords(Ped),
					["Permission"] = v["Permission"],
					["Level"] = v["Level"]
				}
			end
		end
	end

	return Markers
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Enter",function(source,Permission,Level,Passport,Timed)
	if not Players[source] then
		Players[source] = {
			["Passport"] = Passport,
			["Permission"] = Permission,
			["Level"] = vRP.NameHierarchy(Permission,Level)
		}

		if Timed then
			Timers[Passport] = {
				["Permission"] = Permission,
				["Timer"] = os.time() + Timed,
				["Level"] = Level or 1,
				["Stop"] = false
			}
		end

		local Service = vRP.NumPermission("Policia")
		for _,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("markers:Add",Sources,source,Players[source])
			end)
		end

		TriggerClientEvent("markers:Full",source,Players)
	else
		if Timed and Timers[Passport] then
			if os.time() > Timers[Passport]["Timer"] then
				Timers[Passport]["Timer"] = os.time() + Timed
			else
				Timers[Passport]["Timer"] = Timers[Passport]["Timer"] + Timed
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Exit",function(source,Passport)
	if Players[source] then
		Players[source] = nil

		local Service = vRP.NumPermission("Policia")
		for _,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("markers:Remove",Sources,source)
			end)
		end
	end

	if Timers[Passport] then
		if Timers[Passport]["Timer"] > os.time() then
			Timers[Passport]["Stop"] = true
			Timers[Passport]["Timer"] = Timers[Passport]["Timer"] - os.time()
		else
			Timers[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	exports["markers"]:Exit(source,Passport)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	if Timers[Passport] then
		exports["markers"]:Enter(source,Timers[Passport]["Permission"],Timers[Passport]["Level"],Passport,Timers[Passport]["Timer"])
	end
end)