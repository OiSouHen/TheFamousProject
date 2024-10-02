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
Hensa = {}
Tunnel.bindInterface("propertys",Hensa)
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Amounts = 1
local Theft = nil
local Hoverfy = {}
local Interior = ""
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
									for Line,v in pairs(Informations) do
										exports["dynamic"]:AddButton("Baú","Total de <rare>"..v["Vault"].."Kg</rare> no compartimento.","","",Line,false)
										exports["dynamic"]:AddButton("Geladeira","Total de <rare>"..v["Fridge"].."Kg</rare> no compartimento.","","",Line,false)
										exports["dynamic"]:AddButton("Credenciais","Máximo <rare>1</rare> proprietário e <rare>3</rare> moradores.","","",Line,false)
										exports["dynamic"]:AddButton("Comprar com Dólares","Custo de <rare>$"..Dotted(v["Price"]).."</rare> dólares.","propertys:Buy",Name.."-"..Line.."-Dollars",Line,true)
										exports["dynamic"]:AddButton("Comprar com Diamantes","Custo de <rare>"..Dotted(v["Gemstone"]).."</rare> diamantes.","propertys:Buy",Name.."-"..Line.."-Gemstone",Line,true)
										exports["dynamic"]:AddMenu(Line,"Informações sobre o interior.",Line)
									end
								else
									if Consult ~= "Hotel" then
										exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
										exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
										exports["dynamic"]:AddButton("Cartões","Comprar um novo cartão de acesso.","propertys:Item",Name,false,true)
										exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)
										exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
										exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)
										exports["dynamic"]:AddButton("Transferência","Mudar proprietário.","propertys:Transfer",Name,false,true)
										exports["dynamic"]:AddButton("Hipoteca",Consult["Tax"],"","",false,false)

										Interior = Consult["Interior"]
									else
										Interior = "Hotel"

										TriggerEvent("propertys:Enter",Name,false)
									end
								end

								exports["dynamic"]:Open()
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
							if #(Coords - v) <= 1.0 then
								TimeDistance = 1

								DrawText3D(v,"~g~E~w~  ROUBAR")

								if #(Coords - v) <= 0.75 and IsControlJustPressed(1,38) and vSERVER.Robbery(Init,Index) then
									vRP.PlayAnim(false,{"amb@prop_human_bum_bin@base","base"},true)

									if exports["taskbar"]:Task(5, 5500) then
										vSERVER.PaymentRobbery(Init,Index)
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
								Theft = nil
								Chest = ""
								Init = ""
							elseif not Theft and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) and vSERVER.Permission(Init) then
								vRP.PlayAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
								SendNUIMessage({ Action = "Open" })
								SetNuiFocus(true,true)
								Chest = Line
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
	exports["dynamic"]:AddMenu("Vestir","Abrir lista com todas as vestimentas.","apply")
	exports["dynamic"]:AddMenu("Remover","Abrir lista com todas as vestimentas.","delete")

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for _,v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v,"Vestir-se com as vestimentas.","propertys:Clothes","apply-"..v,"apply",true)
			exports["dynamic"]:AddButton(v,"Remover a vestimenta salva.","propertys:Clothes","delete-"..v,"delete",true)
		end
	end

	exports["dynamic"]:Open()
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
		LocalPlayer["state"]:set("Propertys",true,false)

		if not Hoverfy[Name] then
			local Tables = {}
			Hoverfy[Name] = true

			for _,Intern in pairs(Interiors) do
				for Index,v in pairs(Intern) do
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
			end

			TriggerEvent("hoverfy:Insert",Tables)
		end
	end

	Init = Name
	local Ped = PlayerPedId()
	vSERVER.Toggle(Init,"Enter")
	TriggerEvent("dynamic:Close")
	SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request",function(Data,Callback)
	local Inventory,Chest,InvPeso,InvMax,ChestPeso,ChestMax = vSERVER.Request(Init,Chest)
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, InvPeso = InvPeso, InvMax = InvMax, ChestPeso = ChestPeso, ChestMax = ChestMax })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
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
-- PROPERTYS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Update")
AddEventHandler("propertys:Update",function()
	SendNUIMessage({ Action = "Request" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Weight")
AddEventHandler("propertys:Weight",function(InvPeso,InvMax,ChestPeso,ChestMax)
	SendNUIMessage({ Action = "Weight", InvPeso = InvPeso, InvMax = InvMax, ChestPeso = ChestPeso, ChestMax = ChestMax })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

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

		TriggerEvent("Notify","amarelo","Marcações desativadas.","propriedades",5000)
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

		TriggerEvent("Notify","verde","Marcações ativadas.","propriedades",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"])

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 160 * 0.45
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = { "ig_abigail", "a_m_m_afriamer_01", "ig_mp_agent14", "csb_agent", "ig_amandatownley", "s_m_y_ammucity_01", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_m_armlieut_01", "ig_ashley", "s_m_m_autoshop_01", "ig_money", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "g_m_y_ballasout_01", "s_m_y_barman_01", "u_m_y_baygor", "a_m_o_beach_01", "ig_bestmen", "a_f_y_bevhills_01", "a_m_m_bevhills_02", "u_m_m_bikehire_01", "u_f_y_bikerchic", "mp_f_boatstaff_01", "s_m_m_bouncer_01", "ig_brad", "ig_bride", "u_m_y_burgerdrug_01", "a_m_m_business_01", "a_m_y_business_02", "s_m_o_busker_01", "ig_car3guy2", "cs_carbuyer", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "g_m_m_chigoon_02", "u_f_y_comjane", "ig_dale", "ig_davenorton", "s_m_y_dealer_01", "ig_denise", "ig_devin", "a_m_y_dhill_01", "ig_dom", "a_m_y_downtown_01", "ig_dreyfuss" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:PROPERPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Properpatch")
AddEventHandler("propertys:Properpatch", function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Heading = GetEntityHeading(Ped)

	for Number = 1, Amounts do
		local Cooldown = 0
		local OtherPeds = math.random(#Peds)
		local SpawnX = Coords["x"] + math.random(-20, 20)
		local SpawnY = Coords["y"] + math.random(-20, 20)
		local HitZ, GroundZ = GetGroundZFor_3dCoord(SpawnX, SpawnY, Coords["z"], true)
		local HitSafe, SafeCoords = GetSafeCoordForPed(SpawnX, SpawnY, GroundZ, false, 16)

		repeat
			Cooldown = Cooldown + 1
			SpawnX = Coords["x"] + math.random(-20, 20)
			SpawnY = Coords["y"] + math.random(-20, 20)
			HitZ, GroundZ = GetGroundZFor_3dCoord(SpawnX, SpawnY, Coords["z"], true)
			HitSafe, SafeCoords = GetSafeCoordForPed(SpawnX, SpawnY, GroundZ, false, 16)
		until (HitZ and HitSafe) or Cooldown >= 100

		if HitZ and HitSafe then
			local Application, Network = vRPS.CreatePed(Peds[OtherPeds], SafeCoords["x"], SafeCoords["y"], SafeCoords["z"], Heading, 28)
			if Application then
				SetTimeout(1000, function()
					local Entity = LoadNetwork(Network)
					if Entity then
						SetPedArmour(Entity, 100)
						SetPedAccuracy(Entity, 75)
						SetPedAlertness(Entity, 3)
						SetPedAsEnemy(Entity, true)
						SetPedMaxHealth(Entity, 500)
						SetEntityHealth(Entity, 500)
						SetPedKeepTask(Entity, true)
						SetPedCombatRange(Entity, 2)
						StopPedSpeaking(Entity, true)
						SetPedCombatMovement(Entity, 2)
						DisablePedPainAudio(Entity, true)
						SetPedPathAvoidFire(Entity, true)
						SetPedConfigFlag(Entity, 208, true)
						SetPedSeeingRange(Entity, 10000.0)
						SetPedCanEvasiveDive(Entity, false)
						SetPedHearingRange(Entity, 10000.0)
						SetPedDiesWhenInjured(Entity, false)
						SetPedPathCanUseLadders(Entity, true)
						SetPedFleeAttributes(Entity, 0, false)
						SetPedCombatAttributes(Entity, 46, true)
						SetPedFiringPattern(Entity, 0xC6EE6B4C)
						SetCanAttackFriendly(Entity, true, false)
						SetPedSuffersCriticalHits(Entity, false)
						SetPedPathCanUseClimbovers(Entity, true)
						SetPedDropsWeaponsWhenDead(Entity, false)
						SetPedEnableWeaponBlocking(Entity, false)
						SetPedPathCanDropFromHeight(Entity, false)
						RegisterHatedTargetsAroundPed(Entity, 100.0)
						GiveWeaponToPed(Entity, "WEAPON_PISTOL_MK2", -1, false, true)
						SetCurrentPedWeapon(Entity, "WEAPON_PISTOL_MK2", true)
						SetPedInfiniteAmmo(Entity, true, "WEAPON_PISTOL_MK2")
						SetPedRelationshipGroupHash(Entity, GetHashKey("HATES_PLAYER"))
						SetEntityCanBeDamagedByRelationshipGroup(Entity, false, "HATES_PLAYER")
						SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
						SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("HATES_PLAYER"))
						TaskCombatPed(Entity, Ped, 0, 16)

						SetTimeout(1000, function()
							TaskWanderInArea(Entity, SafeCoords["x"], SafeCoords["y"], SafeCoords["z"], 25.0, 0.0, 0.0)
							SetModelAsNoLongerNeeded(Peds[OtherPeds])
						end)
					end
				end)
			end
		end
	end
end)