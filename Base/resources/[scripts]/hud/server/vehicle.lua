-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VEHICLEEJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hud:VehicleEject")
AddEventHandler("hud:VehicleEject",function(Velocity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Ped = GetPlayerPed(source)
		local Coords = vRP.GetEntityCoords(source)

		SetEntityCoords(Ped,Coords["x"],Coords["y"],Coords["z"] - 0.5,true,true,true)
		SetEntityVelocity(Ped,Velocity)

		Wait(1)

		SetPedToRagdoll(Ped,5000,5000,0,0,0,0)
	end
end)