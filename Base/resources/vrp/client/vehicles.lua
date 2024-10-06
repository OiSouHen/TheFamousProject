-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LastTravel = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestVehicle(Radius)
	local Model = false
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
			Model = GetEntityArchetypeName(Selected)
		end
	end

	return Selected,Model
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleList(Radius)
	local Plate = ""
	local Model = nil
	local Class = false
	local Vehicle = false
	local Networked = false
	local Ped = PlayerPedId()

	if IsPedInAnyVehicle(Ped) then
		Vehicle = GetVehiclePedIsUsing(Ped)
	else
		if not Radius then
			Radius = 5.0
		end

		Vehicle = tvRP.ClosestVehicle(Radius + 0.0)
	end

	if Vehicle and DoesEntityExist(Vehicle) and IsEntityAVehicle(Vehicle) then
		Networked = VehToNet(Vehicle)
		Class = GetVehicleClass(Vehicle)
		Model = GetEntityArchetypeName(Vehicle)
		Plate = GetVehicleNumberPlateText(Vehicle)
	end

	return Vehicle,Networked,Plate,Model,Class,GetEntityCoords(Vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.InsideVehicle()
	local Ped = PlayerPedId()
	return IsPedInAnyVehicle(Ped)
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
		local Vehicle = GetVehiclePedIsUsing(Ped)

		return GetEntityArchetypeName(Vehicle),VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle)
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