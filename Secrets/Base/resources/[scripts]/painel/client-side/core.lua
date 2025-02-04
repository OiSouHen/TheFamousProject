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
Tunnel.bindInterface("painel",Creative)
vSERVER = Tunnel.getInterface("painel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Open(Data)
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ name = "open", payload = { Data } })

	vRP.CreateObjects("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_a","prop_cs_tablet",49,28422,-0.05,0.0,0.0,0.0,0.0, 0.0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invite",function(Data,Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Invite(Data["user_id"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("promote",function(Data,Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Hierarchy(Data["user_id"],"Promote"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("demote",function(Data,Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Hierarchy(Data["user_id"],"Demote"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dismiss",function(Data,Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Dismiss(Data["user_id"]))
	end
end)