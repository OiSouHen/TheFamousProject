-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Range = false
local Accuracy = 800.0
local ConfigTimer = 10000
local ActiveAlarm = false
local ActiveExplosions = false
local Locate = vec3(1689.49, 2602.64, 45.56)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYINACCURACY
-----------------------------------------------------------------------------------------------------------------------------------------
local function ApplyInaccuracy(TargetCoords)
	local Offset = math.random(-Accuracy, Accuracy) / 100
	local XOffset = Offset
	local YOffset = Offset
	local ZOffset = Offset
	return vec3(TargetCoords["x"] + XOffset, TargetCoords["y"] + YOffset, TargetCoords["z"] + ZOffset)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(math.random(1, 2) * 1000)

		local Ped = PlayerPedId()
		local Distance = #(GetEntityCoords(Ped) - Locate)
		if Distance < 300 and GetEntityHeightAboveGround(Ped) > 5.0 and IsPedInFlyingVehicle(Ped) and not (LocalPlayer["state"]["Paramedico"] or LocalPlayer["state"]["Policia"]) then
			local Count = 0
			local random = math.random(1, 5)

			if not Range then
				Range = true
			end

			while Count < random do
				if not ActiveAlarm then
					TriggerEvent("sounds:Private", "warning", 0.7)
					TriggerEvent("Notify", "amarelo", "Você entrou em uma <b>Área Privada</b>, você precisa sair em <b>10 Segundos</b>.", "Atenção", ConfigTimer)

					ActiveAlarm = true
					Wait(ConfigTimer)

					TriggerEvent("sounds:Private", "warning", 0.7)
					TriggerEvent("Notify", "azul", "O sistema aéreo de defesa foi ativado.", false, 5000)
					ActiveExplosions = true
				end
                
				while ActiveExplosions and GetEntityHealth(Ped) > 100 do
					local PedCoords = GetEntityCoords(Ped)
					local TargetCoords = ApplyInaccuracy(PedCoords)
					AddExplosion(TargetCoords["x"], TargetCoords["y"], TargetCoords["z"], 18, 2.0, true, false, 1.0)
					Count = Count + 1

					Wait(math.random(200, 500))

					local Distance = #(PedCoords - Locate)
					if Distance >= 300 then
						ActiveExplosions = false
						break
					end
				end
			end 
		elseif Distance > 300 then
			if Range then
				Range = false
				ActiveAlarm = false
				ActiveExplosions = false
			end
		end

		local PlayerIsDead = IsEntityDead(Ped)
		if PlayerIsDead then 
			Range = false
			ActiveAlarm = false
			ActiveExplosions = false

			Wait(1000)
		end
	end
end)