-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("routes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Initial = {}
local Selectedz = 1
local Actived = false
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Initial = Config

	for Name in pairs(Config) do
		for Index,v in pairs(Initial[Name]["List"]) do
			Initial[Name]["List"][Index] = {
				["Index"] = v["Item"],
				["Name"] = ItemName(v["Item"]),
				["Price"] = v["Price"],
				["Active"] = false
			}
		end

		exports["target"]:AddCircleZone("Routes:"..Name,Initial[Name]["Init"],Initial[Name]["Circle"],{
			name = "Routes:"..Name,
			heading = 0.0,
			useZ = true,
			debugPoly = Initial[Name]["DebugPoly"]
		},{
			shop = Name,
			Distance = 2.0,
			options = {
				{
					event = "routes:Open",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUTES:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("routes:Open",function(Name)
	if not Progress or (Progress and Progress == Name) then
		if vSERVER.Permission(Name) then
			SetNuiFocus(true,true)
			SendNUIMessage({ Action = "Open", Payload = { Progress and true or false,Actived or Initial[Name]["List"],Name } })
		end
	else
		TriggerEvent("Notify","Atenção","Volte no emprego de <b>"..Progress.."</b> e finalize o mesmo.","amarelo",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Start",function(Data,Callback)
	Progress = Data["Name"]

	if Initial[Progress] then
		Selectedz = 1
		Actived = Initial[Progress]["List"]
		BlipMarkerService()
	end

	for Index,Number in pairs(Data["Items"]) do
		if Actived and Actived[Number] then
			Actived[Number]["Active"] = true
		end
	end

	Callback(vSERVER.Start(Data["Items"],Progress))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Finish",function(Data,Callback)
	if vSERVER.Finish() then
		Actived = false
		Progress = false

		if Blip and DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end
	end

	Callback(Progress and true or false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Progress then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)
				local Distance = #(Coords - Initial[Progress]["Coords"][Selectedz])

				if Distance <= 10.0 then
					TimeDistance = 1
					SetDrawOrigin(Initial[Progress]["Coords"][Selectedz]["x"],Initial[Progress]["Coords"][Selectedz]["y"],Initial[Progress]["Coords"][Selectedz]["z"])
					DrawSprite("Textures","H",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
					ClearDrawOrigin()

					if Distance <= 1.0 and IsControlJustPressed(1,74) and vSERVER.Deliver() then
						if Initial[Progress]["Route"] then
							if Selectedz >= #Initial[Progress]["Coords"] then
								Selectedz = 1
							else
								Selectedz = Selectedz + 1
							end
						else
							local Lasted = Selectedz

							repeat
								if Lasted == Selectedz then
									Selectedz = math.random(#Initial[Progress]["Coords"])
								end

								Wait(1)
							until Lasted ~= Selectedz

							Selectedz = math.random(#Initial[Progress]["Coords"])
						end

						BlipMarkerService()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPMARKERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipMarkerService()
	if Blip and DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	if Progress then
		Blip = AddBlipForCoord(Initial[Progress]["Coords"][Selectedz])
		SetBlipSprite(Blip,1)
		SetBlipColour(Blip,77)
		SetBlipScale(Blip,0.5)
		SetBlipRoute(Blip,true)
		SetBlipAsShortRange(Blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Entrega")
		EndTextCommandSetBlipName(Blip)
	end
end