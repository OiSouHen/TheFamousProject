-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
	["Lenhador"] = {
		["Route"] = true, -- false (se a localização de entrega é aleatória)
		["Circle"] = 0.15, -- Tamanho da região do target
		["Wanted"] = 600, -- false (se deseja desativar) | number (quantidade em segundos)
		["Battlepass"] = 2, -- false (se deseja desativar) | number (quantidade em pontos)
		["DebugPoly"] = false, -- true (caso queira ver o tamanho do Circle)
		["Permission"] = false, -- false (Caso não tenha permissão)
		["Mode"] = "Always", -- Always, Init, Never
		["Init"] = vec3(319.81,-679.65,29.58), -- Coordenada de inicio do emprego (use o comando /postit)
		["Experience"] = {
			["Name"] = "Lumberman", -- Nome da experiência
			["Amount"] = 1 -- Quantidade recebida
		},
		["List"] = {
			{ ["Item"] = "joint", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "cocaine", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "meth", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "bandage", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "medkit", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "nitro", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "tyres", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "tomato", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 },
			{ ["Item"] = "lockpick", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 3, ["Price"] = 100 }
		},
		["Coords"] = {
			vec3(-513.92,-1019.31,23.47),
			vec3(-1604.18,-832.26,10.08),
			vec3(-536.48,-45.61,42.57),
			vec3(-53.01,79.35,71.62),
			vec3(581.16,139.13,99.48),
			vec3(814.39,-93.48,80.6),
			vec3(1106.93,-355.03,67.01),
			vec3(1070.71,-780.46,58.36),
			vec3(1142.82,-986.58,45.91),
			vec3(1200.55,-1276.6,35.23),
			vec3(967.81,-1829.29,31.24),
			vec3(809.16,-2222.61,29.65),
			vec3(684.61,-2741.62,6.02),
			vec3(263.47,-2506.62,6.45),
			vec3(94.66,-2676.38,6.01),
			vec3(-43.87,-2519.91,7.4),
			vec3(182.93,-2027.68,18.28),
			vec3(-306.86,-2191.84,10.84),
			vec3(-570.95,-1775.95,23.19),
			vec3(-350.03,-1569.9,25.23),
			vec3(-128.36,-1394.12,29.57),
			vec3(67.84,-1399.02,29.37),
			vec3(343.13,-1297.91,32.51),
			vec3(485.92,-1477.41,29.29),
			vec3(139.81,-1337.41,29.21),
			vec3(263.82,-1346.16,31.93),
			vec3(-723.33,-1112.41,10.66),
			vec3(-842.54,-1128.21,7.02),
			vec3(488.46,-898.56,25.94)
		}
	}
}