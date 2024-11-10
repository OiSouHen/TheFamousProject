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
vCLIENT = Tunnel.getInterface("chat")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage",function(Mode,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Groups = vRP.Groups()
		local FullName = vRP.FullName(Passport)
		local Messages = Message:gsub("[<>]","")

		if not Groups[Mode] then
			if Mode == "OOC" then
				local Players = vRPC.ClosestPeds(source,10)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("chat:ClientMessage",v,FullName,Messages,Mode)
					end)
				end
			else
				TriggerClientEvent("chat:ClientMessage",-1,FullName,Messages,Mode)
			end
		else
			if vRP.GetHealth(source) > 100 and vRP.HasService(Passport,Mode) then
				local Service = vRP.NumPermission(Mode)
				for Passports,Sources in pairs(Service) do
					async(function()
						TriggerClientEvent("chat:ClientMessage",Sources,FullName,Messages,Mode)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Open",function(source)
	return vCLIENT.Open(source)
end)