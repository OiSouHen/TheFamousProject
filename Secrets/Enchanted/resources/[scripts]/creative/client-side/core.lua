-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local BunnyHope = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 149.64,-1041.36,29.59,108,25,"Banco",0.7 },
	{ 313.95,-279.74,54.39,108,25,"Banco",0.7 },
	{ -351.2,-50.57,49.26,108,25,"Banco",0.7 },
	{ -2961.85,482.87,15.92,108,25,"Banco",0.7 },
	{ 1175.09,2707.53,38.31,108,25,"Banco",0.7 },
	{ -1212.37,-331.37,38.0,108,25,"Banco",0.7 },
	{ -112.86,6470.46,31.85,108,25,"Banco",0.7 },
	{ 337.65,-1393.64,32.5,80,38,"Hospital",0.5 },
	{ 55.43,-876.19,30.66,357,62,"Garagem",0.6 },
	{ 598.04,2741.27,42.07,357,62,"Garagem",0.6 },
	{ -136.36,6357.03,31.49,357,62,"Garagem",0.6 },
	{ 275.23,-345.54,45.17,357,62,"Garagem",0.6 },
	{ 596.40,90.65,93.12,357,62,"Garagem",0.6 },
	{ -340.76,265.97,85.67,357,62,"Garagem",0.6 },
	{ -2030.01,-465.97,11.60,357,62,"Garagem",0.6 },
	{ -1184.92,-1510.00,4.64,357,62,"Garagem",0.6 },
	{ 214.02,-808.44,31.01,357,62,"Garagem",0.6 },
	{ -348.88,-874.02,31.31,357,62,"Garagem",0.6 },
	{ 67.74,12.27,69.21,357,62,"Garagem",0.6 },
	{ 361.90,297.81,103.88,357,62,"Garagem",0.6 },
	{ 1035.89,-763.89,57.99,357,62,"Garagem",0.6 },
	{ -796.63,-2022.77,9.16,357,62,"Garagem",0.6 },
	{ 453.27,-1146.76,29.52,357,62,"Garagem",0.6 },
	{ 528.66,-146.3,58.38,357,62,"Garagem",0.6 },
	{ -1159.48,-739.32,19.89,357,62,"Garagem",0.6 },
	{ 101.22,-1073.68,29.38,357,62,"Garagem",0.6 },
	{ 1725.21,4711.77,42.11,357,62,"Garagem",0.6 },
	{ 1624.05,3566.14,35.15,357,62,"Garagem",0.6 },
	{ -73.35,-2004.6,18.27,357,62,"Garagem",0.6 },
	{ 1200.52,-1276.06,35.22,357,62,"Garagem",0.6 },
	{ 46.7,-1749.71,29.62,78,62,"Mercado Central",0.5 },
	{ 224.59,-1511.14,29.28,515,62,"Loja de Eletronicos",0.7 },
	{ 416.02,-982.65,29.44,60,18,"Departamento Policial",0.6 },
	{ 29.2,-1351.89,29.34,52,36,"Loja de Departamento",0.5 },
	{ 2561.74,385.22,108.61,52,36,"Loja de Departamento",0.5 },
	{ 1160.21,-329.4,69.03,52,36,"Loja de Departamento",0.5 },
	{ -711.99,-919.96,19.01,52,36,"Loja de Departamento",0.5 },
	{ -54.56,-1758.56,29.05,52,36,"Loja de Departamento",0.5 },
	{ 375.87,320.04,103.42,52,36,"Loja de Departamento",0.5 },
	{ -3237.48,1004.72,12.45,52,36,"Loja de Departamento",0.5 },
	{ 1730.64,6409.67,35.0,52,36,"Loja de Departamento",0.5 },
	{ 543.51,2676.85,42.14,52,36,"Loja de Departamento",0.5 },
	{ 1966.53,3737.95,32.18,52,36,"Loja de Departamento",0.5 },
	{ 2684.73,3281.2,55.23,52,36,"Loja de Departamento",0.5 },
	{ 1696.12,4931.56,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.18,785.69,137.98,52,36,"Loja de Departamento",0.5 },
	{ 1395.35,3596.6,34.86,52,36,"Loja de Departamento",0.5 },
	{ -2977.14,391.22,15.03,52,36,"Loja de Departamento",0.5 },
	{ -3034.99,590.77,7.8,52,36,"Loja de Departamento",0.5 },
	{ 1144.46,-980.74,46.19,52,36,"Loja de Departamento",0.5 },
	{ 1166.06,2698.17,37.95,52,36,"Loja de Departamento",0.5 },
	{ -1493.12,-385.55,39.87,52,36,"Loja de Departamento",0.5 },
	{ -1228.6,-899.7,12.27,52,36,"Loja de Departamento",0.5 },
	{ -361.85,-132.89,38.67,402,62,"Mecânica",0.7 },
	{ -1142.1,-1987.5,13.16,402,62,"Mecânica",0.7 },
	{ 1178.96,2651.42,37.81,402,62,"Mecânica",0.7 },
	{ 116.95,6615.26,31.85,402,62,"Mecânica",0.7 },
	{ 718.03,-1088.61,22.36,402,62,"Mecânica",0.7 },
	{ -205.64,-1306.65,31.31,402,62,"Mecânica",0.7 },
	{ 1692.27,3760.91,34.69,76,6,"Loja de Armas",0.4 },
	{ 253.8,-50.47,69.94,76,6,"Loja de Armas",0.4 },
	{ 842.54,-1035.25,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.67,6084.86,31.46,76,6,"Loja de Armas",0.4 },
	{ -662.37,-933.58,21.82,76,6,"Loja de Armas",0.4 },
	{ -1304.12,-394.56,36.7,76,6,"Loja de Armas",0.4 },
	{ -1118.98,2699.73,18.55,76,6,"Loja de Armas",0.4 },
	{ 2567.98,292.62,108.73,76,6,"Loja de Armas",0.4 },
	{ -3173.51,1088.35,20.84,76,6,"Loja de Armas",0.4 },
	{ 22.53,-1105.52,29.79,76,6,"Loja de Armas",0.4 },
	{ 810.22,-2158.99,29.62,76,6,"Loja de Armas",0.4 },
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 139.56,-1704.12,29.05,71,62,"Barbearia",0.5 },
	{ -1278.11,-1116.66,6.75,71,62,"Barbearia",0.5 },
	{ 1928.89,3734.04,32.6,71,62,"Barbearia",0.5 },
	{ 1217.05,-473.45,65.96,71,62,"Barbearia",0.5 },
	{ -34.08,-157.01,56.83,71,62,"Barbearia",0.5 },
	{ -274.5,6225.27,31.45,71,62,"Barbearia",0.5 },
	{ 86.06,-1391.64,29.23,366,62,"Loja de Roupas",0.5 },
	{ -719.94,-158.18,37.0,366,62,"Loja de Roupas",0.5 },
	{ -152.79,-306.79,38.67,366,62,"Loja de Roupas",0.5 },
	{ -816.39,-1081.22,11.12,366,62,"Loja de Roupas",0.5 },
	{ -1206.51,-781.5,17.12,366,62,"Loja de Roupas",0.5 },
	{ -1458.26,-229.79,49.2,366,62,"Loja de Roupas",0.5 },
	{ -2.41,6518.29,31.48,366,62,"Loja de Roupas",0.5 },
	{ 1682.59,4819.98,42.04,366,62,"Loja de Roupas",0.5 },
	{ 129.46,-205.18,54.51,366,62,"Loja de Roupas",0.5 },
	{ 618.49,2745.54,42.01,366,62,"Loja de Roupas",0.5 },
	{ 1197.93,2698.21,37.96,366,62,"Loja de Roupas",0.5 },
	{ -3165.74,1061.29,20.84,366,62,"Loja de Roupas",0.5 },
	{ -1093.76,2703.99,19.04,366,62,"Loja de Roupas",0.5 },
	{ 414.86,-807.57,29.34,366,62,"Loja de Roupas",0.5 },
	{ -1728.06,-1050.69,1.71,356,62,"Embarcações",0.6 },
	{ -776.72,-1495.02,2.29,356,62,"Embarcações",0.6 },
	{ -893.97,5687.78,3.29,356,62,"Embarcações",0.6 },
	{ 1509.64,3788.7,33.51,356,62,"Embarcações",0.6 },
	{ 356.42,274.61,103.14,67,62,"Transportador",0.5 },
	{ -172.89,6381.32,31.48,403,5,"Farmácia",0.7 },
	{ 1690.07,3581.68,35.62,403,5,"Farmácia",0.7 },
	{ 114.49,-5.03,67.82,403,5,"Farmácia",0.7 },
	{ -351.65,-1566.27,25.22,318,62,"Lixeiro",0.6 },
	{ 287.36,2843.6,44.7,318,62,"Lixeiro",0.6 },
	{ -413.97,6171.58,31.48,318,62,"Lixeiro",0.6 },
	{ 408.91,-1638.21,29.28,477,62,"Reboque",0.6 },
	{ 966.47,-1914.76,31.14,467,11,"Recicladora",0.7 },
	{ -178.19,6261.09,31.49,467,11,"Recicladora",0.7 },
	{ 270.14,2858.27,43.64,467,11,"Recicladora",0.7 },
	{ 1327.98,-1654.78,52.03,75,13,"Loja de Tatuagem",0.5 },
	{ -1149.04,-1428.64,4.71,75,13,"Loja de Tatuagem",0.5 },
	{ 322.01,186.24,103.34,75,13,"Loja de Tatuagem",0.5 },
	{ -3175.64,1075.54,20.58,75,13,"Loja de Tatuagem",0.5 },
	{ 1866.01,3748.07,32.79,75,13,"Loja de Tatuagem",0.5 },
	{ -295.51,6199.21,31.24,75,13,"Loja de Tatuagem",0.5 },
	{ -66.26,-1102.02,26.17,225,62,"Concessionária",0.6 },
	{ -1896.42,-3032.01,13.93,43,62,"Aviação",0.7 },
	{ -1593.08,5202.9,4.31,141,62,"Caçador",0.7 },
	{ -681.42,5832.95,17.32,141,62,"Caçador",0.7 },
	{ 454.73,-600.83,28.56,513,62,"Motorista",0.5 },
	{ 919.38,-182.83,74.02,198,62,"Taxista",0.5 },
	{ 963.75,-2228.24,30.55,77,62,"Leiteiro",0.5 },
	{ 59.74,101.11,79.01,478,62,"Grime",0.5 },
	{ -1816.64,-1193.73,14.31,68,62,"Pescador",0.5 },
	{ 1965.2,5179.44,47.9,285,62,"Lenhador",0.5 },
	{ 2953.93,2787.49,41.5,617,62,"Minerador",0.6 },
	{ -629.07,243.24,81.89,408,73,"Restaurante",0.6 },
	{ 1239.87,-3257.2,7.09,67,62,"Caminhoneiro",0.5 },
	{ -772.73,312.74,85.7,475,26,"Hotel",0.6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	{ vec3(357.96,-1408.7,32.42),vec3(335.11,-1432.36,46.51) },
	{ vec3(335.11,-1432.36,46.51),vec3(357.96,-1408.7,32.42) },

	{ vec3(-741.07,5593.13,41.66),vec3(446.19,5568.79,781.19) },
	{ vec3(446.19,5568.79,781.19),vec3(-741.07,5593.13,41.66) },

	{ vec3(-740.78,5597.04,41.66),vec3(446.37,5575.02,781.19) },
	{ vec3(446.37,5575.02,781.19),vec3(-740.78,5597.04,41.66) },

	{ vec3(-71.05,-801.01,44.23),vec3(-75.0,-824.54,321.29) },
	{ vec3(-75.0,-824.54,321.29),vec3(-71.05,-801.01,44.23) },

	{ vec3(254.06,225.28,101.87),vec3(252.32,220.21,101.67) },
	{ vec3(252.32,220.21,101.67),vec3(254.06,225.28,101.87) }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	{ vec3(1183.88,4002.14,30.23),200,31,150.0 },
	{ vec3(-230.83,-3332.51,0.59),200,25,150.0 },
	{ vec3(-1314.5,6207.45,-0.56),200,38,150.0 },
	{ vec3(-627.61,7597.86,-0.42),200,49,150.0 }
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
		else
			if BunnyHope >= GetGameTimer() then
				DisableControlAction(1,22,true)
			elseif IsPedJumping(Ped) and BunnyHope <= GetGameTimer() then
				BunnyHope = GetGameTimer() + 5000
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

		SetVehicleDensityMultiplierThisFrame(1.0)
		SetRandomVehicleDensityMultiplierThisFrame(1.0)
		SetParkedVehicleDensityMultiplierThisFrame(1.0)
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

		SetPlayerTargetingMode(3)
		SetPedInfiniteAmmoClip(Ped,false)
		SetPlayerLockonRangeOverride(Pid,0.0)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetEntityProofs(Ped,false,true,true,false,false,false,false,false)
		N_0x4757f00bc6323cfe(-1553120962,0.0)
		N_0x4757f00bc6323cfe(539292904,0.0)

		if IsPlayerWantedLevelGreater(Pid,0) then
			ClearPlayerWantedLevel(Pid)
		end

		SetWeatherTypeNow(GlobalState["Weather"])
		SetWeatherTypePersist(GlobalState["Weather"])
		SetWeatherTypeNowPersist(GlobalState["Weather"])

		if LocalPlayer["state"]["Active"] then
			NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)
		else
			NetworkOverrideClockTime(12,00,00)
		end

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
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

	local Tables = {}

	for Number = 1,#Teleport do
		Tables[#Tables + 1] = { Teleport[Number][1],2.5,"E","Pressione","para acessar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1,#Teleport do
				if #(Coords - Teleport[Number][1]) <= 1 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) then
						SetEntityCoords(Ped,Teleport[Number][2])
					end
				end
			end
		end

		Wait(TimeDistance)
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