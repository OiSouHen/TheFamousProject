-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RolepassPoints = 500
RolepassPrice = 10000
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Boxes = {
	{
		["Id"] = 1,
		["Name"] = "Caixa de Diamantes",
		["Image"] = "gemstone",
		["Price"] = 500,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 250,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 375,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 500,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 625,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 750,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 1000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 5
			},{
				["Id"] = 7,
				["Amount"] = 2000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 4
			},{
				["Id"] = 8,
				["Amount"] = 3000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 3
			},{
				["Id"] = 9,
				["Amount"] = 4000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 2
			},{
				["Id"] = 10,
				["Amount"] = 5000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 1
			},{
				["Id"] = 11,
				["Amount"] = 10000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 0
			},{
				["Id"] = 12,
				["Amount"] = 20000,
				["Image"] = "gemstone",
				["Item"] = "gemstone",
				["Name"] = "Diamante",
				["Chance"] = 0
			}
		}
	},{
		["Id"] = 2,
		["Name"] = "Caixa de Platinas",
		["Image"] = "platinum",
		["Price"] = 1000,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 300
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 200
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 175
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 5
			},{
				["Id"] = 7,
				["Amount"] = 3000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 4
			},{
				["Id"] = 8,
				["Amount"] = 4000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 3
			},{
				["Id"] = 9,
				["Amount"] = 5000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 2
			},{
				["Id"] = 10,
				["Amount"] = 7500,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 1
			},{
				["Id"] = 11,
				["Amount"] = 10000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 0
			},{
				["Id"] = 12,
				["Amount"] = 20000,
				["Image"] = "platinum",
				["Item"] = "platinum",
				["Name"] = "Platina",
				["Chance"] = 0
			}
		}
	},{
		["Id"] = 3,
		["Name"] = "Caixa de Alumínio",
		["Image"] = "aluminum",
		["Price"] = 500,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2250,
				["Image"] = "aluminum",
				["Item"] = "aluminum",
				["Name"] = "Alumínio",
				["Chance"] = 10
			}
		}
	},{
		["Id"] = 4,
		["Name"] = "Caixa de Vidro",
		["Image"] = "glass",
		["Price"] = 500,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2250,
				["Image"] = "glass",
				["Item"] = "glass",
				["Name"] = "Vidro",
				["Chance"] = 10
			}
		}
	},{
		["Id"] = 5,
		["Name"] = "Caixa de Cobre",
		["Image"] = "copper",
		["Price"] = 500,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2250,
				["Image"] = "copper",
				["Item"] = "copper",
				["Name"] = "Cobre",
				["Chance"] = 10
			}
		}
	},{
		["Id"] = 6,
		["Name"] = "Caixa de Borracha",
		["Image"] = "rubber",
		["Price"] = 500,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2250,
				["Image"] = "rubber",
				["Item"] = "rubber",
				["Name"] = "Borracha",
				["Chance"] = 10
			}
		}
	},{
		["Id"] = 7,
		["Name"] = "Caixa de Plástico",
		["Image"] = "plastic",
		["Price"] = 500,
		["Discount"] = 0.75,
		["Rewards"] = {
			{
				["Id"] = 1,
				["Amount"] = 500,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 500
			},{
				["Id"] = 2,
				["Amount"] = 750,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 250
			},{
				["Id"] = 3,
				["Amount"] = 1000,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 200
			},{
				["Id"] = 4,
				["Amount"] = 1250,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 150
			},{
				["Id"] = 5,
				["Amount"] = 1500,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 100
			},{
				["Id"] = 6,
				["Amount"] = 2250,
				["Image"] = "plastic",
				["Item"] = "plastic",
				["Name"] = "Plástico",
				["Chance"] = 10
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
Works = {
	["Grime"] = "Grime",
	["Taxi"] = "Taxista",
	["Towed"] = "Impound",
	["Dismantle"] = "Desmanche",
	["Delivery"] = "Entregador",
	["Transporter"] = "Transportador",
	["Smuggler"] = "Contrabandista",
	["Lumberman"] = "Lenhador",
	["Milkman"] = "Leiteiro",
	["Trucker"] = "Caminhoneiro",
	["Fisherman"] = "Pescador",
	["Driver"] = "Motorista",
	["Traffic"] = "Traficante",
	["Hunting"] = "Caçador",
	["Garbageman"] = "Lixeiro",
	["Race"] = "Corredor"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
Premium = {
	[1] = {
		["Hierarchy"] = 1,
		["Name"] = "Ouro",
		["Image"] = "gold",
		["Price"] = 20000,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Type"] = "Info",
				["Name"] = "Reduz 20% de quebrar a Lockpick"
			},{
				["Type"] = "Info",
				["Name"] = "Recebe 100 Kilos de peso na mochila"
			},{
				["Type"] = "Info",
				["Name"] = "20% de bonificação nos empregos"
			},{
				["Type"] = "Info",
				["Name"] = "Salário de $10.000 a cada 30 minutos"
			},{
				["Type"] = "Info",
				["Name"] = "75% de desconto em todos os impostos"
			}
		}
	},
	[2] = {
		["Hierarchy"] = 2,
		["Name"] = "Prata",
		["Image"] = "silver",
		["Price"] = 10000,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Type"] = "Info",
				["Name"] = "Reduz 10% de quebrar a Lockpick"
			},{
				["Type"] = "Info",
				["Name"] = "50 Kilos de peso na mochila"
			},{
				["Type"] = "Info",
				["Name"] = "10% de bonificação nos empregos"
			},{
				["Type"] = "Info",
				["Name"] = "Salário de $5.000 a cada 30 minutos"
			},{
				["Type"] = "Info",
				["Name"] = "50% de desconto em todos os impostos"
			}
		}
	},
	[3] = {
		["Hierarchy"] = 3,
		["Name"] = "Bronze",
		["Image"] = "bronze",
		["Price"] = 5000,
		["Discount"] = 1.0,
		["Rewards"] = {
			{
				["Type"] = "Info",
				["Name"] = "Reduz 5% de quebrar a Lockpick"
			},{
				["Type"] = "Info",
				["Name"] = "25 Kilos de peso na mochila"
			},{
				["Type"] = "Info",
				["Name"] = "5% de bonificação nos empregos"
			},{
				["Type"] = "Info",
				["Name"] = "Salário de $2.500 a cada 30 minutos"
			},{
				["Type"] = "Info",
				["Name"] = "25% de desconto em todos os impostos"
			}
		}
	}
	-- [4] = {
	-- 	["Hierarchy"] = 3,
	-- 	["Name"] = "Bronze",
	-- 	["Image"] = "bronze",
	-- 	["Price"] = 5000,
	-- 	["Discount"] = 1.0,
	-- 	["Rewards"] = {
	-- 		{
	-- 			["Type"] = "Item",
	-- 			["Item"] = "bandage",
	-- 			["Name"] = "Bandagem",
	-- 			["Amount"] = 1
	-- 		},{
	-- 			["Type"] = "Info",
	-- 			["Name"] = "Veiculo da categoria 2 30 dias"
	-- 		},{
	-- 			["Type"] = "Vehicle",
	-- 			["Name"] = "SkylineR34",
	-- 			["Index"] = "skyliner34",
	-- 			["Amount"] = 30
	-- 		}
	-- 	},
	-- 	["Selectables"] = {
	-- 		{
	-- 			["Id"] = 1,
	-- 			["Name"] = "Categoria 2",
	-- 			["Options"] = {
	-- 				{
	-- 					["Name"] = "SkylineR34",
	-- 					["Index"] = "skyliner34"
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPITENS
-----------------------------------------------------------------------------------------------------------------------------------------
ShopItens = {
	["gemstone"] = {
		["Price"] = 1,
		["Discount"] = 1.0
	},
	["premiumplate"] = {
		["Price"] = 5000,
		["Discount"] = 1.0
	},
	["newchars"] = {
		["Price"] = 4000,
		["Discount"] = 1.0
	},
	["namechange"] = {
		["Price"] = 3000,
		["Discount"] = 1.0
	},
	["diagram"] = {
		["Price"] = 500,
		["Discount"] = 1.0
	},
	["WEAPON_KATANA"] = {
		["Price"] = 500,
		["Discount"] = 1.0
	},
	["pickaxeplus"] = {
		["Price"] = 2500,
		["Discount"] = 1.0
	},
	["fishingrodplus"] = {
		["Price"] = 2500,
		["Discount"] = 1.0
	},
	["axeplus"] = {
		["Price"] = 2500,
		["Discount"] = 1.0
	},
	["backpackp"] = {
		["Price"] = 2000,
		["Discount"] = 0.95
	},
	["backpackm"] = {
		["Price"] = 3500,
		["Discount"] = 1.0
	},
	["backpackg"] = {
		["Price"] = 5000,
		["Discount"] = 1.0
	},
	["teddypack"] = {
		["Price"] = 5000,
		["Discount"] = 1.0
	},
	["weaponbox"] = {
		["Price"] = 5000,
		["Discount"] = 1.0
	},
	["ammobox"] = {
		["Price"] = 3500,
		["Discount"] = 1.0
	},
	["sewingkit"] = {
		["Price"] = 2500,
		["Discount"] = 1.0
	},
	["seatbelt"] = {
		["Price"] = 5000,
		["Discount"] = 0.95
	},
	["adrenalineplus"] = {
		["Price"] = 500,
		["Discount"] = 0.98
	},
	["washbattery"] = {
		["Price"] = 750,
		["Discount"] = 1.0
	},
	["radiomhz"] = {
		["Price"] = 7500,
		["Discount"] = 1.0
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLEITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RoleItens = {
	["Free"] = {
		{
			["Amount"] = 1000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit01"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit02"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit03"
		},{
			["Amount"] = 1000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1250,
			["Item"] = "dollar"
		},{
			["Amount"] = 1500,
			["Item"] = "dollar"
		},{
			["Amount"] = 1750,
			["Item"] = "dollar"
		},{
			["Amount"] = 1,
			["Item"] = "medkit"
		},{
			["Amount"] = 3,
			["Item"] = "bandage"
		},{
			["Amount"] = 3,
			["Item"] = "analgesic"
		},{
			["Amount"] = 5,
			["Item"] = "gauze"
		},{
			["Amount"] = 1,
			["Item"] = "medicalkey"
		},{
			["Amount"] = 1,
			["Item"] = "utilkey"
		},{
			["Amount"] = 3,
			["Item"] = "toolbox"
		},{
			["Amount"] = 1,
			["Item"] = "advtoolbox"
		},{
			["Amount"] = 1,
			["Item"] = "adrenalineplus"
		},{
			["Amount"] = 100,
			["Item"] = "plastic"
		},{
			["Amount"] = 100,
			["Item"] = "glass"
		},{
			["Amount"] = 100,
			["Item"] = "rubber"
		},{
			["Amount"] = 100,
			["Item"] = "aluminum"
		},{
			["Amount"] = 100,
			["Item"] = "copper"
		},{
			["Amount"] = 275,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 325,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 375,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 1,
			["Item"] = "television"
		},{
			["Amount"] = 1,
			["Item"] = "safependrive"
		},{
			["Amount"] = 1,
			["Item"] = "goldenjug"
		}
	},
	["Premium"] = {
		{
			["Amount"] = 2500,
			["Item"] = "dollar"
		},{
			["Amount"] = 2750,
			["Item"] = "dollar"
		},{
			["Amount"] = 3000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit01"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit02"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit03"
		},{
			["Amount"] = 1,
			["Item"] = "repairkit04"
		},{
			["Amount"] = 3,
			["Item"] = "toolbox"
		},{
			["Amount"] = 3,
			["Item"] = "advtoolbox"
		},{
			["Amount"] = 2500,
			["Item"] = "dollar"
		},{
			["Amount"] = 2750,
			["Item"] = "dollar"
		},{
			["Amount"] = 3000,
			["Item"] = "dollar"
		},{
			["Amount"] = 1,
			["Item"] = "backpackp"
		},{
			["Amount"] = 3,
			["Item"] = "adrenalineplus"
		},{
			["Amount"] = 3,
			["Item"] = "diagram"
		},{
			["Amount"] = 3,
			["Item"] = "diagram"
		},{
			["Amount"] = 225,
			["Item"] = "plastic"
		},{
			["Amount"] = 225,
			["Item"] = "glass"
		},{
			["Amount"] = 225,
			["Item"] = "rubber"
		},{
			["Amount"] = 225,
			["Item"] = "aluminum"
		},{
			["Amount"] = 225,
			["Item"] = "copper"
		},{
			["Amount"] = 625,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 725,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 825,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 928,
			["Item"] = "blueprint_fragment"
		},{
			["Amount"] = 1,
			["Item"] = "goldenleopard"
		},{
			["Amount"] = 1,
			["Item"] = "goldenlion"
		},{
			["Amount"] = 1,
			["Item"] = "blueprint_bench"
		},{
			["Amount"] = 1,
			["Item"] = "goldenjug"
		},{
			["Amount"] = 1,
			["Item"] = "moneywash"
		}
	}
}