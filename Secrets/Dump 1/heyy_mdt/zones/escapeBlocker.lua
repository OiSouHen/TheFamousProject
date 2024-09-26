local prisonArea = PolyZone:Create({
	vector2(1834.6761474609, 2689.56640625),
	vector2(1809.3924560547, 2620.4396972656),
	vector2(1807.8846435547, 2590.9816894531),
	vector2(1806.2783203125, 2533.9580078125),
	vector2(1813.1881103516, 2488.4614257813),
	vector2(1808.66015625, 2475.2778320313),
	vector2(1761.7457275391, 2426.8337402344),
	vector2(1749.1492919922, 2420.7392578125),
	vector2(1668.0671386719, 2408.4904785156),
	vector2(1653.0963134766, 2410.4658203125),
	vector2(1558.8934326172, 2469.7097167969),
	vector2(1551.5587158203, 2482.3278808594),
	vector2(1547.9206542969, 2576.3117675781),
	vector2(1548.5532226563, 2591.2736816406),
	vector2(1576.7238769531, 2666.9868164063),
	vector2(1585.3874511719, 2679.1840820313),
	vector2(1649.4774169922, 2741.609375),
	vector2(1661.6525878906, 2747.8376464844),
	vector2(1762.7478027344, 2751.7177734375),
	vector2(1776.0155029297, 2746.4721679688),
	vector2(1829.4299316406, 2702.7770996094)
}, {
	name="prison",
	maxZ = 67.15,
	minZ = -10.00
})

Citizen.CreateThread(function()
	Wait(10000)
	_debug("escapeBlocker started!")

	-- Quando jogador entrar/sair da área da prisão
	prisonArea:onPlayerInOut(function(isPointInside, point)
		if LocalPlayer.state.cutscene then return end

		-- Se jogador estiver SAINDO da prisão e está preso
		if not isPointInside and LocalPlayer.state.arrested and config.prison.escapes.blockIncorrectEscapes then
			-- Teleportar jogador de volta para prisão
			TriggerEvent("heyy_mdt:prison:teleportBack")

		-- Se algum jogador aleatório (que não está preso) adentrar o presídio
		elseif isPointInside and not LocalPlayer.state.arrested and config.prison.invadeJail.blockInvasion then
			-- Prender jogador pela invasão
			TriggerServerEvent("heyy_mdt:prison:invadeJail")
		end
	end)
end)

Citizen.CreateThread(function()
	while config.prison.escapes.blockIncorrectEscapes do
		if LocalPlayer.state.arrested and not LocalPlayer.state.cutscene then
			local coord = GetEntityCoords(PlayerPedId())
			local insidePrison = prisonArea:isPointInside(coord)

			-- Se jogador estiver SAINDO da prisão e está preso
			if not insidePrison then
				-- Teleportar jogador de volta para prisão
				TriggerEvent("heyy_mdt:prison:teleportBack")
			end
		end
		Wait(10000)
	end
end)
