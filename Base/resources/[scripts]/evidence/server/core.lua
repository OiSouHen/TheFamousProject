-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vCLIENT = Tunnel.getInterface("evidence")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local EvidencesNumber = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Evidences"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:Drop")
AddEventHandler("evidence:Drop",function(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Color = 1
		local Marker = {}

		if Type == "Yellow" then
			Color = 1
			Marker = { 244,197,50 }
		elseif Type == "Red" then
			Color = 2
			Marker = { 241,96,96 }
		elseif Type == "Green" then
			Color = 3
			Marker = { 140,212,91 }
		elseif Type == "Blue" then
			Color = 4
			Marker = { 70,140,245 }
		end

		EvidencesNumber = EvidencesNumber + 1

		local userCoords,gridZone = vCLIENT.GetPostions(source)
		local Evidences = GlobalState["Evidences"]

		if Evidences[gridZone] == nil then
			Evidences[gridZone] = {}
		end

		Evidences[gridZone][tostring(EvidencesNumber)] = { userCoords, tostring("evidence0"..Color.."-"..Passport.."-"..vRP.Identity(Passport)["License"]), Marker }

		GlobalState["Evidences"] = Evidences
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:Remove")
AddEventHandler("evidence:Remove",function(evidenceId,gridZone)
	if GlobalState["Evidences"][gridZone] then
		local Evidences = GlobalState["Evidences"]
		Evidences[gridZone][tostring(evidenceId)] = nil

		GlobalState["Evidences"] = Evidences
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:Pickup")
AddEventHandler("evidence:Pickup",function(evidenceId,gridZone)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["Evidences"][gridZone] then
			if GlobalState["Evidences"][gridZone][tostring(evidenceId)] then
				vRP.GenerateItem(Passport, GlobalState["Evidences"][gridZone][tostring(evidenceId)][2], 1, true)

				local Evidences = GlobalState["Evidences"]
				Evidences[gridZone][tostring(evidenceId)] = nil
				GlobalState["Evidences"] = Evidences
			end
		end
	end
end)