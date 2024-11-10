-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vINVENTORY = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Worked = nil
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(List) do
		exports["target"]:AddBoxZone("Deliver:"..Name,v["Coords"],0.75,0.75,{
			name = "Deliver:"..Name,
			heading = 0.0,
			minZ = v["Coords"]["z"] - 1.0,
			maxZ = v["Coords"]["z"] + 1.0
		},{
			shop = Name,
			Distance = 1.75,
			options = {
				{
					event = "deliver:Init",
					tunnel = "client",
					label = "Iniciar Expediente"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("deliver:Init",function(Service)
	if Locations[Service] then
		if Progress then
			Worked = nil
			Progress = false
			TriggerEvent("Notify","Central de Empregos","Você acaba finalizar sua jornada de trabalho, esperamos que você tenha aprendido bastante hoje.","default",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Iniciar Expediente")
			end

			if Blip and DoesBlipExist(Blip) then
				RemoveBlip(Blip)
				Blip = nil
			end
		else
			Progress = true
			Worked = Service
			BlipMarkerService()
			TriggerEvent("Notify","Central de Empregos","Você acaba de dar inicio a sua jornada de trabalho, lembrando que a sua vida não se resume só a isso.","default",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Finalizar Expediente")
			end

			while Progress do
				local TimeDistance = 999
				local Ped = PlayerPedId()
				if not IsPedInAnyVehicle(Ped) then
					local Coords = GetEntityCoords(Ped)
					local Selected = List[Worked]["Locate"]
					local Distance = #(Coords - Locations[Worked][Selected])

					if Distance <= 10.0 then
						TimeDistance = 1
						SetDrawOrigin(Locations[Worked][Selected]["x"],Locations[Worked][Selected]["y"],Locations[Worked][Selected]["z"])
						DrawSprite("Textures","H",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
						ClearDrawOrigin()

						if Distance <= 1.0 and IsControlJustPressed(1,74) and vINVENTORY.Deliver(Worked) then
							if List[Worked]["Route"] then
								if Selected >= #Locations[Worked] then
									List[Worked]["Locate"] = 1
								else
									List[Worked]["Locate"] = List[Worked]["Locate"] + 1
								end
							else
								local Lasted = List[Worked]["Locate"]

								repeat
									if Lasted == List[Worked]["Locate"] then
										List[Worked]["Locate"] = math.random(#Locations)
									end

									Wait(1)
								until Lasted ~= List[Worked]["Locate"]

								List[Worked]["Locate"] = math.random(#Locations[Worked])
							end

							BlipMarkerService()
						end
					end
				end

				Wait(TimeDistance)
			end
		end
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

	if Worked then
		local Selected = List[Worked]["Locate"]
		local Coords = Locations[Worked][Selected]
		Blip = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])
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