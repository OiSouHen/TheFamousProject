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
Tunnel.bindInterface("hud",Hensa)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Display = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Hood = false
local Pause = false
local Road = "Alta Street"
local Crossing = "Alta Street"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = 999
local Armour = 999
local Staminas = 999
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local Thirst = 999
local ThirstTimer = 0
local ThirstAmount = 90000
local ThirstDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local Hunger = 999
local HungerTimer = 0
local HungerAmount = 90000
local HungerDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
local Stress = 999
local StressTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUGH
-----------------------------------------------------------------------------------------------------------------------------------------
local Cough = 999
local CoughTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = 0
local WantedMax = 0
local WantedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
local Reposed = 0
local ReposedMax = 0
local ReposedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCK
-----------------------------------------------------------------------------------------------------------------------------------------
local Luck = 0
local LuckTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEXTERITY
-----------------------------------------------------------------------------------------------------------------------------------------
local Dexterity = 0
local DexterityTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
local Mask = nil
local Tank = nil
local Oxigen = 100
local OxigenTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if LocalPlayer["state"]["Active"] then
            local Pid = PlayerId()
            local Ped = PlayerPedId()

            if IsPauseMenuActive() then
                if not Pause and Display then
                    SendNUIMessage({ Action = "Body", Status = false })
                    Pause = true
                end
            else
                if Display then
                    if Pause then
                        SendNUIMessage({ Action = "Body", Status = true })
                        Pause = false
                    end

                    local Coords = GetEntityCoords(Ped)
                    local Armouring = GetPedArmour(Ped)
                    local Healing = GetEntityHealth(Ped) - 100
					local Stamina = 100 - GetPlayerSprintStaminaRemaining(Pid)
                    local MinRoad, MinCross = GetStreetNameAtCoord(Coords["x"], Coords["y"], Coords["z"])
                    local FullRoad = GetStreetNameFromHashKey(MinRoad)
                    local FullCross = GetStreetNameFromHashKey(MinCross)

                    if Health ~= Healing then
                        if Healing < 0 then
                            Healing = 0
                        end

                        SendNUIMessage({ Action = "Health", Number = Healing })
                        Health = Healing
                    end

                    if Staminas ~= Stamina then
                        SendNUIMessage({ Action = "Staminas", Number = Stamina })
                        Staminas = Stamina
                    end

                    if Armour ~= Armouring then
                        SendNUIMessage({ Action = "Armour", Number = Armouring })
                        Armour = Armouring
                    end

                    if FullRoad ~= "" and Road ~= FullRoad then
                        SendNUIMessage({ Action = "Road", Name = FullRoad })
                        Road = FullRoad
                    end

                    if FullCross ~= "" and Crossing ~= FullCross then
                        SendNUIMessage({ Action = "Crossing", Name = FullCross })
                        Crossing = FullCross
                    end

                    SendNUIMessage({ Action = "Clock", Hours = GlobalState["Hours"], Minutes = GlobalState["Minutes"] })

                    local location = LocalPlayer["state"]["Location"]
                    if location == "South" or location == "North" then
                        local weather = location == "South" and GlobalState["WeatherS"] or GlobalState["WeatherN"]
                        local temperature = location == "South" and GlobalState["TemperatureS"] or GlobalState["TemperatureN"]
                        SendNUIMessage({ Action = "Weather", Weather = ClassWeather(weather) })
                        SendNUIMessage({ Action = "Temperature", Temperature = temperature })
                    end
                end
            end

            if Luck > 0 and LuckTimer <= GetGameTimer() then
				Luck = Luck - 1
				LuckTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Luck", Number = Luck })
			end

			if Dexterity > 0 and DexterityTimer <= GetGameTimer() then
				Dexterity = Dexterity - 1
				DexterityTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Dexterity", Number = Dexterity })
			end

			if Wanted > 0 and WantedTimer <= GetGameTimer() then
				Wanted = Wanted - 1
				WantedTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Wanted", Number = Wanted })
			end

			if Reposed > 0 and ReposedTimer <= GetGameTimer() then
				Reposed = Reposed - 1
				ReposedTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Reposed", Number = Reposed })
			end

            if GetEntityHealth(Ped) > 100 then
				if Hunger < 15 and HungerTimer <= GetGameTimer() then
					HungerTimer = GetGameTimer() + 10000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "fome", "Sofrendo com a <b>Fome</b>.", "Fome", 2500)
				end

				if Thirst < 15 and ThirstTimer <= GetGameTimer() then
					ThirstTimer = GetGameTimer() + 10000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "sede", "Sofrendo com a <b>Sede</b>.", "Sede", 2500)
				end

				if Stress >= 40 and StressTimer <= GetGameTimer() then
					StressTimer = GetGameTimer() + 10000
					TriggerEvent("Notify", "roxo", "Sofrendo com o <b>Estresse</b>.", "Estresse", 2500)

					AnimpostfxPlay("MenuMGIn")
					SetTimeout(1500, function()
						AnimpostfxStop("MenuMGIn")
					end)
				end

				if Cough >= 20 and CoughTimer <= GetGameTimer() then
					CoughTimer = GetGameTimer() + 30000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "amarelo", "Sofrendo com a <b>Tosse</b>.", "Tosse", 2500)

					vRP.PlayAnim(true, { "timetable@gardener@smoking_joint", "idle_cough" }, true)
					SetTimeout(4000, function()
						vRP.Destroy("one")
						vSERVER.GetCough(math.random(3, 6))
					end)
				end
			end
        end

        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Safezone", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SendNUIMessage({ name = "Safezone", payload = Value })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voip",function(Number)
	local Target = { "Baixo","Normal","Médio","Alto","Megafone" }

	SendNUIMessage({ Action = "Voip", Voip = Target[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voice",function(Status)
	SendNUIMessage({ Action = "Voice", Status = Status and "#6fa9dc" or "#ccc" })
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
exports("Wanted", function()
	return Wanted > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Reposed")
AddEventHandler("hud:Reposed",function(Seconds)
	Reposed = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed",function()
	return Reposed > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Active",function(Status)
	SendNUIMessage({ Action = "Body", Status = Status })
	Display = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
	Display = not Display
	SendNUIMessage({ Action = "Body", Status = Display })

	if not Display then
		if IsMinimapRendering() then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
	SendNUIMessage({ Action = "Progress", Message = Message, Timer = Timer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLECONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected",function()
	SendNUIMessage({ Action = "Voip", Voip = "Online" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLEDISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected",function()
	SendNUIMessage({ Action = "Voip", Voip = "Offline" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number)
	if Thirst ~= Number then
		SendNUIMessage({ Action = "Thirst", Number = Number })
		Thirst = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(Number)
	if Hunger ~= Number then
		SendNUIMessage({ Action = "Hunger", Number = Number })
		Hunger = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(Number)
	if Stress ~= Number then
		SendNUIMessage({ Action = "Stress", Number = Number })
		Stress = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:COUGH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Cough")
AddEventHandler("hud:Cough", function(Number)
	if Cough ~= Number then
		SendNUIMessage({ Action = "Cough", Number = Number })
		Cough = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Oxigen")
AddEventHandler("hud:Oxigen", function(Number)
	if Oxigen ~= Number then
		SendNUIMessage({ Action = "Oxigen", Number = Number })
		Oxigen = Number
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
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Radio",function(Frequency)
	if type(Frequency) == "number" then
		SendNUIMessage({ Action = "Frequency", Frequency = Frequency.."Mhz" })
	else
		SendNUIMessage({ Action = "Frequency", Frequency = Frequency })
	end
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
		DoScreenFadeIn(0)
		Hood = false
	else
		DoScreenFadeOut(0)
		Hood = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SCUBAREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:ScubaRemove")
AddEventHandler("hud:ScubaRemove",function()
	if DoesEntityExist(Mask) then
		TriggerServerEvent("DeleteObject",ObjToNet(Mask))
		Mask = nil
	end

	if DoesEntityExist(Tank) then
		TriggerServerEvent("DeleteObject",ObjToNet(Tank))
		Tank = nil
	end

	SetEnableScuba(PlayerPedId(),false)
	SetPedMaxTimeUnderwater(PlayerPedId(),10.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Scuba")
AddEventHandler("hud:Scuba",function()
	if Mask or Tank then
		TriggerEvent("hud:ScubaRemove")
	else
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		local Progression,Network = vRPS.CreateObject("p_s_scuba_tank_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			Tank = LoadNetwork(Network)
			AttachEntityToEntity(Tank,Ped,GetPedBoneIndex(Ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
			SetModelAsNoLongerNeeded("p_s_scuba_tank_s")
		end

		local Progression,Network = vRPS.CreateObject("p_s_scuba_mask_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			Mask = LoadNetwork(Network)
			AttachEntityToEntity(Mask,Ped,GetPedBoneIndex(Ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
			SetModelAsNoLongerNeeded("p_s_scuba_tank_s")
		end

		SetEnableScuba(Ped,true)
		SetPedMaxTimeUnderwater(Ped,2000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMASK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			if Mask ~= nil then
				if GetGameTimer() >= OxigenTimers then
					OxigenTimers = GetGameTimer() + 30000

					Oxigen = Oxigen - 1
					vSERVER.Oxigen(1)
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADWARZONES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if LocalPlayer["state"]["Active"] and GetGameTimer() >= OxigenTimers then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            for _, zoneData in ipairs(WarZonesList) do
                local zoneCenter = vec3(zoneData[1], zoneData[2], zoneData[3])
                local distance = #(Coords - zoneCenter)
                if distance <= zoneData[4] then
                    OxigenTimers = GetGameTimer() + 30000

                    vSERVER.CheckHasZones()
                    Oxigen = Oxigen - 1
                    vSERVER.Oxigen(1)
                end
            end
        end
        Wait(1000)
    end
end)