-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 68.93,-1569.81,29.59, 1, 1, "Money Wash", 0.5 },

	{ 300.16,-584.9,43.29, 80, 49, "Hospital", 0.5 },

	{ 435.47,-981.86,30.68, 60, 10, "Departamento Policial", 0.6 },

	{ 945.82,-984.14,39.5, 402, 18, "Mecânica AutoCare", 0.8 },

	{ -1816.64,-1193.73,14.31, 68, 18, "Pescador", 0.6 },

	{ 1961.61,5179.26,47.94, 285, 10, "Lenhador", 0.6 },
	{ 1694.92,4920.44,42.23, 285, 10, "Venda de Madeira", 0.6 },

	{ 1212.36,336.08,81.99, 77, 32, "Leiteiro", 0.5 },

	{ 264.74,219.99,101.67, 67, 4, "Transportador", 0.6 },

	{ 1239.87,-3257.2,7.09, 67, 4, "Caminhoneiro", 0.6 },

	{ 453.47,-602.34,28.59, 513, 4, "Motorista", 0.6 },

	{ 408.91,-1622.75,29.28, 477, 4, "Reboque", 0.6 },

	{ 901.97,-167.97,74.07, 198, 70, "Taxista", 0.6 },

	{ 68.99,127.46,79.21, 478, 20, "Go Postal", 0.6 },

	{ -628.79,-238.7,38.05, 617, 26, "Joalheria", 0.6 },

	{ -1741.52,-219.85,56.14, 429, 62, "Cemitério", 0.5 },

	{ 46.7,-1749.71,29.62, 78, 30, "Mega Mall", 0.5 },

	{ -172.89,6381.32,31.48, 403, 5, "Farmácia", 0.7 },
	{ 1690.07,3581.68,35.62, 403, 5, "Farmácia", 0.7 },
	{ 114.49,-5.03,67.82, 403, 5, "Farmácia", 0.7 },

	{ -772.76,312.81,85.7, 475, 36, "Hotel", 0.7 },

	{ -56.98,-1098.79,26.42, 225, 62, "Concessionária", 0.6 },

	{ 232.58,215.65,106.29, 108, 82, "Banco Central", 0.7 },
	{ -109.85,6463.8,31.63, 108, 82, "Banco Central", 0.7 },

	{ 1692.27,3760.91,34.69, 76, 35, "Loja de Armas", 0.5 },
	{ 253.8,-50.47,69.94, 76, 35, "Loja de Armas", 0.5 },
	{ 842.54,-1035.25,28.19, 76, 35, "Loja de Armas", 0.5 },
	{ -331.67,6084.86,31.46, 76, 35, "Loja de Armas", 0.5 },
	{ -662.37,-933.58,21.82, 76, 35, "Loja de Armas", 0.5 },
	{ -1304.12,-394.56,36.7, 76, 35, "Loja de Armas", 0.5 },
	{ -1118.98,2699.73,18.55, 76, 35, "Loja de Armas", 0.5 },
	{ 2567.98,292.62,108.73, 76, 35, "Loja de Armas", 0.5 },
	{ -3173.51,1088.35,20.84, 76, 35, "Loja de Armas", 0.5 },
	{ 22.53,-1105.52,29.79, 76, 35, "Loja de Armas", 0.5 },
	{ 810.22,-2158.99,29.62, 76, 35, "Loja de Armas", 0.5 },

	{ 1327.98,-1654.78,52.03, 75, 13, "Loja de Tatuagem", 0.6 },
	{ -1149.04,-1428.64,4.71, 75, 13, "Loja de Tatuagem", 0.6 },
	{ 322.01,186.24,103.34, 75, 13, "Loja de Tatuagem", 0.6 },
	{ -3175.64,1075.54,20.58, 75, 13, "Loja de Tatuagem", 0.6 },
	{ 1866.01,3748.07,32.79, 75, 13, "Loja de Tatuagem", 0.6 },
	{ -295.51,6199.21,31.24, 75, 13, "Loja de Tatuagem", 0.6 },

	{ -815.12,-184.15,37.57, 71, 13, "Barbearia", 0.6 },
	{ 139.56,-1704.12,29.05, 71, 13, "Barbearia", 0.6 },
	{ -1278.11,-1116.66,6.75, 71, 13, "Barbearia", 0.6 },
	{ 1928.89,3734.04,32.6, 71, 13, "Barbearia", 0.6 },
	{ 1217.05,-473.45,65.96, 71, 13, "Barbearia", 0.6 },
	{ -34.08,-157.01,56.83, 71, 13, "Barbearia", 0.6 },
	{ -274.5,6225.27,31.45, 71, 13, "Barbearia", 0.6 },

	{ 86.06,-1391.64,29.23, 366, 51, "Loja de Roupas", 0.5 },
	{ -719.94,-158.18,37.0, 366, 51, "Loja de Roupas", 0.5 },
	{ -152.79,-306.79,38.67, 366, 51, "Loja de Roupas", 0.5 },
	{ -816.39,-1081.22,11.12, 366, 51, "Loja de Roupas", 0.5 },
	{ -1206.51,-781.5,17.12, 366, 51, "Loja de Roupas", 0.5 },
	{ -1458.26,-229.79,49.2, 366, 51, "Loja de Roupas", 0.5 },
	{ -2.41,6518.29,31.48, 366, 51, "Loja de Roupas", 0.5 },
	{ 1682.59,4819.98,42.04, 366, 51, "Loja de Roupas", 0.5 },
	{ 129.46,-205.18,54.51, 366, 51, "Loja de Roupas", 0.5 },
	{ 618.49,2745.54,42.01, 366, 51, "Loja de Roupas", 0.5 },
	{ 1197.93,2698.21,37.96, 366, 51, "Loja de Roupas", 0.5 },
	{ -3165.74,1061.29,20.84, 366, 51, "Loja de Roupas", 0.5 },
	{ -1093.76,2703.99,19.04, 366, 51, "Loja de Roupas", 0.5 },
	{ 414.86,-807.57,29.34, 366, 51, "Loja de Roupas", 0.5 },

	{ 76.99,-194.58,54.49, 357, 32, "Garagem", 0.6 },
	{ -1686.58,26.39,64.38, 357, 32, "Garagem", 0.6 },
	{ -616.03,-1209.16,14.2, 357, 32, "Garagem", 0.6 },
	{ 964.11,-1035.85,40.83, 357, 32, "Garagem", 0.6 },
	{ 453.0,-1917.46,24.7, 357, 32, "Garagem", 0.6 },
	{ 1700.43,3766.2,34.42, 357, 32, "Garagem", 0.6 },
	{ -197.57,6233.16,31.49, 357, 32, "Garagem", 0.6 },
	{ 1109.02,2660.88,37.98, 357, 32, "Garagem", 0.6 },
	
	{ 29.2,-1351.89,29.34, 59, 4, "Lojas 24/7", 0.6 },
	{ 2561.74,385.22,108.61, 59, 4, "Lojas 24/7", 0.6 },
	{ 1160.21,-329.4,69.03, 59, 4, "Lojas 24/7", 0.6 },
	{ -711.99,-919.96,19.01, 59, 4, "Lojas 24/7", 0.6 },
	{ -54.56,-1758.56,29.05, 59, 4, "Lojas 24/7", 0.6 },
	{ 375.87,320.04,103.42, 59, 4, "Lojas 24/7", 0.6 },
	{ -3237.48,1004.72,12.45, 59, 4, "Lojas 24/7", 0.6 },
	{ 1730.64,6409.67,35.0, 59, 4, "Lojas 24/7", 0.6 },
	{ 543.51,2676.85,42.14, 59, 4, "Lojas 24/7", 0.6 },
	{ 1966.53,3737.95,32.18, 59, 4, "Lojas 24/7", 0.6 },
	{ 2684.73,3281.2,55.23, 59, 4, "Lojas 24/7", 0.6 },
	{ 1696.12,4931.56,42.07, 59, 4, "Lojas 24/7", 0.6 },
	{ -1820.18,785.69,137.98, 59, 4, "Lojas 24/7", 0.6 },
	{ 1395.35,3596.6,34.86, 59, 4, "Lojas 24/7", 0.6 },
	{ -2977.14,391.22,15.03, 59, 4, "Lojas 24/7", 0.6 },
	{ -3034.99,590.77,7.8, 59, 4, "Lojas 24/7", 0.6 },
	{ 1144.46,-980.74,46.19, 59, 4, "Lojas 24/7", 0.6 },
	{ 1166.06,2698.17,37.95, 59, 4, "Lojas 24/7", 0.6 },
	{ -1493.12,-385.55,39.87, 59, 4, "Lojas 24/7", 0.6 },
	{ -1228.6,-899.7,12.27, 59, 4, "Lojas 24/7", 0.6 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	{ vec3(-2026.53,-1460.38,5.34), 200, 18, 150.0 }
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