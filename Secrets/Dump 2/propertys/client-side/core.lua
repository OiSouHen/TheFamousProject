-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {}
local Interior = ""
local Inside = false
local Opened = false
local Policed = false
local Stealing = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			if not Inside then
				for Name,v in pairs(Propertys) do
					if #(Coords - v["Coords"]) <= 0.75 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							local Consult = vSERVER.Propertys(Name)

							if Consult then
								if Consult == "Nothing" then
									if not Propertys[Name]["Galpão"] then
										exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","propertys:Robbery",Name,false,true)
									end

									for Line,v in pairs(Informations) do
										if (Propertys[Name]["Galpão"] and Line == "Galpão") or (not Propertys[Name]["Galpão"] and Line ~= "Galpão") then
											exports["dynamic"]:AddMenu(Line,"Informações sobre o interior.",Line)

											if v["Vault"] then
												exports["dynamic"]:AddButton("Baú","Total de <yellow>"..v["Vault"].."Kg</yellow> no compartimento.","","",Line,false)
											end

											if v["Fridge"] then
												exports["dynamic"]:AddButton("Geladeira","Total de <yellow>"..v["Fridge"].."Kg</yellow> no compartimento.","","",Line,false)
											end

											exports["dynamic"]:AddButton("Credenciais","Máximo <yellow>1</yellow> proprietário e <yellow>3</yellow> adicionais.","","",Line,false)
											exports["dynamic"]:AddButton("Comprar com Dinheiro","Custo de <yellow>"..Currency..Dotted(v["Price"]).."</yellow>.","propertys:Buy",Name.."-"..Line.."-Dollar",Line,true)
											exports["dynamic"]:AddButton("Comprar com Diamantes","Custo de <yellow>"..Dotted(v["Gemstone"]).."</yellow>.","propertys:Buy",Name.."-"..Line.."-Gemstone",Line,true)
										end
									end

									exports["dynamic"]:Open()
								else
									if Consult ~= "Hotel" then
										exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
										exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
										exports["dynamic"]:AddButton("Cartões","Comprar um novo cartão de acesso.","propertys:Item",Name,false,true)
										exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)

										if not Propertys[Name]["Galpão"] then
											exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
										end

										exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)
										exports["dynamic"]:AddButton("Transferência","Mudar proprietário.","propertys:Transfer",Name,false,true)
										exports["dynamic"]:AddButton("Hipoteca",Consult["Tax"],"","",false,false)

										Interior = Consult["Interior"]
										exports["dynamic"]:Open()
									else
										Interior = "Hotel"

										TriggerEvent("propertys:Enter",Name,false)
									end
								end
							elseif not Propertys[Name]["Galpão"] and Name ~= "Hotel" then
								exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","propertys:Robbery",Name,false,true)
								exports["dynamic"]:Open()
							end
						end
					end
				end
			elseif Propertys[Inside] and Internal[Interior] then
				SetPlayerBlipPositionThisFrame(Propertys[Inside]["Coords"]["x"],Propertys[Inside]["Coords"]["y"])

				if Coords["z"] < (Internal[Interior]["Exit"]["z"] - 25.0) then
					SetEntityCoords(Ped,Internal[Interior]["Exit"],false,false,false,false)
				end

				if Internal[Interior]["Furniture"] and Policed and Policed <= GetGameTimer() and (GetPedMovementClipset(Ped) ~= -1155413492 or IsPedSprinting(Ped) or MumbleIsPlayerTalking(Pid)) then
					vSERVER.Police(Propertys[Inside]["Coords"],Coords)
					Policed = GetGameTimer() + 15000
				end

				for Line,v in pairs(Internal[Interior]) do
					if Line ~= "Furniture" and #(Coords - v) <= 1.0 then
						if Line == "Exit" and IsControlJustPressed(1,38) then
							if Stealing and Internal[Interior]["Furniture"] then
								for Index in pairs(Internal[Interior]["Furniture"]) do
									exports["target"]:RemCircleZone("Robberys:"..Index)
								end
							end

							SetEntityCoords(Ped,Propertys[Inside]["Coords"],false,false,false,false)
							vSERVER.Toggle(Inside,"Exit")
							Stealing = false
							Policed = false
							Inside = false
						elseif not Stealing and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) and vSERVER.Permission(Inside) then
							vRP.playAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
							Opened = Line

							TriggerEvent("inventory:Open",{
								Type = "Chest",
								Resource = "propertys"
							})
						elseif not Stealing and Line == "Clothes" and IsControlJustPressed(1,38) then
							ClothesMenu()
						end
					end
				end

				TimeDistance = 1
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function ClothesMenu()
	exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","skinshop:Open","",false,false)
	exports["dynamic"]:AddMenu("Armário","Abrir lista com todas as vestimentas.","wardrobe")
	exports["dynamic"]:AddButton("Guardar","Salvar vestimentas do corpo.","propertys:Clothes","Save","wardrobe",true)

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for Index,v in pairs(Clothes) do
			exports["dynamic"]:AddMenu(v,"Informações da vestimenta.",Index,"wardrobe")
			exports["dynamic"]:AddButton("Aplicar","Vestir-se com as vestimentas.","propertys:Clothes","Apply-"..v,Index,true)
			exports["dynamic"]:AddButton("Remover","Deletar a vestimenta do armário.","propertys:Clothes","Delete-"..v,Index,true,true)
		end
	end

	exports["dynamic"]:Open()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter",function(Name,Theft)
	if Theft then
		Stealing = true
		Interior = Theft
		Policed = GetGameTimer() + 15000
		TriggerEvent("player:Residual","Resquício de Línter")

		if Internal[Interior] and Internal[Interior]["Furniture"] then
			for Number,v in pairs(Internal[Interior]["Furniture"]) do
				exports["target"]:AddCircleZone("Robberys:"..Number,v,0.1,{
					name = "Robberys:"..Number,
					heading = 0.0,
					useZ = true
				},{
					shop = Number,
					Distance = 1.25,
					options = {
						{
							event = "propertys:RobberyItem",
							label = "Roubar",
							tunnel = "server",
							service = Name
						}
					}
				})
			end
		end
	end

	Inside = Name
	local Ped = PlayerPedId()
	TriggerEvent("dynamic:Close")
	vSERVER.Toggle(Inside,"Enter")
	SetEntityCoords(Ped,Internal[Interior]["Exit"],false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Primary,Secondary,PrimaryWeight,SecondaryWeight = vSERVER.Mount(Inside,Opened)
	if Primary then
		Callback({ Primary = Primary, Secondary = Secondary, PrimaryMaxWeight = PrimaryWeight, SecondaryMaxWeight = SecondaryWeight })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Opened then
		Opened = false
		vRP.Destroy()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:RemCircleZone")
AddEventHandler("propertys:RemCircleZone",function(Index)
	exports["target"]:RemCircleZone("Robberys:"..Index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["slot"],Data["amount"],Data["target"],Inside,Opened)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Inside,Opened)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Update(Data["slot"],Data["target"],Data["amount"],Inside,Opened)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Name,v in pairs(Propertys) do
		Tables[#Tables + 1] = { v["Coords"],0.75,"E","Pressione","para acessar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Blips")
AddEventHandler("propertys:Blips",function()
	if json.encode(Blips) ~= "[]" then
		for _,v in pairs(Blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		Blips = {}

		TriggerEvent("Notify","Propriedades","Marcações desativadas.","default",10000)
	else
		for Name,v in pairs(Propertys) do
			if Name ~= "Hotel" then
				Blips[Name] = AddBlipForCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])

				if v["Galpão"] then
					SetBlipSprite(Blips[Name],473)
				else
					SetBlipSprite(Blips[Name],374)
				end

				SetBlipScale(Blips[Name],0.5)
				SetBlipAsShortRange(Blips[Name],true)
				SetBlipColour(Blips[Name],GlobalState["Markers"][Name] and 35 or 43)
			end
		end

		TriggerEvent("Notify","Propriedades","Marcações ativadas.","default",10000)
	end
end)