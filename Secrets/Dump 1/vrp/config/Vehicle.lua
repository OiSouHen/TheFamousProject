-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	-- BOATS
	["dinghy"] = {
		["Name"] = "Dinghy",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["dinghy2"] = {
		["Name"] = "Dinghy 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["dinghy3"] = {
		["Name"] = "Dinghy 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["dinghy4"] = {
		["Name"] = "Dinghy 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["jetmax"] = {
		["Name"] = "Jetmax",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["marquis"] = {
		["Name"] = "Marquis",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["seashark"] = {
		["Name"] = "Seashark",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["seashark2"] = {
		["Name"] = "Seashark 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["seashark3"] = {
		["Name"] = "Seashark 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["speeder"] = {
		["Name"] = "Speeder",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["speeder2"] = {
		["Name"] = "Speeder 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["squalo"] = {
		["Name"] = "Squalo",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["submersible"] = {
		["Name"] = "Submersible",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["submersible2"] = {
		["Name"] = "Submersible 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["suntrap"] = {
		["Name"] = "Suntrap",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["toro"] = {
		["Name"] = "Toro",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["toro2"] = {
		["Name"] = "Toro 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["tropic"] = {
		["Name"] = "Tropic",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["tropic2"] = {
		["Name"] = "Tropic 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["tug"] = {
		["Name"] = "Tug",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["avisa"] = {
		["Name"] = "Avisa",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["dinghy5"] = {
		["Name"] = "Dinghy 5",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["kosatka"] = {
		["Name"] = "Kosatka",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["longfin"] = {
		["Name"] = "Longfin",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["patrolboat"] = {
		["Name"] = "Patrolboat",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},

	-- COMMERCIALS
	["biff"] = {
		["Name"] = "Biff",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["cerberus"] = {
		["Name"] = "Cerberus",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["cerberus2"] = {
		["Name"] = "Cerberus 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["cerberus3"] = {
		["Name"] = "Cerberus 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["hauler"] = {
		["Name"] = "Hauler",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["hauler2"] = {
		["Name"] = "Hauler 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["mule3"] = {
		["Name"] = "Mule 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["mule4"] = {
		["Name"] = "Mule 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["packer"] = {
		["Name"] = "Packer",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["phantom"] = {
		["Name"] = "Phantom",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["phantom2"] = {
		["Name"] = "Phantom 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["phantom3"] = {
		["Name"] = "Phantom 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["pounder"] = {
		["Name"] = "Pounder",
		["Weight"] = 300,
		["Price"] = 250000,
		["Mode"] = nil,
		["Gemstone"] = 10000,
		["Class"] = "Caminhões"
	},
	["pounder2"] = {
		["Name"] = "Pounder 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["stockade"] = {
		["Name"] = "Stockade",
		["Weight"] = 50,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["stockade3"] = {
		["Name"] = "Stockade 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},
	["terbyte"] = {
		["Name"] = "Terbyte",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Caminhões"
	},

	-- COMPACTS
	["asbo"] = {
		["Name"] = "Asbo",
		["Weight"] = 20,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["blista"] = {
		["Name"] = "Blista",
		["Weight"] = 20,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["brioso"] = {
		["Name"] = "Brioso",
		["Weight"] = 20,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["club"] = {
		["Name"] = "Club",
		["Weight"] = 20,
		["Price"] = 15000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["dilettante"] = {
		["Name"] = "Dilettante",
		["Weight"] = 30,
		["Price"] = 100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["dilettante2"] = {
		["Name"] = "Dilettante 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["kanjo"] = { --ALTERADO
		["Name"] = "Kanjo",
		["Weight"] = 30,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["issi2"] = { --ALTERADO
		["Name"] = "Issi 2",
		["Weight"] = 25,
		["Price"] = 100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["issi3"] = {
		["Name"] = "Issi 3",
		["Weight"] = 35,
		["Price"] = 80000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["issi4"] = {
		["Name"] = "Issi 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["issi5"] = {
		["Name"] = "Issi 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["issi6"] = {
		["Name"] = "Issi 6",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["panto"] = {
		["Name"] = "Panto",
		["Weight"] = 20,
		["Price"] = 15000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["prairie"] = {
		["Name"] = "Prairie",
		["Weight"] = 15,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["rhapsody"] = {
		["Name"] = "Rhapsody",
		["Weight"] = 15,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["brioso2"] = {
		["Name"] = "Brioso 2",
		["Weight"] = 20,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["weevil"] = {
		["Name"] = "Weevil",
		["Weight"] = 35,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},

	-- COUPES
	["cogcabrio"] = {
		["Name"] = "Cogcabrio",
		["Weight"] = 30,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["exemplar"] = {
		["Name"] = "Exemplar",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["f620"] = {
		["Name"] = "F620",
		["Weight"] = 30,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["felon"] = {
		["Name"] = "Felon",
		["Weight"] = 30,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["felon2"] = {
		["Name"] = "Felon 2",
		["Weight"] = 35,
		["Price"] = 280000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["jackal"] = {
		["Name"] = "Jackal",
		["Weight"] = 30,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["oracle"] = {
		["Name"] = "Oracle",
		["Weight"] = 30,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["oracle2"] = {
		["Name"] = "Oracle 2",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["sentinel"] = {
		["Name"] = "Sentinel",
		["Weight"] = 30,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["sentinel2"] = {
		["Name"] = "Sentinel 2",
		["Weight"] = 35,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["windsor"] = {
		["Name"] = "Windsor",
		["Weight"] = 30,
		["Price"] = 320000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["windsor2"] = {
		["Name"] = "Windsor 2",
		["Weight"] = 40,
		["Price"] = 370000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["zion"] = {
		["Name"] = "Zion",
		["Weight"] = 30,
		["Price"] = 125000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["zion2"] = {
		["Name"] = "Zion 2",
		["Weight"] = 35,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},
	["previon"] = {
		["Name"] = "Previon",
		["Weight"] = 30,
		["Price"] = 320000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Cupês"
	},

	-- CYCLES
	["bmx"] = {
		["Name"] = "Bmx",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},	
	["cruiser"] = {
		["Name"] = "Cruiser",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},
	["fixter"] = {
		["Name"] = "Fixter",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},
	["scorcher"] = {
		["Name"] = "Scorcher",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},
	["tribike"] = {
		["Name"] = "Tribike",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},
	["tribike2"] = {
		["Name"] = "Tribike 2",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},
	["tribike3"] = {
		["Name"] = "Tribike 3",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Bicicletas"
	},

	-- EMERGENCY
	["ambulance"] = {
		["Name"] = "Ambulance",
		["Weight"] = 0,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["fbi"] = {
		["Name"] = "Fbi",
		["Weight"] = 0,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["fbi2"] = {
		["Name"] = "Fbi 2",
		["Weight"] = 0,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["firetruk"] = {
		["Name"] = "Firetruk",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},	
	["lguard"] = {
		["Name"] = "Lguard",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["pbus"] = {
		["Name"] = "Pbus",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["police"] = {
		["Name"] = "Police",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["police2"] = {
		["Name"] = "Police 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["police3"] = {
		["Name"] = "Police 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["police4"] = {
		["Name"] = "Police 4",
		["Weight"] = 20,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["policeb"] = {
		["Name"] = "Harley FLH1200",
		["Weight"] = 0,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["polmav"] = {
		["Name"] = "Polmav",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["policeold1"] = {
		["Name"] = "Policeold 1",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["policeold2"] = {
		["Name"] = "Policeold 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["policet"] = {
		["Name"] = "Police T",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["pranger"] = {
		["Name"] = "Pranger",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["predator"] = {
		["Name"] = "Predator",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["riot"] = {
		["Name"] = "Riot",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["riot2"] = {
		["Name"] = "Riot 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["sheriff"] = {
		["Name"] = "Sheriff",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},
	["sheriff2"] = {
		["Name"] = "Sheriff 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Emergência"
	},

	-- HELICOPTERS
	["akula"] = {
		["Name"] = "Akula",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["annihilator"] = {
		["Name"] = "Annihilator",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["buzzard"] = {
		["Name"] = "Buzzard",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["buzzard2"] = {
		["Name"] = "Buzzard 2",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["cargobob"] = {
		["Name"] = "Cargobob",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["cargobob2"] = {
		["Name"] = "Cargobob 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["cargobob3"] = {
		["Name"] = "Cargobob 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["cargobob4"] = {
		["Name"] = "Cargobob 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["frogger2"] = {
		["Name"] = "Frogger 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["havok"] = {
		["Name"] = "Havok",
		["Weight"] = 100,
		["Price"] = 262500,
		["Mode"] = "Work",
		["Gemstone"] = 7500,
		["Class"] = "Helicópteros"
	},
	["hunter"] = {
		["Name"] = "Hunter",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["maverick"] = {
		["Name"] = "Maverick",
		["Weight"] = 100,
		["Price"] = 437500,
		["Mode"] = "Work",
		["Gemstone"] = 12500,
		["Class"] = "Helicópteros"
	},
	["savage"] = {
		["Name"] = "Savage",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["seasparrow"] = {
		["Name"] = "Seasparrow",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["skylift"] = {
		["Name"] = "Skylift",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["supervolito"] = {
		["Name"] = "Supervolito",
		["Weight"] = 100,
		["Price"] = 437500,
		["Mode"] = "Work",
		["Gemstone"] = 12500,
		["Class"] = "Helicópteros"
	},
	["supervolito2"] = {
		["Name"] = "Supervolito 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["swift"] = {
		["Name"] = "Swift",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["swift2"] = {
		["Name"] = "Swift 2",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["valkyrie"] = {
		["Name"] = "Valkyrie",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["valkyrie2"] = {
		["Name"] = "Valkyrie 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["volatus"] = {
		["Name"] = "Volatus",
		["Weight"] = 100,
		["Price"] = 437500,
		["Mode"] = "Work",
		["Gemstone"] = 12500,
		["Class"] = "Helicópteros"
	},
	["annihilator2"] = {
		["Name"] = "Annihilator 2",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["seasparrow2"] = {
		["Name"] = "Seasparrow 2",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},
	["seasparrow3"] = {
		["Name"] = "Seasparrow 3",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Helicópteros"
	},

	-- INDUSTRIAL
	["bulldozer"] = {
		["Name"] = "Bulldozer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["cutter"] = {
		["Name"] = "Cutter",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["dump"] = {
		["Name"] = "Dump",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["flatbed"] = {
		["Name"] = "Flatbed",
		["Weight"] = 25,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["wrdeliveryst"] = {
		["Name"] = "Caminhão",
		["Weight"] = 25,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["guardian"] = {
		["Name"] = "Guardian",
		["Weight"] = 50,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["handler"] = {
		["Name"] = "Handler",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["mixer"] = {
		["Name"] = "Mixer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["mixer2"] = {
		["Name"] = "Mixer 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["rubble"] = {
		["Name"] = "Rubble",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["tiptruck"] = {
		["Name"] = "Tiptruck",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},
	["tiptruck2"] = {
		["Name"] = "Tiptruck 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Industriais"
	},

	-- MILITARY
	["apc"] = {
		["Name"] = "Apc",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["barracks"] = {
		["Name"] = "Barracks",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["barracks2"] = {
		["Name"] = "Barracks 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["barracks3"] = {
		["Name"] = "Barracks 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["barrage"] = {
		["Name"] = "Barrage",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["chernobog"] = {
		["Name"] = "Chernobog",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["crusader"] = {
		["Name"] = "Crusader",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["halftrack"] = {
		["Name"] = "Halftrack",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["khanjali"] = {
		["Name"] = "Khanjali",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["minitank"] = {
		["Name"] = "Minitank",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["rhino"] = {
		["Name"] = "Rhino",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["scarab"] = {
		["Name"] = "Scarab",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["scarab2"] = {
		["Name"] = "Scarab 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["scarab3"] = {
		["Name"] = "Scarab 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["thruster"] = {
		["Name"] = "Thruster",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["trailersmall2"] = {
		["Name"] = "Trailersmall 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},
	["vetir"] = {
		["Name"] = "Vetir",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Militares"
	},

	-- BIKES
	["akuma"] = {
		["Name"] = "Akuma",
		["Weight"] = 20,
		["Price"] = 510000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["avarus"] = {
		["Name"] = "Avarus",
		["Weight"] = 20,
		["Price"] = 280000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["bagger"] = {
		["Name"] = "Bagger",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["bati"] = {
		["Name"] = "Bati",
		["Weight"] = 20,
		["Price"] = 420000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["bati2"] = {
		["Name"] = "Bati 2",
		["Weight"] = 20,
		["Price"] = 450000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["bf400"] = {
		["Name"] = "Bf400",
		["Weight"] = 20,
		["Price"] = 550000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["carbonrs"] = {
		["Name"] = "Carbon RS",
		["Weight"] = 20,
		["Price"] = 320000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["chimera"] = {
		["Name"] = "Chimera",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["cliffhanger"] = {
		["Name"] = "Cliffhanger",
		["Weight"] = 20,
		["Price"] = 280000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["daemon"] = {
		["Name"] = "Daemon",
		["Weight"] = 20,
		["Price"] = 210000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["daemon2"] = {
		["Name"] = "Daemon 2",
		["Weight"] = 20,
		["Price"] = 260000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["defiler"] = {
		["Name"] = "Defiler",
		["Weight"] = 20,
		["Price"] = 410000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["deathbike"] = {
		["Name"] = "Deathbike",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["deathbike2"] = {
		["Name"] = "Deathbike 2",
		["Weight"] = 20,
		["Price"] = 65000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["deathbike3"] = {
		["Name"] = "Deathbike 3",
		["Weight"] = 20,
		["Price"] = 65000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["diablous"] = {
		["Name"] = "Diablous",
		["Weight"] = 20,
		["Price"] = 240000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["diablous2"] = {
		["Name"] = "Diablous 2",
		["Weight"] = 20,
		["Price"] = 310000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["double"] = {
		["Name"] = "Double",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["enduro"] = {
		["Name"] = "Enduro",
		["Weight"] = 20,
		["Price"] = 190000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["esskey"] = {
		["Name"] = "Esskey",
		["Weight"] = 20,
		["Price"] = 230000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["faggio"] = {
		["Name"] = "Faggio",
		["Weight"] = 10,
		["Price"] = 10000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["faggio2"] = {
		["Name"] = "Faggio 2",
		["Weight"] = 10,
		["Price"] = 35000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["faggio3"] = {
		["Name"] = "Faggio 3",
		["Weight"] = 10,
		["Price"] = 40000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["fcr"] = {
		["Name"] = "Fcr",
		["Weight"] = 20,
		["Price"] = 210000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["fcr2"] = {
		["Name"] = "Fcr 2",
		["Weight"] = 20,
		["Price"] = 230000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["gargoyle"] = {
		["Name"] = "Gargoyle",
		["Weight"] = 20,
		["Price"] = 310000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["hakuchou"] = {
		["Name"] = "Hakuchou",
		["Weight"] = 20,
		["Price"] = 550000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["hakuchou2"] = {
		["Name"] = "Hakuchou 2",
		["Weight"] = 20,
		["Price"] = 580000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["hexer"] = {
		["Name"] = "Hexer",
		["Weight"] = 20,
		["Price"] = 370000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["innovation"] = {
		["Name"] = "Innovation",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["lectro"] = {
		["Name"] = "Lectro",
		["Weight"] = 20,
		["Price"] = 390000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["manchez"] = {
		["Name"] = "Manchez",
		["Weight"] = 20,
		["Price"] = 190000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["manchez3"] = {
		["Name"] = "manchez3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["nemesis"] = {
		["Name"] = "Nemesis",
		["Weight"] = 20,
		["Price"] = 400000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["nightblade"] = {
		["Name"] = "Nightblade",
		["Weight"] = 20,
		["Price"] = 450000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["oppressor"] = {
		["Name"] = "Oppressor",
		["Weight"] = 20,
		["Price"] = 130000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["oppressor2"] = {
		["Name"] = "Oppressor 2",
		["Weight"] = 20,
		["Price"] = 130000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["pcj"] = {
		["Name"] = "Pcj",
		["Weight"] = 20,
		["Price"] = 130000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["powersurge"] = {
		["Name"] = "powersurge",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["ratbike"] = {
		["Name"] = "Ratbike",
		["Weight"] = 20,
		["Price"] = 110000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["ruffian"] = {
		["Name"] = "Ruffian",
		["Weight"] = 20,
		["Price"] = 330000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["rrocket"] = {
		["Name"] = "Rrocket",
		["Weight"] = 20,
		["Price"] = 350000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["sanchez"] = {
		["Name"] = "Sanchez",
		["Weight"] = 15,
		["Price"] = 260000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["sanchez2"] = {
		["Name"] = "Sanchez 2",
		["Weight"] = 15,
		["Price"] = 280000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["sanctus"] = {
		["Name"] = "Sanctus",
		["Weight"] = 20,
		["Price"] = 480000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["sovereign"] = {
		["Name"] = "Sovereign",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["stryder"] = {
		["Name"] = "Stryder",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["thrust"] = {
		["Name"] = "Thrust",
		["Weight"] = 20,
		["Price"] = 215000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["vader"] = {
		["Name"] = "Vader",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["vindicator"] = {
		["Name"] = "Vindicator",
		["Weight"] = 20,
		["Price"] = 280000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["vortex"] = {
		["Name"] = "Vortex",
		["Weight"] = 20,
		["Price"] = 310000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["wolfsbane"] = {
		["Name"] = "Wolfsbane",
		["Weight"] = 20,
		["Price"] = 200000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["zombiea"] = {
		["Name"] = "Zombie A",
		["Weight"] = 20,
		["Price"] = 270000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["zombieb"] = {
		["Name"] = "Zombie B",
		["Weight"] = 20,
		["Price"] = 275000,
		["Mode"] = "Bikes",
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},
	["manchez2"] = {
		["Name"] = "Manchez 2",
		["Weight"] = 20,
		["Price"] = 230000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Motocicletas"
	},

	-- MUSCLES
	["blade"] = {
		["Name"] = "Blade",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["broadway"] = {
		["Name"] = "broadway",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["buccaneer"] = {
		["Name"] = "Buccaneer",
		["Weight"] = 30,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["buccaneer2"] = {
		["Name"] = "Buccaneer 2",
		["Weight"] = 35,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["chino"] = {
		["Name"] = "Chino",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["chino2"] = {
		["Name"] = "Chino 2",
		["Weight"] = 45,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["clique"] = {
		["Name"] = "Clique",
		["Weight"] = 35,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["coquette3"] = {
		["Name"] = "Coquette 3",
		["Weight"] = 40,
		["Price"] = 360000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["deviant"] = {
		["Name"] = "Deviant",
		["Weight"] = 50,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator"] = {
		["Name"] = "Dominator",
		["Weight"] = 50,
		["Price"] = 410000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator2"] = {
		["Name"] = "Dominator 2",
		["Weight"] = 50,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator3"] = {
		["Name"] = "Dominator 3",
		["Weight"] = 30,
		["Price"] = 500000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},	
	["dominator4"] = {
		["Name"] = "Dominator 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator5"] = {
		["Name"] = "Dominator 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator6"] = {
		["Name"] = "Dominator 6",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dukes"] = {
		["Name"] = "Dukes",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dukes2"] = {
		["Name"] = "Dukes 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dukes3"] = {
		["Name"] = "Dukes 3",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["faction"] = {
		["Name"] = "Faction",
		["Weight"] = 50,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["faction2"] = {
		["Name"] = "Faction 2",
		["Weight"] = 40,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["faction3"] = {
		["Name"] = "Faction 3",
		["Weight"] = 40,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ellie"] = {
		["Name"] = "Ellie",
		["Weight"] = 50,
		["Price"] = 410000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["eudora"] = {
		["Name"] = "eudora",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["gauntlet"] = {
		["Name"] = "Gauntlet",
		["Weight"] = 40,
		["Price"] = 340000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["gauntlet2"] = {
		["Name"] = "Gauntlet 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["gauntlet3"] = {
		["Name"] = "Gauntlet 3",
		["Weight"] = 40,
		["Price"] = 290000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["gauntlet4"] = {
		["Name"] = "Gauntlet 4",
		["Weight"] = 40,
		["Price"] = 1120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["gauntlet5"] = {
		["Name"] = "Gauntlet 5",
		["Weight"] = 40,
		["Price"] = 430000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["hermes"] = {
		["Name"] = "Hermes",
		["Weight"] = 40,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["hotknife"] = {
		["Name"] = "Hotknife",
		["Weight"] = 30,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["hustler"] = {
		["Name"] = "Hustler",
		["Weight"] = 40,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["impaler"] = {
		["Name"] = "Impaler",
		["Weight"] = 50,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["impaler2"] = {
		["Name"] = "Impaler 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["impaler3"] = {
		["Name"] = "Impaler 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["impaler4"] = {
		["Name"] = "Impaler 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["imperator"] = {
		["Name"] = "Imperator",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["imperator2"] = {
		["Name"] = "Imperator 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["imperator3"] = {
		["Name"] = "Imperator 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["lurcher"] = {
		["Name"] = "Lurcher",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["moonbeam"] = {
		["Name"] = "Moonbeam",
		["Weight"] = 50,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["moonbeam2"] = {
		["Name"] = "Moonbeam 2",
		["Weight"] = 40,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["nightshade"] = {
		["Name"] = "Nightshade",
		["Weight"] = 30,
		["Price"] = 310000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["peyote2"] = {
		["Name"] = "Peyote 2",
		["Weight"] = 45,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["phoenix"] = {
		["Name"] = "Phoenix",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["picador"] = {
		["Name"] = "Picador",
		["Weight"] = 60,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ratloader"] = {
		["Name"] = "Ratloader",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ratloader2"] = {
		["Name"] = "Ratloader 2",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ruiner"] = {
		["Name"] = "Ruiner",
		["Weight"] = 50,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ruiner2"] = {
		["Name"] = "Ruiner 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["ruiner3"] = {
		["Name"] = "Ruiner 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["sabregt"] = {
		["Name"] = "Sabre GT",
		["Weight"] = 45,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["sabregt2"] = {
		["Name"] = "Sabregt 2",
		["Weight"] = 50,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan"] = {
		["Name"] = "Slamvan",
		["Weight"] = 50,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan2"] = {
		["Name"] = "Slamvan 2",
		["Weight"] = 50,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan3"] = {
		["Name"] = "Slamvan 3",
		["Weight"] = 40,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan4"] = {
		["Name"] = "Slamvan 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan5"] = {
		["Name"] = "Slamvan 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["slamvan6"] = {
		["Name"] = "Slamvan 6",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["stalion"] = {
		["Name"] = "Stalion",
		["Weight"] = 30,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["stalion2"] = {
		["Name"] = "Stalion 2",
		["Weight"] = 30,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["tahoma"] = {
		["Name"] = "tahoma",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["tampa"] = {
		["Name"] = "Tampa",
		["Weight"] = 40,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["tampa3"] = {
		["Name"] = "Tampa 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["tulip"] = {
		["Name"] = "Tulip",
		["Weight"] = 50,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["tulip2"] = {
		["Name"] = "tulip2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["vamos"] = {
		["Name"] = "Vamos",
		["Weight"] = 50,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["vigero"] = {
		["Name"] = "Vigero",
		["Weight"] = 30,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["virgo"] = {
		["Name"] = "Virgo",
		["Weight"] = 25,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["virgo2"] = {
		["Name"] = "Virgo 2",
		["Weight"] = 50,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["virgo3"] = {
		["Name"] = "Virgo 3",
		["Weight"] = 50,
		["Price"] = 100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["voodoo"] = {
		["Name"] = "Voodoo",
		["Weight"] = 45,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["voodoo2"] = {
		["Name"] = "Voodoo 2",
		["Weight"] = 25,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["yosemite"] = {
		["Name"] = "Yosemite",
		["Weight"] = 50,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["yosemite2"] = {
		["Name"] = "Yosemite 2",
		["Weight"] = 50,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["yosemite3"] = {
		["Name"] = "Yosemite 3",
		["Weight"] = 50,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["dominator7"] = {
		["Name"] = "Dominator 7",
		["Weight"] = 20,
		["Price"] = 850000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},

	-- OFF-ROADS
	["bfinjection"] = {
		["Name"] = "Bfinjection",
		["Weight"] = 20,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["bifta"] = {
		["Name"] = "Bifta",
		["Weight"] = 20,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["blazer"] = {
		["Name"] = "Blazer",
		["Weight"] = 10,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["blazer2"] = {
		["Name"] = "Blazer 2",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["blazer3"] = {
		["Name"] = "Blazer 3",
		["Weight"] = 10,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["blazer4"] = {
		["Name"] = "Blazer 4",
		["Weight"] = 10,
		["Price"] = 220000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["blazer5"] = {
		["Name"] = "Blazer 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["bodhi2"] = {
		["Name"] = "Bodhi 2",
		["Weight"] = 30,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["brawler"] = {
		["Name"] = "Brawler",
		["Weight"] = 40,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["bruiser"] = {
		["Name"] = "Bruiser",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["bruiser2"] = {
		["Name"] = "Bruiser 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["bruiser3"] = {
		["Name"] = "Bruiser 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["brutus"] = {
		["Name"] = "Brutus",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["brutus2"] = {
		["Name"] = "Brutus 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["brutus3"] = {
		["Name"] = "Brutus 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["caracara"] = {
		["Name"] = "Caracara",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["caracara2"] = {
		["Name"] = "Caracara 2",
		["Weight"] = 50,
		["Price"] = 1220000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dloader"] = {
		["Name"] = "Dloader",
		["Weight"] = 40,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dubsta3"] = {
		["Name"] = "Dubsta 3",
		["Weight"] = 55,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dune"] = {
		["Name"] = "Dune",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dune2"] = {
		["Name"] = "Dune 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dune3"] = {
		["Name"] = "Dune 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dune4"] = {
		["Name"] = "Dune 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["dune5"] = {
		["Name"] = "Dune 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["freecrawler"] = {
		["Name"] = "Freecrawler",
		["Weight"] = 50,
		["Price"] = 480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["hellion"] = {
		["Name"] = "Hellion",
		["Weight"] = 50,
		["Price"] = 220000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["insurgent"] = {
		["Name"] = "Insurgent",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["insurgent2"] = {
		["Name"] = "Insurgent 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["insurgent3"] = {
		["Name"] = "Insurgent 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["kalahari"] = {
		["Name"] = "Kalahari",
		["Weight"] = 30,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["kamacho"] = {
		["Name"] = "Kamacho",
		["Weight"] = 50,
		["Price"] = 720000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["marshall"] = {
		["Name"] = "Marshall",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["mesa3"] = {
		["Name"] = "Mesa 3",
		["Weight"] = 50,
		["Price"] = 350000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["monster"] = {
		["Name"] = "Monster",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["monster3"] = {
		["Name"] = "Monster 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["monster4"] = {
		["Name"] = "Monster 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["monster5"] = {
		["Name"] = "Monster 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["menacer"] = {
		["Name"] = "Menacer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["outlaw"] = {
		["Name"] = "Outlaw",
		["Weight"] = 20,
		["Price"] = 600000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["nightshark"] = {
		["Name"] = "Nightshark",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},	
	["rancherxl"] = {
		["Name"] = "Rancher XL",
		["Weight"] = 40,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["rancherxl2"] = {
		["Name"] = "Rancher XL2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["rebel"] = {
		["Name"] = "Rebel",
		["Weight"] = 40,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["rebel2"] = {
		["Name"] = "Rebel 2",
		["Weight"] = 45,
		["Price"] = 185000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["rcbandito"] = {
		["Name"] = "RC Bandito",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["riata"] = {
		["Name"] = "Riata",
		["Weight"] = 45,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["sandking"] = {
		["Name"] = "Sandking",
		["Weight"] = 50,
		["Price"] = 700000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["sandking2"] = {
		["Name"] = "Sandking 2",
		["Weight"] = 55,
		["Price"] = 610000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["technical"] = {
		["Name"] = "Technical",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["technical2"] = {
		["Name"] = "Technical 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["technical3"] = {
		["Name"] = "Technical 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["trophytruck"] = {
		["Name"] = "Trophytruck",
		["Weight"] = 20,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["trophytruck2"] = {
		["Name"] = "Trophytruck 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["vagrant"] = {
		["Name"] = "Vagrant",
		["Weight"] = 30,
		["Price"] = 430000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["zhaba"] = {
		["Name"] = "Zhaba",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["verus"] = {
		["Name"] = "Verus",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["winky"] = {
		["Name"] = "Winky",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},

	-- OPEN WHEELS
	["formula"] = {
		["Name"] = "Formula",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Formula 1"
	},
	["formula2"] = {
		["Name"] = "Formula 2",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Formula 1"
	},
	["openwheel1"] = {
		["Name"] = "Openwheel 1",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Formula 1"
	},
	["openwheel2"] = {
		["Name"] = "Openwheel 2",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Formula 1"
	},

	-- PLANES
	["alphaz1"] = {
		["Name"] = "Alphaz 1",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["avenger"] = {
		["Name"] = "Avenger",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["avenger2"] = {
		["Name"] = "Avenger 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["besra"] = {
		["Name"] = "Besra",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["blimp"] = {
		["Name"] = "Blimp",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["blimp2"] = {
		["Name"] = "Blimp 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["blimp3"] = {
		["Name"] = "Blimp 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["bombushka"] = {
		["Name"] = "Bombushka",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["cargoplane"] = {
		["Name"] = "Cargoplane",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["cargoplane2"] = {
		["Name"] = "cargoplane2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["cuban800"] = {
		["Name"] = "Cuban800",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["dodo"] = {
		["Name"] = "Dodo",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["duster"] = {
		["Name"] = "Duster",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["howard"] = {
		["Name"] = "Howard",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["hydra"] = {
		["Name"] = "Hydra",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["jet"] = {
		["Name"] = "Jet",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["lazer"] = {
		["Name"] = "Lazer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["luxor"] = {
		["Name"] = "Luxor",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["luxor2"] = {
		["Name"] = "Luxor 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["mammatus"] = {
		["Name"] = "Mammatus",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["microlight"] = {
		["Name"] = "Microlight",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["miljet"] = {
		["Name"] = "Miljet",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["mogul"] = {
		["Name"] = "Mogul",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["molotok"] = {
		["Name"] = "Molotok",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["nimbus"] = {
		["Name"] = "Nimbus",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["nokota"] = {
		["Name"] = "Nokota",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["pyro"] = {
		["Name"] = "Pyro",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["rogue"] = {
		["Name"] = "Rogue",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["seabreeze"] = {
		["Name"] = "Seabreeze",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["shamal"] = {
		["Name"] = "Shamal",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["starling"] = {
		["Name"] = "Starling",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["strikeforce"] = {
		["Name"] = "Strikeforce",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["stunt"] = {
		["Name"] = "Stunt",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["titan"] = {
		["Name"] = "Titan",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["tula"] = {
		["Name"] = "Tula",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["velum"] = {
		["Name"] = "Velum",
		["Weight"] = 0,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["velum2"] = {
		["Name"] = "Velum 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["vestra"] = {
		["Name"] = "Vestra",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["volatol"] = {
		["Name"] = "Volatol",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},
	["alkonost"] = {
		["Name"] = "Alkonost",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Aviões"
	},

	-- SUVS
	["baller"] = {
		["Name"] = "Baller",
		["Weight"] = 50,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["baller2"] = {
		["Name"] = "Baller 2",
		["Weight"] = 50,
		["Price"] = 280000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["baller3"] = {
		["Name"] = "Baller 3",
		["Weight"] = 50,
		["Price"] = 380000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["baller4"] = {
		["Name"] = "Baller 4",
		["Weight"] = 50,
		["Price"] = 430000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["baller5"] = {
		["Name"] = "Baller 5",
		["Weight"] = 50,
		["Price"] = 400000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["baller6"] = {
		["Name"] = "Baller 6",
		["Weight"] = 50,
		["Price"] = 410000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["bjxl"] = {
		["Name"] = "Bjxl",
		["Weight"] = 40,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["cavalcade"] = {
		["Name"] = "Cavalcade",
		["Weight"] = 30,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["cavalcade2"] = {
		["Name"] = "Cavalcade 2",
		["Weight"] = 45,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["contender"] = {
		["Name"] = "Contender",
		["Weight"] = 40,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["dubsta"] = {
		["Name"] = "Dubsta",
		["Weight"] = 50,
		["Price"] = 3100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["dubsta2"] = {
		["Name"] = "Dubsta 2",
		["Weight"] = 55,
		["Price"] = 350000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["fq2"] = {
		["Name"] = "Fq2",
		["Weight"] = 40,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["granger"] = {
		["Name"] = "Granger",
		["Weight"] = 65,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["gresley"] = {
		["Name"] = "Gresley",
		["Weight"] = 35,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["habanero"] = {
		["Name"] = "Habanero",
		["Weight"] = 35,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["huntley"] = {
		["Name"] = "Huntley",
		["Weight"] = 35,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["issi8"] = {
		["Name"] = "issi8",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["landstalker"] = {
		["Name"] = "Landstalker",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["landstalker2"] = {
		["Name"] = "Landstalker 2",
		["Weight"] = 50,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["mesa"] = {
		["Name"] = "Mesa",
		["Weight"] = 40,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["mesa2"] = {
		["Name"] = "Mesa 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["novak"] = {
		["Name"] = "Novak",
		["Weight"] = 40,
		["Price"] = 320000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["patriot"] = {
		["Name"] = "Patriot",
		["Weight"] = 50,
		["Price"] = 280000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["patriot2"] = {
		["Name"] = "Patriot 2",
		["Weight"] = 50,
		["Price"] = 340000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["radi"] = {
		["Name"] = "Radi",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["rebla"] = {
		["Name"] = "Rebla",
		["Weight"] = 40,
		["Price"] = 1400000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["rocoto"] = {
		["Name"] = "Rocoto",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["seminole"] = {
		["Name"] = "Seminole",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["seminole2"] = {
		["Name"] = "Seminole 2",
		["Weight"] = 45,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["serrano"] = {
		["Name"] = "Serrano",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["toros"] = {
		["Name"] = "Toros",
		["Weight"] = 50,
		["Price"] = 1600000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["xls"] = {
		["Name"] = "Xls",
		["Weight"] = 35,
		["Price"] = 720000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["xls2"] = {
		["Name"] = "Xls 2",
		["Weight"] = 50,
		["Price"] = 20000000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["squaddie"] = {
		["Name"] = "Squaddie",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},

	-- SEDANS
	["asea"] = {
		["Name"] = "Asea",
		["Weight"] = 30,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["asea2"] = {
		["Name"] = "Asea 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["asterope"] = {
		["Name"] = "Asterope",
		["Weight"] = 20,
		["Price"] = 30000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["cog55"] = {
		["Name"] = "Cog55",
		["Weight"] = 50,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["cog552"] = {
		["Name"] = "Cog55 2",
		["Weight"] = 50,
		["Price"] = 410000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["cognoscenti"] = {
		["Name"] = "Cognoscenti",
		["Weight"] = 50,
		["Price"] = 230000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["cognoscenti2"] = {
		["Name"] = "Cognoscenti 2",
		["Weight"] = 50,
		["Price"] = 400000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["emperor"] = {
		["Name"] = "Emperor",
		["Weight"] = 25,
		["Price"] = 35000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["emperor2"] = {
		["Name"] = "Emperor 2",
		["Weight"] = 20,
		["Price"] = 20000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["emperor3"] = {
		["Name"] = "Emperor 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["fugitive"] = {
		["Name"] = "Fugitive",
		["Weight"] = 60,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["glendale"] = {
		["Name"] = "Glendale",
		["Weight"] = 40,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["glendale2"] = {
		["Name"] = "Glendale 2",
		["Weight"] = 50,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["ingot"] = {
		["Name"] = "Ingot",
		["Weight"] = 40,
		["Price"] = 40000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["intruder"] = {
		["Name"] = "Intruder",
		["Weight"] = 40,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["limo2"] = {
		["Name"] = "Limo 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["premier"] = {
		["Name"] = "Premier",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["primo"] = {
		["Name"] = "Primo",
		["Weight"] = 30,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["primo2"] = {
		["Name"] = "Primo 2",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["regina"] = {
		["Name"] = "Regina",
		["Weight"] = 40,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["romero"] = {
		["Name"] = "Romero",
		["Weight"] = 25,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["stafford"] = {
		["Name"] = "Stafford",
		["Weight"] = 40,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["stanier"] = {
		["Name"] = "Stanier",
		["Weight"] = 25,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["stratum"] = {
		["Name"] = "Stratum",
		["Weight"] = 40,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["stretch"] = {
		["Name"] = "Stretch",
		["Weight"] = 40,
		["Price"] = 420000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["superd"] = {
		["Name"] = "Superd",
		["Weight"] = 40,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["surge"] = {
		["Name"] = "Surge",
		["Weight"] = 40,
		["Price"] = 100000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["tailgater"] = {
		["Name"] = "Tailgater",
		["Weight"] = 40,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["warrener"] = {
		["Name"] = "Warrener",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["washington"] = {
		["Name"] = "Washington",
		["Weight"] = 40,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},
	["tailgater2"] = {
		["Name"] = "Tailgater 2",
		["Weight"] = 40,
		["Price"] = 380000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Sedans"
	},

	-- SERVICES
	["airbus"] = {
		["Name"] = "Airbus",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["brickade"] = {
		["Name"] = "Brickade",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["bus"] = {
		["Name"] = "Bus",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["coach"] = {
		["Name"] = "Coach",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["pbus2"] = {
		["Name"] = "Pbus 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["rallytruck"] = {
		["Name"] = "Rally Truck",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["rentalbus"] = {
		["Name"] = "Rental Bus",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["taxi"] = {
		["Name"] = "Taxi",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["tourbus"] = {
		["Name"] = "Tour Bus",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["trash"] = {
		["Name"] = "Trash",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["trash2"] = {
		["Name"] = "Trash 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["wastelander"] = {
		["Name"] = "Wastelander",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},

	-- SPORTS
	["alpha"] = {
		["Name"] = "Alpha",
		["Weight"] = 40,
		["Price"] = 270000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
    ["astron"] = {
		["Name"] = "Astron",
		["Weight"] = 40,
		["Price"] = 690000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["banshee"] = {
		["Name"] = "Banshee",
		["Weight"] = 30,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["bestiagts"] = {
		["Name"] = "Bestia GTS",
		["Weight"] = 50,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["blista2"] = {
		["Name"] = "Blista 2",
		["Weight"] = 30,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["blista3"] = {
		["Name"] = "Blista 3",
		["Weight"] = 30,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["buffalo"] = {
		["Name"] = "Buffalo",
		["Weight"] = 40,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["buffalo2"] = {
		["Name"] = "Buffalo 2",
		["Weight"] = 50,
		["Price"] = 100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["buffalo3"] = {
		["Name"] = "Buffalo 3",
		["Weight"] = 50,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["carbonizzare"] = {
		["Name"] = "Carbonizzare",
		["Weight"] = 50,
		["Price"] = 410000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet2"] = {
		["Name"] = "Comet 2",
		["Weight"] = 40,
		["Price"] = 360000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet3"] = {
		["Name"] = "Comet 3",
		["Weight"] = 40,
		["Price"] = 310000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet4"] = {
		["Name"] = "Comet 4",
		["Weight"] = 40,
		["Price"] = 420000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet5"] = {
		["Name"] = "Comet 5",
		["Weight"] = 40,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["coquette"] = {
		["Name"] = "Coquette",
		["Weight"] = 40,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["coquette4"] = {
		["Name"] = "Coquette 4",
		["Weight"] = 30,
		["Price"] = 640000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["drafter"] = {
		["Name"] = "Drafter",
		["Weight"] = 40,
		["Price"] = 260000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["deveste"] = {
		["Name"] = "Deveste",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["elegy"] = {
		["Name"] = "Elegy",
		["Weight"] = 50,
		["Price"] = 640000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["elegy2"] = {
		["Name"] = "Elegy 2",
		["Weight"] = 30,
		["Price"] = 890000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["everon2"] = {
		["Name"] = "Everon2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["feltzer2"] = {
		["Name"] = "Feltzer 2",
		["Weight"] = 50,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["flashgt"] = {
		["Name"] = "Flash GT",
		["Weight"] = 40,
		["Price"] = 740000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["furoregt"] = {
		["Name"] = "Furore GT",
		["Weight"] = 35,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["fusilade"] = {
		["Name"] = "Fusilade",
		["Weight"] = 35,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["futo"] = {
		["Name"] = "Futo",
		["Weight"] = 40,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["gb200"] = {
		["Name"] = "Gb200",
		["Weight"] = 40,
		["Price"] = 290000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["hotring"] = {
		["Name"] = "Hotring",
		["Weight"] = 50,
		["Price"] = 130000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["komoda"] = {
		["Name"] = "Komoda",
		["Weight"] = 50,
		["Price"] = 920000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["imorgon"] = {
		["Name"] = "Imorgon",
		["Weight"] = 40,
		["Price"] = 580000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["issi7"] = {
		["Name"] = "Issi 7",
		["Weight"] = 40,
		["Price"] = 870000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["italigto"] = {
		["Name"] = "Itali GTO",
		["Weight"] = 30,
		["Price"] = 920000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jugular"] = {
		["Name"] = "Jugular",
		["Weight"] = 30,
		["Price"] = 1480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jester"] = {
		["Name"] = "Jester",
		["Weight"] = 30,
		["Price"] = 480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jester2"] = {
		["Name"] = "Jester 2",
		["Weight"] = 30,
		["Price"] = 230000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jester3"] = {
		["Name"] = "Jester 3",
		["Weight"] = 30,
		["Price"] = 430000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["khamelion"] = {
		["Name"] = "Khamelion",
		["Weight"] = 30,
		["Price"] = 140000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["kuruma"] = {
		["Name"] = "Kuruma",
		["Weight"] = 50,
		["Price"] = 650000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["kuruma2"] = {
		["Name"] = "Kuruma 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["locust"] = {
		["Name"] = "Locust",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["lynx"] = {
		["Name"] = "Lynx",
		["Weight"] = 35,
		["Price"] = 400000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["massacro"] = {
		["Name"] = "Massacro",
		["Weight"] = 50,
		["Price"] = 350000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["massacro2"] = {
		["Name"] = "Massacro 2",
		["Weight"] = 50,
		["Price"] = 260000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["neo"] = {
		["Name"] = "Neo",
		["Weight"] = 20,
		["Price"] = 1300000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["neon"] = {
		["Name"] = "Neon",
		["Weight"] = 30,
		["Price"] = 830000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ninef"] = {
		["Name"] = "Ninef",
		["Weight"] = 40,
		["Price"] = 330000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ninef2"] = {
		["Name"] = "Ninef 2",
		["Weight"] = 40,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["omnis"] = {
		["Name"] = "Omnis",
		["Weight"] = 40,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["paragon"] = {
		["Name"] = "Paragon",
		["Weight"] = 30,
		["Price"] = 260000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["paragon2"] = {
		["Name"] = "Paragon 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["pariah"] = {
		["Name"] = "Pariah",
		["Weight"] = 30,
		["Price"] = 370000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["panthere"] = {
		["Name"] = "panthere",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["penumbra"] = {
		["Name"] = "Penumbra",
		["Weight"] = 40,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["penumbra2"] = {
		["Name"] = "Penumbra 2",
		["Weight"] = 30,
		["Price"] = 480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["r300"] = {
		["Name"] = "r300",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["raiden"] = {
		["Name"] = "Raiden",
		["Weight"] = 40,
		["Price"] = 680000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["rapidgt"] = {
		["Name"] = "Rapid GT",
		["Weight"] = 20,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["rapidgt2"] = {
		["Name"] = "Rapidgt GT2",
		["Weight"] = 20,
		["Price"] = 260000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["raptor"] = {
		["Name"] = "Raptor",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["revolter"] = {
		["Name"] = "Revolter",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ruston"] = {
		["Name"] = "Ruston",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schafter2"] = {
		["Name"] = "Schafter 2",
		["Weight"] = 40,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schafter3"] = {
		["Name"] = "Schafter 3",
		["Weight"] = 50,
		["Price"] = 210000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schafter4"] = {
		["Name"] = "Schafter 4",
		["Weight"] = 40,
		["Price"] = 330000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schafter5"] = {
		["Name"] = "Schafter 5",
		["Weight"] = 50,
		["Price"] = 400000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schafter6"] = {
		["Name"] = "Schafter 6",
		["Weight"] = 50,
		["Price"] = 320000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schlagen"] = {
		["Name"] = "Schlagen",
		["Weight"] = 30,
		["Price"] = 470000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["schwarzer"] = {
		["Name"] = "Schwarzer",
		["Weight"] = 50,
		["Price"] = 230000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sentinel3"] = {
		["Name"] = "Sentinel 3",
		["Weight"] = 30,
		["Price"] = 330000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["seven70"] = {
		["Name"] = "Seven 70",
		["Weight"] = 20,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["specter"] = {
		["Name"] = "Specter",
		["Weight"] = 20,
		["Price"] = 440000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["specter2"] = {
		["Name"] = "Specter 2",
		["Weight"] = 20,
		["Price"] = 560000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["streiter"] = {
		["Name"] = "Streiter",
		["Weight"] = 35,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sugoi"] = {
		["Name"] = "Sugoi",
		["Weight"] = 30,
		["Price"] = 320000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sultan"] = {
		["Name"] = "Sultan",
		["Weight"] = 30,
		["Price"] = 740000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sultan2"] = {
		["Name"] = "Sultan 2",
		["Weight"] = 30,
		["Price"] = 1800000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["surano"] = {
		["Name"] = "Surano",
		["Weight"] = 35,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tampa2"] = {
		["Name"] = "Tampa 2",
		["Weight"] = 35,
		["Price"] = 280000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tropos"] = {
		["Name"] = "Tropos",
		["Weight"] = 35,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["verlierer2"] = {
		["Name"] = "Verlierer 2",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["vstr"] = {
		["Name"] = "Vstr",
		["Weight"] = 40,
		["Price"] = 950000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["zr380"] = {
		["Name"] = "Zr380",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["zr3802"] = {
		["Name"] = "Zr380 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["zr3803"] = {
		["Name"] = "Zr380 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["italirsx"] = {
		["Name"] = "Itali RSX",
		["Weight"] = 20,
		["Price"] = 2800000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["veto"] = {
		["Name"] = "Veto",
		["Weight"] = 0,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["veto2"] = {
		["Name"] = "Veto 2",
		["Weight"] = 0,
		["Price"] = 220000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["zr350"] = {
		["Name"] = "ZR 350",
		["Weight"] = 20,
		["Price"] = 590000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["calico"] = {
		["Name"] = "Calico",
		["Weight"] = 20,
		["Price"] = 580000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["futo2"] = {
		["Name"] = "Futo 2",
		["Weight"] = 40,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["euros"] = {
		["Name"] = "Euros",
		["Weight"] = 30,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jester4"] = {
		["Name"] = "Jester 4",
		["Weight"] = 30,
		["Price"] = 680000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["remus"] = {
		["Name"] = "Remus",
		["Weight"] = 20,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet6"] = {
		["Name"] = "Comet 6",
		["Weight"] = 30,
		["Price"] = 700000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["comet7"] = {
		["Name"] = "Comet 7",
		["Weight"] = 30,
		["Price"] = 690000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["growler"] = {
		["Name"] = "Growler",
		["Weight"] = 30,
		["Price"] = 910000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["vectre"] = {
		["Name"] = "Vectre",
		["Weight"] = 40,
		["Price"] = 810000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["cypher"] = {
		["Name"] = "Cypher",
		["Weight"] = 20,
		["Price"] = 780000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sultan3"] = {
		["Name"] = "Sultan 3",
		["Weight"] = 30,
		["Price"] = 1200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["rt3000"] = {
		["Name"] = "RT 3000",
		["Weight"] = 20,
		["Price"] = 640000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ardent"] = {
		["Name"] = "Ardent",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["btype"] = {
		["Name"] = "Btype",
		["Weight"] = 50,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["btype2"] = {
		["Name"] = "Btype 2",
		["Weight"] = 30,
		["Price"] = 230000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["btype3"] = {
		["Name"] = "Btype 3",
		["Weight"] = 50,
		["Price"] = 260000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["casco"] = {
		["Name"] = "Casco",
		["Weight"] = 50,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["cheetah2"] = {
		["Name"] = "Cheetah 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["coquette2"] = {
		["Name"] = "Coquette 2",
		["Weight"] = 40,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["deluxo"] = {
		["Name"] = "Deluxo",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["dynasty"] = {
		["Name"] = "Dynasty",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["fagaloa"] = {
		["Name"] = "Fagaloa",
		["Weight"] = 50,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["feltzer3"] = {
		["Name"] = "Feltzer 3",
		["Weight"] = 50,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["gt500"] = {
		["Name"] = "GT 500",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["infernus2"] = {
		["Name"] = "Infernus 2",
		["Weight"] = 20,
		["Price"] = 480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jb700"] = {
		["Name"] = "JB 700",
		["Weight"] = 30,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["jb7002"] = {
		["Name"] = "JB 7002",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["mamba"] = {
		["Name"] = "Mamba",
		["Weight"] = 50,
		["Price"] = 340000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["manana"] = {
		["Name"] = "Manana",
		["Weight"] = 35,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["manana2"] = {
		["Name"] = "Manana 2",
		["Weight"] = 35,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["michelli"] = {
		["Name"] = "Michelli",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["monroe"] = {
		["Name"] = "Monroe",
		["Weight"] = 50,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["nebula"] = {
		["Name"] = "Nebula",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["peyote"] = {
		["Name"] = "Peyote",
		["Weight"] = 35,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["peyote3"] = {
		["Name"] = "Peyote 3",
		["Weight"] = 45,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["pigalle"] = {
		["Name"] = "Pigalle",
		["Weight"] = 40,
		["Price"] = 80000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["rapidgt3"] = {
		["Name"] = "Rapid GT3",
		["Weight"] = 50,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["retinue"] = {
		["Name"] = "Retinue",
		["Weight"] = 40,
		["Price"] = 100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["retinue2"] = {
		["Name"] = "Retinue 2",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["savestra"] = {
		["Name"] = "Savestra",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["stinger"] = {
		["Name"] = "Stinger",
		["Weight"] = 50,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["stingergt"] = {
		["Name"] = "Stinger GT",
		["Weight"] = 50,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["stromberg"] = {
		["Name"] = "Stromberg",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["swinger"] = {
		["Name"] = "Swinger",
		["Weight"] = 50,
		["Price"] = 290000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["torero"] = {
		["Name"] = "Torero",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado"] = {
		["Name"] = "Tornado",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado2"] = {
		["Name"] = "Tornado 2",
		["Weight"] = 45,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado3"] = {
		["Name"] = "Tornado 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado4"] = {
		["Name"] = "Tornado 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado5"] = {
		["Name"] = "Tornado 5",
		["Weight"] = 50,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tornado6"] = {
		["Name"] = "Tornado 6",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["turismo2"] = {
		["Name"] = "Turismo 2",
		["Weight"] = 30,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["viseris"] = {
		["Name"] = "Viseris",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["z190"] = {
		["Name"] = "Z190",
		["Weight"] = 40,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ztype"] = {
		["Name"] = "Ztype",
		["Weight"] = 50,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["zion3"] = {
		["Name"] = "Zion 3",
		["Weight"] = 40,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["cheburek"] = {
		["Name"] = "Cheburek",
		["Weight"] = 40,
		["Price"] = 40000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["toreador"] = {
		["Name"] = "Toreador",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},

	-- SUPER
	["adder"] = {
		["Name"] = "Adder",
		["Weight"] = 20,
		["Price"] = 620000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["autarch"] = {
		["Name"] = "Autarch",
		["Weight"] = 20,
		["Price"] = 1100000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["banshee2"] = {
		["Name"] = "Banshee 2",
		["Weight"] = 20,
		["Price"] = 440000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["bullet"] = {
		["Name"] = "Bullet",
		["Weight"] = 30,
		["Price"] = 450000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["cheetah"] = {
		["Name"] = "Cheetah",
		["Weight"] = 20,
		["Price"] = 740000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["cyclone"] = {
		["Name"] = "Cyclone",
		["Weight"] = 20,
		["Price"] = 1350000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["entity2"] = {
		["Name"] = "Entity 2",
		["Weight"] = 30,
		["Price"] = 1200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["entity3"] = {
		["Name"] = "entity3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["entityxf"] = {
		["Name"] = "Entity XF",
		["Weight"] = 20,
		["Price"] = 590000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["emerus"] = {
		["Name"] = "Emerus",
		["Weight"] = 20,
		["Price"] = 950000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["fmj"] = {
		["Name"] = "Fmj",
		["Weight"] = 20,
		["Price"] = 840000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["furia"] = {
		["Name"] = "Furia",
		["Weight"] = 20,
		["Price"] = 650000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["gp1"] = {
		["Name"] = "Gp1",
		["Weight"] = 20,
		["Price"] = 560000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["infernus"] = {
		["Name"] = "Infernus",
		["Weight"] = 20,
		["Price"] = 930000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["italigtb"] = {
		["Name"] = "Italigtb",
		["Weight"] = 20,
		["Price"] = 560000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["italigtb2"] = {
		["Name"] = "Italigtb 2",
		["Weight"] = 20,
		["Price"] = 610000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["krieger"] = {
		["Name"] = "Krieger",
		["Weight"] = 20,
		["Price"] = 750000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["le7b"] = {
		["Name"] = "Le7b",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["nero"] = {
		["Name"] = "Nero",
		["Weight"] = 20,
		["Price"] = 780000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["nero2"] = {
		["Name"] = "Nero 2",
		["Weight"] = 20,
		["Price"] = 840000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["osiris"] = {
		["Name"] = "Osiris",
		["Weight"] = 20,
		["Price"] = 2200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["penetrator"] = {
		["Name"] = "Penetrator",
		["Weight"] = 30,
		["Price"] = 720000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["pfister811"] = {
		["Name"] = "Pfister 811",
		["Weight"] = 20,
		["Price"] = 690000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["prototipo"] = {
		["Name"] = "Prototipo",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["reaper"] = {
		["Name"] = "Reaper",
		["Weight"] = 20,
		["Price"] = 930000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["s80"] = {
		["Name"] = "S80",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["sc1"] = {
		["Name"] = "Sc1",
		["Weight"] = 40,
		["Price"] = 610000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["scramjet"] = {
		["Name"] = "Scramjet",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["sheava"] = {
		["Name"] = "Sheava",
		["Weight"] = 30,
		["Price"] = 840000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["sultanrs"] = {
		["Name"] = "Sultan RS",
		["Weight"] = 30,
		["Price"] = 540000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["t20"] = {
		["Name"] = "T20",
		["Weight"] = 20,
		["Price"] = 3200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["taipan"] = {
		["Name"] = "Taipan",
		["Weight"] = 20,
		["Price"] = 1200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["tempesta"] = {
		["Name"] = "Tempesta",
		["Weight"] = 20,
		["Price"] = 720000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["tezeract"] = {
		["Name"] = "Tezeract",
		["Weight"] = 20,
		["Price"] = 980000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["thrax"] = {
		["Name"] = "Thrax",
		["Weight"] = 50,
		["Price"] = 2300000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["tigon"] = {
		["Name"] = "Tigon",
		["Weight"] = 30,
		["Price"] = 920000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["turismor"] = {
		["Name"] = "Turismo R",
		["Weight"] = 20,
		["Price"] = 1600000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["tyrant"] = {
		["Name"] = "Tyrant",
		["Weight"] = 20,
		["Price"] = 710000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["tyrus"] = {
		["Name"] = "Tyrus",
		["Weight"] = 20,
		["Price"] = 820000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["vacca"] = {
		["Name"] = "Vacca",
		["Weight"] = 20,
		["Price"] = 480000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["vagner"] = {
		["Name"] = "Vagner",
		["Weight"] = 20,
		["Price"] = 1900000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["vigilante"] = {
		["Name"] = "Vigilante",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["virtue"] = {
		["Name"] = "virtue",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["visione"] = {
		["Name"] = "Visione",
		["Weight"] = 20,
		["Price"] = 2300000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["voltic"] = {
		["Name"] = "Voltic",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["voltic2"] = {
		["Name"] = "Voltic 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["xa21"] = {
		["Name"] = "Xa21",
		["Weight"] = 20,
		["Price"] = 1200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["zentorno"] = {
		["Name"] = "Zentorno",
		["Weight"] = 20,
		["Price"] = 2300000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["zorrusso"] = {
		["Name"] = "Zorrusso",
		["Weight"] = 20,
		["Price"] = 980000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},

	-- TRAILER
	["armytanker"] = {
		["Name"] = "Armytanker",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["armytrailer"] = {
		["Name"] = "Armytrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["armytrailer2"] = {
		["Name"] = "Armytrailer 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["baletrailer"] = {
		["Name"] = "Baletrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["boattrailer"] = {
		["Name"] = "Boattrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["cablecar"] = {
		["Name"] = "Cablecar",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["docktrailer"] = {
		["Name"] = "Docktrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["freighttrailer"] = {
		["Name"] = "Freighttrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["graintrailer"] = {
		["Name"] = "Graintrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["proptrailer"] = {
		["Name"] = "Proptrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["raketrailer"] = {
		["Name"] = "Raketrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tr2"] = {
		["Name"] = "Tr2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tr3"] = {
		["Name"] = "Tr3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tr4"] = {
		["Name"] = "Tr4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trflat"] = {
		["Name"] = "Trflat",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tvtrailer"] = {
		["Name"] = "Tvtrailer",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tanker"] = {
		["Name"] = "Tanker",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["tanker2"] = {
		["Name"] = "Tanker 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailerlarge"] = {
		["Name"] = "Trailerlarge",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailerlogs"] = {
		["Name"] = "Trailerlogs",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailers"] = {
		["Name"] = "Trailers",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailers2"] = {
		["Name"] = "Trailers 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailers3"] = {
		["Name"] = "Trailers 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},
	["trailers4"] = {
		["Name"] = "Trailers 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trailers"
	},

	-- TRAINS
	["freight"] = {
		["Name"] = "Freight",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["freightcar"] = {
		["Name"] = "Freightcar",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["freightcont1"] = {
		["Name"] = "Freightcont 1",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["freightcont2"] = {
		["Name"] = "Freightcont 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["freightgrain"] = {
		["Name"] = "Freightgrain",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["metrotrain"] = {
		["Name"] = "Metrotrain",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},
	["tankercar"] = {
		["Name"] = "Rankercar",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Trens"
	},

	-- UTILITY
	["airtug"] = {
		["Name"] = "Airtug",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["caddy"] = {
		["Name"] = "Caddy",
		["Weight"] = 10,
		["Price"] = 30000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["caddy2"] = {
		["Name"] = "Caddy 2",
		["Weight"] = 10,
		["Price"] = 25000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["caddy3"] = {
		["Name"] = "Caddy 3",
		["Weight"] = 10,
		["Price"] = 20000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["docktug"] = {
		["Name"] = "Docktug",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["forklift"] = {
		["Name"] = "Forklift",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["mower"] = {
		["Name"] = "Mower",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["ripley"] = {
		["Name"] = "Ripley",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["sadler"] = {
		["Name"] = "Sadler",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["sadler2"] = {
		["Name"] = "Sadler 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["scrap"] = {
		["Name"] = "Scrap",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["towtruck"] = {
		["Name"] = "Towtruck",
		["Weight"] = 25,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["towtruck2"] = {
		["Name"] = "Towtruck 2",
		["Weight"] = 25,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["tractor"] = {
		["Name"] = "Tractor",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["tractor2"] = {
		["Name"] = "Tractor 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["tractor3"] = {
		["Name"] = "Tractor 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["utillitruck"] = {
		["Name"] = "Utillitruck",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["utillitruck2"] = {
		["Name"] = "Utillitruck 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["utillitruck3"] = {
		["Name"] = "Utillitruck 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},
	["slamtruck"] = {
		["Name"] = "Slamtruck",
		["Weight"] = 20,
		["Price"] = 10000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Utilitários"
	},

	-- VANS
	["bison"] = {
		["Name"] = "Bison",
		["Weight"] = 30,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["bison2"] = {
		["Name"] = "Bison 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["bison3"] = {
		["Name"] = "Bison 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["bobcatxl"] = {
		["Name"] = "Bobcat XL",
		["Weight"] = 45,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["boxville"] = {
		["Name"] = "Boxville",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["boxville2"] = {
		["Name"] = "Boxville",
		["Weight"] = 1000,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Serviços"
	},
	["boxville3"] = {
		["Name"] = "Boxville 3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["boxville4"] = {
		["Name"] = "Boxville",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["boxville5"] = {
		["Name"] = "Boxville 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["burrito"] = {
		["Name"] = "Burrito",
		["Weight"] = 35,
		["Price"] = 70000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["burrito2"] = {
		["Name"] = "Burrito 2",
		["Weight"] = 40,
		["Price"] = 90000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["burrito3"] = {
		["Name"] = "Burrito 3",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["burrito4"] = {
		["Name"] = "Burrito 4",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["burrito5"] = {
		["Name"] = "Burrito 5",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["camper"] = {
		["Name"] = "Camper",
		["Weight"] = 50,
		["Price"] = 160000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["gburrito"] = {
		["Name"] = "Gburrito",
		["Weight"] = 50,
		["Price"] = 240000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["gburrito2"] = {
		["Name"] = "Gburrito 2",
		["Weight"] = 10,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["journey"] = {
		["Name"] = "Journey",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["journey2"] = {
		["Name"] = "journey2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["minivan"] = {
		["Name"] = "Minivan",
		["Weight"] = 40,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["minivan2"] = {
		["Name"] = "Minivan 2",
		["Weight"] = 40,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["paradise"] = {
		["Name"] = "Paradise",
		["Weight"] = 50,
		["Price"] = 90000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["pony"] = {
		["Name"] = "Pony",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["pony2"] = {
		["Name"] = "Pony 2",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["rumpo"] = {
		["Name"] = "Rumpo",
		["Weight"] = 30,
		["Price"] = 130000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["rumpo2"] = {
		["Name"] = "Rumpo 2",
		["Weight"] = 40,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["rumpo3"] = {
		["Name"] = "Rumpo 3",
		["Weight"] = 50,
		["Price"] = "Rental",
		["Mode"] = "Cars",
		["Gemstone"] = 12000,
		["Class"] = "Vans"
	},
	["speedo"] = {
		["Name"] = "Speedo",
		["Weight"] = 50,
		["Price"] = 70000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["speedo2"] = {
		["Name"] = "Speedo 2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["speedo4"] = {
		["Name"] = "Speedo 4",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["surfer"] = {
		["Name"] = "Surfer",
		["Weight"] = 40,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["surfer2"] = {
		["Name"] = "Surfer 2",
		["Weight"] = 40,
		["Price"] = 40000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["surfer3"] = {
		["Name"] = "surfer3",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["taco"] = {
		["Name"] = "Taco",
		["Weight"] = 15,
		["Price"] = 2000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["youga"] = {
		["Name"] = "Youga",
		["Weight"] = 70,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},
	["youga2"] = {
		["Name"] = "Youga 2",
		["Weight"] = 40,
		["Price"] = 1000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Vans"
	},

	-- IMPORTS
	["wrch48"] = {
		["Name"] = "Ch Blindado",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrps32"] = {
		["Name"] = "Puro Sangue Blindada",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrarmoredct"] = {
		["Name"] = "Truck Blindado",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrq6civ"] = {
		["Name"] = "Que6",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["23jeepwag3"] = {
		["Name"] = "Wag 2023",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["agstorexc90r"] = {
		["Name"] = "XisCe90",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrarmoredurus22"] = {
		["Name"] = "Uros Blindada",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrmansorydbx"] = {
		["Name"] = "Dbx",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["sf90"] = {
		["Name"] = "S90F",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrfpace2017"] = {
		["Name"] = "PaceF",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["faq8"] = {
		["Name"] = "Que8",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrgt63s"] = {
		["Name"] = "G63T",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrdefender"] = {
		["Name"] = "Defendo",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrswfour"] = {
		["Name"] = "SwFor",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["armoredx7m60i"] = {
		["Name"] = "Xis7 Blindada",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["22m5sal"] = {
		["Name"] = "EMI5",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["rs7c821"] = {
		["Name"] = "ERRIS7",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["992gt3rs"] = {
		["Name"] = "992Gt3",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["a90e"] = {
		["Name"] = "A90",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["boxster"] = {
		["Name"] = "Boxster",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["gstacidium2"] = {
		["Name"] = "Jeepo Stacidium",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["lbm4"] = {
		["Name"] = "EMME4",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["esnevox"] = {
		["Name"] = "EvoXis",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["gtrpit"] = {
		["Name"] = "Gete R35",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["lfa"] = {
		["Name"] = "L EFFIA",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrsonata"] = {
		["Name"] = "Sonato",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["570s"] = {
		["Name"] = "570S",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["m3g80"] = {
		["Name"] = "EMME3 G80",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["jetta24gli"] = {
		["Name"] = "Jetto 24GLI",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["m2g87"] = {
		["Name"] = "EMME2 G87",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrcorollaciv"] = {
		["Name"] = "Corollo",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["23ramsound "] = {
		["Name"] = "RAMSOUND",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["audirs6"] = {
		["Name"] = "ERRE S 6",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["lamborghinihuracan"] = {
		["Name"] = "Ruracan",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["r34dypt"] = {
		["Name"] = "ERRE 34",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["cp9a"] = {
		["Name"] = "CEPE9a",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["shotaro"] = {
		["Name"] = "Shotaro",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrcivic2008"] = {
		["Name"] = "Civico 2008",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrm3f80"] = {
		["Name"] = "EMME 3 F80",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wra45"] = {
		["Name"] = "A 45",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["mustang19"] = {
		["Name"] = "Mustango 2019",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["toyotasupra"] = {
		["Name"] = "Sopro",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["23camss"] = {
		["Name"] = "Camarro SS",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["ferrari812"] = {
		["Name"] = "812",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["mercedesamg63"] = {
		["Name"] = "GE 63",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["panameramansory"] = {
		["Name"] = "Panamero",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["audir8"] = {
		["Name"] = "ERRE 8",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["jeep20"] = {
		["Name"] = "Jeepo 2020",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["x7m60i"] = {
		["Name"] = "Xis 7",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["mclarensenna"] = {
		["Name"] = "Mc Senna",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["subaruimpreza"] = {
		["Name"] = "Subaro Empresa",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["gle"] = {
		["Name"] = "GL E",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["huracantecnica"] = {
		["Name"] = "Tecnica",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["na1"] = {
		["Name"] = "N1",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["rs3s20"] = {
		["Name"] = "ERRE S3",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["ttrs"] = {
		["Name"] = "TETE RS",
		["Weight"] = 60,
		["Price"] = 200000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["urusperf23"] = {
		["Name"] = "Uros Perf",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["mclarenp1"] = {
		["Name"] = "PE1",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrgolf2003"] = {
		["Name"] = "Golfo 2003",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrpassat"] = {
		["Name"] = "Passato",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrsaveiroquadrada"] = {
		["Name"] = "Quadradinha",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrsaveirosurf"] = {
		["Name"] = "Surfista",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["mt07"] = {
		["Name"] = "Emite 07",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrmt09"] = {
		["Name"] = "Emite 09",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["hornet"] = {
		["Name"] = "Horneto",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["f850gs"] = {
		["Name"] = "Effi850",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["duke90"] = {
		["Name"] = "Duko90",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["xre300ag"] = {
		["Name"] = "XIS RE300",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["cb500f23"] = {
		["Name"] = "Cebe 500",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrcg160"] = {
		["Name"] = "CEGE 160",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["r1200"] = {
		["Name"] = "ERRE1200",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["s1000rr"] = {
		["Name"] = "ESSE1000RR",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrtiger900civ"] = {
		["Name"] = "Tigor 900",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrtracer900"] = {
		["Name"] = "Traicer 900",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrxt660civ"] = {
		["Name"] = "Xiste 660",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["africatexc"] = {
		["Name"] = "Africo",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["2XLA90AutumnKoi"] = {
		["Name"] = "A90 Autumnkoi",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["2XLM4Power"] = {
		["Name"] = "Emme4 Power",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["2xlr35kuromi"] = {
		["Name"] = "ERRE 35 Kuromi",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["2xlr35sakura"] = {
		["Name"] = "ERRE 35 Sakura",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["370zrubytiger"] = {
		["Name"] = "Z370 Ruby",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["r34bluedragon"] = {
		["Name"] = "ERRE 34 BlueDragon",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["r34reddragon"] = {
		["Name"] = "ERRE 34 RedDragon",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["s15nihilred"] = {
		["Name"] = "Esse15 Red",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["s15nihilwhite"] = {
		["Name"] = "Esse15 White",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["g63alisson"] = {
		["Name"] = "GE63 Full Blindada",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["amrevu23mg"] = {
		["Name"] = "Revu 23",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wra45"] = {
		["Name"] = "45A",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["bmwm3gtr"] = {
		["Name"] = "EMME 3 GTERRE",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["gxs15"] = {
		["Name"] = "GXESSE15",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["monza"] = {
		["Name"] = "Momzam",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrb412bel"] = {
		["Name"] = "BE412",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 450000,
		["Class"] = "Importados"
	},
	["armoredporschemacan"] = {
		["Name"] = "Mascan Blindada",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["918spyder"] = {
		["Name"] = "Spyder",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["ram19"] = {
		["Name"] = "Ra 19",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["320deboxe"] = {
		["Name"] = "320 Deboxe",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["fasilvialeal"] = {
		["Name"] = "Esse15 FA",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["sxr"] = {
		["Name"] = "EsseXR",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wramarok"] = {
		["Name"] = "Amaroko",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["wrsubarus209"] = {
		["Name"] = "Sabaru209 Blindado",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["etrongt22"] = {
		["Name"] = "Estron GT",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},
	["faraptorcr"] = {
		["Name"] = "Raptu",
		["Weight"] = 60,
		["Price"] = 100000,
		["Mode"] = "Rental",
		["Gemstone"] = 250000,
		["Class"] = "Importados"
	},


	-- VIP FAC 
	["youga3"] = {
		["Name"] = "Youga 3",
		["Weight"] = 400,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Vans"
	},
	["everon"] = {
		["Name"] = "Everon",
		["Weight"] = 200,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Off-Roads"
	},
	["mule"] = {
		["Name"] = "Mule",
		["Weight"] = 500,
		["Price"] = 125000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Caminhões"
	},
	["mule2"] = {
		["Name"] = "Mule 2",
		["Weight"] = 1000,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Caminhões"
	},
	["benson"] = {
		["Name"] = "Benson",
		["Weight"] = 1500,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Caminhões"
	},
	["lancerevolution9"] = {
		["Name"] = "Evolucao 9",
		["Weight"] = 1500,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},
	["v4sp"] = {
		["Name"] = "V4SP",
		["Weight"] = 1500,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},
	["r1"] = {
		["Name"] = "ERRE1",
		["Weight"] = 40,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},
	["r6"] = {
		["Name"] = "ERRE6",
		["Weight"] = 40,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},
	["tenere1200"] = {
		["Name"] = "Terere 1200",
		["Weight"] = 40,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},
	["frogger"] = {
		["Name"] = "Frogger",
		["Weight"] = 0,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Helicópteros"
	},
	["golfgti"] = {
		["Name"] = "Golfo GTI",
		["Weight"] = 60,
		["Price"] = 10000,
		["Mode"] = "Work",
		["Gemstone"] = 200000,
		["Class"] = "Importados"
	},






	-- SERVICES
	["wrmaverickmed"] = {
		["Name"] = "Maverico Samu",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrsprintermed"] = {
		["Name"] = "Van Samu",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrvolitomed"] = {
		["Name"] = "Volito samu",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrtigermed"] = {
		["Name"] = "Tigor Samu",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wras350m"] = {
		["Name"] = "350 PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrcorollam"] = {
		["Name"] = "Corollo PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrdusterm"] = {
		["Name"] = "Dustor PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrhiluxm"] = {
		["Name"] = "Hiluxo PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrrangerm"] = {
		["Name"] = "Rangor PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrs10m"] = {
		["Name"] = "ESSE10 PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrxre300m"] = {
		["Name"] = "XIS RE300 PMERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrchm"] = {
		["Name"] = "CH PMERJ", -- VIP
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrq6m"] = {
		["Name"] = "QUE6 PMERJ Blindada", -- VIP
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrcruzec"] = {
		["Name"] = "Cruzo PCERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrequinoxc"] = {
		["Name"] = "Equinow PCERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrsw4c"] = {
		["Name"] = "SWFOR PCERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrq6c"] = {
		["Name"] = "QUE6 PCERJ Blindada", -- VIP
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrcaveirao"] = {
		["Name"] = "Caveirao BOPE",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrrangerbope"] = {
		["Name"] = "Rangor BOPE",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrs10bope"] = {
		["Name"] = "ESSE10 BOPE",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wruh1huey"] = {
		["Name"] = "Heli BOPE",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrchallengerprf"] = {
		["Name"] = "Speed PRF",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrcruzeprf"] = {
		["Name"] = "Cruzo PRF",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrhiluxprf"] = {
		["Name"] = "Hiluxo PRF",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrtigerprf"] = {
		["Name"] = "Tigor PRF",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrxre300prf"] = {
		["Name"] = "XIS RE300",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrsprintersoe"] = {
		["Name"] = "Van PCERJ",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wr5toneb"] = {
		["Name"] = "Caminhao EB",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrhileb"] = {
		["Name"] = "Hiluxo EB",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrpanteraeb"] = {
		["Name"] = "Pantera EB",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrdeliverysrt"] = {
		["Name"] = "Guincho SRT",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},
	["wrtrxsrt"] = {
		["Name"] = "TRX SRT",
		["Weight"] = 50,
		["Price"] = 5000,
		["Mode"] = "Work",
		["Gemstone"] = 0,
		["Class"] = "Empregos"
	},

	-- SEM CLASSES
	["brickade2"] = {
		["Name"] = "brickade2",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["boor"] = {
		["Name"] = "boor",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["patriot3"] = {
		["Name"] = "Patriot 3",
		["Weight"] = 40,
		["Price"] = 320000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["omnisegt"] = {
		["Name"] = "Omni SE GT",
		["Weight"] = 40,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["tenf2"] = {
		["Name"] = "Tenf 2",
		["Weight"] = 40,
		["Price"] = 190000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["sm722"] = {
		["Name"] = "Mm722",
		["Weight"] = 40,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["brioso3"] = {
		["Name"] = "Brioso 3",
		["Weight"] = 40,
		["Price"] = 50000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["lm87"] = {
		["Name"] = "Lm87",
		["Weight"] = 40,
		["Price"] = 170000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["iwagen"] = {
		["Name"] = "Iwagen",
		["Weight"] = 40,
		["Price"] = 260000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["jubilee"] = {
		["Name"] = "Jubilee",
		["Weight"] = 40,
		["Price"] = 150000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["reever"] = {
		["Name"] = "Reever",
		["Weight"] = 20,
		["Price"] = 170000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["shinobi"] = {
		["Name"] = "Shinobi",
		["Weight"] = 20,
		["Price"] = 180000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["granger2"] = {
		["Name"] = "Granger 2",
		["Weight"] = 85,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["buffalo4"] = {
		["Name"] = "Buffalo 4",
		["Weight"] = 30,
		["Price"] = 250000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["vigero2"] = {
		["Name"] = "Vigero 2",
		["Weight"] = 40,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["sentinel4"] = {
		["Name"] = "Sentinel 4",
		["Weight"] = 40,
		["Price"] = 140000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["ignus"] = {
		["Name"] = "Ignus",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["youga4"] = {
		["Name"] = "Youga 4",
		["Weight"] = 70,
		["Price"] = 90000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["zeno"] = {
		["Name"] = "Zeno",
		["Weight"] = 20,
		["Price"] = 250000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["deity"] = {
		["Name"] = "Deity",
		["Weight"] = 40,
		["Price"] = 300000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["kanjosj"] = {
		["Name"] = "Kanjo SJ",
		["Weight"] = 40,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["greenwood"] = {
		["Name"] = "Greenwood",
		["Weight"] = 40,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["corsita"] = {
		["Name"] = "Corsita",
		["Weight"] = 40,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	},
	["cinquemila"] = {
		["Name"] = "Cinquemila",
		["Weight"] = 30,
		["Price"] = 200000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["rhinehart"] = {
		["Name"] = "Rhinehart",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "SUVs"
	},
	["tenf"] = {
		["Name"] = "Tenf",
		["Weight"] = 40,
		["Price"] = 180000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["postlude"] = {
		["Name"] = "Postlude",
		["Weight"] = 40,
		["Price"] = 60000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Esportivos"
	},
	["mule5"] = {
		["Name"] = "Mule 5",
		["Weight"] = 0,
		["Price"] = 1000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["baller7"] = {
		["Name"] = "Baller 7",
		["Weight"] = 50,
		["Price"] = 480000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["conada"] = {
		["Name"] = "Conada",
		["Weight"] = 40,
		["Price"] = 100,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["champion"] = {
		["Name"] = "Champion",
		["Weight"] = 20,
		["Price"] = 220000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["draugur"] = {
		["Name"] = "Draugur",
		["Weight"] = 40,
		["Price"] = 320000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Off-Roads"
	},
	["astron"] = {
		["Name"] = "Astron",
		["Weight"] = 40,
		["Price"] = 220000,
		["Mode"] = nil,
		["Gemstone"] = 0,
		["Class"] = "Embarcações"
	},
	["ruiner4"] = {
		["Name"] = "Ruiner4",
		["Weight"] = 40,
		["Price"] = 110000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Muscles"
	},
	["weevil2"] = {
		["Name"] = "Weevil 2",
		["Weight"] = 40,
		["Price"] = 120000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Compactos"
	},
	["torero2"] = {
		["Name"] = "Torero 2",
		["Weight"] = 40,
		["Price"] = 200000,
		["Mode"] = "Cars",
		["Gemstone"] = 0,
		["Class"] = "Clássicos"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleList()
	return List
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleExist(Name)
	return List[Name] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleName(Name)
	return List[Name] and List[Name]["Name"] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleWeight(Name)
	return List[Name] and List[Name]["Weight"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function VehiclePrice(Name)
	return List[Name] and List[Name]["Price"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMode(Name)
	return List[Name] and List[Name]["Mode"] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleGemstone(Name)
	return List[Name] and List[Name]["Gemstone"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLECLASS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleClass(Name)
	return List[Name] and List[Name]["Class"] or "Desconhecido"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESTOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleStock(Name)
	return List[Name] and List[Name]["Stock"] or 999999
end