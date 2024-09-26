-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Attached = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Tow")
AddEventHandler("inventory:Tow",function(Selected)
	local Ped = PlayerPedId()
	local Selected = Selected[3]
	local Vehicle = GetLastDrivenVehicle()
	if DoesEntityExist(Selected) and DoesEntityExist(Vehicle) and not Entity(Selected)["state"]["Tower"] and GetEntityArchetypeName(Vehicle) == "flatbed" and not IsPedInAnyVehicle(Ped) then
		local Coords = GetEntityCoords(Selected)
		local OtherCoords = GetEntityCoords(Vehicle)

		if #(Coords - OtherCoords) <= 15 then
			if Entity(Selected)["state"]["Tow"] then
				TriggerServerEvent("inventory:Tow",VehToNet(Vehicle),VehToNet(Selected),false)
			else
				LocalPlayer["state"]["Cancel"] = true
				LocalPlayer["state"]["Commands"] = true

				TaskTurnPedToFaceEntity(Ped,Tower,5000)
				TriggerEvent("sounds:Private","tow",0.5)
				vRP.playAnim(false,{"mini@repair","fixing_a_player"},true)

				SetTimeout(5000,function()
					vRP.Destroy()

					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					Entity(Vehicle)["state"]:set("Tow",true,true)
					Entity(Selected)["state"]:set("Tow",true,true)

					TriggerServerEvent("inventory:Tow",VehToNet(Vehicle),VehToNet(Selected),true)
				end)
			end
		else
			TriggerEvent("Notify","Aviso","O reboque precisa estar próximo do veículo.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLIENTTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ClientTow")
AddEventHandler("inventory:ClientTow",function(Vehicle,Selected,Mode)
	if NetworkDoesNetworkIdExist(Vehicle) and NetworkDoesNetworkIdExist(Selected) then
		local Vehicle = NetToEnt(Vehicle)
		local Selected = NetToEnt(Selected)
		if DoesEntityExist(Vehicle) and DoesEntityExist(Selected) then
			if Mode then
				local Model = GetEntityModel(Selected)
				local Dimensions = GetModelDimensions(Model)

				AttachEntityToEntity(Selected,Vehicle,GetEntityBoneIndexByName(Vehicle,"bodyshell"),0,-2.2,0.4 - Dimensions["z"],0,0,0,true,true,true,true,2,true)
			else
				DetachEntity(Selected,false,false)

				local Heading = GetEntityHeading(Vehicle)
				local Coords = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-10.0,0.0)
				SetEntityCoords(Selected,Coords["x"],Coords["y"],Coords["z"],false,false,false,false)
				SetEntityHeading(Selected,Heading)
				SetVehicleOnGroundProperly(Selected)

				if Entity(Vehicle)["state"]["Tow"] then
					Entity(Vehicle)["state"]:set("Tow",nil,true)
				end

				if Entity(Selected)["state"]["Tow"] then
					Entity(Selected)["state"]:set("Tow",nil,true)
				end
			end
		end
	end
end)