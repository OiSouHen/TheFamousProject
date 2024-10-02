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
AddEventHandler("chat:ServerMessage",function(Tag,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Groups = vRP.Groups()
		local FullName = vRP.FullName(Passport)
		local Messages = Message:gsub("[<>]","")

		if not Groups[Tag] then
			if Tag == "ooc" then
				local Players = vRPC.ClosestPeds(source,10)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("chat:ClientMessage",v,FullName,Messages,Tag)
					end)
				end
			else
				TriggerClientEvent("chat:ClientMessage",-1,FullName,Messages,Tag)
			end
		else
			if vRP.GetHealth(source) > 100 and vRP.HasService(Passport,Tag) then
				local Service = vRP.NumPermission(Tag)
				for Passports,Sources in pairs(Service) do
					async(function()
						TriggerClientEvent("chat:ClientMessage",Sources,FullName,Messages,Tag)
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