-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Index,v in pairs(Plants) do
				if v["Route"] == LocalPlayer["state"]["Route"] then
					local OtherCoords = vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3])
					if #(Coords - OtherCoords) <= 50 then
						if not Objects[Index] then
							exports["target"]:AddBoxZone("Plants:"..Index,vec3(OtherCoords["x"],OtherCoords["y"],OtherCoords["z"] + 0.25),0.4,0.4,{
								name = "Plants:"..Index,
								heading = v["Coords"][4],
								minZ = OtherCoords["z"] + 0.50,
								maxZ = OtherCoords["z"] + 1.50
							},{
								shop = Index,
								Distance = 1.5,
								options = {
									{
										event = "plants:Informations",
										label = "Verificar",
										tunnel = "client"
									}
								}
							})

							CreateModels(Index,v["Hash"],v["Coords"])
							TimeDistance = 100
						end
					elseif Objects[Index] then
						ClearObjects(Index)
					end
				elseif Objects[Index] then
					ClearObjects(Index)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plants:Informations",function(Number)
	local Informations = vSERVER.Informations(Number)
	if Informations then
		exports["dynamic"]:AddButton("Germinação","Tipo de Frutos: <rare>"..ItemName(Informations[3]).."</rare>","","",false,false)
		exports["dynamic"]:AddButton("Fototropismo",Informations[1],"plants:Collect",Number,false,true)
		exports["dynamic"]:AddButton("Fertilização",Informations[2],"plants:Cloning",Number,false,true)
		exports["dynamic"]:AddButton("Hidratação","Fortificação do Adubo: <epic>"..math.floor(Informations[4] * 100).."%</epic>","plants:Water",Number,false,true)

		exports["dynamic"]:Open()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateModels(Number,Hash,Coords)
	if LoadModel(Hash) then
		Objects[Number] = CreateObjectNoOffset(Hash,Coords[1],Coords[2],Coords[3],false,false,false)

		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			SetEntityNoCollisionEntity(Objects[Number],GetVehiclePedIsUsing(Ped),false)
		end

		SetEntityHeading(Objects[Number],Coords[4])
		SetEntityNoCollisionEntity(Objects[Number],Ped,false)
		PlaceObjectOnGroundProperly(Objects[Number])
		FreezeEntityPosition(Objects[Number],true)
		SetModelAsNoLongerNeeded(Hash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Table")
AddEventHandler("plants:Table",function(Table)
	Plants = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:NEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:New")
AddEventHandler("plants:New",function(Number,Table)
	Plants[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAROBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClearObjects(Index)
	if Objects[Index] then
		if DoesEntityExist(Objects[Index]) then
			DeleteEntity(Objects[Index])
		end

		exports["target"]:RemCircleZone("Plants:"..Index)
		Objects[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Remove")
AddEventHandler("plants:Remove",function(Number)
	if Plants[Number] then
		Plants[Number] = nil
	end

	ClearObjects(Number)
end)