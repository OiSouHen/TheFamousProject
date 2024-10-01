
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 139.56,-1704.12,29.05,71,62,"Barbearia",0.5 },
	{ -1278.11,-1116.66,6.75,71,62,"Barbearia",0.5 },
	{ 1928.89,3734.04,32.6,71,62,"Barbearia",0.5 },
	{ 1217.05,-473.45,65.96,71,62,"Barbearia",0.5 },
	{ -34.08,-157.01,56.83,71,62,"Barbearia",0.5 },
	{ -274.5,6225.27,31.45,71,62,"Barbearia",0.5 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	-- Air Defense
	{ vec3(1689.49, 2602.64, 45.56), 200, 1, 300.0 },

	-- Impound
	{ vec3(405.21, -1638.34, 29.28), 100, 9, 15.0 },

	-- War Zones
	{ vec3(2954.97, 2807.08, 41.75), 100, 72, 150.0 },
	{ vec3(3533.77, 3720.49, 28.36), 100, 72, 150.0 },

	-- Car Wash
	{ vec3(24.27, -1391.96, 28.7), 200, 54, 15.0 },
	{ vec3(167.69, -1715.92, 28.66), 200, 54, 15.0 },
	{ vec3(-699.86, -932.84, 18.38), 200, 54, 15.0 },

	-- Speed Cameras
	{ vec3(348.72, -1921.64, 24.2), 200, 76, 15.0 },
	{ vec3(945.37, -1935.09, 30.46), 200, 76, 15.0 },
	{ vec3(1280.27, -1504.25, 40.05), 200, 76, 15.0 },
	{ vec3(145.67, -1614.32, 28.83), 200, 76, 15.0 },
	{ vec3(310.92, 155.6, 103.32), 200, 76, 15.0 },
	{ vec3(-441.11, 244.36, 82.58), 200, 76, 15.0 },
	{ vec3(-2690.74, -39.01, 15.3), 200, 76, 15.0 },
	{ vec3(-1468.19, -104.2, 50.36), 200, 76, 15.0 },
	{ vec3(774.04, -743.38, 26.96), 200, 76, 15.0 },
	{ vec3(-638.7, -837.08, 24.42), 200, 76, 15.0 },
	{ vec3(-632.22, -373.37, 34.31), 200, 76, 15.0 },
	{ vec3(-227.22, -1003.37, 28.83), 200, 76, 15.0 },
	{ vec3(154.36, -1019.31, 28.88), 200, 76, 15.0 },
	{ vec3(73.64, -164.13, 54.61), 200, 76, 15.0 },
	{ vec3(394.65, -592.25, 28.27), 200, 76, 15.0 },
	{ vec3(-521.92, -1770.01, 21.42), 200, 76, 15.0 },
	{ vec3(2578.46, 4245.33, 41.8), 200, 76, 15.0 },
	{ vec3(1578.62, -980.07, 60.09), 200, 76, 15.0 },
	{ vec3(2134.19, -572.18, 95.1), 200, 76, 15.0 },
	{ vec3(714.88, 6511.94, 27.41), 200, 76, 15.0 },
	{ vec3(-2658.32, 2632.84, 16.68), 200, 76, 15.0 },
	{ vec3(2559.33, 5399.29, 44.21), 200, 76, 15.0 },
	{ vec3(2654.56, 4938.91, 44.4), 200, 76, 15.0 },
	{ vec3(-342.69, 6190.71, 31.04), 200, 76, 15.0 },
	{ vec3(-131.01, 6400.8, 31.09), 200, 76, 15.0 },
	{ vec3(1669.52, 3556.42, 35.23), 200, 76, 15.0 },

	-- Ilegal
	{ vec3(-472.08, 6287.5, 14.63), 200, 59, 20.0 },

	-- Scuba
	{ vec3(767.19, 7192.03, -30.16), 200, 21, 100.0 },

	-- Fishing
	{ vec3(-315.33, 6588.65, -0.47), 200, 18, 30.0 },

	-- Caça
	{ vec3(827.1, 5426.91, 485.51), 200, 51, 700.0 },
	{ vec3(-2080.6, 1357.4, 257.87), 200, 51, 500.0 },

	-- Influence
	{ vec3(-1663.58, -749.36, 10.21), 200, 11, 200.0 },
	{ vec3(922.22, -1923.63, 30.89), 200, 11, 200.0 },
	{ vec3(1770.85, 3652.74, 34.41), 200, 11, 100.0 },
	{ vec3(-303.89, 6229.39, 31.46), 200, 11, 100.0},
	{ vec3(-88.0, 249.04, 100.0), 200, 11, 200.0 },

	-- Bikes
	{ vec3(156.44, -1065.79, 30.04), 200, 56, 10.0 },
	{ vec3(-1188.13, -1574.47, 4.35), 200, 56, 10.0 },
	{ vec3(-777.44, 5593.64, 33.63), 200, 56, 10.0 },
	{ vec3(435.06, -647.39, 28.73), 200, 56, 10.0 },
	{ vec3(-896.38, -779.06, 15.91), 200, 56, 10.0 },
	{ vec3(-1668.56, -998.63, 7.38), 200, 56, 10.0 },
	{ vec3(102.53, -1957.14, 20.74), 200, 56, 10.0 },
	{ vec3(-161.23, -1623.57, 33.65), 200, 56, 10.0 },
	{ vec3(337.84, -2036.2, 21.37), 200, 56, 10.0 },
	{ vec3(524.05, -1829.38, 28.43), 200, 56, 10.0 },
	{ vec3(232.37, -1756.87, 29.0), 200, 56, 10.0 },
	{ vec3(143.91, 6653.49, 31.53), 200, 56, 10.0 },
	{ vec3(1703.32, 4820.19, 41.97), 200, 56, 10.0 },
	{ vec3(958.53, 3618.86, 32.67), 200, 56, 10.0 },
	{ vec3(1032.52, 2656.05, 39.55), 200, 56, 10.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local InfoList = {
	{
		["Props"] = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		["Coords"] = vec3(-1150.70,-1520.70,10.60)
	},{
		["Props"] = {
			"csr_beforeMission",
			"csr_inMission"
		},
		["Coords"] = vec3(-47.10,-1115.30,26.50)
	},{
		["Props"] = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		["Coords"] = vec3(-802.30,175.00,72.80)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		for Number = 1,22 do
			if Number ~= 14 and Number ~= 16 then
				HideHudComponentThisFrame(Number)
			end
		end

		DisableControlAction(0,37,true)
		DisableControlAction(0,204,true)
		DisableControlAction(0,211,true)
		DisableControlAction(0,349,true)
		DisableControlAction(0,192,true)
		DisableControlAction(0,157,true)
		DisableControlAction(0,158,true)
		DisableControlAction(0,159,true)
		DisableControlAction(0,160,true)
		DisableControlAction(0,161,true)
		DisableControlAction(0,162,true)
		DisableControlAction(0,163,true)
		DisableControlAction(0,164,true)
		DisableControlAction(0,165,true)

		DisableVehicleDistantlights(true)
		SetArtificialLightsState(false)
		SetAllVehicleGeneratorsActive()
		CancelCurrentPoliceReport()
		BlockWeaponWheelThisFrame()
		InvalidateVehicleIdleCam()
		SetCreateRandomCops(false)
		SetPoliceRadarBlips(false)
		DistantCopCarSirens(false)
		SetPauseMenuActive(false)
		InvalidateIdleCam()

		SetVehicleDensityMultiplierThisFrame(0.2)
		SetRandomVehicleDensityMultiplierThisFrame(0.2)
		SetParkedVehicleDensityMultiplierThisFrame(0.2)
		SetScenarioPedDensityMultiplierThisFrame(1.0,1.0)
		SetPedDensityMultiplierThisFrame(1.0)

		if IsPedArmed(Ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if IsPedUsingActionMode(Ped) then
			SetPedUsingActionMode(Ped,-1,-1,1)
		end

		SetPedInfiniteAmmoClip(Ped,false)
		SetPlayerLockonRangeOverride(Pid,0.0)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		if IsPlayerWantedLevelGreater(Pid,0) then
			ClearPlayerWantedLevel(Pid)
		end

		if IsPedInAnyVehicle(Ped) then
			DisableControlAction(0,345,true)
		end

		if not DisableTargetMode then
			SetPlayerLockonRangeOverride(Pid, 0.0)
		end

		if LocalPlayer["state"]["Active"] then
			NetworkOverrideClockTime(GlobalState["Hours"], GlobalState["Minutes"], 00)
		else
			NetworkOverrideClockTime(12, 00, 00)
		end

		if IsPedOnFoot(GetPlayerPed(-1)) then
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			local Distance = #(Coords - vec3(253.73, 224.19, 101.91))
			if Distance <= 1.5 then
				TimeDistance = 1

				if IsControlJustPressed(1, 38) then
					local Handle, Object = FindFirstObject()
					local Finished = false

					repeat
						local Heading = GetEntityHeading(Object)
						local CoordsObj = GetEntityCoords(Object)
						local DistanceObjs = #(CoordsObj - Coords)

						if DistanceObjs < 3.0 and GetEntityModel(Object) == 961976194 then
							if Heading > 150.0 then
								SetEntityHeading(Object, 0.0)
							else
								SetEntityHeading(Object, 160.0)
							end

							FreezeEntityPosition(Object, true)
							Finished = true
						end

						Finished, Object = FindNextObject(Handle)
					until not Finished

					EndFindObject(Handle)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	SetMapZoomDataLevel(0,0.96,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(1,1.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(2,8.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(3,12.3,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(4,22.3,0.9,0.08,0.0,0.0)

	for _,v in pairs(InfoList) do
		local Interior = GetInteriorAtCoords(v["Coords"])
		LoadInterior(Interior)

		if v["Props"] then
			for _,Index in pairs(v["Props"]) do
				EnableInteriorProp(Interior,Index)
			end
		end

		RefreshInterior(Interior)
	end

	for Number = 1,#Alphas do
		local Blip = AddBlipForRadius(Alphas[Number][1]["x"],Alphas[Number][1]["y"],Alphas[Number][1]["z"],Alphas[Number][4])
		SetBlipAlpha(Blip,Alphas[Number][2])
		SetBlipColour(Blip,Alphas[Number][3])
	end

	for Number = 1,#Blips do
		local Blip = AddBlipForCoord(Blips[Number][1],Blips[Number][2],Blips[Number][3])
		SetBlipSprite(Blip,Blips[Number][4])
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,Blips[Number][5])
		SetBlipScale(Blip,Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57,-5174.42,2.0)) <= 2000 then
			if not IsIplActive("h4_islandairstrip") then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
			end
		else
			if IsIplActive("h4_islandairstrip") then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
			end
		end

		for _,Entity in pairs(GetGamePool("CPed")) do
			if (NetworkGetEntityOwner(Entity) == -1 or NetworkGetEntityOwner(Entity) == PlayerId()) and GetPedArmour(Entity) <= 0 and not NetworkGetEntityIsNetworked(Entity) then
				if IsPedInAnyVehicle(Entity) then
					local Vehicle = GetVehiclePedIsUsing(Entity)
					if NetworkGetEntityIsNetworked(Vehicle) then
						TriggerServerEvent("garages:Delete",NetworkGetNetworkIdFromEntity(Vehicle),GetVehicleNumberPlateText(Vehicle))
					else
						DeleteEntity(Vehicle)
					end
				else
					DeleteEntity(Entity)
				end
			end
		end

		for _,Vehicle in pairs(GetGamePool("CVehicle")) do
			if (NetworkGetEntityOwner(Vehicle) == -1 or NetworkGetEntityOwner(Vehicle) == PlayerId()) and not NetworkGetEntityIsNetworked(Vehicle) and GetVehicleNumberPlateText(Vehicle) ~= "PDMSPORT" then
				DeleteEntity(Vehicle)
			end
		end

		for Number = 1,121 do
			EnableDispatchService(Number,false)
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRAPPEL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			TimeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if IsControlJustPressed(1,154) and not IsAnyPedRappellingFromHeli(Vehicle) and (GetPedInVehicleSeat(Vehicle,1) == Ped or GetPedInVehicleSeat(Vehicle,2) == Ped) then
				TaskRappelFromHeli(Ped,1)
			end
		end

		Wait(TimeDistance)
	end
end)