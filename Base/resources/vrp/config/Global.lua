-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
CombatLogMinutes = 3 -- segundos para entrar em combatlog
SalarySeconds = 1800 -- tempo do salário
SpawnCoords = vec3(-1039.47,-2739.57,12.85) -- coordenada padrão de spawn ao criar um personagem
UnprisonCoords = vec3(1896.15,2604.44,45.75) -- coordenada padrão de saida da prisão
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTINGS
-----------------------------------------------------------------------------------------------------------------------------------------
BaseMode = "license" -- license ou steam
ServerName = "Hensa" -- nome do servidor
UsingLbPhone = false -- se você usa ou não o LB-Phone
UsableF7 = true -- mostrar id encima das cabeças
Whitelisted = true -- whitelist no servidor
ServerLink = "https://hensa.store" -- link de sua preferência
GiveIdentity = true -- dar o item identidade ao criar um personagem
ShakeVehicleCamera = true -- balançar a câmera do personagem quando bater o veículo
EntityLockdown = "inactive" -- strict / relaxed / inactive (use inactive para o LBPhone funcionar)
CanPushCars = false -- se você pode empurrar veículos presisonando a letra Q
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = false -- true para ativar a manutenção
MaintenanceLicenses = { -- licenses que podem entrar no servidor durante a manutenção
	["8d0038693c8d128014fb22709c06f122822d5bf1"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTS
-----------------------------------------------------------------------------------------------------------------------------------------
BannedText = "Banido" -- texto de banimento
ReleaseText = "Efetue sua liberação enviando o seu número de whitelist" -- texto de liberação da whitelist
UnprisonText = "Você ganhou a liberdade da <b>Prisão</b>." -- texto de quando a prisão de alguém é limpa
MaintenanceText = "Servidor em manutenção" -- texto de quando o servidor está em manutenção
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
Currency = "R$"
DefaultMoneyOne = "dollar"
DefaultMoneyTwo = "dirtydollar"
DefaultMoneyThree = "wetdollar"
DefaultMoneySpecial = "gemstone"
-----------------------------------------------------------------------------------------------------------------------------------------
-- BACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
WipeBackpackDeath = false -- limpar inventário ao morrer
CleanNormalInventory = true -- limpar inventário ao dar /gg
ClearPremiumInventory = true -- limpar inventário de premiums ao dar /gg
DefaultBackpackPremium = 30 -- peso padrão do inventário Premium
DefaultBackpackNormal = 15 -- peso padrão do inventário
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER / THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
ConsumeHunger = 1 -- quantos % vai consumir da fome
ConsumeThirst = 1 -- quantos % vai consumir da sede
CooldownHungerThrist = 60000 -- tempo de desgaste
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
Theme = { -- configuração das cores do tema
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
-- CHARACTERITENS
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = { -- itens que são dados ao criar um personagem
	["cellphone"] = 1,
	["radio"] = 1,
	["hamburger"] = 4,
	["soda"] = 4
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupBlips = { -- serviços com blips em tempo real
	["Policia"] = true,
	["Mecanico"] = true,
	["Paramedico"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
ClientState = { -- playerstate das permissões
	["Admin"] = true,
	["Premium"] = true,
	["Policia"] = true,
	["Paramedico"] = true,
	["Mecanico"] = true,
	["Burgershot"] = true,
	["Ballas"] = true,
	["Vagos"] = true,
	["Families"] = true,
	["Aztecas"] = true,
	["Bloods"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LANG
-----------------------------------------------------------------------------------------------------------------------------------------
Lang = { -- configuração de idioma da fila
	["Join"] = "Entrando...",
	["Connecting"] = "Conectando...",
	["Position"] = "Você é o %d/%d da fila, aguarde sua conexão",
	["Error"] = "Conexão perdida."
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
Queue = { -- configuração da fila
	["List"] = {},
	["Players"] = {},
	["Counts"] = 0,
	["Connecting"] = {},
	["Threads"] = 0,
	["Max"] = 2048
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- F7
-----------------------------------------------------------------------------------------------------------------------------------------
UseF7 = { -- ids que podem usar o f7
	[1] = true
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