-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Rolepass = 1726525499
SalaryCooldowns = 1800
GroupsSetCooldown = 259200
PrisonCoords = vec3(1896.15,2604.44,45.75)
CreatorCoords = vec4(-1039.47,-2739.57,12.85,328.82)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERINFO
-----------------------------------------------------------------------------------------------------------------------------------------
Currency = "R$"
DiscordBot = true
BaseMode = "steam"
Whitelisted = true
Liberation = "id"
ServerName = "Hype Connect"
NameDefault = "Indivíduo Indigente"
ServerLink = "https://discord.gg/connecthype"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
SpawnCoords = {
	vec3(-1040.66,-2742.59,13.93)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
MaxRepair = 1
MinimumWeight = 15
SlotInventory = 100
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
Theme = {
	["currency"] = Currency,
	["main"] = "#5DA1F8",
	["common"] = "#6fc66a",
	["rare"] = "#6ac6c5",
	["epic"] = "#c66a75",
	["legendary"] = "#c6986a",
	["accept"] = {
		["letter"] = "#dcffe9",
		["background"] = "#3fa466"
	},
	["reject"] = {
		["letter"] = "#ffe8e8",
		["background"] = "#ad4443"
	},
	["chat"] = {
		["Families"] = "#ff0000",
		["Ballas"] = "#00ff00",
		["Vagos"] = "#0000ff"
	},
	["hud"] = {
		["percentage"] = true,
		["icons"] = "#ffffff",
		["nitro"] = "#ffffff",
		["rpm"] = "#ffffff",
		["fuel"] = "#ff4a56",
		["health"] = "#76B984",
		["armor"] = "#A66FED",
		["hunger"] = "#F4B266",
		["thirst"] = "#7FC8F8",
		["stress"] = "#E287C9",
		["luck"] = "#F18A7C",
		["dexterity"] = "#E4E76E",
		["repose"] = "#7FCCC7",
		["pointer"] = "#ef4444",
		["progress"] = {
			["background"] = "#ffffff",
			["circle"] = "#5DA1F8",
			["letter"] = "#ffffff"
		}
	},
	["notifyitem"] = {
		["add"] = {
			["letter"] = "#dcffe9",
			["background"] = "#3fa466"
		},
		["remove"] = {
			["letter"] = "#ffe8e8",
			["background"] = "#ad4443"
		}
	},
	["pause"] = {
		["premium"] = false,
		["store"] = true,
		["battlepass"] = false,
		["boxes"] = true,
		["marketplace"] = true,
		["skinweapon"] = true,
		["map"] = true,
		["disconnect"] = true
	}
}
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
		["Client"] = true,
		["Chat"] = true
	},
	["PMERJ"] = {
		["Permission"] = {
			["PMERJ"] = true
		},
		["Hierarchy"] = { "Comando Geral","Tenente Coronel","Major","Capitão","Tenente","Sargento","Cabo","Soldado","Recruta" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["BOPE"] = {
		["Permission"] = {
			["BOPE"] = true
		},
		["Hierarchy"] = { "Comando Geral","Sub-Comandante","Major","Capitão","Tenente","Sargento","Cabo","Soldado","Recruta" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["PCERJ"] = {
		["Permission"] = {
			["PCERJ"] = true
		},
		["Hierarchy"] = { "Delegado","Delegado Adjunto","Perito","Escrivão","Investigador","Agente" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["PRF"] = {
		["Permission"] = {
			["PRF"] = true
		},
		["Hierarchy"] = { "Diretor Geral","Sub-Diretor","Coordenador","Espetor","AgenteEspecial","Estagiario" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["PF"] = {
		["Permission"] = {
			["PF"] = true
		},
		["Hierarchy"] = { "Delegado","Delegado Adjunto","Perito","Escrivão","Investigador","Agente" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["BPCHQ"] = {
		["Permission"] = {
			["BPCHQ"] = true
		},
		["Hierarchy"] = { "Comando Geral","Sub-Comandante","Major","Capitão","Tenente","Sargento","Cabo","Soldado","Recruta" },
		["Salary"] = { 6050,6050,4000,4000,4000,4000,4000,4000,4000 },
		["Discord"] = "1236102727369756774",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Paramedico"] = {
		["Permission"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe","Médico","Enfermeiro","Residente" },
		["Salary"] = { 6050,6050,4000,4000 },
		["Discord"] = "1236103044811456662",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["Mecanico"] = {
		["Permission"] = {
			["Mecanico"] = true
		},
		["Hierarchy"] = { "Chefe","Mecânico","Borracheiro","Estagiário" },
		["Discord"] = "1236103044811456662",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Ballas"] = {
		["Permission"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080429965316127",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Vagos"] = {
		["Permission"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080465155657860",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Families"] = {
		["Permission"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080491814523022",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Marabunta"] = {
		["Permission"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080518507069500",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Bennys"] = {
		["Permission"] = {
			["Bennys"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080543908036638",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Aztecas"] = {
		["Permission"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080564049084438",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Bahamas"] = {
		["Permission"] = {
			["Bahamas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Armas01"] = {
		["Permission"] = {
			["Armas01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Armas02"] = {
		["Permission"] = {
			["Armas02"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Municao01"] = {
		["Permission"] = {
			["Municao01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Municao02"] = {
		["Permission"] = {
			["Municao02"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Drogas01"] = {
		["Permission"] = {
			["Drogas01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Drogas02"] = {
		["Permission"] = {
			["Drogas02"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Drogas03"] = {
		["Permission"] = {
			["Drogas03"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Drogas04"] = {
		["Permission"] = {
			["Drogas04"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Desmanche01"] = {
		["Permission"] = {
			["Desmanche01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Desmanche02"] = {
		["Permission"] = {
			["Desmanche02"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Roubos01"] = {
		["Permission"] = {
			["Roubos01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Lavagem01"] = {
		["Permission"] = {
			["Lavagem01"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Lavagem02"] = {
		["Permission"] = {
			["Lavagem02"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Discord"] = "1250080611851309107",
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Block"] = true,
		["Chat"] = true
	},
	["Restaurante"] = {
		["Permission"] = {
			["Restaurante"] = true
		},
		["Hierarchy"] = { "Chefe","Supervisor","Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 10,
		["Chat"] = true
	},
	["Ferro"] = {
		["Permission"] = {
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 12000 },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Bronze"] = {
		["Permission"] = {
			["Bronze"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 4000 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["Prata"] = {
		["Permission"] = {
			["Prata"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 8500 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["Ouro"] = {
		["Permission"] = {
			["Ouro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 14000 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["Platina"] = {
		["Permission"] = {
			["Platina"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 17000 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["Diamante"] = {
		["Permission"] = {
			["Diamante"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 20000 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["Esmeralda"] = {
		["Permission"] = {
			["Esmeralda"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 40000 },
		["Service"] = {},
		["Block"] = true,
		["Client"] = true,
		["Chat"] = false
	},
	["CustomSpawn"] = {
		["Permission"] = {
			["CustomSpawn"] = true,
			["Esmeralda"] = true,
			["Diamante"] = true,
			["Platina"] = true,
			["Ouro"] = true,
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Camera"] = {
		["Permission"] = {
			["Camera"] = true,
			["Esmeralda"] = true,
			["Diamante"] = true,
			["Platina"] = true,
			["Ouro"] = true,
			["Prata"] = true,
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Som"] = {
		["Permission"] = {
			["Som"] = true,
			["Esmeralda"] = true,
			["Diamante"] = true,
			["Platina"] = true,
			["Ouro"] = true,
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Attachs"] = {
		["Permission"] = {
			["Attachs"] = true,
			["Esmeralda"] = true,
			["Diamante"] = true,
			["Platina"] = true,
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Backpack"] = {
		["Permission"] = {
			["Backpack"] = true,
			["Esmeralda"] = true,
			["Diamante"] = true,
			["Platina"] = true,
			["Ouro"] = true,
			["Ferro"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Policia"] = {
		["Permission"] = {
			["PMERJ"] = true,
			["BOPE"] = true,
			["PCERJ"] = true,
			["PRF"] = true,
			["PF"] = true,
			["BPCHQ"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	},
	["Emergencia"] = {
		["Permission"] = {
			["PMERJ"] = true,
			["BOPE"] = true,
			["PCERJ"] = true,
			["PRF"] = true,
			["PF"] = true,
			["BPCHQ"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {},
		["Block"] = true,
		["Chat"] = false
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["cellphone"] = 1,
	["radio"] = 1,
	["hamburger"] = 4,
	["soda"] = 4
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Boxes = {
	["treasurebox"] = {
		["Multiplier"] = { ["Min"] = 1, ["Max"] = 1 },
		["List"] = {
			{ ["Item"] = "dollar", ["Chance"] = 100, ["Min"] = 4250, ["Max"] = 6250 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOPINIT
-----------------------------------------------------------------------------------------------------------------------------------------
SkinshopInit = {
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOPINIT
-----------------------------------------------------------------------------------------------------------------------------------------
BarbershopInit = {
	["mp_m_freemode_01"] = { 13,25,0,3,0,-1,-1,-1,-1,13,38,38,0,0,0,0,0.5,0,0,1,0,10,1,0,1,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	["mp_f_freemode_01"] = { 13,25,1,3,0,-1,-1,-1,-1,1,38,38,0,0,0,0,1,0,0,1,0,0,0,0,1,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
}