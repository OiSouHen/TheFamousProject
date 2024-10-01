-----------------------------------------------------------------------------------------------------------------------------------------
-- VARPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
local First = vec3(0.0, 0.0, 0.0)
local Second = vec3(5.0, 5.0, 5.0)
local PushVehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARCAST
-----------------------------------------------------------------------------------------------------------------------------------------
local CountCast = 0
local DelayCast = 1000
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARLX
-----------------------------------------------------------------------------------------------------------------------------------------
local LxSirenSend = {}
local LxSirenState = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARAIR
-----------------------------------------------------------------------------------------------------------------------------------------
local AirSirenSend = {}
local AirSirenState = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGMUTEDFLTSRNFORVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function TogMuteDfltSrnForVeh(Vehicle, Toggle)
	if DoesEntityExist(Vehicle) and not IsEntityDead(Vehicle) then
		SetVehicleHasMutedSirens(Vehicle, Toggle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLXSIRENSTATEFORVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function SetLxSirenStateForVeh(Vehicle, State)
	if DoesEntityExist(Vehicle) and not IsEntityDead(Vehicle) then
		if State ~= LxSirenState[Vehicle] then
			if LxSirenSend[Vehicle] then
				StopSound(LxSirenSend[Vehicle])
				ReleaseSoundId(LxSirenSend[Vehicle])
				LxSirenSend[Vehicle] = nil
			end

			if State == 1 then
				LxSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSirenSend[Vehicle], "VEHICLES_HORNS_SIREN_1", Vehicle, 0, 0, 0)
				TogMuteDfltSrnForVeh(Vehicle, true)
			elseif State == 2 then
				LxSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSirenSend[Vehicle], "VEHICLES_HORNS_SIREN_2", Vehicle, 0, 0, 0)
				TogMuteDfltSrnForVeh(Vehicle, true)
			elseif State == 3 then
				LxSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSirenSend[Vehicle], "VEHICLES_HORNS_POLICE_WARNING", Vehicle, 0, 0, 0)
				TogMuteDfltSrnForVeh(Vehicle, true)
			else
				TogMuteDfltSrnForVeh(Vehicle, true)
			end

			LxSirenState[Vehicle] = State
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETAIRMANUSTATEFORVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function SetAirManuStateForVeh(Vehicle, State)
	if DoesEntityExist(Vehicle) and not IsEntityDead(Vehicle) then
		if State ~= AirSirenState[Vehicle] then
			if AirSirenSend[Vehicle] then
				StopSound(AirSirenSend[Vehicle])
				ReleaseSoundId(AirSirenSend[Vehicle])
				AirSirenSend[Vehicle] = nil
			end

			if State == 1 then
				AirSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSirenSend[Vehicle], "SIRENS_AIRHORN", Vehicle, 0, 0, 0)
			elseif State == 2 then
				AirSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSirenSend[Vehicle], "VEHICLES_HORNS_SIREN_1", Vehicle, 0, 0, 0)
			elseif State == 3 then
				AirSirenSend[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSirenSend[Vehicle], "VEHICLES_HORNS_SIREN_2", Vehicle, 0, 0, 0)
			end

			AirSirenState[Vehicle] = State
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle, -1) == Ped and GetVehicleClass(Vehicle) == 18 then
				TimeDistance = 0

				local ActiveHorn = false
				local ActiveManual = false

				DisableControlAction(0, 19, true)
				DisableControlAction(0, 80, true)
				DisableControlAction(0, 81, true)
				DisableControlAction(0, 82, true)
				DisableControlAction(0, 85, true)
				DisableControlAction(0, 86, true)
				DisableControlAction(0, 172, true)

				SetVehRadioStation(Vehicle, "OFF")
				SetVehicleRadioEnabled(Vehicle, false)

				if not LxSirenState[Vehicle] or (LxSirenState[Vehicle] < 0 or LxSirenState[Vehicle] > 3) then
					LxSirenState[Vehicle] = 0
				end

				if not AirSirenState[Vehicle] or (AirSirenState[Vehicle] < 0 or AirSirenState[Vehicle] > 3) then
					AirSirenState[Vehicle] = 0
				end

				if not IsVehicleSirenOn(Vehicle) and LxSirenState[Vehicle] > 0 then
					SetLxSirenStateForVeh(Vehicle, 0)
					CountCast = DelayCast
				end

				if not IsPauseMenuActive() then
					if IsDisabledControlJustReleased(0, 85) or IsDisabledControlJustReleased(0, 246) then
						if IsVehicleSirenOn(Vehicle) then
							SetVehicleSiren(Vehicle, false)
						else
							SetVehicleSiren(Vehicle, true)
							CountCast = DelayCast
						end
					elseif IsDisabledControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) then
						if LxSirenState[Vehicle] == 0 then
							if IsVehicleSirenOn(Vehicle) then
								SetLxSirenStateForVeh(Vehicle, 1)
								CountCast = DelayCast
							end
						else
							SetLxSirenStateForVeh(Vehicle, 0)
							CountCast = DelayCast
						end
					end

					if LxSirenState[Vehicle] > 0 then
						if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
							if IsVehicleSirenOn(Vehicle) then
								local NewState = 1
								if LxSirenState[Vehicle] == 1 or LxSirenState[Vehicle] == 2 then
									NewState = LxSirenState[Vehicle] + 1
								end

								SetLxSirenStateForVeh(Vehicle, NewState)
								CountCast = DelayCast
							end
						end
					end

					if LxSirenState[Vehicle] < 1 then
						if IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81) then
							ActiveManual = true
						else
							ActiveManual = false
						end
					else
						ActiveManual = false
					end

					if IsDisabledControlPressed(0, 86) then
						ActiveHorn = true
					else
						ActiveHorn = false
					end
				end

				local ManualState = 0
				if ActiveHorn and not ActiveManual then
					ManualState = 1
				elseif not ActiveHorn and ActiveManual then
					ManualState = 2
				elseif ActiveHorn and ActiveManual then
					ManualState = 3
				end

				if AirSirenState[Vehicle] ~= ManualState then
					SetAirManuStateForVeh(Vehicle, ManualState)
					CountCast = DelayCast
				end

				if CountCast > DelayCast then
					CountCast = 0
					Entity(Vehicle)["state"]:set("Sirens", { LxSirenState[Vehicle], AirSirenState[Vehicle] }, true)
				else
					CountCast = CountCast + 1
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Sirens", nil, function(Name, Key, Value)
	local Network = parseInt(Name:gsub("entity:", ""))
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToVeh(Network)
		if DoesEntityExist(Vehicle) then
			TogMuteDfltSrnForVeh(Vehicle, true)
			SetLxSirenStateForVeh(Vehicle, Value[1])
			SetAirManuStateForVeh(Vehicle, Value[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYENUMERATOR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat

		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVeh()
    local Vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(Vehicles,vehicle)
    end

    return Vehicles
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetClosestVeh(Coords)
	local Vehicles = GetVeh()
	local ClosestDistance = -1
	local ClosestVehicle = -1
	local Coords = Coords

	if Coords == nil then
		local Ped = PlayerPedId()
		Coords = GetEntityCoords(Ped)
	end

	for i=1,#Vehicles,1 do
		local VehicleCoords = GetEntityCoords(Vehicles[i])
		local Distance = GetDistanceBetweenCoords(VehicleCoords, Coords["x"], Coords["y"], Coords["z"], true)
		if ClosestDistance == -1 or ClosestDistance > Distance then
			ClosestVehicle  = Vehicles[i]
			ClosestDistance = Distance
		end
	end

	return ClosestVehicle,ClosestDistance
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCLOSEST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local ClosestVehicle,Distance = GetClosestVeh()
		if Distance < 3 and not IsPedInAnyVehicle(Ped) then
			PushVehicle["Coords"] = GetEntityCoords(ClosestVehicle)
			PushVehicle["Dimensions"] = GetModelDimensions(GetEntityModel(ClosestVehicle), First, Second)
			PushVehicle["Vehicle"] = ClosestVehicle
			PushVehicle["Distance"] = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(ClosestVehicle) + GetEntityForwardVector(ClosestVehicle), GetEntityCoords(Ped), true) > GetDistanceBetweenCoords(GetEntityCoords(ClosestVehicle) + GetEntityForwardVector(ClosestVehicle) * -1, GetEntityCoords(Ped), true) then
				PushVehicle["IsInFront"] = false
			else
				PushVehicle["IsInFront"] = true
			end
		else
			PushVehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end

		Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	if CanPushCars then
		while true do 
			Wait(500)

			if PushVehicle["Vehicle"] ~= nil then
				local Ped = PlayerPedId()
				if IsControlPressed(0, 152) and GetEntityHealth(Ped) > 100 and IsVehicleSeatFree(PushVehicle["Vehicle"], -1) and not IsEntityAttachedToEntity(Ped,PushVehicle["Vehicle"]) and not (GetEntityRoll(PushVehicle["Vehicle"]) > 75.0 or GetEntityRoll(PushVehicle["Vehicle"]) < -75.0) then
					RequestAnimDict("missfinale_c2ig_11")
					TaskPlayAnim(Ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0, -8.0, -1, 35, 0, 0, 0, 0)

					NetworkRequestControlOfEntity(PushVehicle["Vehicle"])

					if PushVehicle["IsInFront"] then
						AttachEntityToEntity(Ped, PushVehicle["Vehicle"], GetPedBoneIndex(6286), 0.0, PushVehicle["Dimensions"]["y"] * -1 + 0.1, PushVehicle["Dimensions"]["z"] + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
					else
						AttachEntityToEntity(Ped, PushVehicle["Vehicle"], GetPedBoneIndex(6286), 0.0, PushVehicle["Dimensions"]["y"] - 0.3, PushVehicle["Dimensions"]["z"] + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
					end

					while true do
						Wait(5)

						if IsDisabledControlPressed(0, 34) then
							TaskVehicleTempAction(Ped, PushVehicle["Vehicle"], 11, 100)
						end

						if IsDisabledControlPressed(0, 9) then
							TaskVehicleTempAction(Ped, PushVehicle["Vehicle"], 10, 100)
						end

						if PushVehicle["IsInFront"] then
							SetVehicleForwardSpeed(PushVehicle["Vehicle"], -1.0)
						else
							SetVehicleForwardSpeed(PushVehicle["Vehicle"], 1.0)
						end

						if not IsDisabledControlPressed(0, 152) then
							DetachEntity(Ped, false, false)
							StopAnimTask(Ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0)
							break
						end
					end
				end
			end
		end
	end
end)