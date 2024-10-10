-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Display = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Hood = false
local Gemstone = 0
local Pause = false
local Road = "Roads"
local Crossing = "Crossing"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Armour = 0
local Health = 200
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local Thirst = 100
local ThirstTimer = 0
local ThirstAmount = 180000
local ThirstDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local Hunger = 100
local HungerTimer = 0
local HungerAmount = 180000
local HungerDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
local Stress = 0
local StressTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = 0
local WantedMax = 0
local WantedTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
local Repose = 0
local ReposeMax = 0
local ReposeTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCK
-----------------------------------------------------------------------------------------------------------------------------------------
local Luck = 0
local LuckTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEXTERITY
-----------------------------------------------------------------------------------------------------------------------------------------
local Dexterity = 0
local DexterityTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBOS
-----------------------------------------------------------------------------------------------------------------------------------------
local Roubos = false
RegisterCommand("esconderroubos",function()
	if Roubos then
		Roubos = false
		SendNUIMessage({ name = "Robberies", payload = false })
	elseif GlobalState["Roubos"] then
		Roubos = true
		SendNUIMessage({ name = "Robberies", payload = { true,GlobalState["Roubos"] } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Roubos",nil,function(Name,Key,Value)
	if Value then
		SendNUIMessage({ name = "Robberies", payload = { true,Value } })

		if not Roubos then
			Roubos = true
		end
	else
		SendNUIMessage({ name = "Robberies", payload = false })

		if Roubos then
			Roubos = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUPOM
-----------------------------------------------------------------------------------------------------------------------------------------
local Cupom = false
RegisterCommand("escondercupom",function()
	if Cupom then
		Cupom = false
		SendNUIMessage({ name = "Coupon", payload = false })
	elseif GlobalState["Cupom"] then
		Cupom = true
		SendNUIMessage({ name = "Coupon", payload = { true,GlobalState["Cupom"][1],GlobalState["Cupom"][2],GlobalState["Cupom"][3] } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Cupom",nil,function(Name,Key,Value)
	if Value then
		SendNUIMessage({ name = "Coupon", payload = { true,Value[1],Value[2],Value[3] } })

		if not Cupom then
			Cupom = true
		end
	else
		SendNUIMessage({ name = "Coupon", payload = false })

		if Cupom then
			Cupom = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function()
	if GlobalState["Cupom"] then
		SendNUIMessage({ name = "Coupon", payload = { true,GlobalState["Cupom"][1],GlobalState["Cupom"][2],GlobalState["Cupom"][3] } })
		Cupom = true
	end

	if GlobalState["Roubos"] then
		SendNUIMessage({ name = "Robberies", payload = { true,GlobalState["Roubos"] } })
		Roubos = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadMovement("move_m@injured")

	while true do
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()

			if IsPauseMenuActive() then
				if not Pause and Display then
					Pause = true
					SendNUIMessage({ name = "Body", payload = false })
				end
			else
				if Display then
					if Pause then
						SendNUIMessage({ name = "Body", payload = true })
						Pause = false
					end

					local Coords = GetEntityCoords(Ped)
					local Armouring = GetPedArmour(Ped)
					local Healing = GetEntityHealth(Ped) - 100
					local MinRoad,MinCross = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
					local FullRoad = GetStreetNameFromHashKey(MinRoad)
					local FullCross = GetStreetNameFromHashKey(MinCross)

					if GetEntityMaxHealth(Ped) ~= 200 then
						if Health ~= parseInt(Healing * 0.66) then
							Healing = parseInt(Healing * 0.66)

							if Healing > 100 then
								Healing = 100
							end

							SendNUIMessage({ name = "Health", payload = Healing })
							Health = Healing
						end
					else
						if Healing > 100 then
							SetEntityHealth(Ped,200)
							Healing = 100
						end

						if Health ~= Healing then
							SendNUIMessage({ name = "Health", payload = Healing })
							Health = Healing
						end

						if not IsPedSwimming(Ped) then
							if Healing <= 30 and GetPedMovementClipset(Ped) ~= -650503762 then
								LocalPlayer["state"]:set("Walk",false,false)
								SetPedMovementClipset(Ped,"move_m@injured",0.5)
							elseif Healing > 30 and GetPedMovementClipset(Ped) == -650503762 then
								LocalPlayer["state"]:set("Walk",false,false)
							end
						end
					end

					if Armour ~= Armouring then
						SendNUIMessage({ name = "Armour", payload = Armouring })
						Armour = Armouring
					end

					if FullRoad ~= "" and Road ~= FullRoad then
						SendNUIMessage({ name = "Road", payload = FullRoad })
						Road = FullRoad
					end

					if FullCross ~= "" and Crossing ~= FullCross then
						SendNUIMessage({ name = "Crossing", payload = FullCross })
						Crossing = FullCross
					end

					SendNUIMessage({ name = "Clock", payload = { GlobalState["Hours"],GlobalState["Minutes"] } })
				end
			end

			if Luck > 0 and LuckTimer <= GetGameTimer() then
				Luck = Luck - 1
				LuckTimer = GetGameTimer() + 1000

				SendNUIMessage({ name = "Luck", payload = Luck })
			end

			if Dexterity > 0 and DexterityTimer <= GetGameTimer() then
				Dexterity = Dexterity - 1
				DexterityTimer = GetGameTimer() + 1000

				SendNUIMessage({ name = "Dexterity", payload = Dexterity })
			end

			if Wanted > 0 and WantedTimer <= GetGameTimer() then
				Wanted = Wanted - 1
				WantedTimer = GetGameTimer() + 1000

				SendNUIMessage({ name = "Wanted", payload = { Wanted,WantedMax } })
			end

			if Repose > 0 and ReposeTimer <= GetGameTimer() then
				Repose = Repose - 1
				ReposeTimer = GetGameTimer() + 1000

				SendNUIMessage({ name = "Repose", payload = { Repose,ReposeMax } })
			end

			if GetEntityHealth(Ped) > 100 then
				if Hunger <= 10 and HungerTimer <= GetGameTimer() then
					ApplyDamageToPed(Ped,1,false)
					HungerTimer = GetGameTimer() + 60000
					TriggerEvent("Notify","Alimentação","Sofrendo com a <b>fome</b>.","fome",2500)
				end

				if Thirst <= 10 and ThirstTimer <= GetGameTimer() then
					ApplyDamageToPed(Ped,1,false)
					ThirstTimer = GetGameTimer() + 60000
					TriggerEvent("Notify","Hidratação","Sofrendo com a <b>sede</b>.","sede",2500)
				end

				if Stress ~= 999 and Stress >= 50 and StressTimer <= GetGameTimer() then
					AnimpostfxPlay("MenuMGIn")
					SetTimeout(1000,function()
						AnimpostfxStop("MenuMGIn")
					end)

					StressTimer = GetGameTimer() + 30000
				end

				if Hunger > 0 and HungerDelay <= GetGameTimer() then
					Hunger = Hunger - 1
					vRPS.DowngradeHunger()
					HungerDelay = GetGameTimer() + HungerAmount

					SendNUIMessage({ name = "Hunger", payload = Hunger })
				end

				if Thirst > 0 and ThirstDelay <= GetGameTimer() then
					Thirst = Thirst - 1
					vRPS.DowngradeThirst()
					ThirstDelay = GetGameTimer() + ThirstAmount

					SendNUIMessage({ name = "Thirst", payload = Thirst })
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYVELOCITY
-----------------------------------------------------------------------------------------------------------------------------------------
function EntityVelocity(Ped)
	local Velocity = GetEntityVelocity(Ped)

	return math.min(math.sqrt(Velocity["x"] * Velocity["x"] + Velocity["y"] * Velocity["y"] + Velocity["z"] * Velocity["z"]),10)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Passport",("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
	SendNUIMessage({ name = "Passport", payload = Dotted(Value) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Players",nil,function(Name,Key,Value)
	SendNUIMessage({ name = "Players", payload = Dotted(Value) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voip",function(Number)
	local Target = { "BAIXO","NORMAL","MÉDIO","ALTO" }

	SendNUIMessage({ name = "Voip", payload = Target[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voice",function(Status)
	SendNUIMessage({ name = "Voice", payload = Status })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Wanted")
AddEventHandler("hud:Wanted",function(Seconds)
	WantedMax = Seconds
	Wanted = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function()
	return Wanted > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Safezone",("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
	SendNUIMessage({ name = "Safezone", payload = Value })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Repose")
AddEventHandler("hud:Repose",function(Seconds)
	ReposeMax = Seconds
	Repose = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Repose",function()
	return Repose > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Active",function(Status)
	SendNUIMessage({ name = "Body", payload = Status })
	Display = Status

	if not Display and IsMinimapRendering() then
		DisplayRadar(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
	Display = not Display
	SendNUIMessage({ name = "Body", payload = Display })

	if not Display and IsMinimapRendering() then
		DisplayRadar(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
	SendNUIMessage({ name = "Progress", payload = { "Progresso",Message,Timer } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number)
	if Thirst ~= Number then
		SendNUIMessage({ name = "Thirst", payload = Number })
		Thirst = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(Number)
	if Hunger ~= Number then
		SendNUIMessage({ name = "Hunger", payload = Number })
		Hunger = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(Number)
	if Stress ~= Number then
		SendNUIMessage({ name = "Stress", payload = Number })
		Stress = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:LUCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Luck")
AddEventHandler("hud:Luck",function(Seconds)
	Luck = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:DEXTERITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Dexterity")
AddEventHandler("hud:Dexterity",function(Seconds)
	Dexterity = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ADDGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:AddGemstone")
AddEventHandler("hud:AddGemstone",function(Number)
	Gemstone = Gemstone + Number

	SendNUIMessage({ name = "Gemstone", payload = Dotted(Gemstone) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveGemstone")
AddEventHandler("hud:RemoveGemstone",function(Number)
	Gemstone = Gemstone - Number

	if Gemstone < 0 then
		Gemstone = 0
	end

	SendNUIMessage({ name = "Gemstone", payload = Dotted(Gemstone) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Radio",function(Frequency)
	SendNUIMessage({ name = "Frequency", payload = Frequency })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Health",function()
	Health = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Hunger",function(Value)
	HungerAmount = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Thirst",function(Value)
	ThirstAmount = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hood")
AddEventHandler("hud:Hood",function()
	if Hood then
		DoScreenFadeIn(2500)
		Hood = false
	else
		DoScreenFadeOut(0)
		Hood = true
	end
end)