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

		if IsPedInAnyVehicle(Ped) then
			DisableControlAction(0,345,true)
			DisablePlayerVehicleRewards(Pid)

			if IsPedInAnyHeli(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if IsControlJustPressed(1,154) and not IsAnyPedRappellingFromHeli(Vehicle) and (GetPedInVehicleSeat(Vehicle,1) == Ped or GetPedInVehicleSeat(Vehicle,2) == Ped) then
					TaskRappelFromHeli(Ped,1)
				end
			end
		end

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