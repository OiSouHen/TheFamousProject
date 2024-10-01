local ENTITY_MODELHASH__DOCTOR    = `s_m_y_autopsy_01`
local ENTITY_MODELHASH__CLIPBOARD = `p_cs_clipboard`
local ENTITY_MODELHASH__PENCIL    = `prop_pencil_01`

local ENTITY_ATTACHBONE__CLIPBOARD = 60309
local ENTITY_ATTACHBONE__PENCIL    = 28422

local ENTITY_POSITION__DOCTOR_WITH_CLIPBOARD = vector4(278.6999, -1337.546, 23.261, 328.000)
local ENTITY_POSITION__DOCTOR_NO_CLIPBOARD   = vector4(280.0447, -1336.337, 23.241, 148.573)

local POST_CUSTCENE_TELEPORT_POS = vector4(240.9, -1379.18, 33.73, 137.06)
local gCameraId

local gZipbigUnkSpriteCenterY
local gZipbigSpriteCenterY
local gZipbigAudioPlayed
local gZipbigAudioId

local gEntityId__player
local gEntityId__playerClone
local gEntityId__doctorWithClipboard
local gEntityId__doctorNoClipboard
local gEntityId__clipboard
local gEntityId__pencil

local gSceneId__withClipboard
local gSceneId__noClipboard
local gSceneId__player

local FSM = { state = nil }

local function CreatePedWithDefaults(modelHash, pos, heading)
	local entityId = CreatePed(26, modelHash, pos.x, pos.y, pos.z, heading, false, true)

	-- SetPedRandomComponentVariation(entityId, 0)
	-- SetPedDiesWhenInjured(entityId, true)
	-- SetPedKeepTask(entityId, true)
	-- SetPedConfigFlag(entityId, 132, true)

	ForcePedAiAndAnimationUpdate(entityId, false, false)

	-- SetPedCanPlayAmbientAnims(entityId, false)
	SetPedCanUseAutoConversationLookat(entityId, true)

    return entityId
end

local function DeleteEntitySafe(entityId)
    if not DoesEntityExist(entityId) then
        return
    end

    DeleteEntity(entityId)
end

local function LoadAssets()
	RequestModel(ENTITY_MODELHASH__DOCTOR)
	RequestModel(ENTITY_MODELHASH__CLIPBOARD)
	RequestModel(ENTITY_MODELHASH__PENCIL)

	RequestAnimDict('missfbi1')
	RequestStreamedTextureDict('fbi1', false)
	-- PrepareAlarm('FBI_01_MORGUE_ALARMS')

	RequestAmbientAudioBank('SCRIPT\\FBI_01_DMW_01', false, -1)

	RequestAmbientAudioBank('SCRIPT\\FBI_01_DMW_02', false, -1)

	RequestAmbientAudioBank('SCRIPT\\FBI_01_DMW_Autopsy_1', false, -1)
	
	-- LoadStream('FIB1_MORGUE_AMBIENCE_master', 0)

	StopScriptedConversation(true)

	ClearAdditionalText(0, true)

	RequestAdditionalText('fbi1', 0)
	RequestAdditionalText('fbi1aud', 6)

    while
		not HasModelLoaded(ENTITY_MODELHASH__DOCTOR) or
		not HasModelLoaded(ENTITY_MODELHASH__CLIPBOARD) or
		not HasModelLoaded(ENTITY_MODELHASH__PENCIL) or
		not HasAdditionalTextLoaded(0) or
		not HasAdditionalTextLoaded(6)
	do
		Wait(0)
	end

	PrepareMusicEvent('FBI1_WAKE_UP')

	PlayStreamFrontend()
end

local function ReleaseAssets()
	SetModelAsNoLongerNeeded(ENTITY_MODELHASH__DOCTOR)
	SetModelAsNoLongerNeeded(ENTITY_MODELHASH__CLIPBOARD)
	SetModelAsNoLongerNeeded(ENTITY_MODELHASH__PENCIL)

	RemoveAnimDict('missfbi1')
	SetStreamedTextureDictAsNoLongerNeeded('fbi1', false)

	ReleaseNamedScriptAudioBank('SCRIPT\\FBI_01_DMW_01', false, -1)
	ReleaseNamedScriptAudioBank('SCRIPT\\FBI_01_DMW_02', false, -1)
	ReleaseNamedScriptAudioBank('script\\FBI_01_DMW_Autopsy_1', false, -1)

	StopAudioScene('FBI1_WAKE_UP')

	-- CancelMusicEvent('FBI1_WAKE_UP')

	ClearAdditionalText(0)
end

function FSM:tick()
	self['state__' .. self.state](self)
end

function FSM:nextState()
	self.state = self.state and self.state + 1 or 0
end

function FSM:getState()
	return self.state
end

function FSM:finish()
	self.state = nil
end

function FSM:isActive()
	return self.state ~= nil
end

function FSM:state__0()
	-- RequestAnimDict('Dead')

	local playerPedId = PlayerPedId()

	gEntityId__player 			   = playerPedId
	gEntityId__playerClone 		   = ClonePed(playerPedId, false, true, true)
    gEntityId__doctorWithClipboard = CreatePedWithDefaults(ENTITY_MODELHASH__DOCTOR, ENTITY_POSITION__DOCTOR_WITH_CLIPBOARD, ENTITY_POSITION__DOCTOR_WITH_CLIPBOARD.w)
    gEntityId__doctorNoClipboard   = CreatePedWithDefaults(ENTITY_MODELHASH__DOCTOR, ENTITY_POSITION__DOCTOR_NO_CLIPBOARD  , ENTITY_POSITION__DOCTOR_NO_CLIPBOARD.w  )

    local posDoctorWithClipboard = GetEntityCoords(gEntityId__doctorWithClipboard)

    gEntityId__clipboard = CreateObject(ENTITY_MODELHASH__CLIPBOARD, posDoctorWithClipboard.x, posDoctorWithClipboard.y, posDoctorWithClipboard.z, false, true, false)
    gEntityId__pencil    = CreateObject(ENTITY_MODELHASH__PENCIL   , posDoctorWithClipboard.x, posDoctorWithClipboard.y, posDoctorWithClipboard.z, false, true, false)

    AttachEntityToEntity(gEntityId__clipboard, gEntityId__doctorWithClipboard, GetPedBoneIndex(gEntityId__doctorWithClipboard, ENTITY_ATTACHBONE__CLIPBOARD), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    AttachEntityToEntity(gEntityId__pencil   , gEntityId__doctorWithClipboard, GetPedBoneIndex(gEntityId__doctorWithClipboard, ENTITY_ATTACHBONE__PENCIL)   , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    local CAM_POS = vec3(280.336, -1335.462, 24.55331)

	gCameraId = CreateCamWithParams('default_scripted_camera', CAM_POS.x, CAM_POS.y, CAM_POS.z, 63.40054, 0.0, -129.3897, 56.0, false, 2)
	SetCamNearDof(gCameraId, 0.01)
	SetCamFarDof(gCameraId, 0.05)
	SetCamDofStrength(gCameraId, 0.2)
	SetCamUseShallowDofMode(gCameraId, true)

    SetFocusPosAndVel(CAM_POS.x, CAM_POS.y, CAM_POS.z, 0.0, 0.0, 0.0)

	SetEntityCoords(gEntityId__player     , CAM_POS.x, CAM_POS.y, CAM_POS.z)
	SetEntityCoords(gEntityId__playerClone, CAM_POS.x, CAM_POS.y, CAM_POS.z)

	SetPedComponentVariation(gEntityId__doctorWithClipboard, 0, 0, 0, 0)
	SetPedComponentVariation(gEntityId__doctorWithClipboard, 3, 0, 0, 0)

	do
		gSceneId__withClipboard = CreateSynchronizedScene(280.583, -1335.896, 23.588, 0.0, 0.0, 38.0, 2)
		TaskSynchronizedScene(gEntityId__doctorWithClipboard, gSceneId__withClipboard, 'missfbi1', 'fbi_1_ig_1_b_clipb', 1000.0, -8.0, 0, 0, 1000.0, 0)
	end

	do
		gSceneId__noClipboard = CreateSynchronizedScene(281.083, -1336.146, 23.638, 0.0, 0.0, 44.0, 2)
		TaskSynchronizedScene(gEntityId__doctorNoClipboard, gSceneId__noClipboard, 'missfbi1', 'fbi_1_ig_1_a', 1000.0, -8.0, 0, 0, 1000.0, 0)

		SetSynchronizedScenePhase(gSceneId__noClipboard, 0.145)
		SetSynchronizedSceneRate(gSceneId__noClipboard, 0.0)
	end

	do
		gSceneId__player = CreateSynchronizedScene(280.645, -1335.833, 24.5, 0.0, 0.0, -138.0, 2)
		TaskSynchronizedScene(gEntityId__player, gSceneId__player, 'missfbi1', 'cpr_pumpchest_idle', 1000.0, -8.0, 0, 0, 1000.0, 0)
	end

	CreateNewScriptedConversation()

	AddPedToConversation(3 --[[ SpeakerConversationIndex ]], gEntityId__doctorWithClipboard, 'doctor1')
	AddPedToConversation(4 --[[ SpeakerConversationIndex ]], gEntityId__doctorNoClipboard, 'doctor2')

	--[[
		A gente troca os speaker intermitente, porque se não a gente vai ter linhas de dialogo duplicada,
		fazendo com que o dialogo dure mais do que deveria!
	]]
	local currSpeaker = 4
	
	for i = 1, 7 do
		local conversation = 'fbi1_doc1'
		local subtitle = ('%s_%d'):format(conversation, i)
		local contextTextLabel = subtitle .. 'A'
		local context = GetLabelText(contextTextLabel)

		-- print('context', contextTextLabel, context)

		if not DoesTextLabelExist(contextTextLabel) then
			break
		end

		--[[ Ignorar falas de pausa (SFX_PAUSE), para que a conversa dure menos tempo! ]]
		if not context:find('SFX_PAUSE') then

			AddLineToConversation(
				currSpeaker, --[[ SpeakerNumber ]]
				context, --[[ Context ]]
				subtitle, --[[ Subtitle]]
				0, --[[ ListenerNumber ]]
				0, --[[ volumeType ]]
				false, --[[ isRandom ]]
				false, --[[ interruptible ]]
				0, --[[ ducksRadio ]]
				0, --[[ ducksScore ]]
				0, --[[ audibility ]]
				true, --[[ headset ]]
				false,--[[ dontInterruptForSpecialAbility ]]
				false --[[ isPadSpeakerRoute ]]
			)

			currSpeaker = currSpeaker == 3 and 4 or 3
		end
	end

    StartScriptConversation(
		true, --[[ DisplaySubtitles ]]
		true, --[[ addToBriefScreen ]]
		true, --[[ cloneConversation ]]
		false --[[ Interruptible ]]
	)

	SetEntityVisible(gEntityId__player     , false, false)
	SetEntityVisible(gEntityId__playerClone, false, false)

	gZipbigUnkSpriteCenterY = 0.05
	gZipbigSpriteCenterY = -0.5

	SetCamActive(gCameraId, true)
	RenderScriptCams(true, false, 3000, true, false, 0)

	DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255, false)

	Wait(0)

	SetScriptGfxDrawOrder(1)

	DoScreenFadeIn(2000)

	StartAudioScene('FBI_01_DMW_IN_BODY_BAG')

	FSM:nextState()

	DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255, false)
end

function FSM:state__1()
	DrawSprite('fbi1', 'zipbig', 0.5, gZipbigSpriteCenterY, 1.0, 3.1, 0.0, 255, 255, 255, 255, false)

	if IsScreenFadedIn() then
		
		if not IsScriptedConversationOngoing() then
			FSM:nextState()
		end
	end

	SetUseHiDof()
end

function FSM:state__2()
	SetScriptGfxDrawOrder(1)
	SetScriptGfxDrawBehindPausemenu(true)

	if not IsScriptedConversationOngoing() then

		if not gZipbigAudioPlayed then

			-- TriggerMusicEvent('FBI1_WAKE_UP')

			StopAudioScene('FBI_01_DMW_IN_BODY_BAG')

			--[[ Não funciona ]]
			PlaySoundFromEntity(gZipbigAudioId, 'UNZIP', gEntityId__player, 'FBI_01_SOUNDS', false, 0)

			SetSynchronizedSceneRate(gSceneId__noClipboard, 1.0)

			gZipbigAudioPlayed = true
		end

		if gZipbigUnkSpriteCenterY < 0.2 then
			gZipbigUnkSpriteCenterY = gZipbigUnkSpriteCenterY + 0.01
		end
		
		if gZipbigSpriteCenterY < 2.5 then
			gZipbigSpriteCenterY = (gZipbigSpriteCenterY + gZipbigUnkSpriteCenterY)

			DrawSprite('fbi1', 'zipbig', 0.5, gZipbigSpriteCenterY, 1.0, 3.1, 0.0, 255, 255, 255, 255, false)
		else
			if not HasSoundFinished(gZipbigAudioId) then
				StopSound(gZipbigAudioId)
			end

			FSM:nextState()

			--[[ Preparando conversation para o proximo state ]]

			StopScriptedConversation(true)

			CreateNewScriptedConversation()

			AddPedToConversation(3 --[[ SpeakerConversationIndex ]], gEntityId__doctorWithClipboard, 'doctor1')
			AddPedToConversation(4 --[[ SpeakerConversationIndex ]], gEntityId__doctorNoClipboard, 'doctor2')

			--[[ O primeiro a falar vai ser o segundo doutor ]]
			local currSpeaker = 4

			for i = 1, 8 do
				local subtitle = ('fbi1_doc5_%d'):format(i)
				local contextTextLabel = subtitle .. 'A'
				local context = GetLabelText(contextTextLabel)

				if not DoesTextLabelExist(contextTextLabel) then
					break
				end

				if not context:find('SFX_PAUSE') then
		
					AddLineToConversation(
						currSpeaker, --[[ SpeakerNumber ]]
						context, --[[ Context ]]
						subtitle, --[[ Subtitle]]
						0, --[[ ListenerNumber ]]
						0, --[[ volumeType ]]
						false, --[[ isRandom ]]
						false, --[[ interruptible ]]
						0, --[[ ducksRadio ]]
						0, --[[ ducksScore ]]
						0, --[[ audibility ]]
						true, --[[ headset ]]
						false,--[[ dontInterruptForSpecialAbility ]]
						false --[[ isPadSpeakerRoute ]]
					)

					currSpeaker = currSpeaker == 3 and 4 or 3
				end
			end
		
			StartScriptConversation(
				true, --[[ DisplaySubtitles ]]
				true, --[[ addToBriefScreen ]]
				true, --[[ cloneConversation ]]
				false --[[ Interruptible ]]
			)
		end
	else
		DrawSprite('fbi1', 'zipbig', 0.5, gZipbigSpriteCenterY, 1.0, 3.1, 0.0, 255, 255, 255, 255, false)
	end

	SetUseHiDof()
end

--[[ Aguardar a ultima conversa terminar ]]
function FSM:state__3()
	
	if not IsScriptedConversationOngoing() then
		self:nextState()
	end

	SetUseHiDof()
end

--[[ Normalizar o DOF da camera e iniciar o carregamento da cutscene ]]
function FSM:state__4()
	if GetCamFarDof(gCameraId) < 4.0 then
		local currFarDof = GetCamFarDof(gCameraId)
		local newFarDof = (currFarDof + ((currFarDof * 2.0) * Timestep()))

		newFarDof = math.min(newFarDof, 4.0)

		SetCamFarDof(gCameraId, newFarDof)
		SetUseHiDof()
	end

	if GetCamFarDof(gCameraId) == 4.0 then

		RequestCutscene('FBI_1_MCS_1_concat', 8)

		if CanRequestAssetsForCutsceneEntity() then
			SetCutscenePedComponentVariationFromPed('Michael', gEntityId__player, 0)
			SetCutscenePedComponentVariationFromPed('Scientist_with_clipboard', gEntityId__doctorWithClipboard, 0)
			SetCutscenePedComponentVariationFromPed('Scientist_whos_grabbed', gEntityId__doctorNoClipboard, 0)

			self:nextState()
		end
	end
end

--[[ Aguardar o carregamento da cutscene, registrar as entidades e iniciar a cutscene ]]
function FSM:state__5()
	if HasCutsceneLoaded() then
		StopStream()
		TriggerMusicEvent('FBI1_WAKE_UP')

		RegisterEntityForCutscene(gEntityId__player, 'Michael', 0, 0, 0 --[[ CEO_NONE ]] | 64 --[[ CEO_IGNORE_MODEL_NAME ]])
		RegisterEntityForCutscene(gEntityId__doctorWithClipboard, 'Scientist_with_clipboard', 0, 0, 0)
		RegisterEntityForCutscene(gEntityId__doctorNoClipboard, 'Scientist_whos_grabbed', 0, 0, 0)

		RegisterEntityForCutscene(gEntityId__clipboard, 'FIB_1_clipboard', 0, 0, 0)
		RegisterEntityForCutscene(gEntityId__pencil, 'FIB_1_Pencil', 0, 0, 0)

		StartCutscene(0)

		self:nextState()
	end
end

--[[ Pre-termino da cutscene, executar alguns cleanups ]]
function FSM:state__6()
	if IsCutscenePlaying() then

		SetEntityVisible(gEntityId__player, true, false)
		SetEntityCollision(gEntityId__player, true, false)
		FreezeEntityPosition(gEntityId__player, false)

		DestroyAllCams(false)
		RenderScriptCams(false, false, 3000, true, false, 0)
		SetGameplayCamRelativeHeading(0.0)
		SetGameplayCamRelativePitch(0.0, 1.0)

		self:nextState()
	end
end

--[[ Aguardando a cutscene terminar, para fazer o cleanup e aplicar estados de exit! ]]
function FSM:state__7()
	RequestStealthModeAsset('MICHAEL_ACTION')
	local playerPedId = PlayerPedId()

	if IsCutsceneActive() then
		ClonePedToTarget(gEntityId__playerClone, gEntityId__player)

		if CanSetExitStateForRegisteredEntity('michael', 0) then
			SetPedStealthMovement(playerPedId, true, 0)
			ForcePedMotionState(playerPedId, `stealth`, false, 0, false)
		end

		if GetCutsceneTime() >= 16000 and IsCutscenePlaying() then

			DoScreenFadeOut(1000)

			if IsScreenFadedOut() then
				StopCutsceneImmediately()
			end
		end
	else
		ReleaseNamedScriptAudioBank('script\\FBI_01_DMW_Autopsy_1')
		DeletePed(gEntityId__doctorWithClipboard)

		SetStreamedTextureDictAsNoLongerNeeded('fbi1')

		SetScriptGfxDrawOrder(4) --[[ ? ]]
		SetScriptGfxDrawBehindPausemenu(false) --[[ ? ]]

		SetEntityVisible(playerPedId, true, false)
		SetEntityCollision(playerPedId, true, false)
		FreezeEntityPosition(playerPedId, false)

		self:finish()
	end
end

local function Terminate()
	DestroyAllCams(true)
    ClearFocus()

	gEntityId__player			   = nil
	gEntityId__playerClone		   = DeleteEntitySafe(gEntityId__playerClone)
    gEntityId__doctorWithClipboard = DeleteEntitySafe(gEntityId__doctorWithClipboard)
    gEntityId__doctorNoClipboard   = DeleteEntitySafe(gEntityId__doctorNoClipboard)
    gEntityId__clipboard           = DeleteEntitySafe(gEntityId__clipboard)
    gEntityId__pencil              = DeleteEntitySafe(gEntityId__pencil)

	if gZipbigAudioId then
		StopSound(gZipbigAudioId)
		ReleaseSoundId(gZipbigAudioId)
	end

    gZipbigAudioId = nil
    gSceneId__withClipboard = nil
    gSceneId__noClipboard   = nil
    gSceneId__player        = nil

	StopAudioScenes()
	ReleaseAssets()
    RemoveCutscene()
end

local function Init(onFinished)
	gZipbigUnkSpriteCenterY = 0.0
	gZipbigSpriteCenterY = 0.0
	gZipbigAudioPlayed = false
	gZipbigAudioId = GetSoundId()

	LoadAssets()
	DoScreenFadeOut(2000)
	Wait(2000)

	FSM:nextState()

	local playerPos = GetEntityCoords(PlayerPedId())
	NetworkResurrectLocalPlayer(playerPos.x, playerPos.y, playerPos.z, true,true,false)

	CreateThread(function()
		while FSM:isActive() do
			FSM:tick()

			Wait(0)
		end

		Terminate()

        if onFinished then
            onFinished()
        end
	end)
end

AddEventHandler('beforePlayerRespawn', function(respawnFn)
    --[[ Cancelar a lógica padrão de respawn e usar a nossa própria. ]]
    CancelEvent()

    Init(function()

        local playerPedId = PlayerPedId()
        local status, err = pcall(function()
            respawnFn(true)
        end)
        
        SetEntityCoords(playerPedId, POST_CUSTCENE_TELEPORT_POS.x, POST_CUSTCENE_TELEPORT_POS.y, POST_CUSTCENE_TELEPORT_POS.z)
        SetEntityHeading(playerPedId, POST_CUSTCENE_TELEPORT_POS.w)
        SimulatePlayerInputGait(PlayerId(), 1.0, 1500, 0.0, true, false)
        Wait(500)
        DoScreenFadeIn(1000)

        if not status then
            logger:error('Ocorreu um error ao tentar respawnar o player!', err)
        end
    end)
end)

RegisterNetEvent("cinematicDeath")
AddEventHandler("cinematicDeath",function(respawnFn)
    Init(function()
        local playerPedId = PlayerPedId()
        local status, err = pcall(function()
            respawnFn(true)
        end)
        SetEntityCoords(playerPedId, POST_CUSTCENE_TELEPORT_POS.x, POST_CUSTCENE_TELEPORT_POS.y, POST_CUSTCENE_TELEPORT_POS.z)
        SetEntityHeading(playerPedId, POST_CUSTCENE_TELEPORT_POS.w)
        SimulatePlayerInputGait(PlayerId(), 1.0, 1500, 0.0, true, false)
        Wait(500)
        DoScreenFadeIn(1000)
    end)
end)