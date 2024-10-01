-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Yoga = false
local YogaPoints = 0
local YogaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:YOGA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Yoga")
AddEventHandler("player:Yoga",function()
	if not Yoga then
		Yoga = true
		YogaPoints = 0
		TriggerEvent("Notify", "amarelo", "Yoga iniciado, para finalizar pressione <b>E</b>.", "Atenção", 5000)

		while Yoga do
			if GetGameTimer() >= YogaTimer then
				YogaTimer = GetGameTimer() + 1000
				YogaPoints = YogaPoints + 1

				if YogaPoints >= 5 then
					TriggerServerEvent("player:DowngradeStress", math.random(5))
					TriggerServerEvent("player:DowngradeCough", math.random(5))
					YogaPoints = 0
				end
			end

			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped, "amb@world_human_yoga@male@base", "base_a", 3) then
				vRP.PlayAnim(false, {"amb@world_human_yoga@male@base","base_a"}, true)
			end

			if IsControlJustPressed(1, 38) then
				vRP.Destroy()
				Yoga = false
				break
			end

			Wait(1)
		end
	end
end)