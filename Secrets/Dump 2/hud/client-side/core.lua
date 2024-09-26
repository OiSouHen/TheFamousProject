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
					SendNUIMessage({ Action = "Body", Payload = false })
				end
			else
				if Display then
					if Pause then
						SendNUIMessage({ Action = "Body", Payload = true })
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

							SendNUIMessage({ Action = "Health", Payload = Healing })
							Health = Healing
						end
					else
						if Healing > 100 then
							SetEntityHealth(Ped,200)
							Healing = 100
						end

						if Health ~= Healing then
							SendNUIMessage({ Action = "Health", Payload = Healing })
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
						SendNUIMessage({ Action = "Armour", Payload = Armouring })
						Armour = Armouring
					end

					if FullRoad ~= "" and Road ~= FullRoad then
						SendNUIMessage({ Action = "Road", Payload = FullRoad })
						Road = FullRoad
					end

					if FullCross ~= "" and Crossing ~= FullCross then
						SendNUIMessage({ Action = "Crossing", Payload = FullCross })
						Crossing = FullCross
					end

					SendNUIMessage({ Action = "Clock", Payload = { GlobalState["Hours"],GlobalState["Minutes"] } })
				end
			end

			if Luck > 0 and LuckTimer <= GetGameTimer() then
				Luck = Luck - 1
				LuckTimer = GetGameTimer() + 1000

				SendNUIMessage({ Action = "Luck", Payload = Luck })
			end

			if Dexterity > 0 and DexterityTimer <= GetGameTimer() then
				Dexterity = Dexterity - 1
				DexterityTimer = GetGameTimer() + 1000

				SendNUIMessage({ Action = "Dexterity", Payload = Dexterity })
			end

			if Wanted > 0 and WantedTimer <= GetGameTimer() then
				Wanted = Wanted - 1
				WantedTimer = GetGameTimer() + 1000

				SendNUIMessage({ Action = "Wanted", Payload = { Wanted,WantedMax } })
			end

			if Repose > 0 and ReposeTimer <= GetGameTimer() then
				Repose = Repose - 1
				ReposeTimer = GetGameTimer() + 1000

				SendNUIMessage({ Action = "Repose", Payload = { Repose,ReposeMax } })
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

					SendNUIMessage({ Action = "Hunger", Payload = Hunger })
				end

				if Thirst > 0 and ThirstDelay <= GetGameTimer() then
					Thirst = Thirst - 1
					vRPS.DowngradeThirst()
					ThirstDelay = GetGameTimer() + ThirstAmount

					SendNUIMessage({ Action = "Thirst", Payload = Thirst })
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
	SendNUIMessage({ Action = "Passport", Payload = Dotted(Value) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Players",nil,function(Name,Key,Value)
	SendNUIMessage({ Action = "Players", Payload = Dotted(Value) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voip",function(Number)
	local Target = { "BAIXO","NORMAL","MÉDIO","ALTO" }

	SendNUIMessage({ Action = "Voip", Payload = Target[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voice",function(Status)
	SendNUIMessage({ Action = "Voice", Payload = Status })
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
	SendNUIMessage({ Action = "Body", Payload = Status })
	Display = Status

	if not Display and IsMinimapRendering() then
		DisplayRadar(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
	if exports["chat"]:Open() then
		Display = not Display
		SendNUIMessage({ Action = "Body", Payload = Display })

		if not Display and IsMinimapRendering() then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
	SendNUIMessage({ Action = "Progress", Payload = Timer - 300 })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number)
	if Thirst ~= Number then
		SendNUIMessage({ Action = "Thirst", Payload = Number })
		Thirst = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(Number)
	if Hunger ~= Number then
		SendNUIMessage({ Action = "Hunger", Payload = Number })
		Hunger = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(Number)
	if Stress ~= Number then
		SendNUIMessage({ Action = "Stress", Payload = Number })
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

	SendNUIMessage({ Action = "Gemstone", Payload = Dotted(Gemstone) })
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

	SendNUIMessage({ Action = "Gemstone", Payload = Dotted(Gemstone) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Radio",function(Frequency)
	SendNUIMessage({ Action = "Frequency", Payload = Frequency })
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