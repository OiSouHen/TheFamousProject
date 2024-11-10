-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAIRS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chairs = {
	[-1235256368] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.0, ["Heading"] = 90.0 },
	[538002882] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = -0.1, ["Heading"] = 180.0 },
	[-1118419705] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[-377849416] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[-109356459] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[-1692811878] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[-729914417] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[1577885496] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[1889748069] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[1816935351] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[1037469683] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.4, ["Heading"] = 180.0 },
	[536071214] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[438342263] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.25, ["Heading"] = 180.0 },
	[2129125614] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[195568113] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.51, ["Heading"] = 180.0 },
	[1827229923] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 },
	[-1078931853] = { ["OffsetX"] = 0.0, ["OffsetY"] = 0.0, ["OffsetZ"] = 0.5, ["Heading"] = 180.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	AddTargetModel({ -1235256368,538002882,-1118419705,-377849416,-109356459,-1692811878,-729914417,1577885496,1889748069,1816935351,1037469683,536071214,438342263,2129125614,195568113,1827229923,-1078931853 },{
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
-- TARGET:UPCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpChair")
AddEventHandler("target:UpChair",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
		FreezeEntityPosition(Ped,false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:CHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Chair")
AddEventHandler("target:Chair",function(Vars)
	local Model = Vars[2]
	local Entitys = Vars[1]
	local Ped = PlayerPedId()

	if Chairs[Model] then
		FreezeEntityPosition(Ped,false)
		FreezeEntityPosition(Entitys,true)

		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Vars[4]["x"],Vars[4]["y"],Vars[4]["z"] + 0.5)
		SetEntityHeading(Ped,GetEntityHeading(Entitys) - Chairs[Model]["Heading"])

		TaskStartScenarioAtPosition(Ped,"PROP_HUMAN_SEAT_CHAIR_UPRIGHT",Vars[4]["x"] + Chairs[Model]["OffsetX"],Vars[4]["y"] + Chairs[Model]["OffsetY"],Vars[4]["z"] + Chairs[Model]["OffsetZ"],GetEntityHeading(Entitys) - Chairs[Model]["Heading"],0,true,true)
	end
end)