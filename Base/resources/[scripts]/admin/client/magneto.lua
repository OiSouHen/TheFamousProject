-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ForcefieldRadius = 5.0
local forcefield = false
ForcefieldRadiusOps = {5.0, 10.0, 15.0, 20.0, 50.0}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEMAGNETO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:ToggleMagneto")
AddEventHandler("admin:ToggleMagneto",function()
	forcefield = not forcefield
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYFORCE
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyForce(entity)
	local pos = GetEntityCoords(PlayerPedId())
	local coord = GetEntityCoords(entity)
	local dx = coord.x - pos.x
	local dy = coord.y - pos.y
	local dz = coord.z - pos.z
	local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
	local distanceRate = (50 / distance) * math.pow(1.04, 1 - distance)
	ApplyForceToEntity(entity, 1, distanceRate * dx, distanceRate * dy, distanceRate * dz, math.random() * math.random(-1, 1), math.random() * math.random(-1, 1), math.random() * math.random(-1, 1), true, false, true, true, true, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCONTROLONCE
-----------------------------------------------------------------------------------------------------------------------------------------
function RequestControlOnce(entity)
	if not NetworkIsInSession or NetworkHasControlOfEntity(entity) then
		return true
	end

	SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
	return NetworkRequestControlOfEntity(entity)
end
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

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil

		disposeFunc(iter)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOFORCEFIELDTICK
-----------------------------------------------------------------------------------------------------------------------------------------
local function DoForceFieldTick(radius)
	local player = PlayerPedId()
	local coords = GetEntityCoords(PlayerPedId())
	local playerVehicle = GetPlayersLastVehicle()
	local inVehicle = IsPedInVehicle(player, playerVehicle, true)

	DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, radius, radius, radius, 180, 80, 0, 35, false, true, 2, nil, nil, false)

	for k in EnumerateVehicles() do
		if (not inVehicle or k ~= playerVehicle) and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) <= radius * 2 then
			RequestControlOnce(k)
			ApplyForce(k)
		end
	end

	for k in EnumeratePeds() do
		if k ~= PlayerPedId() and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) <= radius * 2 then
			RequestControlOnce(k)
			SetPedRagdollOnCollision(k, true)
			SetPedRagdollForceFall(k)
			ApplyForce(k)
		end
	end

	-- Só ative em caso de estar crashando
	-- for k in EnumerateObjects() do
		-- if k ~= PlayerPedId() and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) <= radius * 2 then
			-- RequestControlOnce(k)
			-- ApplyForce(k)
		-- end
	-- end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local currForcefieldRadiusIndex = 1
	local selForcefieldRadiusIndex = 1
	while true do
		if forcefield then
			DoForceFieldTick(ForcefieldRadius)
		end

		Wait(1)
	end
end)