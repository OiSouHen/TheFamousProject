-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Showform = {}
local Textform = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TEXTFORM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Textform")
AddEventHandler("hud:Textform",function(Coords,Text,Seconds)
	Textform[#Textform + 1] = {
		["Text"] = Text,
		["Coords"] = Coords,
		["Seconds"] = GetGameTimer() + Seconds
	}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTEXTFORM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Textform) do
			local Distance = #(Coords - v["Coords"])
			if Distance <= 15 and GetGameTimer() <= v["Seconds"] then
				TimeDistance = 1
				local _,X,Y = GetScreenCoordFromWorldCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])
				if not Showform[Number] then
					SendNUIMessage({ Action = "Textform", Mode = "Create", Number = Number, x = X, y = Y })
					Showform[Number] = true
				end

				SendNUIMessage({ Action = "Textform", Mode = "Update", Text = v["Text"], Number = Number, x = X, y = Y })
			else
				if Showform[Number] then
					SendNUIMessage({ Action = "Textform", Mode = "Remove", Number = Number })
					Showform[Number] = nil
				end
			end
		end

		Wait(TimeDistance)
	end
end)