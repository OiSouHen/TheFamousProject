-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Binded = {}
local Object = nil
local Point = false
local Crouch = false
local Persistent = nil
local PersistentList = {}
local Button = GetGameTimer()
local AnimVars = { nil,nil,false,49 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CreativeBinds = GetResourceKvpString("CreativeBinds")
	Binded = (CreativeBinds and json.decode(CreativeBinds)) or {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Route",0,true)
LocalPlayer["state"]:set("Name","",false)
LocalPlayer["state"]:set("Passport",0,true)
LocalPlayer["state"]:set("Carry",false,true)
LocalPlayer["state"]:set("Walk",false,false)
LocalPlayer["state"]:set("Cancel",false,true)
LocalPlayer["state"]:set("Camera",false,true)
LocalPlayer["state"]:set("Hoverfy",true,false)
LocalPlayer["state"]:set("Bennys",false,false)
LocalPlayer["state"]:set("Prison",false,false)
LocalPlayer["state"]:set("Active",false,false)
LocalPlayer["state"]:set("Freecam",false,false)
LocalPlayer["state"]:set("Handcuff",false,true)
LocalPlayer["state"]:set("Commands",false,true)
LocalPlayer["state"]:set("Spectate",false,false)
LocalPlayer["state"]:set("DamageModify",false,false)

LocalPlayer["state"]:set("Nitro",false,true)
LocalPlayer["state"]:set("Buttons",false,true)
LocalPlayer["state"]:set("TestDrive",false,false)
LocalPlayer["state"]:set("BlockLocked",false,false)
LocalPlayer["state"]:set("Source",GetPlayerServerId(PlayerId()),true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Walkers = {
	"move_m@alien","anim_group_move_ballistic","move_f@arrogant@a","move_m@brave","move_m@casual@a","move_m@casual@b","move_m@casual@c",
	"move_m@casual@d","move_m@casual@e","move_m@casual@f","move_f@chichi","move_m@confident","move_m@business@a","move_m@business@b",
	"move_m@business@c","move_m@drunk@a","move_m@drunk@slightlydrunk","move_m@buzzed","move_m@drunk@verydrunk","move_f@femme@",
	"move_characters@franklin@fire","move_characters@michael@fire","move_m@fire","move_f@flee@a","move_p_m_one","move_m@gangster@generic",
	"move_m@gangster@ng","move_m@gangster@var_e","move_m@gangster@var_f","move_m@gangster@var_i","anim@move_m@grooving@","move_f@heels@c",
	"move_m@hipster@a","move_m@hobo@a","move_f@hurry@a","move_p_m_zero_janitor","move_p_m_zero_slow","move_m@jog@","anim_group_move_lemar_alley",
	"move_heist_lester","move_f@maneater","move_m@money","move_m@posh@","move_f@posh@","move_m@quick","female_fast_runner","move_m@sad@a",
	"move_m@sassy","move_f@sassy","move_f@scared","move_f@sexy@a","move_m@shadyped@a","move_characters@jimmy@slow@","move_m@swagger",
	"move_m@tough_guy@","move_f@tough_guy@","move_p_m_two","move_m@bag","move_m@intimidation@cop@unarmed"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Walk",("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
	if Value then
		if LoadMovement(Value) then
			SetPedMovementClipset(PlayerPedId(),Value,0.5)
			Walk = Value
		end
	else
		ResetPedMovementClipset(PlayerPedId(),0.5)
		Walk = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,Message)
	if not LocalPlayer["state"]["Walk"] and exports["chat"]:Open() then
		local Ped = PlayerPedId()

		if Message[1] then
			local Mode = parseInt(Message[1])

			if Walkers[Mode] and LoadMovement(Walkers[Mode]) then
				Walk = Walkers[Mode]
				SetPedMovementClipset(Ped,Walk,0.5)
			end
		else
			ResetPedMovementClipset(Ped,0.5)
			Walk = false
		end
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
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,137,true)
			DisablePlayerFiring(Ped,true)
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
		if LocalPlayer["state"]["Active"] and (exports["lb-phone"]:IsOpen() or AnimVars[3]) then
			TimeDistance = 1
			DisableControlAction(0,18,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,68,true)
			DisableControlAction(0,70,true)
			DisableControlAction(0,91,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,257,true)
			DisablePlayerFiring(Ped,true)

			if AnimVars[3] and not IsEntityPlayingAnim(Ped,AnimVars[1],AnimVars[2],3) then
				TaskPlayAnim(Ped,AnimVars[1],AnimVars[2],8.0,8.0,-1,AnimVars[4],1,0,0,0)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObjects(Dict,Anim,Prop,Flag,Hands,Height,Pos1,Pos2,Pos3,Pos4,Pos5)
	local Ped = PlayerPedId()
	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject",ObjToNet(Object))
		Object = nil
	end

	if Anim ~= "" then
		if LoadAnim(Dict) then
			TaskPlayAnim(Ped,Dict,Anim,8.0,8.0,-1,Flag,1,0,0,0)
		end

		AnimVars = { Dict,Anim,true,Flag }
	end

	if not IsPedInAnyVehicle(Ped) then
		local Coords = GetEntityCoords(Ped)
		local Network = vRPS.CreateObject(Prop,Coords["x"],Coords["y"],Coords["z"])
		if Network then
			Object = LoadNetwork(Network)
			if Object then
				SetEntityLodDist(Object,0xFFFF)
				SetModelAsNoLongerNeeded(Prop)

				if Height then
					AttachEntityToEntity(Object,Ped,GetPedBoneIndex(Ped,Hands),Height,Pos1,Pos2,Pos3,Pos4,Pos5,true,true,false,true,1,true)
				else
					AttachEntityToEntity(Object,Ped,GetPedBoneIndex(Ped,Hands),0.0,0.0,0.0,0.0,0.0,0.0,true,true,false,true,2,true)
				end
			else
				Object = nil
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Destroy(Mode)
	local Ped = PlayerPedId()

	if IsPedUsingScenario(Ped,"PROP_HUMAN_SEAT_CHAIR_UPRIGHT") then
		TriggerEvent("target:UpChair")
	elseif IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) or LocalPlayer["state"]["Bed"] then
		TriggerEvent("target:UpBed")
	end

	if Mode == "one" then
		tvRP.stopAnim(true)
	elseif Mode == "two" then
		tvRP.stopAnim(false)
	else
		tvRP.stopAnim(true)
		tvRP.stopAnim(false)
	end

	AnimVars[3] = false

	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject",ObjToNet(Object))
		Object = nil
	end

	if Persistent then
		TriggerEvent("emotes",Persistent["Anim"])
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

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end

			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local Coords = GetOffsetFromEntityInWorldCoords(Ped,(cosCamHeading * - 0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)),(sinCamHeading * - 0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)),0.6)
			local Ray = Cast_3dRayPointToPoint(Coords["x"],Coords["y"],Coords["z"] - 0.2,Coords["x"],Coords["y"],Coords["z"] + 0.2,0.4,95,Ped,7);
			_,blocked = GetRaycastResult(Ray)

			SetTaskMoveNetworkSignalFloat(Ped,"Pitch",Cam)
			SetTaskMoveNetworkSignalFloat(Ped,"Heading",camHeading * -1.0 + 1.0)
			SetTaskMoveNetworkSignalBool(Ped,"isBlocked",blocked)
			SetTaskMoveNetworkSignalBool(Ped,"isFirstPerson",GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Cancel",function()
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500
		TriggerServerEvent("inventory:Cancel")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("HandsUp",function()
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500

		if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
			StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
			tvRP.AnimActive()
		else
			tvRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Point",function()
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500

		if not Point then
			Point = true
			tvRP.AnimActive()
			SetPedConfigFlag(Ped,36,true)

			if LoadAnim("anim@mp_point") then
				TaskMoveNetwork(Ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
			end
		else
			RequestTaskMoveNetworkStateTransition(Ped,"Stop")
			if not IsPedInjured(Ped) then
				ClearPedSecondaryTask(Ped)
			end

			SetPedConfigFlag(Ped,36,false)
			ClearPedSecondaryTask(Ped)
			Point = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Engine",function()
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500

		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped then
			local Running = GetIsVehicleEngineRunning(Vehicle)
			SetVehicleEngineOn(Vehicle,not Running,true,true)

			if Running then
				SetVehicleUndriveable(Vehicle,true)
			else
				SetVehicleUndriveable(Vehicle,false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CROUCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Crouch",function()
	DisableControlAction(0,36,true)

	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500

		if Crouch then
			Crouch = false
			ResetPedStrafeClipset(Ped)
			ResetPedMovementClipset(Ped,0.5)

			if Walk and LoadMovement(Walk) then
				SetPedMovementClipset(Ped,Walk,0.5)
			end
		else
			if LoadMovement("move_ped_crouched") and LoadMovement("move_ped_crouched_strafing") then
				SetPedStrafeClipset(Ped,"move_ped_crouched_strafing")
				SetPedMovementClipset(Ped,"move_ped_crouched",0.5)
				Crouch = true

				while Crouch do
					DisablePlayerFiring(Ped,true)
					Wait(1)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FASTBINDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("FastBinds",function(source,Message)
	local Ped = PlayerPedId()
	if (parseInt(Message[1]) >= 101 and parseInt(Message[1]) <= 103) and LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500
		TriggerEvent("inventory:Use",Message[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBINDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("NumBinds",function(source,Message)
	local Ped = PlayerPedId()
	if Message[1] and (Binded[Message[1]] or Message[1] == "0") and LocalPlayer["state"]["Active"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,7) and not IsPedSwimming(Ped) then
		Button = GetGameTimer() + 500

		if Message[1] == "0" then
			SetPedToRagdoll(Ped,2500,2500,0,0,0,0)
		else
			TriggerEvent("emotes",Binded[Message[1]])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("binds",function(source,Message)
	if Message[1] and Message[2] and parseInt(Message[1]) >= 1 and parseInt(Message[1]) <= 9 then
		Binded[Message[1]] = Message[2]
		SetResourceKvp("CreativeBinds",json.encode(Binded))
		TriggerEvent("Notify","Animações","A animação <b>"..Message[2].."</b> foi salvo na tecla <b>"..Message[1].."</b>.","verde",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Lock",function()
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and not LocalPlayer["state"]["BlockLocked"] and GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not exports["lb-phone"]:IsOpen() and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 500

		local Vehicle,Network = tvRP.VehicleList()
		if Vehicle then
			TriggerServerEvent("garages:Lock",Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERSISTENTBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PersistentBlock(Item,Animation)
	local Item = SplitOne(Item)

	if not Persistent then
		Persistent = {
			["Item"] = Item,
			["Anim"] = Animation
		}

		TriggerEvent("emotes",Animation)
	elseif Persistent and Item ~= Persistent["Item"] then
		PersistentList[#PersistentList + 1] = {
			["Item"] = Item,
			["Anim"] = Animation
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERSISTENTNONE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PersistentNone(Item)
	local Item = SplitOne(Item)

	if Persistent and Item == Persistent["Item"] then
		Persistent = nil
		tvRP.Destroy()
	else
		for Index,v in pairs(PersistentList) do
			if Item == v["Item"] then
				PersistentList[Index] = nil

				break
			end
		end
	end

	for Index,v in pairs(PersistentList) do
		tvRP.PersistentBlock(v["Item"],v["Anim"])
		PersistentList[Index] = nil

		break
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Cancel","Cancelar todas as ações.","keyboard","F6")
RegisterKeyMapping("HandsUp","Levantar as mãos.","keyboard","X")
RegisterKeyMapping("Point","Apontar os dedos.","keyboard","B")
RegisterKeyMapping("Crouch","Agachar.","keyboard","LCONTROL")
RegisterKeyMapping("Engine","Ligar o veículo.","keyboard","Z")
RegisterKeyMapping("Lock","Trancar/Destrancar.","keyboard","L")

RegisterKeyMapping("FastBinds 101","Interação do botão 1.","keyboard","1")
RegisterKeyMapping("FastBinds 102","Interação do botão 2.","keyboard","2")
RegisterKeyMapping("FastBinds 103","Interação do botão 3.","keyboard","3")

RegisterKeyMapping("NumBinds 0","Interação de animação 0.","keyboard","NUMPAD0")
RegisterKeyMapping("NumBinds 1","Interação de animação 1.","keyboard","NUMPAD1")
RegisterKeyMapping("NumBinds 2","Interação de animação 2.","keyboard","NUMPAD2")
RegisterKeyMapping("NumBinds 3","Interação de animação 3.","keyboard","NUMPAD3")
RegisterKeyMapping("NumBinds 4","Interação de animação 4.","keyboard","NUMPAD4")
RegisterKeyMapping("NumBinds 5","Interação de animação 5.","keyboard","NUMPAD5")
RegisterKeyMapping("NumBinds 6","Interação de animação 6.","keyboard","NUMPAD6")
RegisterKeyMapping("NumBinds 7","Interação de animação 7.","keyboard","NUMPAD7")
RegisterKeyMapping("NumBinds 8","Interação de animação 8.","keyboard","NUMPAD8")
RegisterKeyMapping("NumBinds 9","Interação de animação 9.","keyboard","NUMPAD9")