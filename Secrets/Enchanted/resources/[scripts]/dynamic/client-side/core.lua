-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dynamic = false
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
		exports["dynamic"]:AddMenu("Armário","Abrir lista com todas as vestimentas.","wardrobe")
		exports["dynamic"]:AddButton("Guardar","Salvar vestimentas do corpo.","dynamic:Clothes","Save","wardrobe",true)

		local Clothes = vSERVER.Clothes()
		if parseInt(#Clothes) > 0 then
			for Index,v in pairs(Clothes) do
				exports["dynamic"]:AddMenu(v,"Informações da vestimenta.",Index,"wardrobe")
				exports["dynamic"]:AddButton("Aplicar","Vestir-se com as vestimentas.","dynamic:Clothes","Apply-"..v,Index,true)
				exports["dynamic"]:AddButton("Remover","Deletar a vestimenta do armário.","dynamic:Clothes","Delete-"..v,Index,true,true)
			end
		end

		exports["dynamic"]:AddMenu("Roupas","Colocar/Retirar roupas.","clothes")
		exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:Outfit","Hat","clothes",true)
		exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:Outfit","Mask","clothes",true)
		exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:Outfit","Glasses","clothes",true)
		exports["dynamic"]:AddButton("Camisa","Colocar/Retirar a camisa.","player:Outfit","Shirt","clothes",true)
		exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar a jaqueta.","player:Outfit","Torso","clothes",true)
		exports["dynamic"]:AddButton("Luvas","Colocar/Retirar as luvas.","player:Outfit","Arms","clothes",true)
		exports["dynamic"]:AddButton("Colete","Colocar/Retirar o colete.","player:Outfit","Vest","clothes",true)
		exports["dynamic"]:AddButton("Calça","Colocar/Retirar a calça.","player:Outfit","Pants","clothes",true)
		exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar o sapato.","player:Outfit","Shoes","clothes",true)
		exports["dynamic"]:AddButton("Acessórios","Colocar/Retirar os acessórios.","player:Outfit","Accessory","clothes",true)

		if vRP.ClosestVehicle(7) then
			if not IsPedInAnyVehicle(Ped) then
				if vRP.ClosestPed(3) then
					exports["dynamic"]:AddMenu("Jogador","Pessoa mais próxima de você.","closestpeds")
					exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","closestpeds",true)
					exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","closestpeds",true)
				end
			else
				exports["dynamic"]:AddMenu("Veículo","Funções do veículo.","vehicle")
				exports["dynamic"]:AddButton("Sentar no Motorista","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Sentar no Passageiro","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Sentar em Outros","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Mexer nos Vidros","Levantar/Abaixar os vidros.","player:Windows","","vehicle",false)
			end

			exports["dynamic"]:AddMenu("Portas","Portas do veículo.","doors")
			exports["dynamic"]:AddButton("Porta do Motorista","Abrir porta do motorista.","player:Doors","1","doors",true)
			exports["dynamic"]:AddButton("Porta do Passageiro","Abrir porta do passageiro.","player:Doors","2","doors",true)
			exports["dynamic"]:AddButton("Porta Traseira Esquerda","Abrir porta traseira esquerda.","player:Doors","3","doors",true)
			exports["dynamic"]:AddButton("Porta Traseira Direita","Abrir porta traseira direita.","player:Doors","4","doors",true)
			exports["dynamic"]:AddButton("Porta-Malas","Abrir porta-malas.","player:Doors","5","doors",true)
			exports["dynamic"]:AddButton("Capô","Abrir capô.","player:Doors","6","doors",true)
		end

		exports["dynamic"]:AddMenu("Outros","Todas as funções do personagem.","others")
		exports["dynamic"]:AddButton("Propriedades","Marcar/Desmarcar propriedades no mapa.","propertys:Blips","","others",false)
		exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:Injuries","","others",false)
		exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","player:Debug","","others",true)

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

		if CheckPolice() then
			exports["dynamic"]:AddButton("Placa","Verificar emplacamento.","prison:Plate","",false,true)
			exports["dynamic"]:AddButton("Prender","Adicionar ficha criminal.","prison:Create","",false,true)

			exports["dynamic"]:AddMenu("Emergência","Avisos emergenciais.","tencode")
			exports["dynamic"]:AddButton("10-13","Oficial desmaiado/ferido.","dynamic:Tencode","13","tencode",true)
			exports["dynamic"]:AddButton("10-20","Localização.","dynamic:Tencode","20","tencode",true)
			exports["dynamic"]:AddButton("10-38","Abordagem de trânsito.","dynamic:Tencode","38","tencode",true)
			exports["dynamic"]:AddButton("10-78","Apoio com prioridade.","dynamic:Tencode","78","tencode",true)

			if Health > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddMenu("Jogador","Pessoa mais próxima de você.","player")
				exports["dynamic"]:AddButton("Carregar","Carregar a pessoa mais próxima.","inventory:Carry","","player",true)
				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)
				exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:Remove","Hat","player",true)
				exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:Remove","Mask","player",true)
				exports["dynamic"]:AddButton("Remover Óculos","Remover da pessoa mais próxima.","skinshop:Remove","Glasses","player",true)

				exports["dynamic"]:AddMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
				exports["dynamic"]:AddButton("Principal","Fardamento de oficial.","player:Preset","1","prePolice",true)
			end

			exports["dynamic"]:Open()
		elseif LocalPlayer["state"]["Paramedico"] and Health > 100 and not IsPedInAnyVehicle(Ped) then
			exports["dynamic"]:AddMenu("Jogador","Pessoa mais próxima de você.","player")
			exports["dynamic"]:AddButton("Carregar","Carregar a pessoa mais próxima.","inventory:Carry","","player",true)
			exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
			exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)
			exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:Remove","Hat","player",true)
			exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:Remove","Mask","player",true)
			exports["dynamic"]:AddButton("Remover Óculos","Remover da pessoa mais próxima.","skinshop:Remove","Glasses","player",true)

			exports["dynamic"]:AddMenu("Fardamentos","Todos os fardamentos médicos.","preMedic")
			exports["dynamic"]:AddButton("Principal","Fardamento de oficial.","player:Preset","2","preMedic",true)

			exports["dynamic"]:Open()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("PlayerFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("EmergencyFunctions","Abrir menu de emergencial.","keyboard","F10")