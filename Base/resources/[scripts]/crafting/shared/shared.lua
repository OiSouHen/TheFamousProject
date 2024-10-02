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

		for Item,v in pairs(v["List"]) do
			local Number = #ItemList[Shop] + 1

			ItemList[Shop][Number] = {
				["name"] = ItemName(Item),
				["weight"] = ItemWeight(Item),
				["index"] = ItemIndex(Item),
				["rarity"] = ItemRarity(Item),
				["economy"] = ItemEconomy(Item),
				["desc"] = ItemDescription(Item),
				["price"] = v["Amount"],
				["required"] = {},
				["key"] = Item
			}

			for Index,Amount in pairs(v["Required"]) do
				local Rarity = ItemRarity(Index)
				ItemList[Shop][Number]["required"][#ItemList[Shop][Number]["required"] + 1] = "<"..Rarity..">"..Dotted(Amount).."x "..ItemName(Index).."</"..Rarity..">"
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATION
-----------------------------------------------------------------------------------------------------------------------------------------
Location = {
	{
		["Coords"] = vec3(1272.51,-1713.05,54.63),
		["Mode"] = "Lester",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-1078.74,-2085.48,21.09),
		["Mode"] = "Mecanico",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1110.8,-2008.75,31.43),
		["Mode"] = "Furnace",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-629.45,222.9,81.97),
		["Mode"] = "FoodRestaurante",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-627.69,222.96,82.1),
		["Mode"] = "DrinkRestaurante",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1277.53,-160.32,98.36),
		["Mode"] = "Armas01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(600.28,921.05,233.73),
		["Mode"] = "Armas02",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-238.64,3953.42,46.51),
		["Mode"] = "Armas03",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-2679.4,1330.26,140.99),
		["Mode"] = "Municao01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(2703.57,621.5,91.44),
		["Mode"] = "Municao02",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-383.48,1594.99,351.66),
		["Mode"] = "Municao03",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(716.58,-176.1,70.7),
		["Mode"] = "Drogas01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(2180.34,-1155.49,168.2),
		["Mode"] = "Drogas02",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1998.14,-12.15,203.7),
		["Mode"] = "Drogas03",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(544.08,2437.94,59.86),
		["Mode"] = "Drogas04",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1467.57,-719.36,85.59),
		["Mode"] = "Desmanche01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1520.92,1730.92,115.14),
		["Mode"] = "Desmanche02",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1743.87,1279.02,133.91),
		["Mode"] = "Roubos01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(1666.54,6512.2,38.19),
		["Mode"] = "Lavagem01",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(2203.85,4685.17,37.51),
		["Mode"] = "Lavagem02",
		["Circle"] = 0.1
	},{
		["Coords"] = vec3(-1897.97,2067.86,141.02),
		["Mode"] = "Lavagem03",
		["Circle"] = 0.1
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
List = {
	["Armas01"] = {
		["Permission"] = "Armas01",
		["List"] = {
			["WEAPON_PISTOL"] = { -- PISTOL
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL50"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_APPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}, -- CRAFT SMG
			["WEAPON_MICROSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25,
				}
			},
			["WEAPON_MINISMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_GUSENBERG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			}, -- RIFLE
			["WEAPON_COMPACTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_TACTICALRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_HEAVYRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_COMBATPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}
		}
	},
	["Armas02"] = {
		["Permission"] = "Armas02",
		["List"] = {
			["WEAPON_PISTOL"] = { -- PISTOL
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL50"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_APPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}, -- CRAFT SMG
			["WEAPON_MICROSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25,
				}
			},
			["WEAPON_MINISMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_GUSENBERG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			}, -- RIFLE
			["WEAPON_COMPACTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_TACTICALRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_HEAVYRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_COMBATPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}
		}
	},
	["Armas03"] = {
		["Permission"] = "Armas03",
		["List"] = {
			["WEAPON_PISTOL"] = { -- PISTOL
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_PISTOL50"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_APPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}, -- CRAFT SMG
			["WEAPON_MICROSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25,
				}
			},
			["WEAPON_MINISMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_SMG_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			},
			["WEAPON_GUSENBERG"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 25,
					["weaponbody"] = 25,
					["smgsighthandle"] = 25,
					["smgmagazine"] = 25
				}
			}, -- RIFLE
			["WEAPON_COMPACTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_CARBINERIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_TACTICALRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_HEAVYRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 35,
					["weaponbody"] = 35,
					["riflesighthandle"] = 35,
					["riflemagazine"] = 35
				}
			},
			["WEAPON_COMBATPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["weapontrigger"] = 15,
					["weaponbody"] = 15,
					["pistolsighthandle"] = 15,
					["pistolmagazine"] = 15
				}
			}
		}
	},
	["Municao01"] = {
		["Permission"] = "Municao02",
		["List"] = {
			["WEAPON_PISTOL_AMMO"] = { -- AMMOPISTOL
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["pistolprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["smgprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["rifleprojectile"] = 50,
					["fuze"] = 75
				}
			}
		}
	},
	["Municao02"] = {
		["Permission"] = "Municao02",
		["List"] = {
			["WEAPON_PISTOL_AMMO"] = { -- AMMOPISTOL
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["pistolprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["smgprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["rifleprojectile"] = 50,
					["fuze"] = 75
				}
			}
		}
	},
	["Municao03"] = {
		["Permission"] = "Municao03",
		["List"] = {
			["WEAPON_PISTOL_AMMO"] = { -- AMMOPISTOL
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["pistolprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["smgprojectile"] = 50,
					["fuze"] = 75
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["Amount"] = 50,
				["Required"] = {
					["gunpowder"] = 100,
					["rifleprojectile"] = 50,
					["fuze"] = 75
				}
			}
		}
	},
	["Drogas01"] = {
		["Permission"] = "Drogas01",
		["List"] = {
			["cocaine"] = {
				["Amount"] = 1,
				["Required"] = {
					["coke"] = 5,
					["sulfuric"] = 5
				}
			},
			["cokesack"] = {
				["Amount"] = 1,
				["Required"] = {
					["cocaine"] = 10
				}
			}
		}
	},
	["Drogas02"] = {
		["Permission"] = "Drogas02",
		["List"] = {
			["joint"] = {
				["Amount"] = 1,
				["Required"] = {
					["weed"] = 5,
					["silk"] = 5
				}
			},
			["weedsack"] = {
				["Amount"] = 1,
				["Required"] = {
					["joint"] = 10
				}
			}
		}
	},
	["Drogas03"] = {
		["Permission"] = "Drogas03",
		["List"] = {
			["meth"] = {
				["Amount"] = 5,
				["Required"] = {
					["mdma"] = 5,
					["sulfuric"] = 5
				}
			},
			["methsack"] = {
				["Amount"] = 1,
				["Required"] = {
					["meth"] = 10
				}
			}
		}
	},
	["Drogas04"] = {
		["Permission"] = "Drogas04",
		["List"] = {
			["lsd"] = {
				["Amount"] = 5,
				["Required"] = {
					["mushroom"] = 5,
					["sulfuric"] = 5
				}
			},
			["lsdsack"] = {
				["Amount"] = 1,
				["Required"] = {
					["lsd"] = 10
				}
			}
		}
	},
	["Desmanche01"] = {
		["Permission"] = "Desmanche01",
		["List"] = {
			["lockpick"] = {
				["Amount"] = 1,
				["Required"] = {
					["threadscrews"] = 15,
					["forgedaluminum"] = 20
				}
			}
		}
	},
	["Desmanche02"] = {
		["Permission"] = "Desmanche02",
		["List"] = {
			["lockpick"] = {
				["Amount"] = 1,
				["Required"] = {
					["threadscrews"] = 15,
					["forgedaluminum"] = 20
				}
			}
		}
	},
	["Roubos01"] = {
		["Permission"] = "Roubos01",
		["List"] = {
			["ballisticplate"] = {
				["Amount"] = 1,
				["Required"] = {
					["steelplate"] = 15,
					["forgedaluminum"] = 10
				}
			},
			["ATTACH_FLASHLIGHT"] = {
				["Amount"] = 1,
				["Required"] = {
					["silvertape"] = 1,
					["temperedglass"] = 25,
					["temperedglass"] = 25
				}
			},
			["ATTACH_CROSSHAIR"] = {
				["Amount"] = 1,
				["Required"] = {
					["silvertape"] = 1,
					["temperedglass"] = 25,
					["forgedcopper"] = 25
				}
			},
			["ATTACH_SILENCER"] = {
				["Amount"] = 1,
				["Required"] = {
					["silvertape"] = 1,
					["temperedglass"] = 25,
					["forgedcopper"] = 25
				}
			},
			["ATTACH_MAGAZINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["silvertape"] = 1,
					["temperedglass"] = 25,
					["forgedcopper"] = 25
				}
			},
			["ATTACH_GRIP"] = {
				["Amount"] = 1,
				["Required"] = {
					["silvertape"] = 1,
					["temperedglass"] = 25,
					["forgedcopper"] = 25
				}
			}
		}
	},
	["Lavagem01"] = {
		["Permission"] = "Lavagem01",
		["List"] = {
			["dollar"] = {
				["Amount"] = 750,
				["Required"] = {
					["cleaner"] = 100,
					["dirtydollar"] = 1000
				}
			}
		}
	},
	["Lavagem02"] = {
		["Permission"] = "Lavagem02",
		["List"] = {
			["dollar"] = {
				["Amount"] = 750,
				["Required"] = {
					["cleaner"] = 100,
					["dirtydollar"] = 1000
				}
			}
		}
	},
	["Lavagem03"] = {
		["Permission"] = "Lavagem03",
		["List"] = {
			["dollar"] = {
				["Amount"] = 750,
				["Required"] = {
					["cleaner"] = 100,
					["dirtydollar"] = 1000
				}
			}
		}
	},
	["FoodRestaurante"] = {
		["Permission"] = "Restaurante",
		["List"] = {
			["nigirizushi"] = {
				["Amount"] = 3,
				["Required"] = {
					["fishfillet"] = 3,
					["ricebag"] = 1
				}
			},
			["sushi"] = {
				["Amount"] = 2,
				["Required"] = {
					["fishfillet"] = 2,
					["sugarbox"] = 1
				}
			},
			["cupcake"] = {
				["Amount"] = 3,
				["Required"] = {
					["milkbottle"] = 1,
					["chocolate"] = 1,
					["sugarbox"] = 1
				}
			},
			["applelove"] = {
				["Amount"] = 2,
				["Required"] = {
					["sugarbox"] = 1,
					["apple"] = 1
				}
			},
			["cookies"] = {
				["Amount"] = 3,
				["Required"] = {
					["milkbottle"] = 1,
					["chocolate"] = 1,
					["sugarbox"] = 1
				}
			},
			["hamburger2"] = {
				["Amount"] = 1,
				["Required"] = {
					["meatfillet"] = 1,
					["mayonnaise"] = 1,
					["ryebread"] = 1
				}
			},
			["hamburger3"] = {
				["Amount"] = 1,
				["Required"] = {
					["meatfillet"] = 1,
					["mayonnaise"] = 1,
					["ryebread"] = 1
				}
			},
			["pizzamozzarella"] = {
				["Amount"] = 1,
				["Required"] = {
					["milkbottle"] = 1,
					["ryebread"] = 1,
					["water"] = 1,
					["tomato"] = 1
				}
			},
			["pizzabanana"] = {
				["Amount"] = 1,
				["Required"] = {
					["milkbottle"] = 1,
					["ryebread"] = 1,
					["water"] = 1,
					["banana"] = 1
				}
			},
			["pizzachocolate"] = {
				["Amount"] = 1,
				["Required"] = {
					["milkbottle"] = 1,
					["ryebread"] = 1,
					["water"] = 1,
					["chocolate"] = 1
				}
			}
		}
	},
	["DrinkRestaurante"] = {
		["Permission"] = "Restaurante",
		["List"] = {
			["milkshake"] = {
				["Amount"] = 1,
				["Required"] = {
					["milkbottle"] = 1,
					["strawberry"] = 1
				}
			},
			["cappuccino"] = {
				["Amount"] = 1,
				["Required"] = {
					["milkbottle"] = 1,
					["chocolate"] = 1,
					["coffee"] = 1
				}
			},
			["passionjuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["passion"] = 2,
					["water"] = 1
				}
			},
			["tangejuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["tange"] = 1,
					["water"] = 1
				}
			},
			["orangejuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["orange"] = 1,
					["water"] = 1
				}
			},
			["applejuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["apple"] = 1,
					["water"] = 1
				}
			},
			["grapejuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["grape"] = 1,
					["water"] = 1
				}
			},
			["lemonjuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["lemon"] = 1,
					["water"] = 1
				}
			},
			["bananajuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["banana"] = 1,
					["water"] = 1
				}
			},
			["acerolajuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["acerola"] = 1,
					["water"] = 1
				}
			},
			["strawberryjuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["strawberry"] = 1,
					["water"] = 1
				}
			},
			["blueberryjuice"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueberry"] = 1,
					["water"] = 1
				}
			},
			["coffeemilk"] = {
				["Amount"] = 1,
				["Required"] = {
					["coffee"] = 1,
					["milkbottle"] = 1
				}
			}
		}
	},
	["Furnace"] = {
		["List"] = {
			["plastic"] = {
				["Amount"] = 25,
				["Required"] = {
					["emptybottle"] = 3,
					["WEAPON_PETROLCAN_AMMO"] = 4500
				}
			},
			["glass"] = {
				["Amount"] = 5,
				["Required"] = {
					["sand"] = 1
				}
			},
			["latex"] = {
				["Amount"] = 1,
				["Required"] = {
					["woodlog"] = 5,
					["emptybottle"] = 1
				}
			},
			["rubber"] = {
				["Amount"] = 20,
				["Required"] = {
					["latex"] = 1
				}
			},
			["aluminum"] = {
				["Amount"] = 5,
				["Required"] = {
					["bauxite"] = 1
				}
			},
			["copper"] = {
				["Amount"] = 5,
				["Required"] = {
					["chalcopyrite"] = 1
				}
			}
		}
	},
	["Mecanico"] = {
		["Permission"] = "Mecanico",
		["List"] = {
			["coilover"] = {
				["Amount"] = 1,
				["Required"] = {
					["screws"] = 24,
					["screwnuts"] = 24,
					["copper"] = 725,
					["aluminum"] = 725,
					["metalspring"] = 4,
					["sheetmetal"] = 10,
					["roadsigns"] = 4,
					["scotchtape"] = 2,
					["insulatingtape"] = 2,
					["scrapmetal"] = 425
				}
			},
			["advtoolbox"] = {
				["Amount"] = 1,
				["Required"] = {
					["screws"] = 2,
					["screwnuts"] = 2,
					["rubber"] = 40,
					["copper"] = 40,
					["aluminum"] = 40
				}
			},
			["WEAPON_WRENCH"] = {
				["Amount"] = 1,
				["Required"] = {
					["screws"] = 1,
					["screwnuts"] = 1,
					["aluminum"] = 10
				}
			},
			["toolbox"] = {
				["Amount"] = 1,
				["Required"] = {
					["screws"] = 1,
					["screwnuts"] = 1,
					["rubber"] = 15,
					["copper"] = 15,
					["aluminum"] = 15
				}
			},
			["tyres"] = {
				["Amount"] = 1,
				["Required"] = {
					["rubber"] = 15
				}
			},
			["plate"] = {
				["Amount"] = 1,
				["Required"] = {
					["copper"] = 50,
					["aluminum"] = 45
				}
			},
			["nitro"] = {
				["Amount"] = 1,
				["Required"] = {
					["scotchtape"] = 2,
					["insulatingtape"] = 1,
					["screws"] = 2,
					["screwnuts"] = 2,
					["glass"] = 70,
					["copper"] = 40,
					["aluminum"] = 40
				}
			}
		}
	},
	["pistol_bench"] = {
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 100,
					["rubber"] = 100,
					["plastic"] = 120,
					["copper"] = 75,
					["aluminum"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 115,
					["rubber"] = 115,
					["plastic"] = 135,
					["copper"] = 75,
					["aluminum"] = 75
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 1,
					["glass"] = 155,
					["rubber"] = 155,
					["plastic"] = 175,
					["copper"] = 100,
					["aluminum"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 75,
					["rubber"] = 100,
					["plastic"] = 65,
					["copper"] = 55,
					["aluminum"] = 65
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 75,
					["rubber"] = 100,
					["plastic"] = 110,
					["copper"] = 75,
					["aluminum"] = 75
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 75,
					["rubber"] = 75,
					["plastic"] = 100,
					["copper"] = 50,
					["aluminum"] = 50
				}
			},
			["WEAPON_PISTOL50"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 1,
					["glass"] = 155,
					["rubber"] = 155,
					["plastic"] = 165,
					["copper"] = 100,
					["aluminum"] = 100
				}
			},
			["WEAPON_COMBATPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["pistolbody"] = 1,
					["weaponparts"] = 3,
					["metalspring"] = 1,
					["glass"] = 115,
					["rubber"] = 125,
					["plastic"] = 125,
					["copper"] = 75,
					["aluminum"] = 75
				}
			}
		}
	},
	["smg_bench"] = {
		["List"] = {
			["WEAPON_APPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 145,
					["rubber"] = 145,
					["plastic"] = 155,
					["copper"] = 100,
					["aluminum"] = 100
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 145,
					["rubber"] = 145,
					["plastic"] = 155,
					["copper"] = 100,
					["aluminum"] = 100
				}
			},
			["WEAPON_MICROSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 225,
					["rubber"] = 235,
					["plastic"] = 275,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_MINISMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 225,
					["rubber"] = 235,
					["plastic"] = 275,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_SMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 275,
					["rubber"] = 305,
					["plastic"] = 315,
					["copper"] = 225,
					["aluminum"] = 225
				}
			},
			["WEAPON_SMG_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 375,
					["rubber"] = 305,
					["plastic"] = 305,
					["copper"] = 225,
					["aluminum"] = 225
				}
			},
			["WEAPON_GUSENBERG"] = {
				["Amount"] = 1,
				["Required"] = {
					["smgbody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 2,
					["glass"] = 275,
					["rubber"] = 305,
					["plastic"] = 305,
					["copper"] = 225,
					["aluminum"] = 225
				}
			}
		}
	},
	["rifle_bench"] = {
		["List"] = {
			["WEAPON_PUMPSHOTGUN"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 1,
					["glass"] = 225,
					["rubber"] = 265,
					["plastic"] = 255,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 8,
					["metalspring"] = 2,
					["glass"] = 375,
					["rubber"] = 425,
					["plastic"] = 345,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 5,
					["metalspring"] = 1,
					["glass"] = 225,
					["rubber"] = 255,
					["plastic"] = 265,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 8,
					["metalspring"] = 2,
					["glass"] = 305,
					["rubber"] = 325,
					["plastic"] = 265,
					["copper"] = 175,
					["aluminum"] = 175
				}
			},
			["WEAPON_CARBINERIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 405,
					["rubber"] = 405,
					["plastic"] = 405,
					["copper"] = 345,
					["aluminum"] = 335
				}
			},
			["WEAPON_CARBINERIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 405,
					["rubber"] = 415,
					["plastic"] = 375,
					["copper"] = 355,
					["aluminum"] = 375
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 385,
					["rubber"] = 405,
					["plastic"] = 405,
					["copper"] = 335,
					["aluminum"] = 325
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 385,
					["rubber"] = 465,
					["plastic"] = 400,
					["copper"] = 325,
					["aluminum"] = 325
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 305,
					["rubber"] = 425,
					["plastic"] = 425,
					["copper"] = 300,
					["aluminum"] = 425
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 305,
					["rubber"] = 425,
					["plastic"] = 425,
					["copper"] = 425,
					["aluminum"] = 300
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 275,
					["rubber"] = 400,
					["plastic"] = 400,
					["copper"] = 425,
					["aluminum"] = 345
				}
			},
			["WEAPON_TACTICALRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 275,
					["rubber"] = 400,
					["plastic"] = 400,
					["copper"] = 345,
					["aluminum"] = 425
				}
			},
			["WEAPON_HEAVYRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 305,
					["rubber"] = 425,
					["plastic"] = 425,
					["copper"] = 335,
					["aluminum"] = 375
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 305,
					["rubber"] = 425,
					["plastic"] = 425,
					["copper"] = 425,
					["aluminum"] = 300
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["riflebody"] = 1,
					["weaponparts"] = 10,
					["metalspring"] = 3,
					["glass"] = 275,
					["rubber"] = 400,
					["plastic"] = 400,
					["copper"] = 425,
					["aluminum"] = 345
				}
			}
		}
	},
	["blueprint_bench"] = {
		["List"] = {
			["blueprint_WEAPON_ADVANCEDRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 113625
				}
			},
			["blueprint_WEAPON_COMPACTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 66125
				}
			},
			["blueprint_ATTACH_GRIP"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 8625
				}
			},
			["blueprint_WEAPON_SAWNOFFSHOTGUN"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 66125
				}
			},
			["blueprint_WEAPON_MICROSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 66125
				}
			},
			["blueprint_WEAPON_HEAVYRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_WEAPON_ASSAULTRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 113625
				}
			},
			["blueprint_WEAPON_MUSKET"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 16125
				}
			},
			["blueprint_WEAPON_BULLPUPRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 113625
				}
			},
			["blueprint_ATTACH_MAGAZINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 11125
				}
			},
			["blueprint_WEAPON_ASSAULTRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_WEAPON_HEAVYPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 6125
				}
			},
			["blueprint_WEAPON_CARBINERIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_ATTACH_FLASHLIGHT"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 10625
				}
			},
			["blueprint_WEAPON_PISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 28625
				}
			},
			["blueprint_WEAPON_SNSPISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 26125
				}
			},
			["blueprint_ATTACH_SILENCER"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 23625
				}
			},
			["blueprint_WEAPON_SPECIALCARBINE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_WEAPON_PISTOL50"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 41125
				}
			},
			["blueprint_WEAPON_MINISMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 66125
				}
			},
			["blueprint_WEAPON_TACTICALRIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_WEAPON_SNSPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 23625
				}
			},
			["blueprint_WEAPON_GUSENBERG"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 76125
				}
			},
			["blueprint_WEAPON_ASSAULTSMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 76125
				}
			},
			["blueprint_WEAPON_SMG_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 76125
				}
			},
			["blueprint_WEAPON_SMG"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 63625
				}
			},
			["blueprint_WEAPON_PUMPSHOTGUN_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 76375
				}
			},
			["blueprint_WEAPON_PUMPSHOTGUN"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 66125
				}
			},
			["blueprint_WEAPON_SPECIALCARBINE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 113625
				}
			},
			["blueprint_WEAPON_BULLPUPRIFLE_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 121125
				}
			},
			["blueprint_WEAPON_CARBINERIFLE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 113625
				}
			},
			["blueprint_ATTACH_CROSSHAIR"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 13625
				}
			},
			["blueprint_WEAPON_MACHINEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 41125
				}
			},
			["blueprint_WEAPON_APPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 31125
				}
			},
			["blueprint_WEAPON_PISTOL_MK2"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 31125
				}
			},
			["blueprint_WEAPON_SMOKEGRENADE"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 6125
				}
			},
			["blueprint_WEAPON_MOLOTOV"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 6125
				}
			},
			["blueprint_WEAPON_COMBATPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 31125
				}
			},
			["blueprint_WEAPON_VINTAGEPISTOL"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 23625
				}
			},
			["blueprint_metalspring"] = {
				["Amount"] = 1,
				["Required"] = {
					["blueprint_fragment"] = 265
				}
			}
		}
	},
	["drugs_bench"] = {
		["List"] = {
			["cocaine"] = {
				["Amount"] = 1,
				["Required"] = {
					["coke"] = 1
				}
			},
			["cokesack"] = {
				["Amount"] = 1,
				["Required"] = {
					["cocaine"] = 10
				}
			},
			["joint"] = {
				["Amount"] = 1,
				["Required"] = {
					["weed"] = 1
				}
			},
			["weedsack"] = {
				["Amount"] = 1,
				["Required"] = {
					["joint"] = 10
				}
			},
			["meth"] = {
				["Amount"] = 5,
				["Required"] = {
					["saline"] = 1,
					["sulfuric"] = 1
				}
			},
			["methsack"] = {
				["Amount"] = 1,
				["Required"] = {
					["meth"] = 10
				}
			},
			["crack"] = {
				["Amount"] = 1,
				["Required"] = {
					["cocaine"] = 10,
					["acetone"] = 2
				}
			},
			["heroin"] = {
				["Amount"] = 1,
				["Required"] = {
					["meth"] = 7,
					["saline"] = 2,
					["alcohol"] = 2,
					["sulfuric"] = 2
				}
			},
			["metadone"] = {
				["Amount"] = 1,
				["Required"] = {
					["analgesic"] = 1,
					["sulfuric"] = 2,
					["alcohol"] = 2
				}
			},
			["codeine"] = {
				["Amount"] = 1,
				["Required"] = {
					["analgesic"] = 1,
					["sulfuric"] = 2,
					["alcohol"] = 2
				}
			},
			["amphetamine"] = {
				["Amount"] = 1,
				["Required"] = {
					["meth"] = 6,
					["cocaine"] = 6
				}
			}
		}
	},
	["Lester"] = {
		["List"] = {
			["dismantle"] = {
				["Amount"] = 1,
				["Required"] = {
					["plastic"] = 25,
					["dirtydollar"] = 975
				}
			}
		}
	}
}