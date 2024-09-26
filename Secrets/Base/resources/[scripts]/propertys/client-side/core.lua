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
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Theft = nil
local Active = {}
local Hoverfy = {}
local Interior = ""
local Opened = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			if Init == "" then
				for Name,v in pairs(Propertys) do
					if #(Coords - v) <= 0.75 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							local Consult = vSERVER.Propertys(Name)

							if Consult then
								if Consult == "Nothing" then
									exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","inventory:PropertysRobbery",Name,false,true)

									for Line,v in pairs(Informations) do
										exports["dynamic"]:AddButton("Baú","Total de <yellow>"..v["Vault"].."Kg</yellow> no compartimento.","","",Line,false)
										exports["dynamic"]:AddButton("Geladeira","Total de <yellow>"..v["Fridge"].."Kg</yellow> no compartimento.","","",Line,false)
										exports["dynamic"]:AddButton("Credenciais","Máximo <yellow>1</yellow> proprietário e <yellow>3</yellow> adicionais.","","",Line,false)
										exports["dynamic"]:AddButton("Comprar com Dólares","Custo de <yellow>$"..Dotted(v["Price"]).."</yellow> dólares.","propertys:Buy",Name.."-"..Line.."-Dollar",Line,true)
										exports["dynamic"]:AddButton("Comprar com Diamantes","Custo de <yellow>"..Dotted(v["Gemstone"]).."</yellow> diamantes.","propertys:Buy",Name.."-"..Line.."-Gemstone",Line,true)
										exports["dynamic"]:SubMenu(Line,"Informações sobre o interior.",Line)
									end

									exports["dynamic"]:openMenu()
								else
									if Consult ~= "Hotel" then
										exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","inventory:PropertysRobbery",Name,false,true)
										exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
										exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
										exports["dynamic"]:AddButton("Cartões","Comprar um novo cartão de acesso.","propertys:Item",Name,false,true)
										exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)
										exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
										exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)
										exports["dynamic"]:AddButton("Transferência","Mudar proprietário.","propertys:Transfer",Name,false,true)
										exports["dynamic"]:AddButton("Hipoteca",Consult["Tax"],"","",false,false)

										Interior = Consult["Interior"]

										exports["dynamic"]:openMenu()
									else
										Interior = "Hotel"

										TriggerEvent("propertys:Enter",Name,false)
									end
								end
							end
						end
					end
				end
			else
				if Interiors[Interior] then
					SetPlayerBlipPositionThisFrame(Propertys[Init]["x"],Propertys[Init]["y"])

					if Coords["z"] < (Interiors[Interior]["Exit"]["z"] - 25.0) then
						SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
					end

					if Theft and Robbery[Interior]["Furniture"] then
						for Index,v in pairs(Robbery[Interior]["Furniture"]) do
							if not Active[Index] and #(Coords - v) <= 1.0 then
								TimeDistance = 1
								SetDrawOrigin(v["x"],v["y"],v["z"])
								DrawSprite("Targets","E",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
								ClearDrawOrigin()

								if IsControlJustPressed(1,38) and vSERVER.Robbery(Init,Index) then
									vRP.playAnim(false,{"amb@prop_human_bum_bin@base","base"},true)

									if exports["taskbar"]:Task(5,10000) then
										vSERVER.Paybbery(Init,Index)
										Active[Index] = true
									end

									vRP.Destroy()
								end
							end
						end

						if Theft < GetGameTimer() and GetEntitySpeed(Ped) > 2 then
							Theft = GetGameTimer() + 60000
							vSERVER.Police(Propertys[Init])
						end
					end

					for Line,v in pairs(Interiors[Interior]) do
						if #(Coords - v) <= 0.75 then
							TimeDistance = 1

							if Line == "Exit" and IsControlJustPressed(1,38) then
								SetEntityCoords(Ped,Propertys[Init],false,false,false,false)
								LocalPlayer["state"]:set("Propertys",false,false)
								vSERVER.Toggle(Init,"Exit")
								Interior = ""
								Active = {}
								Theft = nil
								Chest = ""
								Init = ""
							elseif not Theft and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) and vSERVER.Permission(Init) then
								vRP.playAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
								Opened = true
								Chest = Line

								TriggerEvent("inventory:Open",{
									Action = "Open",
									Type = "Chest",
									Resource = "propertys"
								})
							elseif not Theft and Line == "Clothes" and IsControlJustPressed(1,38) then
								ClothesMenu()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function ClothesMenu()
	exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","propertys:Clothes","save",false,true)
	exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","skinshop:Open","",false,false)
	exports["dynamic"]:SubMenu("Vestir","Abrir lista com todas as vestimentas.","apply")
	exports["dynamic"]:SubMenu("Remover","Abrir lista com todas as vestimentas.","delete")

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for _,v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v,"Vestir-se com as vestimentas.","propertys:Clothes","apply-"..v,"apply",true)
			exports["dynamic"]:AddButton(v,"Remover a vestimenta salva.","propertys:Clothes","delete-"..v,"delete",true)
		end
	end

	exports["dynamic"]:openMenu()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHESRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:ClothesReset")
AddEventHandler("propertys:ClothesReset",function()
	TriggerEvent("dynamic:Close")
	ClothesMenu()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter",function(Name,Thefting)
	if Thefting then
		Theft = GetGameTimer() + 10000
		Interior = Thefting
	else
		TriggerEvent("dynamic:Close")
		LocalPlayer["state"]:set("Propertys",true,false)

		if not Hoverfy[Name] and Interiors[Interior] then
			local Tables = {}
			Hoverfy[Name] = true

			for Index,v in pairs(Interiors[Interior]) do
				local Message = "Saída"

				if Index == "Vault" then
					Message = "Baú"
				elseif Index == "Fridge" then
					Message = "Geladeira"
				elseif Index == "Clothes" then
					Message = "Armário"
				end

				Tables[#Tables + 1] = { v,0.75,"E",Message,"Pressione para acessar" }
			end

			TriggerEvent("hoverfy:Insert",Tables)
		end
	end

	Init = Name
	local Ped = PlayerPedId()
	vSERVER.Toggle(Init,"Enter")
	SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Primary,Secondary,PrimaryWeight,SecondaryWeight = vSERVER.Mount(Init,Chest)
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
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["slot"],Data["amount"],Data["target"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Update(Data["slot"],Data["target"],Data["amount"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Name,v in pairs(Propertys) do
		Tables[#Tables + 1] = { v,0.75,"E","Propriedade","Pressione para acessar" }
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
				Blips[Name] = AddBlipForCoord(v["x"],v["y"],v["z"])
				SetBlipSprite(Blips[Name],374)
				SetBlipAsShortRange(Blips[Name],true)
				SetBlipColour(Blips[Name],GlobalState["Markers"][Name] and 35 or 43)
				SetBlipScale(Blips[Name],0.4)
			end
		end

		TriggerEvent("Notify","Propriedades","Marcações ativadas.","default",10000)
	end
end)