-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("safecrack",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
animsIdle = {}
animsIdle[1] = "idle_base"
animsIdle[2] = "idle_heavy_breathe"
animsIdle[3] = "idle_look_around"

animsSucceed = {}
animsSucceed[1] = "dial_turn_succeed_1"
animsSucceed[2] = "dial_turn_succeed_2"
animsSucceed[3] = "dial_turn_succeed_3"
animsSucceed[4] = "dial_turn_succeed_4"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFECRAKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Safecrack(Number)
	vRP.Destroy()

	LoadTexture("MPSafeCracking")
	FreezeEntityPosition(PlayerPedId(),true)
	RequestAmbientAudioBank("SAFE_CRACK",false)

	difficultySetting = {}
	difficulty = parseInt(Number)

	for i = 1,difficulty do
		difficultySetting[i] = 1
	end

	desirednum = math.floor(math.random(99))
	if desirednum == 0 then
		desirednum = 1
	end

	i = 0.0
	dicks = 1
	safelock = 0
	currentLock = 1
	cracking = true
	factor = difficulty
	local pinfall = false
	openString = "lock_open"
	closedString = "lock_closed"

	TriggerEvent("inventory:Buttons",{
		{ "←","Girar para Esquerda" },
		{ "→","Girar para Direita" },
		{ "↑","Destrancar" }
	})

	crackingAnim(1)

	while cracking do
		Wait(1)

		DisableControlAction(0,257,true)
		DisableControlAction(0,140,true)
		DisableControlAction(0,142,true)
		DisableControlAction(0,38,true)
		DisablePlayerFiring(Ped,true)

		if IsControlPressed(0,175) then
			if dicks > 1 then
				i = i + 1.8
				PlaySoundFrontend(0,"TUMBLER_TURN","SAFE_CRACK_SOUNDSET",true)

				dicks = 0
				crackingAnim(1)
			end
		end

		if IsControlPressed(0,174) then
			if dicks > 1 then
				i = i - 1.8
				PlaySoundFrontend(0,"TUMBLER_TURN","SAFE_CRACK_SOUNDSET",true)

				dicks = 0
				crackingAnim(1)
			end
		end

		dicks = dicks + 0.2

		if i < 0.0 then
			i = 360.0
		end

		if i > 360.0 then
			i = 0.0
		end

		safelock = math.floor(100 - (i/3.6))

		if currentLock > difficulty then
			break
		end

		if safelock == desirednum then
			if not pinfall then
				PlaySoundFrontend(0,"TUMBLER_PIN_FALL","SAFE_CRACK_SOUNDSET",true)
				pinfall = true
			end

			if IsControlJustPressed(0,172) then
				pinfall = false
				PlaySoundFrontend(0,"TUMBLER_RESET","SAFE_CRACK_SOUNDSET",true)
				factor = factor / 2
				i = 0.0
				safelock = 0
				desirednum = math.floor(math.random(99))
				crackingAnim(2)
				if desirednum == 0 then
					desirednum = 1
				end

				difficultySetting[currentLock] = 0
				currentLock = currentLock + 1
			end
		else
			pinfall = false

			if IsControlJustPressed(0,172) then
				break
			end
		end

		DrawSprite("MPSafeCracking","Dial_BG",0.65,0.5,0.18,0.32,0,255,255,211,255)
		DrawSprite("MPSafeCracking","Dial",0.65,0.5,0.09,0.16,i,255,255,211,255)

		addition = 0.45
		xaddition = 0.58

		for x = 1,difficulty do
			if difficultySetting[x] ~= 1 then
				DrawSprite("MPSafeCracking",openString,xaddition,addition,0.012,0.024,0,255,255,211,255)
			else
				DrawSprite("MPSafeCracking",closedString,xaddition,addition,0.012,0.024,0,255,255,211,255)
			end

			addition = addition + 0.05

			if x == 10 or x == 20 or x == 30 then
				addition = 0.25
				xaddition = xaddition + 0.05
			end
		end
	end

	FreezeEntityPosition(PlayerPedId(),false)
	TriggerEvent("inventory:CloseButtons")
	vRP.Destroy()

	if currentLock > difficulty then
		PlaySoundFrontend(0,"SAFE_DOOR_OPEN","SAFE_CRACK_SOUNDSET",true)
		return true
	end

	PlaySoundFrontend(0,"SAFE_DOOR_CLOSE","SAFE_CRACK_SOUNDSET",true)

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAKINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function crackingAnim(animType)
	local Ped = PlayerPedId()

	if GetEntityHealth(Ped) > 100 and LoadAnim("mini@safe_cracking") then
		if animType == 1 and not IsEntityPlayingAnim(Ped,"mini@safe_cracking","dial_turn_anti_fast_1",3) then
			TaskPlayAnim(Ped,"mini@safe_cracking","dial_turn_anti_fast_1",8.0,8.0,-1,49,1,0,0,0)
		end

		if animType == 2 then
			TaskPlayAnim(Ped,"mini@safe_cracking",animsSucceed[math.floor(math.ceil(4))],8.0,8.0,-1,49,1,0,0,0)
		end
	end
end