-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("player", Hensa)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Residuals = nil
local inTrunk = false
local inTrash = false
local Megaphone = false
local WashProgress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROPE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Carry"] or LocalPlayer["state"]["Handcuff"] or IsEntityPlayingAnim(Ped,"missfinale_c2mcs_1","fin_c2_mcs_1_camman",3) then
			TimeDistance = 1

			DisableControlAction(0,18,true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,55,true)
			DisableControlAction(0,76,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,102,true)
			DisableControlAction(0,179,true)
			DisableControlAction(0,203,true)

			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			TimeDistance = 100

			if not GetPedConfigFlag(Ped,184,true) then
				SetPedConfigFlag(Ped,184,true)
			end

			local Vehicle = GetVehiclePedIsIn(Ped)
			if GetPedInVehicleSeat(Vehicle,0) == Ped then
				if GetIsTaskActive(Ped,165) then
					SetPedIntoVehicle(Ped,Vehicle,0)
				end
			end
		else
			if GetPedConfigFlag(Ped,184,true) then
				SetPedConfigFlag(Ped,184,false)
			end
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:VEHICLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:VehicleHood")
AddEventHandler("player:VehicleHood",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,4,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:VEHICLEDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:VehicleDoors")
AddEventHandler("player:VehicleDoors",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,5,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINDOWS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("player:Windows",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		Entity(Vehicle)["state"]:set("Windows",not Entity(Vehicle)["state"]["Windows"],true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Windows",nil,function(Name,Key,Value)
	local Network = parseInt(Name:gsub("entity:",""))
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToVeh(Network)
		if DoesEntityExist(Vehicle) then
			if Value then
				RollDownWindow(Vehicle,0)
				RollDownWindow(Vehicle,1)
				RollDownWindow(Vehicle,2)
				RollDownWindow(Vehicle,3)
			else
				RollUpWindow(Vehicle,0)
				RollUpWindow(Vehicle,1)
				RollUpWindow(Vehicle,2)
				RollUpWindow(Vehicle,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
local DoorNumber = {
	["1"] = 0,
	["2"] = 1,
	["3"] = 2,
	["4"] = 3,
	["5"] = 5,
	["6"] = 4
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) and GetVehicleDoorLockStatus(Vehicle) <= 1 then
			if DoorNumber[Active] then
				if GetVehicleDoorAngleRatio(Vehicle,DoorNumber[Active]) == 0 then
					SetVehicleDoorOpen(Vehicle,DoorNumber[Active],0,0)
				else
					SetVehicleDoorShut(Vehicle,DoorNumber[Active],0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(Index)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		if Index == "0" then
			if IsVehicleSeatFree(Vehicle,-1) then
				SetPedIntoVehicle(Ped,Vehicle,-1)
			end
		elseif Index == "1" then
			if IsVehicleSeatFree(Vehicle,0) then
				SetPedIntoVehicle(Ped,Vehicle,0)
			end
		else
			for Seat = 1,10 do
				if IsVehicleSeatFree(Vehicle,Seat) then
					SetPedIntoVehicle(Ped,Vehicle,Seat)
					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Carry"] then
			if not IsEntityPlayingAnim(Ped,"mp_arresting","idle",3) then
				if LoadAnim("mp_arresting") then
					TaskPlayAnim(Ped,"mp_arresting","idle",8.0,8.0,-1,49,1,0,0,0)
				end

				TimeDistance = 1
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.checkSoap()
	return Residuals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RESIDUALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Residuals")
AddEventHandler("player:Residuals",function(Informations)
	if Informations then
		if not Residuals then
			Residuals = {}
		end

		Residuals[Informations] = true
	else
		Residuals = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RemoveVehicle()
	if not LocalPlayer["state"]["Bennys"] then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			TaskLeaveVehicle(Ped,GetVehiclePedIsUsing(Ped),0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PlaceVehicle(Network)
	if not LocalPlayer["state"]["Bennys"] and NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			for Number = 0,10 do
				local Ped = PlayerPedId()
				if IsVehicleSeatFree(Vehicle,Number) then
					SetPedIntoVehicle(Ped,Vehicle,Number)
					vRP.Destroy()
					break
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,Message)
	if not LocalPlayer["state"]["DrivingSchool"] then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped and not IsEntityInAir(Vehicle) and (GetEntitySpeed(Vehicle) * 2.236936) >= 10 then
				if not Message[1] then
					SetEntityMaxSpeed(Vehicle, GetVehicleEstimatedMaxSpeed(Vehicle))
					TriggerEvent("Notify","amarelo","<b>Controle de Cruzeiro</b> desativado.","Atenção",5000)
				else
					if parseInt(Message[1]) > 10 then
						SetEntityMaxSpeed(Vehicle, 0.45 * Message[1])
						TriggerEvent("Notify","amarelo","<b>Controle de Cruzeiro</b> ativado.","Atenção",5000)
					end
				end
			end
		end
	else
		TriggerEvent("Notify","amarelo","Você não pode usar o <b>Controle de Cruzeiro</b> durante um teste para <b>Carteira de Habilitação</b>.","Atenção",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldeath = GetGameTimer()
AddEventHandler("gameEventTriggered",function(Name,Message)
	if Name == "CEventNetworkEntityDamage" then
		local Ped = PlayerPedId()
		local OtherPed = Message[2]
		if Message[1] == Ped and GetEntityHealth(Ped) <= 100 and IsEntityAPed(Ped) and IsPedAPlayer(OtherPed) and GetGameTimer() >= Cooldeath then
			Cooldeath = GetGameTimer() + 10000

			local Index = NetworkGetPlayerIndexFromPed(OtherPed)
			local PedIndex = GetPlayerServerId(PlayerId())
			local OtherIndex = GetPlayerServerId(Index)

			TriggerServerEvent("player:Death",PedIndex,OtherIndex)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(Entity)
	if not inTrunk then
		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Invisible",true,false)

		SetEntityVisible(PlayerPedId(),false,0)
		AttachEntityToEntity(PlayerPedId(),Entity[3],-1,0.0,-2.2,0.5,0.0,0.0,0.0,true,true,false,true,2,true)
		inTrunk = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	if inTrunk then
		local Ped = PlayerPedId()
		local Vehicle = GetEntityAttachedTo(Ped)
		if DoesEntityExist(Vehicle) then
			inTrunk = false
			DetachEntity(Ped,false,false)
			SetEntityVisible(Ped,true,0)
			LocalPlayer["state"]:set("Invisible",false,false)
			LocalPlayer["state"]:set("Commands",false,true)
			SetEntityCoords(Ped,GetOffsetFromEntityInWorldCoords(Ped,0.0,-1.25,-0.25),false,false,false,false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		if inTrunk then
			local Ped = PlayerPedId()
			local Vehicle = GetEntityAttachedTo(Ped)
			if DoesEntityExist(Vehicle) then
				TimeDistance = 1

				if GetFollowPedCamViewMode() ~= 4 then
					SetFollowPedCamViewMode(4)
				end

				DisablePlayerFiring(Ped, true)
				DisableControlAction(0, 23, true)

				if IsEntityVisible(Ped) then
					LocalPlayer["state"]:set("Invisible", true, false)
					SetEntityVisible(Ped, false, 0)
				end

				if IsControlJustPressed(1, 38) then
					inTrunk = false
					DetachEntity(Ped, false, false)
					SetEntityVisible(Ped, true, 0)
					SetFollowPedCamViewMode(0)
					LocalPlayer["state"]:set("Invisible", false, false)
					LocalPlayer["state"]:set("Commands", false, true)
					SetEntityCoords(Ped, GetOffsetFromEntityInWorldCoords(Ped, 0.0, -1.25, -0.25), false, false, false, false)
				end
			else
				inTrunk = false
				DetachEntity(Ped, false, false)
				SetEntityVisible(Ped, true, 0)
				LocalPlayer["state"]:set("Invisible", false, false)
				LocalPlayer["state"]:set("Commands", false, true)
				SetEntityCoords(Ped, GetOffsetFromEntityInWorldCoords(Ped, 0.0, -1.25, -0.25), false, false, false, false)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar", function()
	local Ped = PlayerPedId()
	if IsPedInAnyBoat(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if CanAnchorBoatHere(Vehicle) then
			TriggerEvent("Notify", "amarelo", "Embarcação desancorada.", "Atenção", 5000)
			SetBoatAnchor(Vehicle, false)
		else
			TriggerEvent("Notify", "amarelo", "Embarcação ancorada.", "Atenção", 5000)
			SetBoatAnchor(Vehicle, true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Cows = {
	vec3(2440.58, 4736.35, 34.29),
	vec3(2432.5, 4744.58, 34.31),
	vec3(2424.47, 4752.37, 34.31),
	vec3(2416.28, 4760.8, 34.31),
	vec3(2408.6, 4768.88, 34.31),
	vec3(2400.32, 4777.48, 34.53),
	vec3(2432.46, 4802.66, 34.83),
	vec3(2440.62, 4794.22, 34.66),
	vec3(2448.65, 4786.57, 34.64),
	vec3(2456.88, 4778.08, 34.49),
	vec3(2464.53, 4770.04, 34.37),
	vec3(2473.38, 4760.98, 34.31),
	vec3(2495.03, 4762.77, 34.37),
	vec3(2503.13, 4754.08, 34.31),
	vec3(2511.34, 4746.04, 34.31),
	vec3(2519.56, 4737.35, 34.20)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash", function(Entity)
	local Ped = PlayerPedId()

	if GetEntityHealth(Ped) > 100 then
		if not inTrash then
			FreezeEntityPosition(Ped, true)

			LocalPlayer["state"]:set("Commands", true, true)
			LocalPlayer["state"]:set("Invisible", true, false)
			SetEntityVisible(Ped, false, 0)
			SetEntityCoords(Ped, Entity[4], false, false, false, false)

			inTrash = GetOffsetFromEntityInWorldCoords(Entity[1], 0.0, -1.5, 0.0)
			LocalPlayer["state"]:set("usingTrash", true, false)
			vSERVER.EnterTrash()

			while inTrash do
				Wait(1)

				if GetFollowPedCamViewMode() ~= 4 then
					SetFollowPedCamViewMode(4)
				end

				DisablePlayerFiring(Ped, true)
				DisableControlAction(0, 23, true)

				if IsControlJustPressed(1, 38) then
					FreezeEntityPosition(Ped, false)
					SetEntityVisible(Ped, true, 0)
					SetFollowPedCamViewMode(0)
					LocalPlayer["state"]:set("Invisible", false, false)
					LocalPlayer["state"]:set("Commands", false, true)
					SetEntityCoords(Ped, inTrash, false, false, false, false)

					inTrash = false
					LocalPlayer["state"]:set("usingTrash", false, false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash", function()
	if inTrash then
		local Ped = PlayerPedId()
		FreezeEntityPosition(Ped, false)
		SetEntityVisible(Ped, true, 0)
		LocalPlayer["state"]:set("Invisible", false, false)
		LocalPlayer["state"]:set("Commands", false, true)
		SetEntityCoords(Ped, inTrash, false, false, false, false)

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Megaphone")
AddEventHandler("player:Megaphone", function()
	Megaphone = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Megaphone then
			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped, "anim@random@shop_clothes@watches", "base", 3) then
				TriggerServerEvent("pma-voice:Megaphone", false)
				TriggerEvent("pma-voice:Megaphone", false)
				Megaphone = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUIVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {}
local InnerTexture = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUITABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:DuiTable")
AddEventHandler("player:DuiTable", function(Table)
	DuiTextures = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Line, v in pairs(DuiTextures) do
				if #(Coords - v["Coords"]) <= 15 then
					if not InnerTexture[Line] then
						InnerTexture[Line] = true

						local Texture = CreateRuntimeTxd("Texture" .. Line)
						local TextureObject = CreateDui(v["Link"], v["Width"], v["Weight"])
						local TextureHandle = GetDuiHandle(TextureObject)

						CreateRuntimeTextureFromDuiHandle(Texture, "Back" .. Line, TextureHandle)
						AddReplaceTexture(v["Dict"], v["Texture"], "Texture" .. Line, "Back" .. Line)

						exports["target"]:AddCircleZone("Texture" .. Line, v["Coords"], v["Dimension"], {
							name = "Texture" .. Line,
							heading = 0.0
						}, {
							shop = Line,
							Distance = v["Distance"],
							options = {
								{
									event = "player:Texture",
									label = v["Label"],
									tunnel = "server"
								}
							}
						})
					end
				else
					if InnerTexture[Line] then
						exports["target"]:RemCircleZone("Texture" .. Line)
						RemoveReplaceTexture(v["Dict"], v["Texture"])
						InnerTexture[Line] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUIUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:DuiUpdate")
AddEventHandler("player:DuiUpdate", function(Name, Table)
	DuiTextures[Name] = Table

	local Ped = PlayerPedId()
	local Fast = DuiTextures[Name]
	local Coords = GetEntityCoords(Ped)
	if #(Coords - Fast["Coords"]) <= 15 then
		local Texture = CreateRuntimeTxd("Texture" .. Name)
		local TextureObject = CreateDui(Fast["Link"], Fast["Width"], Fast["Weight"])
		local TextureHandle = GetDuiHandle(TextureObject)

		CreateRuntimeTextureFromDuiHandle(Texture, "Back" .. Name, TextureHandle)
		AddReplaceTexture(Fast["Dict"], Fast["Texture"], "Texture" .. Name, "Back" .. Name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WASHLOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local WashLocations = {
	vec3(24.27, -1391.96, 28.7),
	vec3(170.59, -1718.43, 28.66),
	vec3(167.69, -1715.92, 28.66),
	vec3(-699.86, -932.84, 18.38)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Index, v in pairs(Cows) do
		exports["target"]:AddCircleZone("Cows:" .. Index, v, 0.5, {
			name = "Cows:" .. Index,
			heading = 0.0
		}, {
			Distance = 1.25,
			options = {
				{
					event = "inventory:MakeProducts",
					label = "Retirar Leite",
					tunnel = "products",
					service = "milkBottle"
				}
			}
		})
	end

	local Tables = {}
	for Number = 1,#WashLocations do
		Tables[#Tables + 1] = { WashLocations[Number],2.5,"E","Lava-Rápido","Pressione para usar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCARWASH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) and not WashProgress then
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle, -1) == Ped then
				for _, v in pairs(WashLocations) do
					if #(Coords - v) <= 2.5 then
						TimeDistance = 1

						if IsControlJustPressed(1, 38) and vSERVER.PayWash() then
							WashProgress = true

							FreezeEntityPosition(Vehicle, true)

							UseParticleFxAssetNextCall("core")
							local Particle01 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", v["x"], v["y"], v["z"], 0.0, 0.0, 0.0, 1.0, false, false, false, false)

							UseParticleFxAssetNextCall("core")
							local Particle02 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", v["x"] + 2.5, v["y"], v["z"], 0.0, 0.0, 0.0, 1.0, false, false, false, false)

							TriggerEvent("Progress", "Lavando", 15000)
							SetTimeout(15000, function()
								TriggerServerEvent("CleanVehicle", VehToNet(Vehicle))

								FreezeEntityPosition(Vehicle, false)
								StopParticleFxLooped(Particle01, 0)
								StopParticleFxLooped(Particle02, 0)
								WashProgress = false
							end)
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)