-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("postit")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Posts = {}
local Display = {}
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjustes = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjustes[3]) * math.abs(math.cos(Adjustes[1])),math.cos(Adjustes[3]) * math.abs(math.cos(Adjustes[1])),math.sin(Adjustes[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT:INITPOSTIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postit:initPostit")
AddEventHandler("postit:initPostit",function(Admin)
	if not Active then
		Active = true

		CreateThread(function()
			while true do
				local Ped = PlayerPedId()
				local Camera = GetGameplayCamCoord()
				local Handler = StartExpensiveSynchronousShapeTestLosProbe(Camera,GetCoordsFromCam(25.0,Camera),-1,Ped,4)
				local _,_,Coords = GetShapeTestResult(Handler)

				DrawMarker(28,Coords["x"],Coords["y"],Coords["z"],0.0,0.0,0.0,0.0,0.0,0.0,0.05,0.05,0.05,88,101,242,175,0,0,0,0)

				if IsControlJustPressed(1,38) then
					if Admin then
						exports["keyboard"]:Copy("Cordenadas",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"]))
					else
						vSERVER.Add(Coords)
					end

					Active = false

					break
				end

				Wait(1)
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPOSTITS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] and Posts[LocalPlayer["state"]["Route"]] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Route = LocalPlayer["state"]["Route"]

			for Number,v in pairs(Posts[Route]) do
				local Distance = #(Coords - v["Coords"])
				if Distance <= v["Distance"] then
					TimeDistance = 1
					local _,x,y = GetScreenCoordFromWorldCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])

					if not Display[Route] then
						Display[Route] = {}
					end

					if not Display[Route][Number] then
						SendNUIMessage({ Action = "Show", text = "", id = Number, x = x, y = y })
						Display[Route][Number] = true
					end

					SendNUIMessage({ Action = "Update", text = v["Message"], id = Number, x = x, y = y })

					if IsControlJustPressed(0,47) and Distance <= 2 then
						vSERVER.Delete(Route,Number)
					end
				else
					if Display[Route] and Display[Route][Number] then
						SendNUIMessage({ Action = "Remove", id = Number })
						Display[Route][Number] = nil

						if CountTable(Display[Route]) <= 0 then
							Display[Route] = nil
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postit:Delete")
AddEventHandler("postit:Delete",function(Route,Number)
	if Posts[Route] and Posts[Route][Number] then
		Posts[Route][Number] = nil

		if CountTable(Posts[Route]) <= 0 then
			Posts[Route] = nil
		end
	end

	if Display[Route] and Display[Route][Number] then
		SendNUIMessage({ Action = "Remove", id = Number })
		Display[Route][Number] = nil

		if CountTable(Display[Route]) <= 0 then
			Display[Route] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postit:Add")
AddEventHandler("postit:Add",function(Route,Number,Content)
	if not Posts[Route] then
		Posts[Route] = {}
	end

	Posts[Route][Number] = Content
end)