-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
DiscordBot = true
Whitelisted = false
BaseMode = "steam"
SalaryCooldown = 1800
ServerName = "Creative"
GroupsSetCooldown = 259200
NameDefault = "Indivíduo Indigente"
ServerLink = "https://creativenetwork.dev.br"
SpawnCoords = vec4(895.48,-179.38,73.7,240.95)
LeavePrisonCoords = vec3(1896.15,2604.44,45.75)
CreatorCoords = vec4(402.81,-996.55,-100.01,184.26)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INDEX
-----------------------------------------------------------------------------------------------------------------------------------------
TokenIndex = "DDDDDDD"
PlateIndex = "DDLLLDDD"
HashItemIndex = "DDLLDDLL"
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
ItemMaxRepairs = 1
MaxSlotsInventory = 100
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
MinimumWeight = 15
DefaultWeight = 25
PremiumWeight = { 50,25,10 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
RolepassPoint = 50
RolepassPointPremium = 100
RolepassInital = 1712518998
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Permission"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
		["Service"] = {},
		["Client"] = true
	},
	["Premium"] = {
		["Permission"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Ouro","Prata","Bronze" },
		["Salary"] = { 7500,5000,2500 },
		["Service"] = {},
		["Client"] = true,
		["Block"] = true
	},
	["LSPD"] = {
		["Permission"] = {
			["LSPD"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 7500,7250,7000,6750,6500,6250 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true
	},
	["BCSO"] = {
		["Permission"] = {
			["BCSO"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 7500,7250,7000,6750,6500,6250 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true
	},
	["BCPR"] = {
		["Permission"] = {
			["BCPR"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 7500,7250,7000,6750,6500,6250 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true
	},
	["Paramedico"] = {
		["Permission"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe","Médico","Enfermeiro","Residente" },
		["Salary"] = { 7500,7250,7000,6750 },
		["Discord"] = "1236103044811456662",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Ballas"] = {
		["Permission"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080429965316127",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Vagos"] = {
		["Permission"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080465155657860",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Families"] = {
		["Permission"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080491814523022",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Marabunta"] = {
		["Permission"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080518507069500",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Bennys"] = {
		["Permission"] = {
			["Bennys"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080543908036638",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Aztecas"] = {
		["Permission"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080564049084438",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Bahamas"] = {
		["Permission"] = {
			["Bahamas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Restaurante"] = {
		["Permission"] = {
			["Restaurante"] = true
		},
		["Hierarchy"] = { "Chefe","Supervisor","Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 10
	},
	["Camera"] = {
		["Permission"] = {
			["Camera"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true
	},
	["Policia"] = {
		["Permission"] = {
			["LSPD"] = true,
			["BCSO"] = true,
			["BCPR"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true
	},
	["Emergencia"] = {
		["Permission"] = {
			["LSPD"] = true,
			["BCSO"] = true,
			["BCPR"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["soda"] = 2,
	["sandwich"] = 2
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Boxes = {
	["treasurebox"] = {
		["Multiplier"] = 1,
		["List"] = {
			{ ["Item"] = "dollar", ["Chance"] = 100, ["Min"] = 4250, ["Max"] = 6250 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESSTART
-----------------------------------------------------------------------------------------------------------------------------------------
ClothesStart = {
	["mp_m_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 273, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 14, texture = 0 },
		["tshirt"] = { item = 3, texture = 0 },
		["torso"] = { item = 338, texture = 2 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	}
}