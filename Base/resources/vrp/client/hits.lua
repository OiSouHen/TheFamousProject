-----------------------------------------------------------------------------------------------------------------------------------------
-- ISENTITYNEARBY
-----------------------------------------------------------------------------------------------------------------------------------------
function IsEntityNearby(PlayerPed)
	local PlayerCoords = GetEntityCoords(PlayerPed)
	local NearbyEntities = GetNearbyPeds(PlayerPed, 3.0)

	for _, entity in ipairs(NearbyEntities) do
		if DoesEntityExist(entity) and not IsPedAPlayer(entity) then
			return true
		end
	end

	local Players = GetActivePlayers()
	for i = 1, #Players do
		local TargetPed = GetPlayerPed(Players[i])
		if TargetPed ~= PlayerPed then
			local TargetCoords = GetEntityCoords(TargetPed)
			if #(PlayerCoords - TargetCoords) <= 3.0 then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARBYPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetNearbyPeds(PlayerPed, Radius)
	local Peds = {}
	local Handle, Ped = FindFirstPed()
	local Success

	repeat
		local Coords = GetEntityCoords(Ped)
		if DoesEntityExist(Ped) and not IsPedAPlayer(Ped) and #(Coords - GetEntityCoords(PlayerPed)) <= Radius then
			table.insert(Peds, Ped)
		end

		Success, Ped = FindNextPed(Handle)
	until not Success

	EndFindPed(Handle)

	return Peds
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKHITS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1)

		local Ped = PlayerPedId()
		local Weapon = GetSelectedPedWeapon(Ped)
		if Weapon == GetHashKey("WEAPON_UNARMED") then
			if IsControlPressed(0, 25) and IsEntityNearby(Ped) then
				EnableControlAction(0, 24, true)
				EnableControlAction(0, 257, true)
				EnableControlAction(0, 140, true)
				EnableControlAction(0, 141, true)
				EnableControlAction(0, 142, true)
			else
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(Name, Data)
	local Sure = 0

	if HitMarker then
		if Name == "CEventNetworkEntityDamage" then
			if Health == nil then 
				Health = GetEntityMaxHealth(Data[2])
			end

			local EntitySource = Data[1]
			local Player = Data[2]
			if Player == PlayerPedId() and EntitySource ~= Player then
				if ShowNPCDamages then
					if IsPedAPlayer(Player) and GetEntityType(EntitySource) == 1 then
						repeat
							local Damage = math.ceil(Health - GetEntityHealth(EntitySource))

							if GetEntityHealth(EntitySource) >= 100 then
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 29, 108, 177)
							else
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 255, 255, 255)
							end

							Sure = Sure + 1

							Wait(1)
						until Sure > 50

						Health = GetEntityHealth(EntitySource)
					end
				else
					if IsPedAPlayer(Player) and GetEntityType(EntitySource) == 1 and IsPedAPlayer(EntitySource) then
						repeat
							local Damage = math.ceil(Health - GetEntityHealth(EntitySource))

							if GetEntityHealth(EntitySource) >= 100 then
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 29, 108, 177)
							else
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 255, 255, 255)
							end

							Sure = Sure + 1

							Wait(1)
						until Sure > 200

						Health = GetEntityHealth(EntitySource)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWHITTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawHitText3D(coords, text, r, g, b)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	if onScreen then
		SetTextOutline(1)
		SetTextScale(0.50, 0.50)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		DrawText(x, y)
	end
end