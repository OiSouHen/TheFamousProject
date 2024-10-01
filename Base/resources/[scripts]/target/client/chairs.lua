-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number, v in pairs(SitChairs) do
		AddBoxZone("SitChairs:" .. Number, v["Coords"], 0.35, 0.35, {
			name = "SitChairs:" .. Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.1,
			maxZ = v["Coords"]["z"]
		}, {
			shop = Number,
			Distance = 5.25,
			options = {
				{
					event = "target:SitChair",
					label = "Sentar",
					tunnel = "client"
				}
			}
		})
	end

	AddTargetModel( { -1235256368, 538002882, -1118419705, -377849416, -109356459, -1692811878, -729914417, 1577885496, 1889748069, 1816935351, 1037469683, 536071214, 438342263, 2129125614 }, {
		options = {
			{
				event = "target:Chair",
				label = "Sentar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SITCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:SitChair")
AddEventHandler("target:SitChair", function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		local Coords = SitChairs[Number]["Coords"]
		TaskStartScenarioAtPosition(Ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", Coords["x"], Coords["y"], Coords["z"], SitChairs[Number]["Heading"] + 1.0, -1, true, true)
		Previous = GetEntityCoords(Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpChair")
AddEventHandler("target:UpChair", function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped, Previous["x"], Previous["y"], Previous["z"] - 1, false, false, false, false)
		FreezeEntityPosition(Ped, false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:CHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Chair")
AddEventHandler("target:Chair", function(Vars)
	local Model = Vars[2]
	local Entitys = Vars[1]
	local Ped = PlayerPedId()

	if Chairs[Model] then
		FreezeEntityPosition(Ped, false)
		FreezeEntityPosition(Entitys, true)

		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped, Vars[4]["x"], Vars[4]["y"], Vars[4]["z"] + 0.5)
		SetEntityHeading(Ped, GetEntityHeading(Entitys) - Chairs[Model]["Heading"])

		TaskStartScenarioAtPosition(Ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", Vars[4]["x"] + Chairs[Model]["OffsetX"], Vars[4]["y"] + Chairs[Model]["OffsetY"], Vars[4]["z"] + Chairs[Model]["OffsetZ"], GetEntityHeading(Entitys) - Chairs[Model]["Heading"], 0, true, true)
	end
end)