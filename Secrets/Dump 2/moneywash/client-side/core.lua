-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("moneywash")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {}
local MoneyWash = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Index,v in pairs(MoneyWash) do
				if v["Route"] == LocalPlayer["state"]["Route"] then
					local OtherCoords = vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3])
					if #(Coords - OtherCoords) <= 50 then
						if not Objects[Index] then
							exports["target"]:AddBoxZone("MoneyWash:"..Index,vec3(OtherCoords["x"],OtherCoords["y"],OtherCoords["z"] + 1.1),1.4,1.4,{
								name = "MoneyWash:"..Index,
								heading = v["Coords"][4],
								minZ = OtherCoords["z"] + 0.0,
								maxZ = OtherCoords["z"] + 2.25
							},{
								shop = Index,
								Distance = 1.5,
								options = {
									{
										event = "moneywash:Information",
										label = "Informações",
										tunnel = "client"
									},{
										event = "moneywash:StoreObjects",
										label = "Guardar",
										tunnel = "server"
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
-- MONEYWASH:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Information",function(Selected)
	local Information = vSERVER.Information(Selected)
	if Information then
		local OsTime = vSERVER.OsTime()
		local Battery = "Colocar uma nova bateria de 75Ah."
		if (Information["Timer"] >= OsTime) then
			Battery = "Restam "..CompleteTimers(Information["Timer"] - OsTime).."."
		end

		exports["dynamic"]:AddButton("Compartimento","Primário: <rare>"..Currency..Dotted(Information["Money"]).."</rare>  /  Secundário: <epic>"..Currency..Dotted(Information["Washed"]).."</epic>","","",false,false)
		exports["dynamic"]:AddButton("Primário","Esvaziar compartimento primário.","moneywash:Money",Selected,false,true)
		exports["dynamic"]:AddButton("Secundário","Esvaziar compartimento secundário.","moneywash:Washed",Selected,false,true)
		exports["dynamic"]:AddButton("Adicionar","Guardar no compartimento primário.","moneywash:Add",Selected,false,true)
		exports["dynamic"]:AddButton("Energia",Battery,"moneywash:Battery",Selected,false,true)

		exports["dynamic"]:Open()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateModels(Number,Hash,Coords)
	if LoadModel(Hash) then
		Objects[Number] = CreateObjectNoOffset(Hash,Coords[1],Coords[2],Coords[3],false,false,false)

		SetEntityHeading(Objects[Number],Coords[4])
		PlaceObjectOnGroundProperly(Objects[Number])
		FreezeEntityPosition(Objects[Number],true)
		SetModelAsNoLongerNeeded(Hash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("moneywash:Table")
AddEventHandler("moneywash:Table",function(Table)
	MoneyWash = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:NEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("moneywash:New")
AddEventHandler("moneywash:New",function(Selected,Table)
	MoneyWash[Selected] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAROBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClearObjects(Index)
	if Objects[Index] then
		if DoesEntityExist(Objects[Index]) then
			DeleteEntity(Objects[Index])
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Index)
		Objects[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("moneywash:Remove")
AddEventHandler("moneywash:Remove",function(Selected)
	if MoneyWash[Selected] then
		MoneyWash[Selected] = nil
	end

	ClearObjects(Selected)
end)