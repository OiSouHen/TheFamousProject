-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number,Table in pairs(Config) do
				for _,v in pairs(Table) do
					local Distance = #(Coords - v["Coords"])
					if Distance <= 1.75 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() and not exports["lb-phone"]:IsOpen() then
							SetNuiFocus(true,true)
							SendNUIMessage({ Action = "Open", Payload = { Number,Table } })
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Click",function(Data,Callback)
	local Ped = PlayerPedId()
	local Floor = Data["Floor"]
	local Selected = Data["Elevator"]

	if Config[Selected] and Config[Selected][Floor] then
		DoScreenFadeOut(0)
		SetNuiFocus(false,false)
		TriggerEvent("hud:Active",false)
		SetEntityCoords(Ped,Config[Selected][Floor]["Coords"])

		SetTimeout(1000,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(250)
		end)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)