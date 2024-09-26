-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("paramedic", Hensa)
vSERVER = Tunnel.getInterface("paramedic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Damaged = {}
local Bleeding = 0
local BloodTick = 0
local Hope = GetGameTimer()
local Warning = GetGameTimer()
local Injuried = GetGameTimer()
local BloodTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event ~= "CEventNetworkEntityDamage" then
		return
	end

	if PlayerPedId() == Message[1] then
		if (Message[7] == 126349499 or Message[7] == 1064738331 or Message[7] == 85055149) and GetEntityHealth(Message[1]) > 100 then
			SetPedToRagdoll(Message[1],2500,2500,0,0,0,0)
		else
			if GetGameTimer() >= Injuried then
				if not IsPedInAnyVehicle(Message[1]) and GetEntityHealth(Message[1]) > 100 then
					Injuried = GetGameTimer() + 1000

					local Hit,Mark = GetPedLastDamageBone(Message[1])
					if Hit and not Damaged[Mark] and Mark ~= 0 then
						TriggerServerEvent("evidence:Drop", "Yellow")
						Bleeding = Bleeding + 1
						Damaged[Mark] = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOODTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if GetGameTimer() >= BloodTimers and GetEntityHealth(Ped) > 100 then
			BloodTimers = GetGameTimer() + 10000
			BloodTick = BloodTick + 1

			if BloodTick >= 3 and Bleeding >= 3 then
				BloodTick = 0

				AnimpostfxPlay("MenuMGIn")
				SetTimeout(Bleeding * 750, function()
					AnimpostfxStop("MenuMGIn")
				end)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Open")
AddEventHandler("paramedic:Open", function()
	local Ped = PlayerPedId()
	if not IsPedSwimming(Ped) then
		if LocalPlayer["state"]["Paramedico"] then
			SendNUIMessage({ action = "openSystem" })
			TriggerEvent("dynamic:Close")
			SetNuiFocus(true, true)

			if not IsPedInAnyVehicle(Ped) then
				vRP.CreateObjects("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "prop_cs_tablet", 49, 28422, -0.05, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEPSICO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GivePsico", function(data)
	vSERVER.GivePsico(data["passaporte"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Announce", function(data)
	vSERVER.Announce(data["Title"], data["Seconds"], data["Text"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem", function()
	SetNuiFocus(false, false)
	SetCursorLocation(0.5, 0.5)
	SendNUIMessage({ action = "closeSystem" })
	vRP.Destroy("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Update")
AddEventHandler("paramedic:Update", function(action, data)
	SendNUIMessage({ action = action, data = data })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Reset")
AddEventHandler("paramedic:Reset", function()
	Damaged = {}
	Bleeding = 0
	BloodTick = 0
	Injuried = GetGameTimer()
	BloodTimers = GetGameTimer()
	ClearPedBloodDamage(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Bleeding()
	return Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Bandage()
	local Humanes = ""
	for Number, _ in pairs(Damaged) do
		TriggerEvent("Notify", "default", "Passou ataduras no(a) <b>" .. Bone(Number) .. "</b>.", false, 5000)
		TriggerEvent("sounds:Private", "bandage", 0.5)
		Bleeding = Bleeding - 1
		Humanes = Bone(Number)
		Damaged[Number] = nil
		BloodTick = 0
		break
	end

	if Bleeding <= 0 then
		ClearPedBloodDamage(PlayerPedId())
	end

	return Humanes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXYCONTIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Oxycontin()
	Damaged = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:INJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Injuries")
AddEventHandler("paramedic:Injuries", function()
	local Wounds = 0
	local Injuries = ""
	local Damages = false

	for Number, _ in pairs(Damaged) do
		if not Damages then
			Injuries = Injuries .. "<b>Danos Superficiais:</b><br>"
			Damages = true
		end

		Wounds = Wounds + 1
		Injuries = Injuries .. "<b>" .. Wounds .. "</b>: " .. Bone(Number) .. "<br>"
	end

	if Injuries == "" then
		TriggerEvent("Notify", "default", "Nenhum ferimento encontrado.", false, 5000)
	else
		TriggerEvent("Notify", "default", Injuries, "Seus ferimentos", 10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Diagnostic()
	return Damaged, Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Arms", function()
	if Damaged[18905] or Damaged[60309] or Damaged[36029] or Damaged[57005] or Damaged[28422] or Damaged[6286] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEGS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Legs", function()
	if Damaged[14201] or Damaged[65245] or Damaged[57717] or Damaged[52301] or Damaged[35502] or Damaged[24806] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local currentTime = GetGameTimer()

		if not IsPedInAnyVehicle(Ped) then
			local hasLegInjury = exports["paramedic"]:Legs()
			if hasLegInjury then
				TimeDistance = 1

				DisableControlAction(1, 22, true)

				if IsDisabledControlJustPressed(1, 22) and currentTime >= Warning then
					TriggerEvent("Notify", "default", "Você não consegue pular pois está com a <b>Perna</b> machucada.", false, 5000)
					Warning = currentTime + 5000
				end
			elseif currentTime <= Hope then
				TimeDistance = 1
				DisableControlAction(1, 22, true)
			else
				if IsPedJumping(Ped) then
					Hope = currentTime + 5000
				end
			end
		end

		Wait(TimeDistance)
	end
end)