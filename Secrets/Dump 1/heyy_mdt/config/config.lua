config = {
	-- Cor primária do tema (r g b, exemplo: 255 255 255)
	-- Descomente a linha abaixo para substituir a cor padrão
	primaryColor = "135 206 235",

	-- Configurações relacionados à comandos
	commands = {
		-- Comando para abrir o tablet (ou false para nenhum)
		openTablet = "mdt",
		-- openTablet = false,
		-- Comando administrativo para retirar jogador da prisão
		releasePlayer = "rprender",
		-- Comando administrativo para verificar tempo de prisão de um jogador
		checkArrestTime = "checkprison",
	},

	-- Configurações relacionadas à permissões
	permissions = {
		-- Permissão para abrir o tablet (é possível inserir múltiplas permissões)
		openTablet = { "Policia" },
		-- Permissão para adicionar/remover porte de armas (é possível inserir múltiplas permissões)
		toggleGunLicense = { "Policia-1", "Policia-2", "Policia-3" },
		-- Permissão para adicionar/remover avisos do mural (é possível inserir múltiplas permissões)
		manageWarnings = { "Policia-1", "Policia-2", "Policia-3" },
		-- Permissão para verificar informações de outros policiais (é possível inserir múltiplas permissões)
		manageOfficers = { "Policia-1", "Policia-2", "Policia-3" },
		-- Permissão para limpar ficha de um jogador (é possível inserir múltiplas permissões)
		clearHistory = { "Policia-1", "Policia-2", "Policia-3" },
		-- Permissão administrativa para retirar jogador da prisão (é possível inserir múltiplas permissões)
		releasePlayer = { "Admin" },
		-- Permissão administrativa para verificar tempo de prisão de um jogador (é possível inserir múltiplas permissões)
		checkArrestTime = { "Admin" }
	},

	-- Configurações relacionados à prisão
	prison = {
		-- Qual ação será executada ao prender um jogador de forma duplicada
        onDuplicateArrest = "replace", -- "add" ou "replace" (o padrão é replace)

		-- Se será (ou não) executada a cutscene quando o jogador for preso
		cutsceneEnabled = true,
		-- Se será (ou não) executada a cutscene para o oficial que realizou a prisão (true = para o policial e prisoneiro | false = somente para o prisoneiro)
		cutsceneForOfficers = false,
		-- Se será (ou não) criado um clone do Ped do policial ao realizar a cutscene (pode causar ban em alguns anticheats, como MQCU)
		cutsceneCloneOfficer = false,

		-- Configurações relacionadas à placa utilizada na Cutscene
		mugShot = {
			-- Textos da placa
			plate = {
				title = "Departamento de Policia Connect Hype", -- Extremo topo da placa
				header = "~b~Servir e proteger", -- Abaixo do title
			},
			-- Coordenada em que o jogador ficará segurando a placa
			room = { x = 402.77, y = -996.62, z = -100.0, h = 180.0 },
			-- Coordenada da câmera nesse quarto
			camera = { 
				x = 402.77, y = -998.62, z = -98.55,
				rotX = 0.0, rotY = 0.0, rotZ = 0.0,
				fov = 27.0,
			},
		},

		-- Configurações relacionadas à cutscene do ônibus entrando na prisão
		prisonBus = {
			vehicleModel = "pbus", -- Modelo do ônibus
			driverModel = "s_m_m_prisguard_01", -- Modelo do motorista
			suspectSeat = 0, -- Assento em que o jogador ficará sentado
		},

		-- Entrada da prisão (onde o jogador será teleportado ao ser preso)
		entranceLocation = { x = 1775.61, y = 2551.97, z = 45.57, h = 93.88 },
		-- Saída da prisão (onde o jogador será teleportado ao ser solto)
		exitLocation = { x = 1845.99, y = 2585.8, z = 45.68, h = 282.04 },
		-- Local do blip de fuga (onde o jogador deverá ir para conseguir fugir da prisão)
		escapeBlip = { x = 1775.61, y = 2551.97, z = 45.57, h = 93.88 },

		-- Configurações relacionadas à fuga da prisão
		escapes = {
			-- Se será (ou não) bloqueado fugir da prisão sem um sistema de fuga (sair andando pra fora)
			blockIncorrectEscapes = false,
			-- Para quais locais o jogador poderá ser teleportado ao fugir da prisão (saídas)
			exitLocations = {
				{ x = 1845.99, y = 2585.8, z = 45.68, h = 282.04 },
				-- [...]
			},
			-- Pena que será adicionada ao jogador quando o mesmo tentar fugir da prisão de forma indevida (sair andando para fora)
			extraTime = 5,
			-- Se será (ou não) exibido o blip de fuga
			enabled = false,
			-- Se será (ou não) disparado o alarme da prisão quando um jogador fugir
			alarmEnabled = true,
			-- Item e quantidade necessária para fugir da prisão 
			requiredItem = {
				-- Se o item abaixo será (ou não) removido completamente do inventário do jogador quando ele for preso
				removeOnArrest = true,
				-- Item necessário
				item = "key",
				-- Quantidade necessária do item
				amount = 1,
			},
			-- Quantidade de tempo que ficará apitando para polícia a nova posição do jogador (em segundos)
			areaDuration = 120, 
			-- Tempo que será aguardado entre uma atualização de área de busca e outra (em segundos)
			areaUpdateTime = 20,
		},

		-- Configurações relacionadas à invasão da prisão
		invadeJail = {
			-- Se jogadores serão (ou não) presos se adentrarem o presídio sem estarem presos
			blockInvasion = false,
			-- Pena para os jogadores que serão presos ao adentrar o presídio
			arrestTime = 10,
		},

		-- Configurações relacionadas à agressões enquanto preso
		aggression = {
			-- Se agressões deverão (ou não) ser penalizadas (se o tempo de prisão do agressor deverá aumentar)
			penalize = true,
			-- Pena que será adicionada ao agressor quando o mesmo atacar outro jogador dentro da prisão
			extraTime = 2,
		},

		-- Configurações relacionadas à redução do tempo de prisão
		reduction = {
			-- Quantidade do valor da pena que será reduzida por trabalhar
			reductionPerWork = 2,
			-- Se a pena será (ou não) reduzida com o tempo, sem o jogador precisar fazer qualquer ação
			reduceByTime = true,
			-- Tempo para reduzir a pena se a opção acima estiver ativa
			reduceTime = 60,
			-- Quantidade do valor da pena que será retirado a cada período de segundos acima
			reductionPerTime = 4,
		},

		-- Configurações relacionadas aos serviços prisionais
		jobs = {
			cleaner = {
				name = "Limpador", -- Nome do trabalho
				distance = 3, -- Distância para conseguir apertar E
				blipTime = 8, -- Tempo para cada tarefa (em segundos)
				-- Função que será executada após apertar E no blip
				anim = function()
					Functions.createObjects("amb@world_human_janitor@male@idle_a", "idle_a", "prop_tool_broom", 49, 28422)
				end,
				-- Função que será utilizada após aguardar blipTime
				animCancel = function()
					Functions.removeObjects()
				end,
				-- Se as localizações serão aleatórias ou se seguirão a ordem das coordenadas abaixo 
				randomLocations = true,
				-- Coordenada de cada blip
				locations = {
					{ x = 1677.72, y = 2502.09, z = 45.57 },
					{ x = 1654.09, y = 2537.97, z = 45.57 },
					{ x = 1662.44, y = 2565.42, z = 45.57 },
					{ x = 1635.12, y = 2538.21, z = 45.57 },
					{ x = 1635.2, y = 2503.33, z = 45.57 },
					{ x = 1693.29, y = 2482.89, z = 45.57 },
					{ x = 1668.11, y = 2529.15, z = 45.57 },
					{ x = 1724.68, y = 2546.14, z = 45.57 },
					{ x = 1766.2, y = 2550.36, z = 45.57 },
					{ x = 1724.68, y = 2517.52, z = 45.56 },
				},
			},
			-- [...]
		}
	},

	-- Configurações relacionadas à roupa dos prisoneiros
	prisonerPresets = {
		-- Se as roupas deverão (ou não) ser trocadas após o jogador ser preso
		changeClothes = false,

		[`mp_m_freemode_01`] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 191, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 552, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 4, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		[`mp_f_freemode_01`] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 238, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 789, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 3, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
		-- [...]
	},

	-- Configurações relacionadas aos avatares/imagens
	avatar = {
		-- Imagem padrão caso o avatar do usuário não exista
		defaultImage = "https://ionicframework.com/docs/demos/api/avatar/avatar.svg",
		-- Imagem padrão caso a imagem do veículo não exista
		defaultVehicleImage = "https://abbotsfordchrysler.com/wp-content/uploads/2020/03/car-placeholder.jpg",
		-- URL base que será utilizado para as imagens dos veículos no tablet
		vehicleImagesURL = "http://IP/vehicles",
		-- URL do webhook que será utilizado para salvar as fotos
		photoWebhook = "https://discord.com/api/webhooks/1280656043545858169/IQtshaa4k9p38fAhy4YTHcGCQdyY_9MXaPG1YxZBEnm0jNPqPHs_mGL3-PlduGNb49nx"
	},

	-- Configurações gerais, que não se encaixam nas categorias acima
	extras = {
		-- Nome do departamento que será exibido na tela de login
		departmentName = "Departamento de Policia Connect Hype.",
		-- Configurações relacionadas ao tempo de vida de alguns dados
		lifespan = {
			-- Tempo máximo (em dias) que um aviso durará no mural
			warnings = 90,
			-- Tempo máximo (em dias) que um boletim de ocorrência durará na lista (estando arquivado ou não)
			incidents = 90,
		},

		-- Se deverá (ou não) ser exibido o campo de descrição na página de apreensão
		arrestDescriptionField = true,
		-- Se deverá (ou não) ser exibido o campo de descrição na página de multas
		fineDescriptionField = true,

		-- Se o botão de contratar oficial deverá (ou não) ser exibido na página de gerenciamento de oficiais
		disableAddButton = false,

		-- Avançado - Não mexa se não souber o que você está fazendo!
		-- Se quiser desabilitar, exclua ou comente as linhas abaixo
		customLicenses = {
			-- driver = {
			-- 	title = "Carteira de Motorista",
			-- 	actionName = "Alternar status",
			-- 	confirmationMessage = {
			-- 		"Deseja criar uma carteira de motorista para <b>{name}</b>?",
			-- 		"Você tem certeza que deseja invalidar a carteira de motorista de <b>{name}</b>?"
			-- 	},
			-- 	successMessage = {
			-- 		"A carteira de motorista de <b>{name}</b> foi criada com sucesso!",
			-- 		"A carteira de motorista de <b>{name}</b> foi invalidada com sucesso!"
			-- 	},
			-- 	-- O botão de realizar ação será exibido quando a função abaixo retornar TRUE
			-- 	buttonCondition = function(value)
			-- 		-- Neste caso, o botão só será exibido caso o usuário tenha a carteira de motorista.
			-- 		-- Ou seja, seria um botão para revogar.
			-- 		return value
			-- 	end,

			-- 	-- Função para pegar o status
			-- 	-- Functions.getDriverLicense(userID)
			-- 	-- Função ao clicar no botão
			-- 	-- Functions.updateDriverLicense(userID)
			-- 	-- Webhook ao clicar no botão
			-- 	-- Webhooks.onUpdateDriverLicense(userID, officerID)
            -- },

			-- hunt = {
			-- 	title = "Licença de Caça",
			-- 	actionName = "Alterar o status da licença de caça",
			-- 	confirmationMessage = {
			-- 		"Deseja criar uma licença de caça para <b>{name}</b>?",
			-- 		"Você tem certeza que deseja invalidar a licença de caça de <b>{name}</b>?"
			-- 	},
			-- 	successMessage = {
			-- 		"A licença de caça de <b>{name}</b> foi criada com sucesso!",
			-- 		"A licença de caça de <b>{name}</b> foi invalidada com sucesso!"
			-- 	},
			-- 	-- O botão de realizar ação será exibido quando a função abaixo retornar TRUE
			-- 	buttonCondition = function(value)
			-- 		-- Nesse caso, o botão sempre será exibido.
			-- 		-- Ou seja, seria um botão para adicionar/revogar esta licença
			-- 		return true
			-- 	end,

			-- 	-- Função para pegar o status
			-- 	-- Functions.getHuntLicense(userID)
			-- 	-- Função ao clicar no botão
			-- 	-- Functions.updateHuntLicense(userID)
			-- 	-- Webhook ao clicar no botão
			-- 	-- Webhooks.onUpdateHuntLicense(userID, officerID)
			-- }
			-- [...]
		},
	}
}
