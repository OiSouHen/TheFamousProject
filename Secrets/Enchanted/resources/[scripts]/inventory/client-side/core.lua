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
Creative = {}
Tunnel.bindInterface("inventory",Creative)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Types = ""
Actived = false
local Swimming = false
local ShotDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Buttons"] then
			DisableControlAction(0,257,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,47,true)
			DisablePlayerFiring(Ped,true)

			TimeDistance = 1
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARNER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:Cleaner",function(Ped)
	TriggerEvent("hud:Weapon",false)
	RemoveAllPedWeapons(Ped,true)
	TriggerEvent("Weapon","")
	Actived = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRBOOSTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairBoosts")
AddEventHandler("inventory:RepairBoosts",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			local Tyres = {}

			for i = 0,7 do
				local Status = false

				if GetTyreHealth(Vehicle,i) ~= 1000.0 then
					Status = true
				end

				Tyres[i] = Status
			end

			local Fuel = GetVehicleFuelLevel(Vehicle)

			SetVehicleFixed(Vehicle)
			SetVehicleDeformationFixed(Vehicle)

			SetVehicleFuelLevel(Vehicle,Fuel)

			for Tyre,Burst in pairs(Tyres) do
				if Burst then
					SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairTyres")
AddEventHandler("inventory:RepairTyres",function(Vehicle,Tyres,Plate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			if Tyres == "All" then
				for i = 0,10 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreFixed(Vehicle,i)
					end
				end
			else
				for i = 0,10 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle,i,true,1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle,Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRDEFAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairDefault")
AddEventHandler("inventory:RepairDefault",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			SetVehicleEngineHealth(Vehicle,1000.0)
			SetVehicleBodyHealth(Vehicle,1000.0)
			SetEntityHealth(Vehicle,1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairAdmin")
AddEventHandler("inventory:RepairAdmin",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			local Fuel = GetVehicleFuelLevel(Vehicle)

			SetVehicleFixed(Vehicle)
			SetVehicleDeformationFixed(Vehicle)

			SetVehicleFuelLevel(Vehicle,Fuel)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Fishing(Item)
	local Fishings = false
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	local Locates = {
		{ ["Coords"] = vec3(1183.88,4002.14,30.23), ["Item"] = "fishingrod" },
		{ ["Coords"] = vec3(-230.83,-3332.51,0.59), ["Item"] = "fishingrod2" },
		{ ["Coords"] = vec3(-1314.5,6207.45,-0.56), ["Item"] = "fishingrod3" },
		{ ["Coords"] = vec3(-627.61,7597.86,-0.42), ["Item"] = "fishingrod4" }
	}

	for _,v in pairs(Locates) do
		if #(Coords - v["Coords"]) <= 200 and (Item == v["Item"] or Item == "fishingrodplus") then
			Fishings = true
		end
	end

	return Fishings
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(Network,Plate,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local TyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Tyres()
	local Ped = PlayerPedId()
	if not IsPedInAnyVehicle(Ped) then
		local Vehicle,Model = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			local Coords = GetEntityCoords(Ped)

			for Index,Tyre in pairs(TyreList) do
				local Selected = GetEntityBoneIndexByName(Vehicle,Index)
				if Selected ~= -1 then
					local CoordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
					if #(Coords - CoordsWheel) <= 1.0 and GetTyreHealth(Vehicle,Tyre) ~= 1000.0 then
						return Vehicle,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle),Model
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.tyreHealth(Network,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ObjectExists(Coords,Hash,Distance)
	return DoesObjectOfTypeExistAtCoords(Coords[1],Coords[2],Coords[3],Distance or 0.35,Hash,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTERIOR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckInterior()
	return GetInteriorFromEntity(PlayerPedId()) ~= 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOSSANTOS
-----------------------------------------------------------------------------------------------------------------------------------------
local LosSantos = PolyZone:Create({
	vec2(-2153.08,-3131.33),
	vec2(-1581.58,-2092.38),
	vec2(-3271.05,275.85),
	vec2(-3460.83,967.42),
	vec2(-3202.39,1555.39),
	vec2(-1642.50,993.32),
	vec2(312.95,1054.66),
	vec2(1313.70,341.94),
	vec2(1739.01,-1280.58),
	vec2(1427.42,-3440.38),
	vec2(-737.90,-3773.97)
},{ name = "Santos" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANDYSHORES
-----------------------------------------------------------------------------------------------------------------------------------------
local SandyShores = PolyZone:Create({
	vec2(-375.38,2910.14),
	vec2(307.66,3664.47),
	vec2(2329.64,4128.52),
	vec2(2349.93,4578.50),
	vec2(1680.57,4462.48),
	vec2(1570.01,4961.27),
	vec2(1967.55,5203.67),
	vec2(2387.14,5273.98),
	vec2(2735.26,4392.21),
	vec2(2512.33,3711.16),
	vec2(1681.79,3387.82),
	vec2(258.85,2920.16)
},{ name = "Sandy" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- PALETOBAY
-----------------------------------------------------------------------------------------------------------------------------------------
local PaletoBay = PolyZone:Create({
	vec2(-529.40,5755.14),
	vec2(-234.39,5978.46),
	vec2(278.16,6381.84),
	vec2(672.67,6434.39),
	vec2(699.56,6877.77),
	vec2(256.59,7058.49),
	vec2(17.64,7054.53),
	vec2(-489.45,6449.50),
	vec2(-717.59,6030.94)
},{ name = "Paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEVENTGUNSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CEventGunShot",function(_,OtherPeds)
	local Ped = PlayerPedId()
	if Ped == OtherPeds and not CheckPolice() and GetGameTimer() >= ShotDelay and Weapon ~= "WEAPON_MUSKET" then
		ShotDelay = GetGameTimer() + 60000
		TriggerEvent("player:Residual","Resíduo de Pólvora")

		local Coords = GetEntityCoords(Ped)
		if not IsPedCurrentWeaponSilenced(Ped) then
			if (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
			end
		else
			if math.random(100) >= 75 and (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURANTE:POLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Restaurante = PolyZone:Create({
	vec2(-513.92,-683.55),vec2(-513.65,-683.52),vec2(-513.64,-683.7),vec2(-511.38,-683.7),vec2(-511.39,-683.54),
	vec2(-511.21,-683.53),vec2(-511.3,-678.85),vec2(-510.49,-678.83),vec2(-510.48,-678.34),vec2(-501.96,-678.35),
	vec2(-501.94,-678.89),vec2(-500.91,-678.85),vec2(-500.97,-681.31),vec2(-501.25,-681.3),vec2(-501.27,-687.36),
	vec2(-500.98,-687.39),vec2(-500.98,-689.06),vec2(-501.27,-689.1),vec2(-501.26,-695.81),vec2(-501.01,-695.8),
	vec2(-500.93,-697.29),vec2(-498.83,-697.41),vec2(-498.91,-704.5),vec2(-500.66,-704.51),vec2(-500.65,-704.86),
	vec2(-499.66,-704.86),vec2(-499.67,-708.31),vec2(-500.64,-708.33),vec2(-500.64,-708.89),vec2(-500.36,-708.92),
	vec2(-500.41,-709.73),vec2(-500.66,-709.72),vec2(-500.65,-712.02),vec2(-500.81,-712.07),vec2(-500.81,-713.36),
	vec2(-500.64,-713.43),vec2(-500.63,-714.17),vec2(-500.42,-714.21),vec2(-500.43,-714.95),vec2(-500.66,-714.99),
	vec2(-500.63,-717.36),vec2(-500.42,-717.38),vec2(-500.42,-718.15),vec2(-500.1,-718.14),vec2(-500.09,-721.59),
	vec2(-501.0,-721.59),vec2(-500.99,-721.84),vec2(-500.91,-726.23),vec2(-500.94,-726.45),vec2(-500.67,-726.46),
	vec2(-500.61,-728.13),vec2(-500.86,-728.15),vec2(-500.81,-733.63),vec2(-500.54,-733.66),vec2(-500.5,-735.32),
	vec2(-500.79,-735.36),vec2(-502.19,-736.85),vec2(-502.29,-735.99),vec2(-507.68,-736.29),vec2(-507.71,-737.18),
	vec2(-510.26,-737.27),vec2(-510.92,-736.4),vec2(-510.67,-736.18),vec2(-514.1,-732.04),vec2(-514.44,-732.21),
	vec2(-523.5,-720.17),vec2(-523.77,-720.31),vec2(-524.08,-719.73),vec2(-523.94,-719.61),vec2(-529.74,-706.13),
	vec2(-529.99,-706.18),vec2(-530.13,-705.54),vec2(-529.93,-705.45),vec2(-531.62,-692.63),vec2(-531.87,-692.6),
	vec2(-531.83,-691.97),vec2(-531.59,-691.97),vec2(-531.55,-688.62),vec2(-527.98,-688.53),vec2(-528.04,-688.01),
	vec2(-527.49,-687.81),vec2(-528.22,-685.06),vec2(-529.03,-685.07),vec2(-529.03,-684.36),vec2(-528.19,-684.32),
	vec2(-527.54,-681.71),vec2(-528.19,-681.38),vec2(-527.87,-680.76),vec2(-527.22,-681.07),vec2(-525.2,-679.18),
	vec2(-525.6,-678.46),vec2(-525.02,-678.15),vec2(-524.69,-678.65),vec2(-521.95,-678.15),vec2(-521.94,-677.42),
	vec2(-521.29,-677.44),vec2(-521.24,-678.23),vec2(-518.57,-678.9),vec2(-518.12,-678.26),vec2(-517.56,-678.63),
	vec2(-517.93,-679.25),vec2(-515.92,-681.33),vec2(-514.88,-680.81),vec2(-513.91,-681.97)
},{ name = "Restaurante" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Restaurant()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	return Restaurante:isPointInside(Coords)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLEAVESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if IsPedSwimming(Ped) then
				if not Swimming and not ScubaTank and not ScubaMask then
					Swimming = true
					vSERVER.Swimming()
				end
			elseif Swimming then
				Swimming = false
			end
		end

		Wait(10000)
	end
end)