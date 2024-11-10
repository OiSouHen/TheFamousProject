-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("grime")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Lasted = 1
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("WorkGrime",Init["xyz"],0.75,0.75,{
		name = "WorkGrime",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "grime:Init",
				label = "Iniciar Entregas",
				tunnel = "client"
			},{
				event = "grime:Package",
				label = "Retirar Encomenda",
				tunnel = "server"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIME:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("grime:Init",function()
	if Active then
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end

		TriggerEvent("Notify","Central de Empregos","Você acaba finalizar sua jornada de trabalho, esperamos que você tenha aprendido bastante hoje.","default",5000)
		exports["target"]:LabelText("WorkGrime","Iniciar Expediente")
		Active = false
	else
		TriggerEvent("Notify","Central de Empregos","Você acaba de dar inicio a sua jornada de trabalho, lembrando que a sua vida não se resume só a isso.","default",5000)
		exports["target"]:LabelText("WorkGrime","Finalizar Expediente")
		Active = true

		repeat
			if Lasted == Selected then
				Selected = math.random(#Locations)
			end

			Wait(1)
		until Lasted ~= Selected

		MakeBlips()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Active and not IsPedInAnyVehicle(Ped) then
			local Vehicle = GetPlayersLastVehicle()
			if GetEntityArchetypeName(Vehicle) == Model then
				local Coords = GetEntityCoords(Ped)
				local Distance = #(Coords - Locations[Selected])

				if Distance <= 10.0 then
					TimeDistance = 1
					SetDrawOrigin(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
					DrawSprite("Textures","H",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
					ClearDrawOrigin()

					if Distance <= 1.0 and IsControlJustPressed(1,74) and vSERVER.Payment(Selected) then
						Lasted = Selected

						repeat
							if Lasted == Selected then
								Selected = math.random(#Locations)
							end

							Wait(1)
						until Lasted ~= Selected

						MakeBlips()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega")
	EndTextCommandSetBlipName(Blip)
end