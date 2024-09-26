-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local BikesPoints = 0
local BikesMushroom = false
local BikesMaxPoints = 1000
local BikesMushroomPoints = 0
local BikesTimer = GetGameTimer()
local BikesMushroomTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKES:MUSHROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bikes:Mushroom")
AddEventHandler("bikes:Mushroom",function()
	BikesMushroom = true
	BikesMaxPoints = 500
	BikesMushroomPoints = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bikes = {
	[448402357] = true,
	[1131912276] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-400295096] = true,
	[-1233807380] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
if BikesBackpack then
	CreateThread(function()
		while true do
			local Ped = PlayerPedId()

			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				local Model = GetEntityModel(Vehicle)
				local Velocity = GetEntitySpeed(Vehicle) * 2.236936

				if Bikes[Model] and GetGameTimer() >= BikesTimer and Velocity >= 10 then
					BikesTimer = GetGameTimer() + 1000
					BikesPoints = BikesPoints + 1

					if BikesPoints >= BikesMaxPoints then
						vSERVER.BikesBackpack()
						BikesPoints = 0
					end
				end
			end

			Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKESMUSHROOM
-----------------------------------------------------------------------------------------------------------------------------------------
if BikesBackpack then
	CreateThread(function()
		while true do

			if BikesMushroom then
				if GetGameTimer() >= BikesMushroomTimer then
					BikesMushroomTimer = GetGameTimer() + 1000
					BikesMushroomPoints = BikesMushroomPoints + 1

					if BikesMushroomPoints >= 3500 then
						BikesMushroom = false
						BikesMaxPoints = 1000
						BikesMushroomPoints = 0
					end
				end
			end

			Wait(1000)
		end
	end)
end