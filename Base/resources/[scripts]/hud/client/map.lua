-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	if LoadTexture("circleminimap") then
		AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circleminimap", "radarmasksm")

		SetMinimapComponentPosition("minimap", "L", "B", 0.005, -0.025, 0.175, 0.225)
		SetMinimapComponentPosition("minimap_mask", "L", "B", 0.02, 0.39, 0.1135, 0.5)
		SetMinimapComponentPosition("minimap_blur", "L", "B", -0.02, -0.01, 0.265, 0.225)

		SetBigmapActive(true, false)

		repeat
			Wait(100)
			SetMinimapClipType(1)
			SetBigmapActive(false, false)
		until not IsBigmapActive()

		SetRadarZoom(1100)
	end
end)
