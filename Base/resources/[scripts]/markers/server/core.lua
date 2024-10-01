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
Tunnel.bindInterface("markers",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timers = {}
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Users()
	local Markers = {}

	for Index,v in pairs(Players) do
		local Passport = v["Passport"]
		if Timers[Passport] and not Timers[Passport]["Stop"] and os.time() >= Timers[Passport]["Timer"] then
			exports["markers"]:Exit(Index,Passport)
		else
			local Ped = GetPlayerPed(Index)
			if DoesEntityExist(Ped) then
				Markers[Index] = {
					["Coords"] = GetEntityCoords(Ped),
					["Permission"] = v["Permission"]
				}
			end
		end
	end

	return Markers
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Enter",function(source,Permission,Passport,Timed)
	if not Players[source] then
		Players[source] = {
			["Permission"] = Permission,
			["Passport"] = Passport
		}

		if Timed then
			Timers[Passport] = {
				["Permission"] = Permission,
				["Timer"] = os.time() + Timed,
				["Stop"] = false
			}
		end

		local Service = vRP.NumPermission("Emergencia")
		for _,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("markers:Add",Sources,source,Permission)
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

		local Service = vRP.NumPermission("Emergencia")
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
		exports["markers"]:Enter(source,Timers[Passport]["Permission"],Passport,Timers[Passport]["Timer"])
	end
end)