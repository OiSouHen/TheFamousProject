-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Walk = nil
local Object = nil
local Point = false
local Crouch = false
local Button = GetGameTimer()
local AnimVars = { nil, nil, false, 49 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Walkers = {
	"move_m@alien", "anim_group_move_ballistic", "move_f@arrogant@a", "move_m@brave", "move_m@casual@a", "move_m@casual@b", "move_m@casual@c", "move_m@casual@d", "move_m@casual@e", "move_m@casual@f", "move_f@chichi", "move_m@confident", "move_m@business@a", "move_m@business@b", "move_m@business@c", "move_m@drunk@a", "move_m@drunk@slightlydrunk", "move_m@buzzed", "move_m@drunk@verydrunk", "move_f@femme@", "move_characters@franklin@fire", "move_characters@michael@fire", "move_m@fire", "move_f@flee@a", "move_p_m_one", "move_m@gangster@generic", "move_m@gangster@ng", "move_m@gangster@var_e", "move_m@gangster@var_f", "move_m@gangster@var_i", "anim@move_m@grooving@", "move_f@heels@c", "move_m@hipster@a", "move_m@hobo@a", "move_f@hurry@a", "move_p_m_zero_janitor", "move_p_m_zero_slow", "move_m@jog@", "anim_group_move_lemar_alley", "move_heist_lester", "move_f@maneater", "move_m@money", "move_m@posh@", "move_f@posh@", "move_m@quick", "female_fast_runner", "move_m@sad@a", "move_m@sassy", "move_f@sassy", "move_f@scared", "move_f@sexy@a", "move_m@shadyped@a", "move_characters@jimmy@slow@", "move_m@swagger", "move_m@tough_guy@", "move_f@tough_guy@", "move_p_m_two", "move_m@bag", "move_m@injured", "move_m@intimidation@cop@unarmed"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Walk", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	if Value then
		if LoadMovement(Value) then
			SetPedMovementClipset(PlayerPedId(), Value, 0.5)
			Walk = Value
		end
	else
		ResetPedMovementClipset(PlayerPedId(), 0.5)
		Walk = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar", function(source, Message)
	if not LocalPlayer["state"]["Walk"] and exports["chat"]:Open() then
		local Ped = PlayerPedId()

		if Message[1] then
			local Mode = parseInt(Message[1])

			if Walkers[Mode] and LoadMovement(Walkers[Mode]) then
				SetPedMovementClipset(Ped, Walkers[Mode], 0.5)
				Walk = Walkers[Mode]
			end
		else
			ResetPedMovementClipset(Ped, 0.5)
			Walk = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FACES
-----------------------------------------------------------------------------------------------------------------------------------------
local Faces = {
	["normal"] = "mood_normal_1",
	["triste"] = "mood_smug_1",
	["estressado"] = "mood_stressed_1",
	["rapido"] = "mood_drivefast_1",
	["leve"] = "mood_skydive_1",
	["bravo"] = "mood_angry_1",
	["bebado"] = "mood_drunk_1",
	["feliz"] = "mood_happy_1",
	["sulk"] = "mood_sulk_1",
	["atirando"] = "mood_aiming_1",
	["choque"] = "shocked_1",
	["choque2"] = "shocked_2",
	["sonolento"] = "mood_sleeping_1",
	["caindo"] = "mood_knockout_1",
	["morto"] = "dead_1",
	["morto2"] = "dead_2",
	["forte"] = "effort_1",
	["forte2"] = "effort_2",
	["forte3"] = "effort_3",
	["bemforte"] = "melee_effort_1",
	["bemforte1"] = "melee_effort_2",
	["bemforte2"] = "melee_effort_3",
	["machucado"] = "mood_injured_1",
	["machucado2"] = "pain_1",
	["machucado3"] = "pain_2",
	["machucado4"] = "pain_3",
	["machucado5"] = "pain_4",
	["machucado6"] = "pain_5",
	["machucado7"] = "pain_6",
	["morrendo"] = "die_1",
	["morrendo2"] = "die_2",
	["queimando"] = "burning_1",
	["eletrocutado"] = "electrocuted_1",
	["comendo"] = "eating_1",
	["bebendo"] = "drinking_1",
	["fumando"] = "smoking_inhale_1",
	["fumando2"] = "smoking_exhale_1",
	["fumando3"] = "smoking_hold_1",
	["tossindo"] = "coughing_1"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rosto", function(source, Message)
	if Message[1] and exports["chat"]:Open() then
		if Faces[Message[1]] then
			SetFacialIdleAnimOverride(GetPlayerPed(-1), Faces[Message[1]])
		else
			TriggerEvent("Notify", "amarelo", "Rosto inválido.", "Atenção", 5000)
		end
	else
		return false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Active"] and LocalPlayer["state"]["Cancel"] then
			TimeDistance = 1
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 38, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 137, true)
			DisablePlayerFiring(Ped, true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if UsingLbPhone then
			if LocalPlayer["state"]["Active"] and (exports["lb-phone"]:IsOpen() or AnimVars[3]) then
				TimeDistance = 1
				DisableControlAction(0, 18, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 68, true)
				DisableControlAction(0, 70, true)
				DisableControlAction(0, 91, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 143, true)
				DisableControlAction(0, 257, true)
				DisablePlayerFiring(Ped, true)

				if AnimVars[3] and not IsEntityPlayingAnim(Ped, AnimVars[1], AnimVars[2], 3) then
					TaskPlayAnim(Ped, AnimVars[1], AnimVars[2], 8.0, 8.0, -1, AnimVars[4], 1, 0, 0, 0)
				end
			end
		else
			if LocalPlayer["state"]["Active"] and (LocalPlayer["state"]["Phone"] or LocalPlayer["state"]["usingPhone"] or AnimVars[3]) then
				TimeDistance = 1
				DisableControlAction(0, 18, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 68, true)
				DisableControlAction(0, 70, true)
				DisableControlAction(0, 91, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 143, true)
				DisableControlAction(0, 257, true)
				DisablePlayerFiring(Ped, true)

				if AnimVars[3] and not IsEntityPlayingAnim(Ped, AnimVars[1], AnimVars[2], 3) then
					TaskPlayAnim(Ped, AnimVars[1], AnimVars[2], 8.0, 8.0, -1, AnimVars[4], 1, 0, 0, 0)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObjects(Dict, Anim, Prop, Flag, Hands, Height, Pos1, Pos2, Pos3, Pos4, Pos5)
	local Ped = PlayerPedId()
	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject", ObjToNet(Object))
		Object = nil
	end

	if Anim ~= "" then
		if LoadAnim(Dict) then
			TaskPlayAnim(Ped, Dict, Anim, 8.0, 8.0, -1, Flag, 1, 0, 0, 0)
		end

		AnimVars[4] = Flag
		AnimVars[3] = true
		AnimVars[1] = Dict
		AnimVars[2] = Anim
	end

	if not IsPedInAnyVehicle(Ped) then
		local Coords = GetEntityCoords(Ped)
		local Progression, Network = vRPS.CreateObject(Prop, Coords["x"], Coords["y"], Coords["z"])
		if Progression then
			Object = LoadNetwork(Network)
			if Object then
				if Height then
					AttachEntityToEntity(Object, Ped, GetPedBoneIndex(Ped, Hands), Height, Pos1, Pos2, Pos3, Pos4, Pos5, true, true, false, true, 1, true)
				else
					AttachEntityToEntity(Object, Ped, GetPedBoneIndex(Ped, Hands), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 2, true)
				end
			else
				Object = nil
			end

			SetModelAsNoLongerNeeded(Prop)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Destroy(Mode)
	local Ped = PlayerPedId()

	if IsPedUsingScenario(Ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT") then
		TriggerEvent("target:UpChair")
	elseif IsEntityPlayingAnim(Ped, "amb@world_human_sunbathe@female@back@idle_a", "idle_a", 3) or LocalPlayer["state"]["Bed"] then
		TriggerEvent("target:UpBed")
	end

	if Mode == "one" then
		tvRP.StopAnim(true)
	elseif Mode == "two" then
		tvRP.StopAnim(false)
	else
		tvRP.StopAnim(true)
		tvRP.StopAnim(false)
	end

	AnimVars[3] = false

	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject", ObjToNet(Object))
		Object = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 100
		if LocalPlayer["state"]["Active"] and Point then
			TimeDistance = 1
			local Ped = PlayerPedId()
			local Cam = GetGameplayCamRelativePitch()

			if Cam < -70.0 then
				Cam = -70.0
			elseif Cam > 42.0 then
				Cam = 42.0
			end

			Cam = (Cam + 70.0) / 112.0

			local CamHeading = GetGameplayCamRelativeHeading()
			local CosCamHeading = Cos(CamHeading)
			local SinCamHeading = Sin(CamHeading)
			if CamHeading < -180.0 then
				CamHeading = -180.0
			elseif CamHeading > 180.0 then
				CamHeading = 180.0
			end

			CamHeading = (CamHeading + 180.0) / 360.0

			local blocked = 0
			local Coords = GetOffsetFromEntityInWorldCoords(Ped, (CosCamHeading * -0.2) - (SinCamHeading * (0.4 * CamHeading + 0.3)), (SinCamHeading * -0.2) + (CosCamHeading * (0.4 * CamHeading + 0.3)), 0.6)
			local Ray = Cast_3dRayPointToPoint(Coords["x"], Coords["y"], Coords["z"] - 0.2, Coords["x"], Coords["y"], Coords["z"] + 0.2, 0.4, 95, Ped, 7);
			_, blocked = GetRaycastResult(Ray)

			SetTaskMoveNetworkSignalFloat(Ped, "Pitch", Cam)
			SetTaskMoveNetworkSignalFloat(Ped, "Heading", CamHeading * -1.0 + 1.0)
			SetTaskMoveNetworkSignalBool(Ped, "isBlocked", blocked)
			SetTaskMoveNetworkSignalBool(Ped, "isFirstPerson", GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Cancel", function()
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500
			TriggerEvent("inventory:Cancel")
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500
			TriggerEvent("inventory:Cancel")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("HandsUp", function()
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if IsEntityPlayingAnim(Ped, "random@mugging3", "handsup_standing_base", 3) then
				StopAnimTask(Ped, "random@mugging3", "handsup_standing_base", 8.0)
				tvRP.AnimActive()
			else
				tvRP.PlayAnim(true, { "random@mugging3", "handsup_standing_base" }, true)
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if IsEntityPlayingAnim(Ped, "random@mugging3", "handsup_standing_base", 3) then
				StopAnimTask(Ped, "random@mugging3", "handsup_standing_base", 8.0)
				tvRP.AnimActive()
			else
				tvRP.PlayAnim(true, { "random@mugging3", "handsup_standing_base" }, true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Point", function()
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if not Point then
				Point = true
				tvRP.AnimActive()
				SetPedConfigFlag(Ped, 36, true)

				if LoadAnim("anim@mp_point") then
					TaskMoveNetwork(Ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
				end
			else
				RequestTaskMoveNetworkStateTransition(Ped, "Stop")
				if not IsPedInjured(Ped) then
					ClearPedSecondaryTask(Ped)
				end

				SetPedConfigFlag(Ped, 36, false)
				ClearPedSecondaryTask(Ped)
				Point = false
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if not Point then
				Point = true
				tvRP.AnimActive()
				SetPedConfigFlag(Ped, 36, true)

				if LoadAnim("anim@mp_point") then
					TaskMoveNetwork(Ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
				end
			else
				RequestTaskMoveNetworkStateTransition(Ped, "Stop")
				if not IsPedInjured(Ped) then
					ClearPedSecondaryTask(Ped)
				end

				SetPedConfigFlag(Ped, 36, false)
				ClearPedSecondaryTask(Ped)
				Point = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Engine", function()
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle, -1) == Ped then
				local Running = GetIsVehicleEngineRunning(Vehicle)
				SetVehicleEngineOn(Vehicle, not Running, true, true)

				if Running then
					SetVehicleUndriveable(Vehicle, true)
				else
					SetVehicleUndriveable(Vehicle, false)
				end
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle, -1) == Ped then
				local Running = GetIsVehicleEngineRunning(Vehicle)
				SetVehicleEngineOn(Vehicle, not Running, true, true)

				if Running then
					SetVehicleUndriveable(Vehicle, true)
				else
					SetVehicleUndriveable(Vehicle, false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CROUCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Crouch", function()
	DisableControlAction(0, 36, true)

	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if Crouch then
				Crouch = false
				ResetPedStrafeClipset(Ped)
				ResetPedMovementClipset(Ped, 0.5)

				if Walk and LoadMovement(Walk) then
					SetPedMovementClipset(Ped, Walk, 0.5)
				end
			else
				if LoadMovement("move_ped_crouched") and LoadMovement("move_ped_crouched_strafing") then
					SetPedStrafeClipset(Ped, "move_ped_crouched_strafing")
					SetPedMovementClipset(Ped, "move_ped_crouched", 0.5)
					Crouch = true

					while Crouch do
						DisablePlayerFiring(Ped, true)
						Wait(1)
					end
				end
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if Crouch then
				Crouch = false
				ResetPedStrafeClipset(Ped)
				ResetPedMovementClipset(Ped, 0.5)

				if Walk and LoadMovement(Walk) then
					SetPedMovementClipset(Ped, Walk, 0.5)
				end
			else
				if LoadMovement("move_ped_crouched") and LoadMovement("move_ped_crouched_strafing") then
					SetPedStrafeClipset(Ped, "move_ped_crouched_strafing")
					SetPedMovementClipset(Ped, "move_ped_crouched", 0.5)
					Crouch = true

					while Crouch do
						DisablePlayerFiring(Ped, true)
						Wait(1)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Binds", function(source, Message)
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if parseInt(Message[1]) >= 1 and parseInt(Message[1]) <= 5 then
				TriggerEvent("inventory:Use", Message[1], 1)
			elseif Message[1] == "6" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "anim@heists@heist_corona@single_team", "single_team_loop_boss", 3) then
						StopAnimTask(Ped, "anim@heists@heist_corona@single_team", "single_team_loop_boss", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }, true)
					end
				end
			elseif Message[1] == "7" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "mini@strip_club@idles@bouncer@base", "base", 3) then
						StopAnimTask(Ped, "mini@strip_club@idles@bouncer@base", "base", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "mini@strip_club@idles@bouncer@base", "base" }, true)
					end
				end
			elseif Message[1] == "8" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "anim@mp_player_intupperfinger", "idle_a_fp", 3) then
						StopAnimTask(Ped, "anim@mp_player_intupperfinger", "idle_a_fp", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "anim@mp_player_intupperfinger", "idle_a_fp" }, true)
					end
				end
			elseif Message[1] == "9" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "random@arrests@busted", "idle_a", 3) then
						StopAnimTask(Ped, "random@arrests@busted", "idle_a", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "random@arrests@busted", "idle_a" }, true)
					end
				end
			elseif Message[1] == "left" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intupperthumbs_up", "enter" }, false)
				end
			elseif Message[1] == "right" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intcelebrationmale@face_palm", "face_palm" }, false)
				end
			elseif Message[1] == "up" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intcelebrationmale@salute", "salute" }, false)
				end
			elseif Message[1] == "down" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
				end
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			if parseInt(Message[1]) >= 1 and parseInt(Message[1]) <= 5 then
				TriggerEvent("inventory:Use", Message[1], 1)
			elseif Message[1] == "6" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "anim@heists@heist_corona@single_team", "single_team_loop_boss", 3) then
						StopAnimTask(Ped, "anim@heists@heist_corona@single_team", "single_team_loop_boss", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }, true)
					end
				end
			elseif Message[1] == "7" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "mini@strip_club@idles@bouncer@base", "base", 3) then
						StopAnimTask(Ped, "mini@strip_club@idles@bouncer@base", "base", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "mini@strip_club@idles@bouncer@base", "base" }, true)
					end
				end
			elseif Message[1] == "8" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "anim@mp_player_intupperfinger", "idle_a_fp", 3) then
						StopAnimTask(Ped, "anim@mp_player_intupperfinger", "idle_a_fp", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "anim@mp_player_intupperfinger", "idle_a_fp" }, true)
					end
				end
			elseif Message[1] == "9" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped, "random@arrests@busted", "idle_a", 3) then
						StopAnimTask(Ped, "random@arrests@busted", "idle_a", 8.0)
						tvRP.AnimActive()
					else
						tvRP.PlayAnim(true, { "random@arrests@busted", "idle_a" }, true)
					end
				end
			elseif Message[1] == "left" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intupperthumbs_up", "enter" }, false)
				end
			elseif Message[1] == "right" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intcelebrationmale@face_palm", "face_palm" }, false)
				end
			elseif Message[1] == "up" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "anim@mp_player_intcelebrationmale@salute", "salute" }, false)
				end
			elseif Message[1] == "down" and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Commands"] then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) then
					tvRP.PlayAnim(true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Lock", function()
	local Ped = PlayerPedId()
	if UsingLbPhone then
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			local Vehicle, Network, Plate, Model = tvRP.VehicleList(5)
			if Vehicle then
				TriggerServerEvent("garages:Lock", Network, Plate, Model)
			end
		end
	else
		if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			Button = GetGameTimer() + 500

			local Vehicle, Network, Plate, Model = tvRP.VehicleList(5)
			if Vehicle then
				TriggerServerEvent("garages:Lock", Network, Plate, Model)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Cancel", "Cancelar todas as ações.", "keyboard", "F6")
RegisterKeyMapping("HandsUp", "Levantar as mãos.", "keyboard", "X")
RegisterKeyMapping("Point", "Apontar os dedos.", "keyboard", "B")
RegisterKeyMapping("Crouch", "Agachar.", "keyboard", "LCONTROL")
RegisterKeyMapping("Engine", "Ligar o veículo.", "keyboard", "Z")
RegisterKeyMapping("Binds 1", "Interação do botão 1.", "keyboard", "1")
RegisterKeyMapping("Binds 2", "Interação do botão 2.", "keyboard", "2")
RegisterKeyMapping("Binds 3", "Interação do botão 3.", "keyboard", "3")
RegisterKeyMapping("Binds 4", "Interação do botão 4.", "keyboard", "4")
RegisterKeyMapping("Binds 5", "Interação do botão 5.", "keyboard", "5")
RegisterKeyMapping("Binds 6", "Interação do botão 6.", "keyboard", "6")
RegisterKeyMapping("Binds 7", "Interação do botão 7.", "keyboard", "7")
RegisterKeyMapping("Binds 8", "Interação do botão 8.", "keyboard", "8")
RegisterKeyMapping("Binds 9", "Interação do botão 9.", "keyboard", "9")
RegisterKeyMapping("Binds left", "Interação da seta esquerda.", "keyboard", "LEFT")
RegisterKeyMapping("Binds right", "Interação da seta direita.", "keyboard", "RIGHT")
RegisterKeyMapping("Binds up", "Interação da seta pra cima.", "keyboard", "UP")
RegisterKeyMapping("Binds down", "Interação da seta pra baixo.", "keyboard", "DOWN")
RegisterKeyMapping("Lock", "Trancar/Destrancar o veículo.", "keyboard", "L")