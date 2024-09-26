-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local TheNpcControl = 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 280.38,-584.45,43.29, 80, 59, "Hospital", 0.5 },
	{ -247.42,6331.39,32.42, 80, 59, "Hospital", 0.5 },

	{ 435.66,214.75,103.17, 475, 10, "Hotel Crastenburg", 0.7 },

	{ 76.99,-194.58,54.49, 225, 43, "Garagem", 0.6 },
	{ -1686.58,26.39,64.38, 225, 43, "Garagem", 0.6 },
	{ -616.03,-1209.16,14.2, 225, 43, "Garagem", 0.6 },
	{ 964.11,-1035.85,40.83, 225, 43, "Garagem", 0.6 },
	{ 453.0,-1917.46,24.7, 225, 43, "Garagem", 0.6 },
	{ 1700.43,3766.2,34.42, 225, 43, "Garagem", 0.6 },
	{ -197.57,6233.16,31.49, 225, 43, "Garagem", 0.6 },
	{ 1109.02,2660.88,37.98, 225, 43, "Garagem", 0.6 },

	{ -1204.85,-1564.27,4.6, 126, 13, "Academia", 0.6 },

	{ 426.57,-981.71,30.7, 60, 10, "Departamento Policial", 0.6 },

	{ 232.58,215.65,106.29, 108, 82, "Banco Central", 0.7 },
	{ -109.85,6463.8,31.63, 108, 82, "Banco Central", 0.7 },

	{ 128.13,-1710.26,29.28, 500, 41, "Bottom Dollar", 0.7 },
	{ -1412.87,-655.29,28.68, 500, 41, "Bottom Dollar", 0.7 },
	{ 485.85,-943.21,27.13, 500, 41, "Bottom Dollar", 0.7 },
	{ -65.63,6506.31,31.53, 500, 41, "Bottom Dollar", 0.7 },
	{ 122.81,13.44,68.29, 500, 41, "Bottom Dollar", 0.7 },

	{ 29.2,-1351.89,29.34, 59, 0, "Lojas 24/7", 0.6 },
	{ 2561.74,385.22,108.61, 59, 0, "Lojas 24/7", 0.6 },
	{ 1160.21,-329.4,69.03, 59, 0, "Lojas 24/7", 0.6 },
	{ -711.99,-919.96,19.01, 59, 0, "Lojas 24/7", 0.6 },
	{ -54.56,-1758.56,29.05, 59, 0, "Lojas 24/7", 0.6 },
	{ 375.87,320.04,103.42, 59, 0, "Lojas 24/7", 0.6 },
	{ -3237.48,1004.72,12.45, 59, 0, "Lojas 24/7", 0.6 },
	{ 1730.64,6409.67,35.0, 59, 0, "Lojas 24/7", 0.6 },
	{ 543.51,2676.85,42.14, 59, 0, "Lojas 24/7", 0.6 },
	{ 1966.53,3737.95,32.18, 59, 0, "Lojas 24/7", 0.6 },
	{ 2684.73,3281.2,55.23, 59, 0, "Lojas 24/7", 0.6 },
	{ 1696.12,4931.56,42.07, 59, 0, "Lojas 24/7", 0.6 },
	{ -1820.18,785.69,137.98, 59, 0, "Lojas 24/7", 0.6 },
	{ 1395.35,3596.6,34.86, 59, 0, "Lojas 24/7", 0.6 },
	{ -2977.14,391.22,15.03, 59, 0, "Lojas 24/7", 0.6 },
	{ -3034.99,590.77,7.8, 59, 0, "Lojas 24/7", 0.6 },
	{ 1144.46,-980.74,46.19, 59, 0, "Lojas 24/7", 0.6 },
	{ 1166.06,2698.17,37.95, 59, 0, "Lojas 24/7", 0.6 },
	{ -1493.12,-385.55,39.87, 59, 0, "Lojas 24/7", 0.6 },
	{ -1228.6,-899.7,12.27, 59, 0, "Lojas 24/7", 0.6 },

	{ 1692.27,3760.91,34.69, 76, 6, "Ammunation", 0.5 },
	{ 253.8,-50.47,69.94, 76, 6, "Ammunation", 0.5 },
	{ 842.54,-1035.25,28.19, 76, 6, "Ammunation", 0.5 },
	{ -331.67,6084.86,31.46, 76, 6, "Ammunation", 0.5 },
	{ -662.37,-933.58,21.82, 76, 6, "Ammunation", 0.5 },
	{ -1304.12,-394.56,36.7, 76, 6, "Ammunation", 0.5 },
	{ -1118.98,2699.73,18.55, 76, 6, "Ammunation", 0.5 },
	{ 2567.98,292.62,108.73, 76, 6, "Ammunation", 0.5 },
	{ -3173.51,1088.35,20.84, 76, 6, "Ammunation", 0.5 },
	{ 22.53,-1105.52,29.79, 76, 6, "Ammunation", 0.5 },
	{ 810.22,-2158.99,29.62, 76, 6, "Ammunation", 0.5 },

	{ -815.12,-184.15,37.57, 71, 62, "Barbearia", 0.5 },
	{ 139.56,-1704.12,29.05, 71, 62, "Barbearia", 0.5 },
	{ -1278.11,-1116.66,6.75, 71, 62, "Barbearia", 0.5 },
	{ 1928.89,3734.04,32.6, 71, 62, "Barbearia", 0.5 },
	{ 1217.05,-473.45,65.96, 71, 62, "Barbearia", 0.5 },
	{ -34.08,-157.01,56.83, 71, 62, "Barbearia", 0.5 },
	{ -274.5,6225.27,31.45, 71, 62, "Barbearia", 0.5 },

	{ -1081.43,-249.57,37.76, 489, 51, "Life Invader", 0.7 },

	{ 220.98,-1844.86,27.18, 478, 31, "Loja de Usados", 0.7 },

	{ 86.06,-1391.64,29.23, 366, 42, "Loja de Roupas", 0.6 },
	{ -719.94,-158.18,37.0, 366, 42, "Loja de Roupas", 0.6 },
	{ -152.79,-306.79,38.67, 366, 42, "Loja de Roupas", 0.6 },
	{ -816.39,-1081.22,11.12, 366, 42, "Loja de Roupas", 0.6 },
	{ -1206.51,-781.5,17.12, 366, 42, "Loja de Roupas", 0.6 },
	{ -1458.26,-229.79,49.2, 366, 42, "Loja de Roupas", 0.6 },
	{ -2.41,6518.29,31.48, 366, 42, "Loja de Roupas", 0.6 },
	{ 1682.59,4819.98,42.04, 366, 42, "Loja de Roupas", 0.6 },
	{ 129.46,-205.18,54.51, 366, 42, "Loja de Roupas", 0.6 },
	{ 618.49,2745.54,42.01, 366, 42, "Loja de Roupas", 0.6 },
	{ 1197.93,2698.21,37.96, 366, 42, "Loja de Roupas", 0.6 },
	{ -3165.74,1061.29,20.84, 366, 42, "Loja de Roupas", 0.6 },
	{ -1093.76,2703.99,19.04, 366, 42, "Loja de Roupas", 0.6 },
	{ 414.86,-807.57,29.34, 366, 42, "Loja de Roupas", 0.6 },

	{ -1728.06,-1050.69,1.71, 356, 62, "Embarcações", 0.6 },
	{ -776.72,-1495.02,2.29, 356, 62, "Embarcações", 0.6 },
	{ -893.97,5687.78,3.29, 356, 62, "Embarcações", 0.6 },
	{ 1509.64,3788.7,33.51, 356, 62, "Embarcações", 0.6 },

	{ 91.9,-230.88,54.66, 403, 34, "Farmácia", 0.7 },

	{ 2044.86,3195.82,45.19, 467, 11, "Reciclagem", 0.7 },

	{ 408.98,-1622.71,29.28, 357, 9, "Reboque", 0.6 },

	{ 731.49,-1088.87,21.82, 402, 18, "Los Santos Customs", 0.7 },

	{ 562.36,2741.56,42.87, 273, 11, "Animal Park", 0.5 },

	{ 827.1,5426.91,485.51, 141, 51, "Área de Caça", 0.7 },
	{ -2080.6,1357.4,257.87, 141, 51, "Área de Caça", 0.7 },

	{ -679.13,5839.52,17.3, 141, 51, "Cabana de Caça", 0.7 },

	{ -1663.58,-749.36,10.21, 496, 11, "Área Perigosa", 0.7 },
	{ 922.22,-1923.63,30.89, 496, 11, "Área Perigosa", 0.7 },
	{ 1770.85,3652.74,34.41, 496, 11, "Área Perigosa", 0.7},
	{ -303.89,6229.39,31.46, 496, 11, "Área Perigosa", 0.7},
	{ -88.0,249.04,100.0, 496, 11, "Área Perigosa", 0.7 },

	{ 1689.49,2602.64,45.56, 307, 1, "Área Aérea", 0.7 },

	{ -3260.22,3907.64,27.25, 307, 55, "Aircraft Carrier 96", 0.8 },

	{ 2954.97,2807.08,41.75, 274, 1, "Área Contaminada", 0.7 },
	{ 3533.77,3720.49,28.36, 274, 1, "Área Contaminada", 0.7 },
	
	{ 265.05,-1262.65,29.3, 361, 41, "Posto de Gasolina", 0.5 },
	{ 819.02,-1027.96,26.41, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1208.61,-1402.43,35.23, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1181.48,-330.26,69.32, 361, 41, "Posto de Gasolina", 0.5 },
	{ 621.01,268.68,103.09, 361, 41, "Posto de Gasolina", 0.5 },
	{ 2581.09,361.79,108.47, 361, 41, "Posto de Gasolina", 0.5 },
	{ 175.08,-1562.12,29.27, 361, 41, "Posto de Gasolina", 0.5 },
	{ -319.76,-1471.63,30.55, 361, 41, "Posto de Gasolina", 0.5 },
	{ 49.42,2778.8,58.05, 361, 41, "Posto de Gasolina", 0.5 },
	{ 264.09,2606.56,44.99, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1039.38,2671.28,39.56, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1207.4,2659.93,37.9, 361, 41, "Posto de Gasolina", 0.5 },
	{ 2539.19,2594.47,37.95, 361, 41, "Posto de Gasolina", 0.5 },
	{ 2679.95,3264.18,55.25, 361, 41, "Posto de Gasolina", 0.5 },
	{ 2005.03,3774.43,32.41, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1687.07,4929.53,42.08, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1701.53,6415.99,32.77, 361, 41, "Posto de Gasolina", 0.5 },
	{ 180.1,6602.88,31.87, 361, 41, "Posto de Gasolina", 0.5 },
	{ -94.46,6419.59,31.48, 361, 41, "Posto de Gasolina", 0.5 },
	{ -2555.17,2334.23,33.08, 361, 41, "Posto de Gasolina", 0.5 },
	{ -1800.09,803.54,138.72, 361, 41, "Posto de Gasolina", 0.5 },
	{ -1437.0,-276.8,46.21, 361, 41, "Posto de Gasolina", 0.5 },
	{ -2096.3,-320.17,13.17, 361, 41, "Posto de Gasolina", 0.5 },
	{ -724.56,-935.97,19.22, 361, 41, "Posto de Gasolina", 0.5 },
	{ -525.26,-1211.19,18.19, 361, 41, "Posto de Gasolina", 0.5 },
	{ -70.96,-1762.21,29.54, 361, 41, "Posto de Gasolina", 0.5 },
	{ 1776.7,3330.56,41.32, 361, 41, "Posto de Gasolina", 0.5 },
	{ -1112.4,-2884.08,13.93, 361, 41, "Posto de Gasolina", 0.5 },

	{ 1327.98,-1654.78,52.03, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -1149.04,-1428.64,4.71, 75, 13, "Loja de Tatuagem", 0.5 },
	{ 322.01,186.24,103.34, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -3175.64,1075.54,20.58, 75, 13, "Loja de Tatuagem", 0.5 },
	{ 1866.01,3748.07,32.79, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -295.51,6199.21,31.24, 75, 13, "Loja de Tatuagem", 0.5 },

	{ -1177.93,-884.13,13.88, 439, 62, "Restaurante", 0.7 },

	{ -365.86,-248.13,36.08, 351, 16, "Central de Empregos", 0.9 },

	{ -70.49,-1104.59,26.12, 89, 66, "Concessionária", 0.5 },
	{ 1224.78,2728.01,38.0, 89, 66, "Concessionária", 0.5 },

	{ -535.04,-221.34,37.64, 267, 5,  "Prefeitura", 0.6 },

	{ -37.95,-205.64,45.78, 380, 81, "Auto Escola", 0.8 },

	{ -628.79,-238.7,38.05, 617, 84, "Joalheria", 0.6 },

	{ -237.81,6545.23,2.07, 68, 18, "Pescador", 0.7 },

	{ 282.23,6792.7,15.69, 78, 21, "Mergulhador", 0.6 }
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

		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		BlockWeaponWheelThisFrame()
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

		SetVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetRandomVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetParkedVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetScenarioPedDensityMultiplierThisFrame(TheNpcControl, TheNpcControl)
		SetPedDensityMultiplierThisFrame(TheNpcControl)

		if IsPedArmed(Ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if IsPedUsingActionMode(Ped) then
			SetPedUsingActionMode(Ped,-1,-1,1)
		end

		if IsPedInAnyVehicle(Ped) then
			DisableControlAction(0,345,true)
		end

		SetPauseMenuActive(false)
		DisablePlayerVehicleRewards(Pid)
		SetPedInfiniteAmmoClip(Ped,false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		if IsPlayerWantedLevelGreater(Pid,0) then
			ClearPlayerWantedLevel(Pid)
		end

		if not DisableTargetMode then
			SetPlayerLockonRangeOverride(Pid, 0.0)
		end

		SetArtificialLightsState(GlobalState["Blackout"])
		SetArtificialLightsStateAffectsVehicles(false)

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