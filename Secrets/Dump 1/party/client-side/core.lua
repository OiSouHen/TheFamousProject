-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("party")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {}
local Open = false
local Display = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Partys",function()
	local Ped = PlayerPedId()
	if not Open and not IsPedInAnyVehicle(Ped) then
		Open = true
		SetNuiFocus(true,true)
		SendNUIMessage({ Action = "Open", Payload = { LocalPlayer["state"]["Passport"],vSERVER.GetRooms() } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Displays",function()
	Display = not Display

	if Display then
		TriggerEvent("Notify","Grupos","Nome dos participantes ativado.","verde",5000)
	else
		TriggerEvent("Notify","Grupos","Nome dos participantes desativado.","vermelho",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Partys","Abrir os grupos","keyboard","G")
RegisterKeyMapping("Displays","Mostrar/Esconder membros do grupo","keyboard","I")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROOMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetRooms",function(Data,Callback)
	Callback(vSERVER.GetRooms())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMEMBERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetMembers",function(Data,Callback)
	Callback(vSERVER.GetMembers(Data["Id"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("LeaveRoom",function(Data,Callback)
	Callback(vSERVER.LeaveRoom())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CreateRoom",function(Data,Callback)
	Callback(vSERVER.CreateRoom(Data["Name"],Data["Password"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("KickRoom",function(Data,Callback)
	Callback(vSERVER.KickRoom(Data["Room"],Data["Passport"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("EnterRoom",function(Data,Callback)
	Callback(vSERVER.EnterRoom(Data["Room"],Data["Password"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	Open = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY:RESETNUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("party:ResetNui")
AddEventHandler("party:ResetNui",function()
	if Open then
		Open = false
		SetNuiFocus(false,false)
		SendNUIMessage({ Action = "Close" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY:INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("party:Invite")
AddEventHandler("party:Invite",function(Source,Name)
	List[Source] = Name
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY:DISMISS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("party:Dismiss")
AddEventHandler("party:Dismiss",function(Source)
	if List[Source] then
		List[Source] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY:CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("party:Clear")
AddEventHandler("party:Clear",function()
	List = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}
	for _,Entity in pairs(GetGamePool("CPed")) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Entity ~= PlayerPedId() and Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[GetPlayerServerId(Index)] = Entity
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] and not IsPauseMenuActive() and Display then
			local Ped = PlayerPedId()
			local Players = GetPlayers()
			local Coords = GetEntityCoords(Ped)

			for Source,v in pairs(Players) do
				if List[Source] then
					local OtherCoords = GetEntityCoords(v)

					if #(Coords - OtherCoords) <= 25 then
						TimeDistance = 1
						DrawText3D(OtherCoords,"~w~"..List[Source],0.45)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text,Weight)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1.25)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextDropShadow()
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)
	end
end