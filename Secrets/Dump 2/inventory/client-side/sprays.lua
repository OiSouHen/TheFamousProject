-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LastError = false
local LastRayStart = false
local LastRayDirection = false
local LastComputedRayNormal = false
local LastComputedRayEndCoords = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPRAYCONTROLLING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SprayControlling(Model)
	local Aplication = false
	local OtherCoords = false

	if LoadModel(Model) then
		local Progress = true
		local NextObject = false

		TriggerEvent("inventory:Buttons",{
			{ "F","Cancelar" },
			{ "H","Pichar" }
		})

		while Progress do
			local RayCoords,RayNormal,Foward = FindRaySprayCoords()
			if RayCoords and RayNormal then
				local Ped = PlayerPedId()
				local PlayerCoords = GetEntityCoords(Ped)
				local SprayCoords = RayCoords + Foward * 0.035
				local EntityCoords = GetEntityCoords(NextObject)
				local Heading = GetHeadingFromVector_2d(EntityCoords["x"] - PlayerCoords["x"],EntityCoords["y"] - PlayerCoords["y"])

				if not NextObject then
					NextObject = CreateObjectNoOffset(Model,SprayCoords["x"],SprayCoords["y"],SprayCoords["z"],false,false,false)
					SetEntityAlpha(NextObject,175,false)
					SetEntityCollision(NextObject,false,false)
				end

				SetEntityCoordsNoOffset(NextObject,SprayCoords["x"],SprayCoords["y"],SprayCoords["z"],true,true,true)
				SetEntityRotation(NextObject,0.0,0.0,Heading,2,true)
			end

			if IsControlJustPressed(1,74) then
				TriggerEvent("inventory:CloseButtons")
				Aplication = true
				Progress = false
			end

			if IsControlJustPressed(0,49) then
				TriggerEvent("inventory:CloseButtons")
				Aplication = false
				Progress = false
			end

			Wait(1)
		end

		if NextObject and DoesEntityExist(NextObject) then
			local oCoords = GetEntityCoords(NextObject)
			local oHeading = GetEntityHeading(NextObject)

			OtherCoords = { Optimize(oCoords["x"]),Optimize(oCoords["y"]),Optimize(oCoords["z"]),Optimize(oHeading) }

			DeleteEntity(NextObject)
		end
	end

	return Aplication,OtherCoords
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDRAYSPRAYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function FindRaySprayCoords()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local CameraCoord = GetGameplayCamCoord()
    local CameraRotation = GetGameplayCamRot()
    local Direction = RotationDirection(CameraRotation)

    if not LastRayStart or not LastRayDirection or ((not LastComputedRayEndCoords or not LastComputedRayNormal) and not LastError) or CameraCoord ~= LastRayStart or Direction ~= LastRayDirection then
        LastRayStart = CameraCoord
        LastRayDirection = Direction

        local Result,RayCoords,RayNormal = FindRaycastSprayCoordsNotCached(Ped,Coords,CameraCoord,Direction)

        if Result then
            if LastSubtitleText then
                LastSubtitleText = nil
                ClearPrints()
            end

            LastComputedRayEndCoords = RayCoords
            LastComputedRayNormal = RayNormal
            LastError = false

            return LastComputedRayEndCoords,LastComputedRayNormal,LastComputedRayNormal
        else
            LastComputedRayEndCoords = nil
            LastComputedRayNormal = nil
            LastError = true
        end
    else
        return LastComputedRayEndCoords,LastComputedRayNormal,LastComputedRayNormal
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDRAYSPRAYCOORDSNOTCACHED
-----------------------------------------------------------------------------------------------------------------------------------------
function FindRaycastSprayCoordsNotCached(Ped,Coords,Start,Direction)
	local rayHit,rayEndCoords,rayNormal = CheckRay(Ped,Start,Direction)
	local ray2Hit,ray2EndCoords,ray2Normal = CheckRay(Ped,Start + vector3(0.0,0.0,0.2),Direction)
	local ray3Hit,ray3EndCoords,ray3Normal = CheckRay(Ped,Start + vector3(1.0,0.0,0.0),Direction)
	local ray4Hit,ray4EndCoords,ray4Normal = CheckRay(Ped,Start + vector3(-1.0,0.0,0.0),Direction)
	local ray5Hit,ray5EndCoords,ray5Normal = CheckRay(Ped,Start + vector3(0.0,1.0,0.0),Direction)
	local ray6Hit,ray6EndCoords,ray6Normal = CheckRay(Ped,Start + vector3(0.0,-1.0,0.0),Direction)

	if not (ray2Normal["z"] > 0.9) and rayHit and ray2Hit and ray3Hit and ray4Hit and ray5Hit and ray6Hit then
		if #(Coords - rayEndCoords) < 5.0 then
			if (IsNormalSame(rayNormal,ray2Normal) and IsNormalSame(rayNormal,ray3Normal) and IsNormalSame(rayNormal,ray4Normal) and IsNormalSame(rayNormal,ray5Normal) and IsNormalSame(rayNormal,ray6Normal)) then
				return true,rayEndCoords,rayNormal,rayNormal
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRAY
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckRay(Ped,Coords,Direction)
	local EndPoint = Coords + Direction * 1000.0
	local Handle = StartShapeTestRay(Coords["x"],Coords["y"],Coords["z"],EndPoint["x"],EndPoint["y"],EndPoint["z"],1,Ped)
	local _,Hit,EndCoords,Surface,Material = GetShapeTestResultEx(Handle)

	return Hit == 1,EndCoords,Surface,Material
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISNORMALSAME
-----------------------------------------------------------------------------------------------------------------------------------------
function IsNormalSame(One,Two)
    local xDistance = math.abs(One["x"] - Two["x"])
    local yDistance = math.abs(One["y"] - Two["y"])
    local zDistance = math.abs(One["z"] - Two["z"])

    return xDistance < 0.01 and yDistance < 0.01 and zDistance < 0.01
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationDirection(rotation)
	local Adjust = {
		x = (math.pi / 180) * rotation["x"],
		y = (math.pi / 180) * rotation["y"],
		z = (math.pi / 180) * rotation["z"]
	}

	return vector3(-math.sin(Adjust["z"]) * math.abs(math.cos(Adjust["x"])),math.cos(Adjust["z"]) * math.abs(math.cos(Adjust["x"])),math.sin(Adjust["x"]))
end