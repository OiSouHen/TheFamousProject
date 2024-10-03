-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ItemList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTARTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Shop,v in pairs(List) do
		if not ItemList[Shop] then
			ItemList[Shop] = {}
		end

		for Item,Value in pairs(v["List"]) do
			local Number = #ItemList[Shop] + 1

			ItemList[Shop][Number] = {
				["name"] = ItemName(Item),
				["weight"] = ItemWeight(Item),
				["index"] = ItemIndex(Item),
				["rarity"] = ItemRarity(Item),
				["economy"] = ItemEconomy(Item),
				["desc"] = ItemDescription(Item),
				["key"] = Item,
				["price"] = Value
			}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATION
-----------------------------------------------------------------------------------------------------------------------------------------
Location = {
	{
		["Coords"] = vec3(1694.92,4920.44,42.23),
		["Mode"] = "Lumberman",
	},{
		["Coords"] = vec3(-634.15,234.73,82.14),
		["Mode"] = "TotenFood",
	},{
		["Coords"] = vec3(-1458.53,-349.46,45.01),
		["Mode"] = "TotenFood",
	},{
		["Coords"] = vec3(24.51,-1346.75,29.49),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(2556.77,380.87,108.61),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1164.81,-323.61,69.2),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-706.16,-914.55,19.21),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-47.35,-1758.59,29.42),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(372.7,326.89,103.56),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-3242.7,1000.05,12.82),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1728.08,6415.6,35.03),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(549.09,2670.89,42.16),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1959.87,3740.44,32.33),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(2677.65,3279.66,55.23),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1697.32,4923.46,42.06),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-1819.52,793.48,138.08),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1391.62,3605.95,34.98),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-2966.41,391.52,15.05),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-3039.42,584.42,7.9),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1134.32,-983.09,46.4),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(1165.32,2710.79,38.15),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-1486.72,-377.61,40.15),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-1221.48,-907.93,12.32),
		["Mode"] = "Departament",
	},{
		["Coords"] = vec3(-1816.64,-1193.73,14.31),
		["Mode"] = "Fishing"
	},{
		["Coords"] = vec3(-1593.08,5202.9,4.31),
		["Mode"] = "Hunting"
	},{
		["Coords"] = vec3(-1266.4,349.82,65.66),
		["Mode"] = "Paramedico"
	},{
		["Coords"] = vec3(-787.12,-1218.58,7.19),
		["Mode"] = "Policia",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-1106.58,-822.22,14.79),
		["Mode"] = "Policia",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-628.79,-238.7,38.05),
		["Mode"] = "Miners"
	},{
		["Coords"] = vec3(179.9,2779.98,45.7),
		["Mode"] = "Clandestine"
	},{
		["Coords"] = vec3(46.7,-1749.71,29.62),
		["Mode"] = "Megamall"
	},{
		["Coords"] = vec3(1692.27,3760.91,34.69),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(253.80,-50.47,69.94),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(842.54,-1035.25,28.19),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-331.67,6084.86,31.46),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-662.37,-933.58,21.82),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-1304.12,-394.56,36.7),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-1118.98,2699.73,18.55),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(2567.98,292.62,108.73),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-3173.51,1088.35,20.84),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(22.53,-1105.52,29.79),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(810.22,-2158.99,29.62),
		["Mode"] = "Ammunation"
	},{
		["Coords"] = vec3(-172.89,6381.32,31.48),
		["Mode"] = "Pharmacy"
	},{
		["Coords"] = vec3(1690.07,3581.68,35.62),
		["Mode"] = "Pharmacy"
	},{
		["Coords"] = vec3(114.49,-5.03,67.82),
		["Mode"] = "Pharmacy"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
List = {
	["Pharmacy"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["medkit"] = 2400,
			["bandage"] = 1200,
			["analgesic"] = 720
		}
	},
	["Lumberman"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["woodlog"] = 25
		}
	},
	["TotenFood"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["orangejuice"] = 150,
			["hamburger2"] = 150
		}
	},
	["Ammunation"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_HATCHET"] = 40000,
			["WEAPON_BAT"] = 40000,
			["WEAPON_BATTLEAXE"] = 40000,
			["WEAPON_SWITCHBLADE"] = 40000,
			["WEAPON_GOLFCLUB"] = 40000,
			["WEAPON_HAMMER"] = 40000,
			["WEAPON_MACHETE"] = 40000,
			["WEAPON_POOLCUE"] = 40000,
			["WEAPON_STONE_HATCHET"] = 40000,
			["WEAPON_WRENCH"] = 40000,
			["WEAPON_KNUCKLE"] = 40000,
			["WEAPON_FLASHLIGHT"] = 40000
		}
	},
	["Departament"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["postit"] = 20,
			["cigarette"] = 15,
			["cellphone"] = 1200,
			["vape"] = 4750,
			["camera"] = 425,
			["binoculars"] = 425,
			["radio"] = 800,
			["lighter"] = 225,
			["emptybottle"] = 15,
			["sugarbox"] = 35,
			["condensedmilk"] = 25,
			["mayonnaise"] = 20,
			["ryebread"] = 20,
			["ricebag"] = 105
		}
	},
	["Megamall"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["boilies"] = 5,
			["rope"] = 925,
			["scuba"] = 975,
			["notepad"] = 10,
			["suitcase"] = 275,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25,
			["alliance"] = 525,
			["GADGET_PARACHUTE"] = 225,
			["axe"] = 1225,
			["pickaxe"] = 1225,
			["fishingrod"] = 1225,
			["emptypurifiedwater"] = 1275
		}
	},
	["Clandestine"] = {
		["Mode"] = "Sell",
		["Type"] = "Consume",
		["Item"] = "dirtydollar",
		["List"] = {
			["scotchtape"] = 45,
			["insulatingtape"] = 55,
			["rammemory"] = 375,
			["powersupply"] = 475,
			["processorfan"] = 325,
			["processor"] = 725,
			["screws"] = 45,
			["screwnuts"] = 45,
			["videocard"] = 4225,
			["ssddrive"] = 525,
			["safependrive"] = 3225,
			["powercable"] = 225,
			["weaponparts"] = 125,
			["electroniccomponents"] = 375,
			["batteryaa"] = 225,
			["batteryaaplus"] = 275,
			["goldnecklace"] = 625,
			["silverchain"] = 425,
			["horsefigurine"] = 2425,
			["toothpaste"] = 175,
			["techtrash"] = 95,
			["tarp"] = 65,
			["sheetmetal"] = 65,
			["roadsigns"] = 65,
			["explosives"] = 105,
			["sulfuric"] = 75,
			["races"] = 425,
			["pistolbody"] = 275,
			["smgbody"] = 525,
			["riflebody"] = 975,
			["pager"] = 425
		}
	},
	["Coffee"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["coffeecup"] = 20
		}
	},
	["Soda"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cola"] = 20,
			["soda"] = 20,
			["water"] = 35
		}
	},
	["Donut"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["donut"] = 15,
			["chocolate"] = 20
		}
	},
	["Hamburger"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hamburger"] = 25
		}
	},
	["Hotdog"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 20
		}
	},
	["Chihuahua"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 20,
			["hamburger"] = 25,
			["cola"] = 20,
			["soda"] = 20,
			["water"] = 35
		}
	},
	["Water"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["water"] = 35
		}
	},
	["Cigarette"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cigarette"] = 15,
			["lighter"] = 225
		}
	},
	["Fuel"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_PETROLCAN"] = 325
		}
	},
	["Paramedico"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Paramedico",
		["List"] = {
			["syringe01"] = 45,
			["syringe02"] = 45,
			["syringe03"] = 45,
			["syringe04"] = 45,
			["bandage"] = 925,
			["gdtkit"] = 25,
			["medkit"] = 1725,
			["sinkalmy"] = 325,
			["analgesic"] = 525,
			["ritmoneury"] = 625,
			["medicbag"] = 725,
			["adrenaline"] = 3225
		}
	},
	["Hunting"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["boar1star"] = 275,
			["boar2star"] = 300,
			["boar3star"] = 325,
			["deer1star"] = 275,
			["deer2star"] = 300,
			["deer3star"] = 325,
			["coyote1star"] = 275,
			["coyote2star"] = 300,
			["coyote3star"] = 325,
			["mtlion1star"] = 275,
			["mtlion2star"] = 300,
			["mtlion3star"] = 325
		}
	},
	["Fishing"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["sardine"] = 65,
			["smalltrout"] = 65,
			["orangeroughy"] = 65,
			["anchovy"] = 70,
			["catfish"] = 70,
			["herring"] = 75,
			["yellowperch"] = 75,
			["salmon"] = 125,
			["smallshark"] = 250
		}
	},
	["Miners"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["tin_pure"] = 80,
			["lead_pure"] = 80,
			["copper_pure"] = 80,
			["iron_pure"] = 80,
			["gold_pure"] = 90,
			["diamond_pure"] = 130,
			["ruby_pure"] = 120,
			["sapphire_pure"] = 110,
			["emerald_pure"] = 100
		}
	},
	["Policia"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Policia",
		["List"] = {
			["gsrkit"] = 25,
			["gdtkit"] = 25,
			["barrier"] = 25,
			["handcuff"] = 125,
			["WEAPON_SMG"] = 2600,
			["WEAPON_COMBATPISTOL"] = 1200,
			["WEAPON_SMG_AMMO"] = 10,
			["WEAPON_PISTOL_AMMO"] = 10,
			["spikestrips"] = 275
		}
	}
}