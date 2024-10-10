-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
vINVENTORY = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dynamic = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local HashAnimal = nil
local SpawnAnimal = false
local FollowAnimal = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local Services = {
	{
		["Permission"] = "Policia",
		["Coords"] = vec3(442.67, -981.89, 30.68),
		["Distance"] = 2.0
	}, {
		["Permission"] = "Paramedico",
		["Coords"] = vec3(311.48, -594.09, 43.29),
		["Distance"] = 2.0
	}, {
		["Permission"] = "Mecanico",
		["Coords"] = vec3(724.15, -1071.79, 23.12),
		["Distance"] = 2.0
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,param,parent_id,server,back)
	SendNUIMessage({ Action = "AddButton", Payload = { title,description,trigger,param,parent_id,server,back } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddMenu",function(title,description,id,parent_id)
	SendNUIMessage({ Action = "AddMenu", Payload = { title,description,id,parent_id } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:AddButton")
AddEventHandler("dynamic:AddButton",function(title,description,trigger,param,parent_id,server,back)
	SendNUIMessage({ Action = "AddButton", Payload = { title,description,trigger,param,parent_id,server,back } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ADDMENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:AddMenu")
AddEventHandler("dynamic:AddMenu",function(title,description,id,parent_id)
	SendNUIMessage({ Action = "AddMenu", Payload = { title,description,id,parent_id } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Open",function()
	SendNUIMessage({ Action = "Open" })
	TriggerEvent("hud:Active",false)
	SetNuiFocus(true,true)
	Dynamic = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Clicked",function(Data,Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] then
			TriggerServerEvent(Data["trigger"],Data["param"])
		else
			TriggerEvent(Data["trigger"],Data["param"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("hud:Active",true)
	SetNuiFocus(false,false)
	Dynamic = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:Close")
AddEventHandler("dynamic:Close",function()
	if Dynamic then
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)
		Dynamic = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("PlayerFunctions",function()
	local Ped = PlayerPedId()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic and not IsPauseMenuActive() and GetEntityHealth(Ped) > 100 then
		if HashAnimal ~= nil then
			exports["dynamic"]:AddMenu("Domésticos", "Tudo sobre animais domésticos.", "animals")
			exports["dynamic"]:AddButton("Seguir", "Seguir o proprietário.", "dynamic:animalFunctions", "follow", "animals", false)
			exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar o animal no veículo.", "dynamic:animalFunctions", "putvehicle", "animals", false)
			exports["dynamic"]:AddButton("Remover do Veículo", "Remover o animal no veículo.", "dynamic:animalFunctions", "removevehicle", "animals", false)
		end

		if LocalPlayer["state"]["Premium"] then
			exports["dynamic"]:AddMenu("Armário Premium", "Colocar/Retirar roupas.", "warpremium")
			exports["dynamic"]:AddButton("Vestir", "Vestir-se com as vestimentas guardadas.", "player:Outfit", "aplicarpre", "warpremium", true)
			exports["dynamic"]:AddButton("Guardar", "Salvar suas vestimentas do corpo.", "player:Outfit", "salvarpre", "warpremium", true)
		end

		exports["dynamic"]:AddMenu("Armário", "Colocar/Retirar roupas.", "wardrobe")
		exports["dynamic"]:AddButton("Vestir", "Vestir-se com as vestimentas guardadas.", "player:Outfit", "aplicar", "wardrobe", true)
		exports["dynamic"]:AddButton("Guardar", "Salvar suas vestimentas do corpo.", "player:Outfit", "salvar", "wardrobe", true)

		exports["dynamic"]:AddMenu("Roupas", "Colocar/Retirar roupas.", "clothes")
		exports["dynamic"]:AddButton("Chapéu", "Colocar/Retirar o chapéu.", "player:Outfit", "Hat", "clothes", true)
		exports["dynamic"]:AddButton("Máscara", "Colocar/Retirar a máscara.", "player:Outfit", "Mask", "clothes", true)
		exports["dynamic"]:AddButton("Óculos", "Colocar/Retirar o óculos.", "player:Outfit", "Glasses", "clothes", true)
		exports["dynamic"]:AddButton("Camisa", "Colocar/Retirar a camisa.", "player:Outfit", "Shirt", "clothes", true)
		exports["dynamic"]:AddButton("Jaqueta", "Colocar/Retirar a jaqueta.", "player:Outfit", "Torso", "clothes", true)
		exports["dynamic"]:AddButton("Luvas", "Colocar/Retirar as luvas.", "player:Outfit", "Arms", "clothes", true)
		exports["dynamic"]:AddButton("Colete", "Colocar/Retirar o colete.", "player:Outfit", "Vest", "clothes", true)
		exports["dynamic"]:AddButton("Calça", "Colocar/Retirar a calça.", "player:Outfit", "Pants", "clothes", true)
		exports["dynamic"]:AddButton("Sapatos", "Colocar/Retirar o sapato.", "player:Outfit", "Shoes", "clothes", true)
		exports["dynamic"]:AddButton("Acessórios", "Colocar/Retirar os acessórios.", "player:Outfit", "Accessory", "clothes", true)

		local Vehicle = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			if not IsPedInAnyVehicle(Ped) then
				if vRP.ClosestPed(3) then
					exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "closestpeds")
					exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "closestpeds", true)
					exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "closestpeds", true)
				end
			else
				exports["dynamic"]:AddMenu("Veículo", "Funções do veículo.", "vehicle")
				exports["dynamic"]:AddButton("Sentar no Motorista", "Sentar no banco do motorista.", "player:seatPlayer", "0", "vehicle", false)
				exports["dynamic"]:AddButton("Sentar no Passageiro", "Sentar no banco do passageiro.", "player:seatPlayer", "1", "vehicle", false)
				exports["dynamic"]:AddButton("Sentar em Outros", "Sentar no banco do passageiro.", "player:seatPlayer", "2", "vehicle", false)
				exports["dynamic"]:AddButton("Mexer nos Vidros", "Levantar/Abaixar os vidros.", "player:Windows", "", "vehicle", false)
			end

			exports["dynamic"]:AddMenu("Portas", "Portas do veículo.", "doors")
			exports["dynamic"]:AddButton("Porta do Motorista", "Abrir porta do motorista.", "player:Doors", "1", "doors", true)
			exports["dynamic"]:AddButton("Porta do Passageiro", "Abrir porta do passageiro.", "player:Doors", "2", "doors", true)
			exports["dynamic"]:AddButton("Porta Traseira Esquerda", "Abrir porta traseira esquerda.", "player:Doors", "3", "doors", true)
			exports["dynamic"]:AddButton("Porta Traseira Direita", "Abrir porta traseira direita.", "player:Doors", "4", "doors", true)
			exports["dynamic"]:AddButton("Porta-Malas", "Abrir porta-malas.", "player:Doors", "5", "doors", true)
			exports["dynamic"]:AddButton("Capô", "Abrir capô.", "player:Doors", "6", "doors", true)
		end

		if MumbleIsConnected() then
			exports["dynamic"]:AddMenu("Experiência", "Todas as suas habilidades.", "Experience")
			local Experience = vSERVER.Experience()
			for Name,Exp in pairs(Experience) do
				exports["dynamic"]:AddButton(Name, "Você possuí <rare>"..Exp.." pontos</rare> no nível <rare>"..ClassCategory(Exp).."</rare>.", "", "", "Experience", false)
			end

			exports["dynamic"]:AddMenu("Estatísticas", "Estatísticas do seu personagem.", "Stats")
			local Stats = vSERVER.PedStats()
			for Name,Points in pairs(Stats) do
				exports["dynamic"]:AddButton(Name, "Você possuí um total de <rare>"..Points.." "..Name.."</rare>.", "", "", "Stats", false)
			end
		end

		exports["dynamic"]:AddMenu("Outros", "Todas as funções do personagem.", "others")
		exports["dynamic"]:AddButton("Estatísticas da Cidade", "Tudo sobre nossa cidade.", "admin:Dynamic", "stats", "others", true)
		exports["dynamic"]:AddButton("Rebocar", "Colocar/Remover o veículo na prancha.", "inventory:InvokeTow", "", "others", false)
		exports["dynamic"]:AddButton("Propriedades", "Marcar/Desmarcar propriedades no mapa.", "propertys:Blips", "", "others", false)
		exports["dynamic"]:AddButton("Armazéns", "Marcar/Desmarcar armazéns no mapa.", "warehouse:Blips", "", "others", false)
		exports["dynamic"]:AddButton("Ferimentos", "Verificar ferimentos no corpo.", "paramedic:Injuries", "", "others", false)
		exports["dynamic"]:AddButton("Desbugar", "Recarregar o personagem.", "player:Debug", "", "others", true)

		exports["dynamic"]:Open()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("EmergencyFunctions",function()
	if not IsPauseMenuActive() and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic then
		local Ped = PlayerPedId()
		local Health = GetEntityHealth(Ped)

		if LocalPlayer["state"]["Policia"] then
			exports["dynamic"]:AddButton("Serviço", "Finalizar expediente de trabalho.", "dynamic:Service", "Policia", false, true)

			exports["dynamic"]:AddButton("Companheiros", "Verifique seus companheiros em serviço.", "admin:Dynamic", "statsPolicia", false, true)

			exports["dynamic"]:AddMenu("Emergência", "Avisos emergenciais.", "tencode")
			exports["dynamic"]:AddButton("10-13", "Oficial desmaiado/ferido.", "dynamic:Tencode", "13", "tencode", true)
			exports["dynamic"]:AddButton("10-20", "Localização.", "dynamic:Tencode", "20", "tencode", true)
			exports["dynamic"]:AddButton("10-38", "Abordagem de trânsito.", "dynamic:Tencode", "38", "tencode", true)
			exports["dynamic"]:AddButton("10-78", "Apoio com prioridade.", "dynamic:Tencode", "78", "tencode", true)

			if Health > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "player")
				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)

				exports["dynamic"]:AddMenu("Fardamentos", "Todos os fardamentos policiais.", "prePolice")
				exports["dynamic"]:AddButton("Sheriff", "Fardamento de oficial.", "player:Preset", "1", "prePolice", true)
				exports["dynamic"]:AddButton("Los Santos Police", "Fardamento de oficial.", "player:Preset", "2", "prePolice", true)
				exports["dynamic"]:AddButton("State Police", "Fardamento de oficial.", "player:Preset", "3", "prePolice", true)
				exports["dynamic"]:AddButton("Park Ranger", "Fardamento de oficial.", "player:Preset", "4", "prePolice", true)

				exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Open", "", false, false)
			end

			exports["dynamic"]:Open()
		elseif LocalPlayer["state"]["Paramedico"] then
			if Health > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Serviço", "Finalizar expediente de trabalho.", "dynamic:Service", "Paramedico", false, true)

				exports["dynamic"]:AddButton("Companheiros", "Verifique seus companheiros em serviço.", "admin:Dynamic", "statsParamedico", false, true)

				exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "player")
				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)

				exports["dynamic"]:AddMenu("Fardamentos", "Todos os fardamentos médicos.", "preMedic")
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de doutor.", "player:Preset", "5", "preMedic", true)
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de paramédico.", "player:Preset", "6", "preMedic", true)
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de paramédico interno.", "player:Preset", "7", "preMedic", true)

				exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "paramedic:Open", "", false, false)

				exports["dynamic"]:Open()
			end
		else
			local Coords = GetEntityCoords(Ped)
			for Permission,v in pairs(Services) do
				if #(Coords - v["Coords"]) <= v["Distance"] then
					exports["dynamic"]:AddButton("Serviço", "Iniciar expediente de trabalho.", "dynamic:Service", v["Permission"], false, true)
					exports["dynamic"]:Open()

					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("AdminFunctions", function()
	if LocalPlayer["state"]["Admin"] and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not Dynamic and not LocalPlayer["state"]["Bennys"] and MumbleIsConnected() then
			if GlobalState["Commands"] then
				TriggerEvent("Notify", "default", "O menu <b>Insert</b> está desativado pois os comandos via <b>Chat</b> estão habilitados.", false, 10000)
			else
				exports["dynamic"]:AddMenu("Gerênciamento", "Clique para mais informações.", "admin")
				exports["dynamic"]:AddButton("God", "Deixar o ID com tudo 100%.", "admin:Dynamic", "god", "admin", true)
				exports["dynamic"]:AddButton("GodAll", "Deixar Todos com tudo 100%.", "admin:Dynamic", "godall", "admin", true)
				exports["dynamic"]:AddButton("Armour", "Deixar o ID com tudo Colete 100%.", "admin:Dynamic", "armour", "admin", true)
				exports["dynamic"]:AddButton("Commands", "Ativar/Desativar os Comandos por Chat.", "admin:Dynamic", "commands", "admin", true)
				exports["dynamic"]:AddButton("Whitelist", "Editar Whitelist de um ID.", "admin:Dynamic", "wl", "admin", true)
				exports["dynamic"]:AddButton("Announce", "Enviar anúncio para todos.", "admin:Dynamic", "announce", "admin", true)
				exports["dynamic"]:AddButton("Chat Announce", "Enviar anúncio no chat para todos.", "admin:Dynamic", "chatannounce", "admin", true)
				exports["dynamic"]:AddButton("Rename", "Renomeie algum ID.", "admin:Dynamic", "rename", "admin", true)
				exports["dynamic"]:AddButton("Kick", "Expuldar o ID.", "admin:Dynamic", "kick", "admin", true)
				exports["dynamic"]:AddButton("Ban", "Banir o ID.", "admin:Dynamic", "ban", "admin", true)
				exports["dynamic"]:AddButton("Unban", "Desbanir o ID.", "admin:Dynamic", "unban", "admin", true)
				exports["dynamic"]:AddButton("Changework", "Mudar o emprego do ID.", "admin:Dynamic", "changework", "admin", true)
				exports["dynamic"]:AddButton("Changemode", "Limpar histórico criminal do ID.", "admin:Dynamic", "changemode", "admin", true)
				exports["dynamic"]:AddButton("Clearprison", "Limpar prisão do ID.", "admin:Dynamic", "clearprison", "admin", true)

				exports["dynamic"]:AddMenu("Clima", "Clique para mais informações.", "weather")
				exports["dynamic"]:AddButton("Timeset", "Mudar a Hora do jogo.", "admin:Dynamic", "timeset", "weather", true)
				exports["dynamic"]:AddButton("Temperatureset", "Mudar a Temperatura do jogo.", "admin:Dynamic", "temperatureset", "weather", true)

				exports["dynamic"]:AddMenu("Grupos", "Clique para mais informações.", "groups")
				exports["dynamic"]:AddButton("Ugroups", "Veja quais grupos do ID.", "admin:Dynamic", "ugroups", "groups", true)
				exports["dynamic"]:AddButton("Group", "Dar um grupo para o ID.", "admin:Dynamic", "group", "groups", true)
				exports["dynamic"]:AddButton("Ungroup", "Remover o grupo de um ID.", "admin:Dynamic", "ungroup", "groups", true)

				exports["dynamic"]:AddMenu("Personagens", "Clique para mais informações.", "peds")
				exports["dynamic"]:AddButton("Skin", "Mude a Skin do ID.", "admin:Dynamic", "skin", "peds", true)
				exports["dynamic"]:AddButton("Resetskin", "Resete a Skin do ID.", "admin:Dynamic", "resetskin", "peds", true)
				exports["dynamic"]:AddButton("Delete", "Delete a conta do ID.", "admin:Dynamic", "delete", "peds", true)

				exports["dynamic"]:AddMenu("Veículos", "Clique para mais informações.", "vehicles")
				exports["dynamic"]:AddButton("Tuning", "Tunar o veículo atual.", "admin:Dynamic", "tuning", "vehicles", true)
				exports["dynamic"]:AddButton("Fix", "Arrumar o veículo atual.", "admin:Dynamic", "fix", "vehicles", true)
				exports["dynamic"]:AddButton("Lockpick", "Desbloqueia o veículo atual.", "admin:Dynamic", "lockpick", "vehicles", true)
				exports["dynamic"]:AddButton("Fuel", "Defina a Gasolina no veículo atual.", "admin:Dynamic", "fuel", "vehicles", true)
				exports["dynamic"]:AddButton("Hash", "Pegar a Hash do veículo atual.", "admin:Dynamic", "hash", "vehicles", true)
				exports["dynamic"]:AddButton("Setcar", "Envie um veículo para o ID.", "admin:Dynamic", "setcar", "vehicles", true)
				exports["dynamic"]:AddButton("Remcar", "Remove um veículo do ID.", "admin:Dynamic", "remcar", "vehicles", true)
				exports["dynamic"]:AddButton("Changelicense", "Atualize o status da CNH do ID.", "admin:Dynamic", "driverlicense", "vehicles", true)

				exports["dynamic"]:AddMenu("Financeiros", "Clique para mais informações.", "wallet")
				exports["dynamic"]:AddButton("Setbank", "Dar dinheiro para o ID.", "admin:Dynamic", "setbank", "wallet", true)
				exports["dynamic"]:AddButton("Rembank", "Remover dinheiro do ID.", "admin:Dynamic", "rembank", "wallet", true)
				exports["dynamic"]:AddButton(""..ItemName("gemstone").."s.", "Inserir "..ItemName("gemstone").."s no ID.", "admin:Dynamic", "gem", "wallet", true)

				exports["dynamic"]:AddMenu("Itens", "Clique para mais informações.", "item")
				exports["dynamic"]:AddButton("Clearinv", "Limpe o inventário do ID.", "admin:Dynamic", "clearinv", "item", true)
				exports["dynamic"]:AddButton("Item", "Pegar Itens para você.", "admin:Dynamic", "item", "item", true)
				exports["dynamic"]:AddButton("Item2", "Dar Itens para o ID.", "admin:Dynamic", "item2", "item", true)
				exports["dynamic"]:AddButton("Itemall", "Dar Itens para todos conectados.", "admin:Dynamic", "itemall", "item", true)

				exports["dynamic"]:AddMenu("Básicos", "Clique para mais informações.", "basic")
				exports["dynamic"]:AddButton("Nc", "Ativar/Desativar o NoClip.", "admin:Dynamic", "nc", "basic", true)
				exports["dynamic"]:AddButton("Debug", "Ativar/Desativar o modo Desenvolvedor.", "admin:Dynamic", "debug", "basic", true)
				exports["dynamic"]:AddButton("Blips", "Ativar/Desativar os Blips.", "admin:Dynamic", "blips", "basic", true)
				exports["dynamic"]:AddButton("Cds", "Pegue sua coordenada atual.", "admin:Dynamic", "cds", "basic", true)
				exports["dynamic"]:AddButton("Tpcds", "Teletransporte para uma coordenada.", "admin:Dynamic", "tpcds", "basic", true)
				exports["dynamic"]:AddButton("Tptome", "Teletransporte um ID para você.", "admin:Dynamic", "tptome", "basic", true)
				exports["dynamic"]:AddButton("Tpto", "Teletransporte para um ID.", "admin:Dynamic", "tpto", "basic", true)
				exports["dynamic"]:AddButton("Tpway", "Teletransporte para uma marcação no GPS.", "admin:Dynamic", "tpway", "basic", true)
				exports["dynamic"]:AddButton("Limparea", "Limpar a área próxima a você.", "admin:Dynamic", "limparea", "basic", true)
				exports["dynamic"]:AddButton("Players", "Verifique quantos onlines existem.", "admin:Dynamic", "players", "basic", true)
				exports["dynamic"]:AddButton("PlayersConnected", "Verifique os players onlines.", "admin:Dynamic", "playersconnected", "basic", true)

				exports["dynamic"]:AddMenu("Divertidos", "Clique para mais informações.", "fun")
				exports["dynamic"]:AddButton("Magneto", "Ativar/Desativar o efeito Magneto.", "admin:Dynamic", "magneto", "fun", true)
				exports["dynamic"]:AddButton("Flash", "Ativar/Desativar o efeito Flash.", "admin:Dynamic", "flash", "fun", true)
				exports["dynamic"]:AddButton("VehicleSpeed", "Mude a velocidade do veículo.", "admin:Dynamic", "vehiclespeed", "fun", true)
				exports["dynamic"]:AddButton("TyreBurst", "Exploda o pneu do veículo do ID.", "admin:Dynamic", "tyreburst", "fun", true)
				exports["dynamic"]:AddButton("CreateLightning", "Crie diversos raios pela cidade.", "admin:Dynamic", "createlightning", "fun", true)

				exports["dynamic"]:Open()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalSpawn")
AddEventHandler("dynamic:animalSpawn", function(Model)
	if HashAnimal == nil then
		if not SpawnAnimal then
			SpawnAnimal = true

			local Ped = PlayerPedId()
			local Heading = GetEntityHeading(Ped)
			local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.0, 1.0, 0.0)
			local Object, Network = vRPS.CreatePed(Model, Coords["x"], Coords["y"], Coords["z"], Heading, 28)
			if Object then
				local SpawnAnimal = 0

				HashAnimal = LoadNetwork(Network)
				while not DoesEntityExist(HashAnimal) and SpawnAnimal <= 1000 do
					HashAnimal = LoadNetwork(Network)
					SpawnAnimal = SpawnAnimal + 1
					Wait(1)
				end

				SpawnAnimal = 0
				local PedControl = NetworkRequestControlOfEntity(HashAnimal)
				while not PedControl and SpawnAnimal <= 1000 do
					PedControl = NetworkRequestControlOfEntity(HashAnimal)
					SpawnAnimal = SpawnAnimal + 1
					Wait(1)
				end

				SetPedCanRagdoll(HashAnimal, false)
				SetEntityInvincible(HashAnimal, true)
				SetPedFleeAttributes(HashAnimal, 0, 0)
				SetEntityAsMissionEntity(HashAnimal, true, false)
				SetBlockingOfNonTemporaryEvents(HashAnimal, true)
				SetPedRelationshipGroupHash(HashAnimal, GetHashKey("k9"))
				GiveWeaponToPed(HashAnimal, GetHashKey("WEAPON_ANIMAL"), 200, true, true)

				SetEntityAsNoLongerNeeded(HashAnimal)

				TriggerEvent("dynamic:animalFunctions", "follow")

				vSERVER.RegisterAnimal(Network)
			end

			SpawnAnimal = false
		end
	else
		vSERVER.ClearAnimal()
		FollowAnimal = false
		HashAnimal = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalFunctions")
AddEventHandler("dynamic:animalFunctions", function(Functions)
	if HashAnimal ~= nil then
		local Ped = PlayerPedId()
		if Functions == "follow" then
			if not FollowAnimal then
				TaskFollowToOffsetOfEntity(HashAnimal, Ped, 1.0, 1.0, 0.0, 5.0, -1, 2.5, 1)
				SetPedKeepTask(HashAnimal, true)
				FollowAnimal = true
			else
				SetPedKeepTask(HashAnimal, false)
				ClearPedTasks(HashAnimal)
				FollowAnimal = false
			end
		elseif Functions == "putvehicle" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if IsVehicleSeatFree(Vehicle, 0) then
					TaskEnterVehicle(HashAnimal, Vehicle, -1, 0, 2.0, 16, 0)
				end
			end
		elseif Functions == "removevehicle" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				TaskLeaveVehicle(HashAnimal, GetVehiclePedIsUsing(Ped), 256)
				TriggerEvent("dynamic:animalFunctions", "follow")
			end
		elseif Functions == "destroy" then
			vSERVER.ClearAnimal()
			FollowAnimal = false
			HashAnimal = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("PlayerFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("EmergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
RegisterKeyMapping("AdminFunctions","Abrir menu de administração.","keyboard","INSERT")