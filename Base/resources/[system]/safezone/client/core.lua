-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("safezone",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = false
local LastVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Safezone = {
	["1"] = {
		["PolyZone"] = PolyZone:Create({
			vector2(205.79,-1024.9),
			vector2(208.78,-1025.24),
			vector2(211.59,-1023.95),
			vector2(213.45,-1021.75),
			vector2(265.77,-877.37),
			vector2(265.96,-872.18),
			vector2(263.66,-867.45),
			vector2(260.59,-865.25),
			vector2(253.69,-862.65),
			vector2(250.3,-863.26),
			vector2(246.89,-864.0),
			vector2(196.15,-845.44),
			vector2(194.17,-843.28),
			vector2(191.79,-840.11),
			vector2(186.61,-840.59),
			vector2(183.84,-843.67),
			vector2(174.82,-866.8),
			vector2(169.77,-877.06),
			vector2(162.94,-886.97),
			vector2(159.76,-893.61),
			vector2(126.22,-985.71),
			vector2(126.45,-990.34),
			vector2(129.62,-993.36),
			vector2(152.5,-1001.3),
			vector2(155.39,-1006.91),
			vector2(157.51,-1008.65),
			vector2(162.7,-1010.22),
			vector2(169.57,-1007.15),
			vector2(192.45,-1014.76),
			vector2(195.25,-1020.51),
			vector2(198.78,-1022.51)
		},{
			["name"] = "Square",
			["minZ"] = 28.00,
			["maxZ"] = 35.00
		})
	},
	["2"] = {
		["PolyZone"] = PolyZone:Create({
			vec2(-282.97512817383, 250.09577941895),
			vec2(-274.83624267578, 250.85043334961),
			vec2(-268.74053955078, 251.34895324707),
			vec2(-264.9072265625, 251.64019775391),
			vec2(-264.91098022461, 233.75854492188),
			vec2(-282.52331542969, 232.76322937012)
		},{
			["name"] = "Restaurante",
			["minZ"] = 25.0,
			["maxZ"] = 100.0
		})
	},
	["3"] = {
		["PolyZone"] = PolyZone:Create({
			vec2(978.78131103516, -987.70562744141),
			vec2(979.19018554688, -985.26971435547),
			vec2(976.95147705078, -973.58575439453),
			vec2(974.72692871094, -964.20947265625),
			vec2(972.57238769531, -955.59375),
			vec2(970.99127197266, -951.00805664062),
			vec2(967.8125, -941.09100341797),
			vec2(963.38031005859, -930.03814697266),
			vec2(958.45733642578, -916.12573242188),
			vec2(958.19219970703, -913.09637451172),
			vec2(945.21154785156, -912.505859375),
			vec2(931.29235839844, -912.29138183594),
			vec2(915.02606201172, -912.0986328125),
			vec2(903.20361328125, -912.00549316406),
			vec2(891.3291015625, -911.58569335938),
			vec2(879.423828125, -911.65447998047),
			vec2(882.58428955078, -990.45867919922),
			vec2(882.69396972656, -994.99786376953),
			vec2(895.13897705078, -994.65148925781),
			vec2(910.02154541016, -994.31018066406),
			vec2(931.15661621094, -993.32690429688),
			vec2(946.63513183594, -993.01861572266),
			vec2(964.66772460938, -991.84503173828),
			vec2(964.7216796875, -989.35040283203),
			vec2(976.36206054688, -988.66986083984)
		},{
			["name"] = "Mechanic",
			["minZ"] = 25.0,
			["maxZ"] = 100.0
		})
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetGhostedEntityAlpha(254)

	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Index,v in pairs(Safezone) do
			if v["PolyZone"]:isPointInside(Coords) then
				if not Active then
					Active = Index
					NetworkSetFriendlyFireOption(false)
					LocalPlayer["state"]:set("Safezone",Active,true)
					LocalPlayer["state"]:set("Blastoise",true,false)
					SetEntityInvincible(Ped,true)
					SetLocalPlayerAsGhost(true)

					if IsPedArmed(Ped,7) then
						TriggerEvent("inventory:CleanWeapons",true)
					end
				end
			else
				if Active and Active == Index then
					Active = false

					SetLocalPlayerAsGhost(false)
					SetEntityInvincible(Ped,false)
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("Safezone",Active,true)
					LocalPlayer["state"]:set("Blastoise",false,false)
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			TimeDistance = 1

			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,68,true)
			DisableControlAction(0,69,true)
			DisableControlAction(0,70,true)
			DisableControlAction(0,91,true)
			DisableControlAction(0,92,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,257,true)

			local Ped = PlayerPedId()
			DisablePlayerFiring(Ped,true)

			if IsPedInAnyVehicle(Ped) then
				if not LastVehicle then
					LastVehicle = GetPlayersLastVehicle()
					SetNetworkVehicleAsGhost(LastVehicle,true)
				end
			else
				if LastVehicle and DoesEntityExist(LastVehicle) then
					SetNetworkVehicleAsGhost(LastVehicle,false)
					LastVehicle = false
				end
			end
		end

		Wait(TimeDistance)
	end
end)