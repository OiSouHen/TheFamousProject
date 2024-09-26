-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = {}
local Sprays = {}
local Objects = {}
local Switch = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPRAYEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.SprayExist(Distance)
	local Return = false

	for Number,v in pairs(Sprays) do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local BlipCoords = GetBlipCoords(v["Blip"])

		if #(Coords - BlipCoords) <= (Distance or 250) then
			Return = v["Permission"]

			break
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Table")
AddEventHandler("objects:Table",function(Table)
	Objects = Table

	for Number,v in pairs(Objects) do
		if v["Mode"] then
			if (v["Mode"] == "LootMedics" or v["Mode"] == "LootWeapons" or v["Mode"] == "LootSupplies" or v["Mode"] == "LootLegendary") then
				local Blip = AddBlipForRadius(v["Coords"][1],v["Coords"][2],v["Coords"][3],25.0)
				SetBlipAlpha(Blip,200)

				if v["Mode"] == "LootMedics" then
					SetBlipColour(Blip,76)
				elseif v["Mode"] == "LootWeapons" then
					SetBlipColour(Blip,52)
				elseif v["Mode"] == "LootSupplies" then
					SetBlipColour(Blip,56)
				elseif v["Mode"] == "LootLegendary" then
					SetBlipColour(Blip,81)
				end
			elseif v["Mode"] == "Sprays" then
				if not Sprays[Number] then
					Sprays[Number] = {}
				end

				Sprays[Number]["Blip"] = AddBlipForRadius(v["Coords"][1],v["Coords"][2],v["Coords"][3],250.0)
				SetBlipColour(Sprays[Number]["Blip"],v["Color"])
				Sprays[Number]["Permission"] = v["Permission"]
				SetBlipAlpha(Sprays[Number]["Blip"],150)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Adicionar")
AddEventHandler("objects:Adicionar",function(Number,Table)
	Objects[Number] = Table

	if Table and Table["Mode"] and Table["Mode"] == "Sprays" then
		if not Sprays[Number] then
			Sprays[Number] = {}
		end

		Sprays[Number]["Blip"] = AddBlipForRadius(Table["Coords"][1],Table["Coords"][2],Table["Coords"][3],250.0)
		SetBlipColour(Sprays[Number]["Blip"],Table["Color"])
		Sprays[Number]["Permission"] = Table["Permission"]
		SetBlipAlpha(Sprays[Number]["Blip"],150)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Remover")
AddEventHandler("objects:Remover",function(Number)
	if Init[Number] then
		if DoesEntityExist(Init[Number]) then
			DeleteEntity(Init[Number])
		end

		if Objects[Number] and Objects[Number]["Mode"] then
			exports["target"]:RemCircleZone("Objects:"..Number)
		end

		Init[Number] = nil
	end

	if Objects[Number] and Objects[Number]["Active"] and Objects[Number]["Active"] == "Spikes" then
		TriggerEvent("spikes:Remover",Number)
	end

	if Sprays[Number] then
		if DoesBlipExist(Sprays[Number]["Blip"]) then
			RemoveBlip(Sprays[Number]["Blip"])
		end

		Sprays[Number] = nil
	end

	if Objects[Number] then
		Objects[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETLABEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetLabel(Number,Coords,Mode,Weight,Item)
	if Mode == "Store" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + Weight),0.75,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "inventory:StoreObjects",
					label = "Guardar",
					tunnel = "server"
				}
			}
		})
	elseif Mode == "Craftings" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + Weight),0.25,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "crafting:Open",
					label = "Abrir",
					tunnel = "products",
					service = SplitOne(Item)
				},{
					event = "inventory:StoreObjects",
					label = "Guardar",
					tunnel = "server"
				}
			}
		})
	elseif Mode == "Shops" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + Weight),0.45,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "shops:Open",
					label = "Abrir",
					tunnel = "products",
					service = SplitOne(Item)
				},{
					event = "inventory:StoreObjects",
					label = "Guardar",
					tunnel = "server"
				}
			}
		})
	elseif Mode == "Chests" and Item then
		local Split = splitString(Item)
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + Weight),1.4,1.7,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3] + 0.0,
			maxZ = Coords[3] + 1.5
		},{
			shop = Number,
			Distance = 1.75,
			options = {
				{
					event = "chest:Item",
					label = "Abrir",
					tunnel = "products",
					service = Split[1]..":"..Split[3]
				},{
					event = "inventory:StoreObjects",
					label = "Guardar",
					tunnel = "server"
				}
			}
		})
	elseif Mode == "Sprays" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + Weight),1.0,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 2.5,
			options = {
				{
					event = "inventory:StoreObjects",
					label = "Limpar",
					tunnel = "server"
				}
			}
		})
	elseif Mode == "Recycle" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 1.0),1.5,3.75,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3],
			maxZ = Coords[3] + 2.0
		},{
			Distance = 2.25,
			options = {
				{
					event = "chest:Recycle",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	elseif Mode == "LootLegendary" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 0.5),1.15,2.15,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3],
			maxZ = Coords[3] + 0.8
		},{
			shop = Number,
			Distance = 2.0,
			options = {
				{
					event = "inventory:Loot",
					label = "Abrir",
					tunnel = "server",
					service = Mode
				}
			}
		})
	elseif Mode == "LootSupplies" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 0.35),0.5,1.0,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3],
			maxZ = Coords[3] + 0.55
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "inventory:Loot",
					label = "Abrir",
					tunnel = "server",
					service = Mode
				}
			}
		})
	elseif Mode == "LootWeapons" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 0.35),0.9,1.5,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3],
			maxZ = Coords[3] + 0.65
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "inventory:Loot",
					label = "Abrir",
					tunnel = "server",
					service = Mode
				}
			}
		})
	elseif Mode == "LootMedics" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 0.15),0.75,1.0,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3] - 0.25,
			maxZ = Coords[3] + 0.55
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "inventory:Loot",
					label = "Abrir",
					tunnel = "server",
					service = Mode
				}
			}
		})
	elseif Mode == "LootCode" then
		exports["target"]:AddBoxZone("Objects:"..Number,vec3(Coords[1],Coords[2],Coords[3] + 1.0),1.0,1.0,{
			name = "Objects:"..Number,
			heading = Coords[4] or 0.0,
			minZ = Coords[3] - 0.0,
			maxZ = Coords[3] + 1.75
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "inventory:Loot",
					label = "Abrir",
					tunnel = "server",
					service = Mode
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Objects) do
			if not v["Route"] or v["Route"] == LocalPlayer["state"]["Route"] then
				local OtherCoords = vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3])
				if #(Coords - OtherCoords) <= (v["Distance"] or 100) then
					if not Init[Number] and LoadModel(v["Object"]) then
						Init[Number] = CreateObjectNoOffset(v["Object"],OtherCoords,false,false,false)
						SetEntityHeading(Init[Number],v["Coords"][4])
						FreezeEntityPosition(Init[Number],true)
						SetModelAsNoLongerNeeded(v["Object"])

						if v["Mode"] then
							TargetLabel(Number,v["Coords"],v["Mode"],v["Weight"] or 0.0,v["Item"])
						end

						if not v["Ground"] then
							PlaceObjectOnGroundProperly(Init[Number])
						end

						if v["Active"] and v["Active"] == "Spikes" then
							local Max = GetOffsetFromEntityInWorldCoords(Init[Number],0.0,1.84,0.1)
							local Min = GetOffsetFromEntityInWorldCoords(Init[Number],0.0,-1.84,-0.1)

							TriggerEvent("spikes:Adicionar",Number,v["Coords"],Min,Max)
						end
					end
				elseif Init[Number] then
					DestroyObject(Number,v)
				end
			elseif Init[Number] then
				DestroyObject(Number,v)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function DestroyObject(Number,v)
	if Init[Number] then
		if v["Mode"] then
			exports["target"]:RemCircleZone("Objects:"..Number)
		end

		if DoesEntityExist(Init[Number]) then
			DeleteEntity(Init[Number])
		end

		if v["Active"] and v["Active"] == "Spikes" then
			TriggerEvent("spikes:Remover",Number)
		end

		Init[Number] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTCONTROLLING
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ObjectControlling(Model,Rotate,Align)
	local Aplication = false
	local OtherCoords = false

	if LoadModel(Model) then
		local Progress = true
		local Ped = PlayerPedId()
		local Heading = GetEntityHeading(Ped)
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,Align or 1.0,0.0)
		local NextObject = CreateObjectNoOffset(Model,Coords["x"],Coords["y"],Coords["z"],false,false,false)
		SetEntityHeading(NextObject,Heading + (Rotate or 0.0))
		SetEntityAlpha(NextObject,175,false)
		PlaceObjectOnGroundProperly(NextObject)
		SetEntityCollision(NextObject,false,false)

		TriggerEvent("inventory:Buttons",{
			{ "F","Cancelar" },
			{ "H","Posicionar" },
			{ "Q","Rotacionar Esquerda" },
			{ "E","Rotacionar Direita" },
			{ "Z","Trocar Modo" }
		})

		while Progress do
			if not Switch then
				local Ped = PlayerPedId()
				local Cam = GetGameplayCamCoord()
				local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,GetCoordsFromCam(10.0,Cam),-1,Ped,4)
				local _,_,Coords = GetShapeTestResult(Handle)

				SetEntityCoords(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false,false)
			else
				if IsDisabledControlPressed(1,314) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,0.0,0.0,0.005)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				if IsDisabledControlPressed(1,315) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,0.0,0.0,-0.005)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				if IsDisabledControlPressed(1,172) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,0.0,0.005,0.0)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				if IsDisabledControlPressed(1,173) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,0.0,-0.005,0.0)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				if IsDisabledControlPressed(1,174) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,-0.005,0.0,0.0)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				if IsDisabledControlPressed(1,175) then
					local Coords = GetOffsetFromEntityInWorldCoords(NextObject,0.005,0.0,0.0)
					SetEntityCoordsNoOffset(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false)
				end

				DrawGraphOutline(NextObject)
			end

			if IsControlPressed(0,38) then
				local Heading = GetEntityHeading(NextObject)
				SetEntityHeading(NextObject,Heading + 0.25)
			end

			if IsControlPressed(0,52) then
				local Heading = GetEntityHeading(NextObject)
				SetEntityHeading(NextObject,Heading - 0.25)
			end

			if IsControlJustPressed(0,48) then
				Switch = not Switch

				if Switch then
					TriggerEvent("inventory:Buttons",{
						{ "F","Cancelar" },
						{ "H","Posicionar" },
						{ "Q","Rotacionar Esquerda" },
						{ "E","Rotacionar Direita" },
						{ "-","Descer" },
						{ "+","Subir" },
						{ "↑","Movimentar para Frente" },
						{ "←","Movimentar para Esquerda" },
						{ "↓","Movimentar para Baixo" },
						{ "→","Movimentar para Direita" },
						{ "Z","Trocar Modo" }
					})
				else
					TriggerEvent("inventory:Buttons",{
						{ "F","Cancelar" },
						{ "H","Posicionar" },
						{ "Q","Rotacionar Esquerda" },
						{ "E","Rotacionar Direita" },
						{ "Z","Trocar Modo" }
					})
				end
			end

			if IsControlJustPressed(1,74) then
				TriggerEvent("inventory:CloseButtons")
				Aplication = true
				Progress = false
				Switch = false
			end

			if IsControlJustPressed(0,49) then
				TriggerEvent("inventory:CloseButtons")
				Aplication = false
				Progress = false
				Switch = false
			end

			Wait(1)
		end

		if NextObject and DoesEntityExist(NextObject) then
			local oCoords = GetEntityCoords(NextObject)
			local oHeading = GetEntityHeading(NextObject)

			OtherCoords = { Optimize(oCoords["x"]),Optimize(oCoords["y"]),Optimize(oCoords["z"]),Optimize(oHeading) }

			DeleteEntity(NextObject)
		end
	end

	return Aplication,OtherCoords
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWGRAPHOUTLINE
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawGraphOutline(Object)
	local Coords = GetEntityCoords(Object)
	local x,y,z = Coords - GetOffsetFromEntityInWorldCoords(Object,2.0,0.0,0.0),Coords - GetOffsetFromEntityInWorldCoords(Object,0.0,2.0,0.0),Coords - GetOffsetFromEntityInWorldCoords(Object,0.0,0.0,2.0)
	local x1,x2,y1,y2,z1,z2 = Coords - x,Coords + x,Coords - y,Coords + y,Coords - z,Coords + z

	DrawLine(x1["x"],x1["y"],x1["z"],x2["x"],x2["y"],x2["z"],255,0,0,255)
	DrawLine(y1["x"],y1["y"],y1["z"],y2["x"],y2["y"],y2["z"],0,0,255,255)
	DrawLine(z1["x"],z1["y"],z1["z"],z2["x"],z2["y"],z2["z"],0,255,0,255)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjusted = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.cos(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.sin(Adjusted[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end