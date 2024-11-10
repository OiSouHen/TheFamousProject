local radioChannel = 0
local radioNames = {}

function isRadioEnabled()
	return radioEnabled and LocalPlayer.state.disableRadio == 0
end

function syncRadioData(radioTable,localPlyRadioName)
	radioData = radioTable

	local isEnabled = isRadioEnabled()

	if isEnabled then
		handleRadioAndCallInit()
	end

	radioNames[playerServerId] = localPlyRadioName
end

RegisterNetEvent("pma-voice:syncRadioData",syncRadioData)

function setTalkingOnRadio(plySource,enabled)
	radioData[plySource] = enabled

	if not isRadioEnabled() then return end

	local enabled = enabled or callData[plySource]
	toggleVoice(plySource,enabled,"radio")
end
RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)

function addPlayerToRadio(plySource,plyRadioName)
	radioData[plySource] = false
	radioNames[plySource] = plyRadioName

	if radioPressed then
		addVoiceTargets(radioData,callData)
	end
end
RegisterNetEvent("pma-voice:addPlayerToRadio",addPlayerToRadio)

function removePlayerFromRadio(plySource)
	if plySource == playerServerId then
		for tgt,_ in pairs(radioData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt,false,"radio")
			end
		end

		radioNames = {}
		radioData = {}

		addVoiceTargets(callData)
	else
		toggleVoice(plySource,false,"radio")

		if radioPressed then
			addVoiceTargets(radioData,callData)
		end

		radioData[plySource] = nil
		radioNames[plySource] = nil
	end
end
RegisterNetEvent("pma-voice:removePlayerFromRadio",removePlayerFromRadio)

RegisterNetEvent("pma-voice:radioChangeRejected",function()
	radioChannel = 0
end)

function setRadioChannel(channel)
	radioEnabled = true
	type_check({ channel,"number" })
	TriggerServerEvent("pma-voice:setPlayerRadio",channel)
	radioChannel = tonumber(channel)

	sendUIMessage({ radioChannel = channel, radioEnabled = radioEnabled })
end

exports("setRadioChannel",setRadioChannel)
exports("SetRadioChannel",setRadioChannel)

exports("removePlayerFromRadio",function()
	radioEnabled = false
	setRadioChannel(0)
end)

exports("addPlayerToRadio",function(_radio)
	local radio = tonumber(_radio)
	if radio then
		setRadioChannel(radio)
	end
end)

RegisterCommand("+radiotalk",function()
	local Ped = PlayerPedId()
	if IsPedSwimming(Ped) or GetEntityHealth(Ped) <= 100 or LocalPlayer["state"]["Handcuff"] or IsPlayerFreeAiming(PlayerId()) or not isRadioEnabled() then
		return
	end

	if not radioPressed then
		if radioChannel > 0 then
			addVoiceTargets(radioData,callData)
			TriggerServerEvent("pma-voice:setTalkingOnRadio",true)
			radioPressed = true
			playMicClicks(true)

			if LoadAnim("random@arrests") then
				TaskPlayAnim(Ped,"random@arrests","generic_radio_enter",8.0,2.0,-1,50,2.0,false,false,false)
			end

			CreateThread(function()
				TriggerEvent("pma-voice:radioActive",true)
				LocalPlayer.state:set("radioActive",true,true)
				local checkFailed = false

				while radioPressed do
					local Ped = PlayerPedId()
					if radioChannel < 0 or GetEntityHealth(Ped) <= 100 or not isRadioEnabled() then
						checkFailed = true
						break
					end

					if not IsEntityPlayingAnim(Ped,"random@arrests","generic_radio_enter",3) then
						TaskPlayAnim(Ped,"random@arrests","generic_radio_enter",8.0,2.0,-1,50,2.0,false,false,false)
					end

					SetControlNormal(0,249,1.0)
					SetControlNormal(1,249,1.0)
					SetControlNormal(2,249,1.0)
					DisableControlAction(0,24,true)
					DisableControlAction(0,25,true)
					DisableControlAction(0,257,true)
					DisableControlAction(0,140,true)
					DisableControlAction(0,142,true)

					Wait(0)
				end

				if checkFailed then
					ExecuteCommand("-radiotalk")
				end
			end)
		end
	end
end,false)

RegisterCommand("-radiotalk",function()
	if radioChannel > 0 and radioPressed then
		radioPressed = false
		MumbleClearVoiceTargetPlayers(voiceTarget)
		addVoiceTargets(callData)
		TriggerEvent("pma-voice:radioActive",false)
		LocalPlayer.state:set("radioActive",false,true)
		playMicClicks(false)

		StopAnimTask(PlayerPedId(),"random@arrests","generic_radio_enter",8.0)
		TriggerServerEvent("pma-voice:setTalkingOnRadio",false)
	end
end,false)

RegisterKeyMapping("+radiotalk","Dialogar no rádio.","keyboard","CAPITAL")

function syncRadio(_radioChannel)
	radioChannel = tonumber(Channel)
end
RegisterNetEvent("pma-voice:clSetPlayerRadio",syncRadio)

function handleRadioEnabledChanged(wasRadioEnabled)
	if wasRadioEnabled then
		syncRadioData(radioData,"")
	else
		removePlayerFromRadio(playerServerId)
	end
end

local function addRadioDisableBit(bit)
	local curVal = LocalPlayer.state.disableRadio or 0
	curVal = curVal | bit
	LocalPlayer.state:set("disableRadio",curVal,true)
end
exports("addRadioDisableBit",addRadioDisableBit)

local function removeRadioDisableBit(bit)
	local curVal = LocalPlayer.state.disableRadio or 0
	curVal = curVal & (~bit)
	LocalPlayer.state:set("disableRadio",curVal,true)
end
exports("removeRadioDisableBit",removeRadioDisableBit)