AddStateBagChangeHandler("submix","",function(bagName,_,value)
	local tgtId = tonumber(bagName:gsub("player:",""),10)
	if not tgtId or (value and not submixIndicies[value]) then return end

	if not value then
		if not radioData[tgtId] and not callData[tgtId] then
			MumbleSetSubmixForServerId(tgtId,-1)
		end

		return
	end

	MumbleSetSubmixForServerId(tgtId,submixIndicies[value])
end)