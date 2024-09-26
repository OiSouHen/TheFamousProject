-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local NoClip = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.noClip()
	NoClip = not NoClip
	local Ped = PlayerPedId()

	if NoClip then
		LocalPlayer["state"]:set("Chikorita",true,false)
		LocalPlayer["state"]:set("Cyndaquil",true,false)

		SetEntityCollision(Ped,false,false)
		SetEntityInvincible(Ped,true)
		SetEntityVisible(Ped,false,0)

		return true
	else
		SetEntityCollision(Ped,true,true)
		SetEntityInvincible(Ped,false)
		SetEntityVisible(Ped,true,0)

		LocalPlayer["state"]:set("Cyndaquil",false,false)
		LocalPlayer["state"]:set("Chikorita",false,false)

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if NoClip then
			TimeDistance = 0
			local Speed = 1.0
			local Ped = PlayerPedId()
			local cX,cY,cZ = GetCamDirections()
			local Coords = GetEntityCoords(Ped)
			local X,Y,Z = table.unpack(Coords)

			if IsControlPressed(0,21) then
				Speed = 5.0
			end

			if IsControlPressed(0,32) then
				X = X + Speed * cX
				Y = Y + Speed * cY
				Z = Z + Speed * cZ
			end

			if IsControlPressed(0,269) then
				X = X - Speed * cX
				Y = Y - Speed * cY
				Z = Z - Speed * cZ
			end

			if IsControlPressed(0,10) then
				Z = Z + 0.25
			end

			if IsControlPressed(0,11) then
				Z = Z - 0.25
			end

			SetEntityCoordsNoOffset(Ped,X,Y,Z,false,false,false)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCamDirections()
	local Ped = PlayerPedId()
	local Pitch = GetGameplayCamRelativePitch()
	local Heading = GetGameplayCamRelativeHeading() + GetEntityHeading(Ped)
	local x = -math.sin(Heading * math.pi / 180.0)
	local y = math.cos(Heading * math.pi / 180.0)
	local z = math.sin(Pitch * math.pi / 180.0)
	local Len = math.sqrt(x * x + y * y + z * z)
	if Len ~= 0 then
		x = x / Len
		y = y / Len
		z = z / Len
	end

	return x,y,z
end