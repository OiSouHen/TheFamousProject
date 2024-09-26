-----------------------------------------------------------------------------------------------------------------------------------------
-- AWAYSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local AwayTimers = GetGameTimer()
local AwaySystem = { 0.0, 0.0, 1800 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if GetGameTimer() >= AwayTimers then
			AwayTimers = GetGameTimer() + 10000

			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			if Coords["x"] == AwaySystem[1] and Coords["y"] == AwaySystem[2] then
				if AwaySystem[3] > 0 then
					AwaySystem[3] = AwaySystem[3] - 10

					if AwaySystem[3] == 60 or AwaySystem[3] == 30 then
						TriggerEvent("Notify", "azul", "Mova-se e evite ser desconectado.", false, 5000)
					end
				else
					vSERVER.KickPlayer("Desconectado, muito tempo ausente.")
				end
			else
				AwaySystem[1] = Coords["x"]
				AwaySystem[2] = Coords["y"]
				AwaySystem[3] = 1800
			end
		end

		Wait(10000)
	end
end)