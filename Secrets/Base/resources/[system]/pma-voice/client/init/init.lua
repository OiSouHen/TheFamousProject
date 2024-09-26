AddEventHandler("onClientResourceStart",function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end

	local success = pcall(function()
		local micClicksKvp = GetResourceKvpString("pma-voice_enableMicClicks")
		if not micClicksKvp then
			SetResourceKvp("pma-voice_enableMicClicks","true")
		else
			micClicks = micClicksKvp
		end
	end)

	if not success then
		SetResourceKvp("pma-voice_enableMicClicks","true")
		micClicks = "true"
	end

	sendUIMessage({ uiEnabled = true, voiceModes = json.encode(Cfg.voiceModes), voiceMode = mode - 1 })

	local radioChannel = LocalPlayer.state.radioChannel or 0
	local callChannel = LocalPlayer.state.callChannel or 0

	if radioChannel ~= 0 then
		setRadioChannel(radioChannel)
	end

	if callChannel ~= 0 then
		setCallChannel(callChannel)
	end

	if not LocalPlayer.state.disableRadio then
		LocalPlayer.state:set("disableRadio",0,true)
	end
end)