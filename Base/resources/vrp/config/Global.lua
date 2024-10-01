-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE
-----------------------------------------------------------------------------------------------------------------------------------------
BaseMode = "license" -- license ou steam
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
UsingLbPhone = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTINGS
-----------------------------------------------------------------------------------------------------------------------------------------
UsableF7 = true                                                         -- mostrar id encima das cabeças
Whitelisted = true                                                      -- whitelist no servidor
CombatLogMinutes = 3                                                    -- segundos para entrar em combatlog
SalarySeconds = 1800                                                    -- tempo do salário
BannedText = "Banido"                                                   -- texto de banimento
CleanDeathInventory = true                                              -- limpar inventário ao dar /gg
ClearInventoryPremium = true                                            -- limpar inventário de premiums ao dar /gg
ServerName = "Hensa"                                                    -- nome do servidor
ReleaseText = "Efetue sua liberação enviando o seu número de whitelist" -- texto de liberação da whitelist
SpawnCoords = vec3(-28.08, -145.96, 56.99)                              -- coordenada padrão de spawn ao criar um personagem
SpawnPrison = vec3(1679.94, 2513.07, 45.56)                             -- coordenada padrão da prisão
BackPrison = vec3(1896.15, 2604.44, 45.75)                              -- coordenada padrão de saida da prisão
BikesBackpack = true                                                    -- receber peso na mochila andando de bicicleta
BackpackWeightPremiumDefault = 25                                       -- peso padrão do inventário Premium
BackpackWeightDefault = 30                                              -- peso padrão do inventário
WipeBackpackDeath = false                                               -- limpar inventário ao morrer
NewItemIdentity = true                                                  -- dar o item identidade ao criar um personagem
BurstTyresBySpeed = true                                                -- estourar pneus quando atingir grandes velocidades forçando o veículo
ShakeVehicleCamera = true                                               -- balançar a câmera do personagem quando bater o veículo
BlackoutTime = 600000                                                   -- tempo para o blackout acabar (600000 = 10 minutos)
BlackoutText = "Os serviços em nossa central foram reestabelecidos."    -- texto da notificação padrão para blackout desativado
EntityLockdown = "inactive"                                             -- strict / relaxed / inactive (use inactive para o LBPhone funcionar)
CanPushCars = false                                                     -- se você pode empurrar veículos presisonando a letra Q
FixedNpcsHasNoCollision = false                                         -- se os npcs fixos não possuem colisão
EnableManeuvers = true                                                  -- se é permitido manobras encima de motos pressionando as setas do teclado
SurvivalUsingAnim = true                                                -- se quando morre o ped fica com animação de morto
CleanPrisonNotify = "Você ganhou a liberdade da <b>Prisão</b>."         -- texto de quando a prisão de alguém é limpa
GiveVotesInServices = true                                              -- da o item voto impresso junto no pagamento em todos os empregos
Currency = "R$"
-----------------------------------------------------------------------------------------------------------------------------------------
-- HITMARKER
-----------------------------------------------------------------------------------------------------------------------------------------
HitMarker = true        -- mostrar danos em pessoas
ShowNPCDamages = true   -- mostrar danos em npcs
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
DefaultDollars1 = "dollars"   -- nome do item de dinheiro padrão da base
DefaultDollars2 = "dollars2"  -- nome do item de dinheiro sujo padrão da base
DefaultDollars3 = "dollars3"  -- nome do item de dinheiro falso padrão da base
DefaultSpecialMoney = "gemstone"   -- nome do item de dinheiro vip padrão da base
-----------------------------------------------------------------------------------------------------------------------------------------
-- MIRA
-----------------------------------------------------------------------------------------------------------------------------------------
DisableTargetMode = true                                                -- desativar mira com armamentos brancos
DefaultTargetMode = 0                                                   -- 0 = Full, 1 = Partial, 2 = Free Aim - Assisted, 3 = Free Aim
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJETOS
-----------------------------------------------------------------------------------------------------------------------------------------
ObjectsBlips = true                                                    -- ativar blips das caixas de loot
ObjectsBlipAlpha = 200                                                  -- opacidade do blip das caixas de loot
ObjectsBlipColour = 85                                                  -- cor do blip das caixas de loot
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPERATURA
-----------------------------------------------------------------------------------------------------------------------------------------
TemperatureHot = 22                                                     -- temperatura minima para ativar o efeito de calor
TemperatureCold = 18                                                    -- temperatura minima para ativar o efeito de frio
TemperatureEffect = true                                                -- efeitos causados por baixas ou altas temperaturas do clima
-----------------------------------------------------------------------------------------------------------------------------------------
-- F7
-----------------------------------------------------------------------------------------------------------------------------------------
UseF7 = { -- ids que podem usar o f7
	[1] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCES
-----------------------------------------------------------------------------------------------------------------------------------------
NewHensa = true        -- true se usa nossa barbershop, skinshop e tattooshop
NewInitial = true      -- true se você tiver o initial
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER / THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
ConsumeHunger = 1            -- quantos % vai consumir da fome
ConsumeThirst = 1            -- quantos % vai consumir da sede
CooldownHungerThrist = 60000 -- tempo de desgaste
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
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = false     -- true para ativar a manutenção
MaintenanceText = "Servidor em manutenção"
MaintenanceLicenses = { -- licenses que podem entrar na manutenção
	["8d0038693c8d128014fb22709c06f122822d5bf1"] = true
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