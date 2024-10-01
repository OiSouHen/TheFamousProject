local volumes = {
	["radio"] = 60 / 100,
	["call"] = 60 / 100
}

mode = 2
radioPressed = false
radioEnabled = false
radioData = {}
callData = {}
submixIndicies = {}
local mutedPlayers = {}

function setVolume(volume,volumeType)
	type_check({ volume, "number" })
	local volume = volume / 100

	if volumeType then
		local volumeTbl = volumes[volumeType]
		if volumeTbl then
			LocalPlayer.state:set(volumeType,volume,true)
			volumes[volumeType] = volume
			resyncVolume(volumeType,volume)
		end
	else
		for volumeType,_ in pairs(volumes) do
			volumes[volumeType] = volume
			LocalPlayer.state:set(volumeType,volume,true)
		end

		resyncVolume("all",volume)
	end
end

exports("setRadioVolume",function(vol)
	setVolume(vol,"radio")
end)

exports("getRadioVolume",function()
	return volumes["radio"]
end)

exports("setCallVolume",function(vol)
	setVolume(vol,"call")
end)

exports("getCallVolume",function()
	return volumes["call"]
end)

local radioEffectId = CreateAudioSubmix("Radio")
SetAudioSubmixEffectRadioFx(radioEffectId,0)
SetAudioSubmixEffectParamInt(radioEffectId,0,GetHashKey("default"),1)
SetAudioSubmixOutputVolumes(radioEffectId,0,1.0,0.25,0.0,0.0,1.0,1.0)
AddAudioSubmixOutput(radioEffectId,0)
submixIndicies["radio"] = radioEffectId

local callEffectId = CreateAudioSubmix("call")
SetAudioSubmixOutputVolumes(callEffectId,1,0.10,0.50,0.0,0.0,1.0,1.0)
AddAudioSubmixOutput(callEffectId,1)
submixIndicies["call"] = callEffectId

exports("registerCustomSubmix",function(callback)
	local submixTable = callback()
	type_check({ submixTable,"table" })
	local submixName,submixId = submixTable[1],submixTable[2]
	type_check({ submixName,"string" },{ submixId,"number" })
	submixIndicies[submixName] = submixId
end)
TriggerEvent("pma-voice:registerCustomSubmixes")

exports("setEffectSubmix",function(type,effectId)
	type_check({ type,"string" },{ effectId,"number" })
	if submixIndicies[type] then
		submixIndicies[type] = effectId
	end
end)

function restoreDefaultSubmix(plyServerId)
	local submix = Player(plyServerId).state.submix
	local submixEffect = submixIndicies[submix]
	if not submix or not submixEffect then
		MumbleSetSubmixForServerId(plyServerId,-1)
		return
	end
	MumbleSetSubmixForServerId(plyServerId,submixEffect)
end

local disableSubmixReset = {}
function toggleVoice(plySource,enabled,moduleType)
	if mutedPlayers[plySource] then return end

	local distance = currentTargets[plySource]
	if enabled and (not distance or distance > 4.0) then
		MumbleSetVolumeOverrideByServerId(plySource,enabled and volumes[moduleType])
		if moduleType then
			disableSubmixReset[plySource] = true
			if submixIndicies[moduleType] then
				MumbleSetSubmixForServerId(plySource,submixIndicies[moduleType])
			end
		else
			restoreDefaultSubmix(plySource)
		end
	elseif not enabled then
		disableSubmixReset[plySource] = nil

		SetTimeout(250,function()
			if not disableSubmixReset[plySource] then
				restoreDefaultSubmix(plySource)
			end
		end)

		MumbleSetVolumeOverrideByServerId(plySource,-1.0)
	end
end

function playerTargets(...)
	local targets = {...}
	local addedPlayers = {
		[playerServerId] = true
	}

	for i = 1,#targets do
		for id,_ in pairs(targets[i]) do
			if addedPlayers[id] and id ~= playerServerId then
				goto skip_loop
			end

			if not addedPlayers[id] then
				addedPlayers[id] = true
				MumbleAddVoiceTargetPlayerByServerId(voiceTarget,id)
			end

			::skip_loop::
		end
	end
end

function playMicClicks(clickType)
	sendUIMessage({
		sound = (clickType and "audio_on" or "audio_off"),
		volume = (clickType and 0.1 or 0.03)
	})
end

RegisterNetEvent("pma-voice:syncMegaphone",function(source,Status)
	toggleVoice(source,Status,"radio")
end)

function setVoiceProperty(type,value)
	if type == "radioEnabled" then
		radioEnabled = value
		sendUIMessage({ radioEnabled = value })
	elseif type == "micClicks" then
		local val = tostring(value)
		micClicks = val
		SetResourceKvp("pma-voice_enableMicClicks",val)
	end
end

local function updateVolumes(voiceTable,override)
	for serverId,talking in pairs(voiceTable) do
		if serverId == playerServerId then goto skip_iter end
		MumbleSetVolumeOverrideByServerId(serverId,talking and override or -1.0)
		::skip_iter::
	end
end

function resyncVolume(volumeType,newVolume)
	if volumeType == "all" then
		resyncVolume("radio",newVolume)
		resyncVolume("call",newVolume)
	elseif volumeType == "radio" then
		updateVolumes(radioData,newVolume)
	elseif volumeType == "call" then
		updateVolumes(callData,newVolume)
	end
end

function toggleMutePlayer(Status)
	local source = LocalPlayer["state"]["Player"]
	if Status then
		mutedPlayers[source] = true
		MumbleSetVolumeOverrideByServerId(source,0.0)
		TriggerServerEvent("pma-voice:toggleMute",true)
	else
		mutedPlayers[source] = nil
		MumbleSetVolumeOverrideByServerId(source,-1.0)
		TriggerServerEvent("pma-voice:toggleMute",false)
	end
end

exports("Mute",toggleMutePlayer)

exports("setVoiceProperty",setVoiceProperty)
exports("SetMumbleProperty",setVoiceProperty)
exports("SetTokoProperty",setVoiceProperty)