-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
PercetageSelling = 0.5 -- Porcentagem a receber ao vender o veículo
PercentageTaxs = 0.15 -- Porcentagem a cobrar pela taxa mensal do veículo
PercentageArrest = 0.1 -- Porcentagem a cobrar para liberar o veículo apreendido
PercentageRescue = 0.1 -- Porcentagem a cobrar para resgatar o veículo em qualquer garagem
PercentageImpost = 0.25 -- Porcentagem de imposto ao comprar um veículo
CarPermission = "Admin" -- Permissão para utilizar o comando /car
DvPermission = "Admin" -- Permissão para utilizar o comando /dv
LockPermission = "Admin" -- Permissão para destrancar qualquer veículo
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
Garages = {
	["1"] = { ["Name"] = "Garage", ["Save"] = true },
	["2"] = { ["Name"] = "Garage", ["Save"] = true },
	["3"] = { ["Name"] = "Garage", ["Save"] = true },
	["4"] = { ["Name"] = "Garage", ["Save"] = true },
	["5"] = { ["Name"] = "Garage", ["Save"] = true },
	["6"] = { ["Name"] = "Garage", ["Save"] = true },
	["7"] = { ["Name"] = "Garage", ["Save"] = true },
	["8"] = { ["Name"] = "Garage", ["Save"] = true },
	["9"] = { ["Name"] = "Garage", ["Save"] = true },
	["10"] = { ["Name"] = "Garage", ["Save"] = true },
	["11"] = { ["Name"] = "Garage", ["Save"] = true },
	["12"] = { ["Name"] = "Garage", ["Save"] = true },
	["13"] = { ["Name"] = "Garage", ["Save"] = true },
	["14"] = { ["Name"] = "Garage", ["Save"] = true },
	["15"] = { ["Name"] = "Garage", ["Save"] = true },
	["16"] = { ["Name"] = "Garage", ["Save"] = true },
	["17"] = { ["Name"] = "Garage", ["Save"] = true },
	["18"] = { ["Name"] = "Garage", ["Save"] = true },
	["19"] = { ["Name"] = "Garage", ["Save"] = true },
	["20"] = { ["Name"] = "Garage", ["Save"] = true },
	["21"] = { ["Name"] = "Garage", ["Save"] = true },
	["22"] = { ["Name"] = "Garage", ["Save"] = true },
	["23"] = { ["Name"] = "Garage", ["Save"] = true },
	["24"] = { ["Name"] = "Garage", ["Save"] = true },
	["25"] = { ["Name"] = "Garage", ["Save"] = true },
	["26"] = { ["Name"] = "Garage", ["Save"] = true },

	-- Paramedic
	["41"] = { ["Name"] = "Paramedico", ["Permission"] = "Paramedico" },
	["42"] = { ["Name"] = "Paramedico2", ["Permission"] = "Paramedico" },

	-- Police
	["51"] = { ["Name"] = "Policia", ["Permission"] = "Policia" },
	["52"] = { ["Name"] = "Policia2", ["Permission"] = "Policia" },
	["53"] = { ["Name"] = "Policia3", ["Permission"] = "Policia" },

	-- Boats
	["121"] = { ["Name"] = "Boats" },
	["122"] = { ["Name"] = "Boats" },
	["123"] = { ["Name"] = "Boats" },
	["124"] = { ["Name"] = "Boats" },

	["131"] = { ["Name"] = "Helicopters" },

	-- Works
	["141"] = { ["Name"] = "Lumberman" },
	["142"] = { ["Name"] = "Driver" },
	["143"] = { ["Name"] = "Garbageman" },
	["144"] = { ["Name"] = "Transporter" },
	["145"] = { ["Name"] = "Garbageman" },
	["146"] = { ["Name"] = "Garbageman" },
	["147"] = { ["Name"] = "Trucker" },
	["148"] = { ["Name"] = "Taxi" },
	["149"] = { ["Name"] = "Grime" },
	["150"] = { ["Name"] = "Towed" },
	["151"] = { ["Name"] = "Milkman" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
Works = {
	["Helicopters"] = {
		"maverick",
		"volatus",
		"supervolito",
		"havok"
	},
	["Paramedico"] = {
		"lguard",
		"blazer2",
		"firetruk",
		"ambulance2"
	},
	["Paramedico2"] = {
		"maverick2"
	},
	["Policia"] = {
		"ballerpol",
		"elegy2pol",
		"fugitivepol",
		"komodapol",
		"kurumapol",
		"nc700pol",
		"oracle2pol",
		"polchall",
		"polchar",
		"police3pol",
		"policepol",
		"policetpol",
		"poltang",
		"polvic",
		"r1250pol",
		"schafter2pol",
		"sheriff2pol",
		"silveradopol",
		"sultanrspol",
		"tahoepol",
		"tailgater2pol",
		"tauruspol"
	},
	["Policia2"] = {
		"polas350"
	},
	["Policia3"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["Garbageman"] = {
		"trash"
	},
	["Trucker"] = {
		"packer"
	},
	["Taxi"] = {
		"taxi"
	},
	["Grime"] = {
		"boxville2"
	},
	["Towed"] = {
		"flatbed"
	},
	["Milkman"] = {
		"youga2"
	}
}