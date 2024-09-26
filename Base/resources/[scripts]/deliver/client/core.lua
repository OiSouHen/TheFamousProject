-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("deliver")
vINVENTORY = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Worked = nil
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Name,v in pairs(List) do
		if v["Drugs"] then
			exports["target"]:AddCircleZone("Deliver:"..Name,v["Coords"],v["Weight"][1],{
				name = "Deliver:"..Name,
				heading = 0.0,
				useZ = true
			},{
				shop = Name,
				Distance = v["Weight"][2],
				options = {
					{
						event = "deliver:Init",
						tunnel = "shop",
						label = "Vender em Rota"
					}, {
						event = "deliver:Drugs",
						tunnel = "shop",
						label = "Vender na Rua"
					}
				}
			})
		else
			exports["target"]:AddCircleZone("Deliver:"..Name,v["Coords"],v["Weight"][1],{
				name = "Deliver:"..Name,
				heading = 0.0,
				useZ = true
			},{
				shop = Name,
				Distance = v["Weight"][2],
				options = {
					{
						event = "deliver:Init",
						tunnel = "shop",
						label = "Trabalhar"
					}
				}
			})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER:DRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("deliver:Drugs",function(Service)
	local Permission = List[Service]["Permission"]
	if Permission and not LocalPlayer["state"][Permission] then
		TriggerEvent("Notify", "vermelho", "Você não tem permissões para isso.", "Aviso", 5000)
		return false
	end

	if LocalPlayer["state"]["Drugs"] then
		LocalPlayer["state"]["Drugs"] = false
		TriggerEvent("Notify", "amarelo", "Você desativou as vendas na rua.", "Atenção", 5000)
	else
		if vSERVER.CheckReputation() then
			LocalPlayer["state"]["Drugs"] = true
			TriggerEvent("Notify", "verde", "Você ativou as vendas na rua.", "Sucesso", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("deliver:Init",function(Service)
	if Locations[Service] then
		local Permission = List[Service]["Permission"]
		if Permission and not LocalPlayer["state"][Permission] then
			TriggerEvent("Notify", "vermelho", "Você não tem permissões para isso.", "Aviso", 5000)
			return false
		end

		local Work = List[Service]["Work"]
		if Work and not vSERVER.CheckWork(Work) then
			return false
		end

		if not Work and not Progress and not vSERVER.CheckRequest(Service) then
			return false
		end

		if Progress then
			Worked = nil
			Progress = false
			TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Trabalhar")
			end

			if Blip and DoesBlipExist(Blip) then
				RemoveBlip(Blip)
				Blip = nil
			end
		else
			Progress = true
			Worked = Service
			BlipMarkerService()
			TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Finalizar")
			end

			while Progress do
				local TimeDistance = 999
				local Ped = PlayerPedId()
				if not IsPedInAnyVehicle(Ped) then
					local Coords = GetEntityCoords(Ped)
					local Selected = List[Worked]["Locate"]
					local Distance = #(Coords - Locations[Worked][Selected])

					if Distance <= 25.0 then
						TimeDistance = 1
						DrawText3D(Locations[Worked][Selected],"~g~G~w~   "..List[Worked]["Label"])

						if Distance <= 1.0 and IsControlJustPressed(1,47) and vINVENTORY.Deliver(Worked) then
							if List[Worked]["Route"] then
								if Selected >= #Locations[Worked] then
									List[Worked]["Locate"] = 1
								else
									List[Worked]["Locate"] = List[Worked]["Locate"] + 1
								end
							else
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
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"])

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(200,200,200,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 350
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,200)
	end
end
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