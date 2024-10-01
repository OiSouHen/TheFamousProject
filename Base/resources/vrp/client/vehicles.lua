-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LastTravel = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestVehicle(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CVehicle")

	for _,Entity in pairs(GamePool) do
		local EntityCoords = GetEntityCoords(Entity)
		local EntityDistance = #(Coords - EntityCoords)

		if EntityDistance < Radius then
			Selected = Entity
			Radius = EntityDistance
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.InsideVehicle()
	local Ped = PlayerPedId()
	return IsPedInAnyVehicle(Ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleList(Radius)
	local Vehicle = nil
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Vehicle = GetVehiclePedIsUsing(Ped)
	else
		Vehicle = tvRP.ClosestVehicle(Radius)
	end

	if IsEntityAVehicle(Vehicle) then
		local Network = VehToNet(Vehicle)
		local Class = GetVehicleClass(Vehicle)
		local Model = GetEntityArchetypeName(Vehicle)
		local Plate = GetVehicleNumberPlateText(Vehicle)

		return Vehicle,Network,Plate,Model,Class
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEAROUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleAround()
	local Ped = PlayerPedId()
	local Vehicle = tvRP.ClosestVehicle(4)

	if IsEntityAVehicle(Vehicle) then
		local PlayerAround = {}
		for _,Player in ipairs(GetActivePlayers()) do
			PlayerAround[#PlayerAround + 1] = GetPlayerServerId(Player)
		end

		return Vehicle, NetworkGetNetworkIdFromEntity(Vehicle), PlayerAround
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleName()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		return GetEntityArchetypeName(GetVehiclePedIsUsing(Ped))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleModel(Vehicle)
	return GetEntityArchetypeName(Vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEHASH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleHash()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetLastDrivenVehicle()
		local Model = GetEntityModel(Vehicle)

		return Model
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LASTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.LastVehicle(Name)
	local Vehicle = GetLastDrivenVehicle()
	if Vehicle and DoesEntityExist(Vehicle) and Name == GetEntityArchetypeName(Vehicle) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATETRAVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CalculateTravel()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if not LastTravel then
		LastTravel = Coords
	end

	return CalculateTravelDistanceBetweenPoints(Coords, LastTravel)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETRAVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpdateTravel()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	LastTravel = Coords
end