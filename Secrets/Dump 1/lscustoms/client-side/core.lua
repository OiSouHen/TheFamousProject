-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("lscustoms",Creative)
vSERVER = Tunnel.getInterface("lscustoms")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Initial = {}
local Focus = false
local Opened = false
local Information = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
function Boolean(Number)
	return parseInt(Number) ~= 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONEZERO
-----------------------------------------------------------------------------------------------------------------------------------------
function OneZero(Number)
	return Number and 1 or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Open(Vehicle,Logo)
	Information["Vehicle"] = Vehicle

	SetVehicleModKit(Information["Vehicle"],0)
	FreezeEntityPosition(Information["Vehicle"],true)
	SetVehicleOnGroundProperly(Information["Vehicle"])

	Wheel(Information["Vehicle"])
	Respray(Information["Vehicle"])
	WindowTint(Information["Vehicle"])
	PlateHolder(Information["Vehicle"])
	Xenons(Information["Vehicle"])
	Turbo(Information["Vehicle"])
	Neons(Information["Vehicle"])
	VehicleExtras(Information["Vehicle"])

	local Ignore = {
		["Wheels"] = true,
		["Respray"] = true,
		["WindowTint"] = true,
		["Xenons"] = true,
		["Turbo"] = true,
		["Neons"] = true,
		["PlateHolder"] = true,
		["VehicleExtras"] = true
	}

	for Mod,Number in pairs(Mods) do
		if not Ignore[Mod] then
			local Exist = GetVehicleMod(Information["Vehicle"],Number)
			local Amount = GetNumVehicleMods(Information["Vehicle"],Number)

			if Amount > 0 then
				Initial[Mod] = {
					["Installed"] = Exist,
					["Selected"] = Exist,
					["Amount"] = Amount,
					["Price"] = {}
				}

				for Value = 1,Amount do
					local Price = 0
					if type(Values[Mod]) ~= "table" then
						Price = Values[Mod]
					else
						if Mod == "SuspensionUpgrade" or Mod == "TransmissionUpgrade" or Mod == "ShieldingUpgrade" or Mod == "EngineUpgrade" or Mod == "BrakeUpgrade" then
							local Model = vRP.VehicleName()
							local VehiclePrice = VehiclePrice(Model)

							Values[Mod] = { parseInt(VehiclePrice * 0.05), parseInt(VehiclePrice * 0.10), parseInt(VehiclePrice * 0.15), parseInt(VehiclePrice * 0.20), parseInt(VehiclePrice * 0.25), parseInt(VehiclePrice * 0.30) }
						end

						local Total = #Values[Mod]
						if Values[Mod] and Values[Mod][Value] and Value <= Total then
							Price = Values[Mod][Value]
						else
							Price = Values[Mod][Total]
						end
					end

					Initial[Mod]["Price"][Value - 1] = Price
				end
			end
		end
	end

	Focus = true
	Opened = true
	SetNuiFocus(Focus,Focus)
	SetCursorLocation(0.5,0.5)
	TriggerEvent("hud:Active",false)
	SendNUIMessage({ Action = "Open", Payload = { Logo,Initial } })
	Information["Model"] = GetEntityArchetypeName(Information["Vehicle"])
	Information["Plate"] = GetVehicleNumberPlateText(Information["Vehicle"])
	TriggerServerEvent("lscustoms:Network",VehToNet(Information["Vehicle"]),Information["Plate"])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPRAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Respray(Vehicle)
	if not Initial["Respray"] then
		Initial["Respray"] = {}
	end

	local Primary,Secondary = GetVehicleColours(Vehicle)
	local InteriorColor = GetVehicleInteriorColour(Vehicle)
	local DashboardColor = GetVehicleDashboardColour(Vehicle)
	local PearlescentColor,WheelColor = GetVehicleExtraColours(Vehicle)
	local PrimaryR,PrimaryG,PrimaryB = GetVehicleCustomPrimaryColour(Vehicle)
	local SecondaryR,SecondaryG,SecondaryB = GetVehicleCustomSecondaryColour(Vehicle)

	if Primary ~= 0 and Primary ~= 12 and Primary ~= 120 then
		Primary = 0
	end

	if Secondary ~= 0 and Secondary ~= 12 and Secondary ~= 120 then
		Secondary = 0
	end

	for Mode,Result in pairs(Resprays) do
		if Mode == "PrimaryColour" or Mode == "SecondaryColour" then
			Initial["Respray"][Mode] = {
				["Installed"] = {
					["Type"] = (Mode == "PrimaryColour" and Primary or Secondary),
					["Color"] = (Mode == "PrimaryColour" and { PrimaryR,PrimaryG,PrimaryB } or { SecondaryR,SecondaryG,SecondaryB })
				},
				["Selected"] = {
					["Type"] = (Mode == "PrimaryColour" and Primary or Secondary),
					["Color"] = (Mode == "PrimaryColour" and { PrimaryR,PrimaryG,PrimaryB } or { SecondaryR,SecondaryG,SecondaryB })
				},
				["Price"] = Values["Respray"]
			}
		else
			Initial["Respray"][Mode] = {
				["Installed"] = (Mode == "PearlescentColour" and PearlescentColor) or (Mode == "WheelColour" and WheelColor) or (Mode == "DashboardColour" and DashboardColor) or (Mode == "InteriorColour" and InteriorColor),
				["Selected"] = (Mode == "PearlescentColour" and PearlescentColor) or (Mode == "WheelColour" and WheelColor) or (Mode == "DashboardColour" and DashboardColor) or (Mode == "InteriorColour" and InteriorColor),
				["Price"] = Values[Mod]
			}
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Wheel(Vehicle)
	if not Initial["Wheels"] then
		Initial["Wheels"] = {}
	end

	local Number = Mods["Wheels"]
	local ExistType = GetVehicleWheelType(Vehicle)
	local R,G,B = GetVehicleTyreSmokeColor(Vehicle)
	local ExistWheel = GetVehicleMod(Vehicle,Number)
	local ExistVariation = GetVehicleModVariation(Vehicle,Number)

	for Mode,Result in pairs(Wheels) do
		if Mode == "TyreSmoke" then
			Initial["Wheels"][Mode] = {
				["Installed"] = { R,G,B },
				["Selected"] = { R,G,B },
				["Price"] = Values["Wheels"]
			}
		elseif Mode == "CustomTyres" then
			Initial["Wheels"][Mode] = {
				["Installed"] = ExistVariation,
				["Selected"] = ExistVariation,
				["Price"] = Values["Wheels"]
			}
		else
			SetVehicleWheelType(Vehicle,Result)

			Initial["Wheels"][Mode] = {
				["Selected"] = (ExistType == Result and ExistWheel or -1),
				["Installed"] = (ExistType == Result and ExistWheel or -1),
				["Amount"] = GetNumVehicleMods(Vehicle,Number),
				["Initial"] = { ExistType,Number,ExistWheel,ExistVariation },
				["Price"] = Values["Wheels"]
			}
		end
	end

	SetVehicleWheelType(Vehicle,ExistType)
	SetVehicleMod(Vehicle,Number,ExistWheel,ExistVariation)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEHOLDER
-----------------------------------------------------------------------------------------------------------------------------------------
function PlateHolder(Vehicle)
	local Exist = GetVehicleNumberPlateTextIndex(Vehicle)

	Initial["PlateHolder"] = {
		["Selected"] = Exist,
		["Installed"] = Exist,
		["Price"] = Values["PlateHolder"]
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleExtras(Vehicle)
	for Number = 1,12 do
		if DoesExtraExist(Vehicle,Number) then
			if not Initial["VehicleExtras"] then
				Initial["VehicleExtras"] = {}
			end

			local Status = IsVehicleExtraTurnedOn(Vehicle,Number)

			Initial["VehicleExtras"][tostring(Number)] = {
				["Selected"] = Status and 0 or 1,
				["Installed"] = Status and 0 or 1,
				["Price"] = Values["VehicleExtras"]
			}
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function WindowTint(Vehicle)
	local Exist = GetVehicleWindowTint(Vehicle)

	Initial["WindowTint"] = {
		["Selected"] = Exist,
		["Installed"] = Exist,
		["Price"] = Values["WindowTint"]
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- XENONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Xenons(Vehicle)
	local Enable = IsToggleModOn(Vehicle,22)
	local Color = GetVehicleHeadlightsColour(Vehicle)

	Initial["Xenons"] = {
		["Installed"] = {
			["Enable"] = Enable,
			["Color"] = Color
		},
		["Selected"] = {
			["Enable"] = Enable,
			["Color"] = Color
		},
		["Price"] = Values["Xenons"]
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TURBO
-----------------------------------------------------------------------------------------------------------------------------------------
function Turbo(Vehicle)
	local Enable = IsToggleModOn(Vehicle,18)
	local Information = OneZero(Enable)

	Initial["Turbo"] = {
		["Installed"] = Information,
		["Selected"] = Information,
		["Price"] = Values["Turbo"]
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Neons(Vehicle)
	local R,G,B = GetVehicleNeonLightsColour(Vehicle)
	local Enable = IsVehicleNeonLightEnabled(Vehicle,0)

	Initial["Neons"] = {
		["Installed"] = {
			["Enable"] = Enable,
			["Color"] = { R,G,B }
		},
		["Selected"] = {
			["Enable"] = Enable,
			["Color"] = { R,G,B }
		},
		["Price"] = Values["Neons"]
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Apply",function(Data,Callback)
	local Item = Data["Item"]
	local Index = Data["Index"]
	local Category = Data["Category"]

	if Index == "Respray" then
		if Category == "PrimaryColour" then
			Initial[Index][Category]["Selected"]["Type"] = Data["Type"]
			Initial[Index][Category]["Selected"]["Color"] = { Data["Color"][1],Data["Color"][2],Data["Color"][3] }

			SetVehicleColours(Information["Vehicle"],Data["Type"],Initial[Index]["SecondaryColour"]["Selected"]["Type"])
			SetVehicleCustomPrimaryColour(Information["Vehicle"],Data["Color"][1],Data["Color"][2],Data["Color"][3])
		elseif Category == "SecondaryColour" then
			Initial[Index][Category]["Selected"]["Type"] = Data["Type"]
			Initial[Index][Category]["Selected"]["Color"] = { Data["Color"][1],Data["Color"][2],Data["Color"][3] }

			SetVehicleColours(Information["Vehicle"],Initial[Index]["PrimaryColour"]["Selected"]["Type"],Data["Type"])
			SetVehicleCustomSecondaryColour(Information["Vehicle"],Data["Color"][1],Data["Color"][2],Data["Color"][3])
		elseif Category == "PearlescentColour" then
			Initial[Index][Category]["Selected"] = Data["Color"]

			SetVehicleExtraColours(Information["Vehicle"],Data["Color"],Initial[Index]["WheelColour"]["Selected"])
		elseif Category == "WheelColour" then
			Initial[Index][Category]["Selected"] = Data["Color"]

			SetVehicleExtraColours(Information["Vehicle"],Initial[Index]["PearlescentColour"]["Selected"],Data["Color"])
		elseif Category == "DashboardColour" then
			Initial[Index][Category]["Selected"] = Data["Color"]

			SetVehicleDashboardColor(Information["Vehicle"],Data["Color"])
		elseif Category == "InteriorColour" then
			Initial[Index][Category]["Selected"] = Data["Color"]

			SetVehicleInteriorColor(Information["Vehicle"],Data["Color"])
		end
	elseif Index == "Wheels" then
		if Category == "TyreSmoke" then
			Initial[Index][Category]["Selected"] = { Data["Color"][1],Data["Color"][2],Data["Color"][3] }

			ToggleVehicleMod(Information["Vehicle"],Wheels[Category],true)
			SetVehicleTyreSmokeColor(Information["Vehicle"],Data["Color"][1],Data["Color"][2],Data["Color"][3])
		elseif Category == "CustomTyres" then
			Initial[Index][Category]["Selected"] = Boolean(Data["Enable"])

			local ExistWheel = GetVehicleMod(Information["Vehicle"],Mods[Index])

			SetVehicleMod(Information["Vehicle"],Mods[Index],ExistWheel,Initial[Index][Category]["Selected"])
		else
			for Categ,_ in pairs(Initial[Index]) do
				if Categ ~= "TyreSmoke" and Categ ~= "CustomTyres" then
					Initial[Index][Categ]["Selected"] = Initial[Index][Categ]["Installed"]
				end
			end

			Initial[Index][Category]["Selected"] = Item

			SetVehicleWheelType(Information["Vehicle"],Wheels[Category])
			SetVehicleMod(Information["Vehicle"],Mods[Index],Item,Initial[Index]["CustomTyres"]["Selected"])
		end
	elseif Index == "VehicleExtras" then
		Initial[Index][Item]["Selected"] = Boolean(Data["Enable"])

		local Windows,Tyres,Doors = {},{},{}
		local Health = GetEntityHealth(Information["Vehicle"])
		local Body = GetVehicleBodyHealth(Information["Vehicle"])
		local Engine = GetVehicleEngineHealth(Information["Vehicle"])

		for Number = 0,7 do
			Tyres[Number] = (GetTyreHealth(Information["Vehicle"],Number) ~= 1000.0 and true or false)
		end

		for Number = 0,5 do
			Doors[Number] = IsVehicleDoorDamaged(Information["Vehicle"],Number)
		end

		for Number = 0,5 do
			Windows[Number] = IsVehicleWindowIntact(Information["Vehicle"],Number)
		end

		SetVehicleExtra(Information["Vehicle"],parseInt(Item),Initial[Index][Item]["Selected"])
		SetVehiclePetrolTankHealth(Information["Vehicle"],4000.0)

		SetVehicleEngineHealth(Information["Vehicle"],Engine)
		SetVehicleBodyHealth(Information["Vehicle"],Body)
		SetEntityHealth(Information["Vehicle"],Health)

		for Number,Enable in pairs(Tyres) do
			if Enable then
				SetVehicleTyreBurst(Information["Vehicle"],Number,true,1000.0)
			end
		end

		for Number,Enable in pairs(Windows) do
			if not Enable then
				SmashVehicleWindow(Information["Vehicle"],Number)
			end
		end

		for Number,Enable in pairs(Doors) do
			if Enable then
				SetVehicleDoorBroken(Information["Vehicle"],Number,true)
			end
		end
	elseif Index == "WindowTint" then
		Initial[Index]["Selected"] = Item

		SetVehicleWindowTint(Information["Vehicle"],Item)
	elseif Index == "Xenons" then
		if Data["Type"] == "Toggle" then
			Initial[Index]["Selected"]["Enable"] = Data["Enable"]

			ToggleVehicleMod(Information["Vehicle"],Mods[Index],Initial[Index]["Selected"]["Enable"])
		else
			Initial[Index]["Selected"]["Color"] = Data["Color"] or 0

			SetVehicleHeadlightsColour(Information["Vehicle"],Data["Color"] or 0)
		end
	elseif Index == "Turbo" then
		Initial[Index]["Selected"] = OneZero(Data["Enable"])

		ToggleVehicleMod(Information["Vehicle"],Mods[Index],Initial[Index]["Selected"])
	elseif Index == "PlateHolder" then
		Initial[Index]["Selected"] = Item

		SetVehicleNumberPlateTextIndex(Information["Vehicle"],Item)
	elseif Index == "Neons" then
		if Data["Type"] == "Toggle" then
			Initial[Index]["Selected"]["Enable"] = Data["Enable"]

			SetVehicleNeonLightEnabled(Information["Vehicle"],0,Initial[Index]["Selected"]["Enable"])
			SetVehicleNeonLightEnabled(Information["Vehicle"],1,Initial[Index]["Selected"]["Enable"])
			SetVehicleNeonLightEnabled(Information["Vehicle"],2,Initial[Index]["Selected"]["Enable"])
			SetVehicleNeonLightEnabled(Information["Vehicle"],3,Initial[Index]["Selected"]["Enable"])
		else
			Initial[Index]["Selected"]["Color"] = { Data["Color"][1] or 0,Data["Color"][2] or 0,Data["Color"][3] or 0 }

			SetVehicleNeonLightsColour(Information["Vehicle"],Data["Color"][1] or 0,Data["Color"][2] or 0,Data["Color"][3] or 0)
		end
	else
		Initial[Index]["Selected"] = Item

		SetVehicleMod(Information["Vehicle"],Mods[Index],Item)
	end

	SendNUIMessage({ Action = "Price", Payload = Calculate(Initial,vRP.VehicleName()) })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
function Apply(Spawn,Table,Mode)
	for Index,v in pairs(Table) do
		if Index == "Respray" then
			for Type,Results in pairs(Table[Index]) do
				if Type == "PrimaryColour" then
					SetVehicleColours(Spawn,Results[Mode]["Type"],Table[Index]["SecondaryColour"][Mode]["Type"])
					SetVehicleCustomPrimaryColour(Spawn,Results[Mode]["Color"][1],Results[Mode]["Color"][2],Results[Mode]["Color"][3])
				elseif Type == "SecondaryColour" then
					SetVehicleColours(Spawn,Table[Index]["PrimaryColour"][Mode]["Type"],Results[Mode]["Type"])
					SetVehicleCustomSecondaryColour(Spawn,Results[Mode]["Color"][1],Results[Mode]["Color"][2],Results[Mode]["Color"][3])
				elseif Type == "PearlescentColour" then
					SetVehicleExtraColours(Spawn,Results[Mode],Table[Index]["WheelColour"][Mode])
				elseif Type == "WheelColour" then
					SetVehicleExtraColours(Spawn,Table[Index]["PearlescentColour"][Mode],Results[Mode])
				elseif Type == "DashboardColour" then
					SetVehicleDashboardColor(Spawn,Results[Mode])
				elseif Type == "InteriorColour" then
					SetVehicleInteriorColor(Spawn,Results[Mode])
				end
			end
		elseif Index == "Wheels" then
			for Type,Results in pairs(Table[Index]) do
				if Type == "TyreSmoke" then
					ToggleVehicleMod(Spawn,Wheels[Type],true)
					SetVehicleTyreSmokeColor(Spawn,Results[Mode][1],Results[Mode][2],Results[Mode][3])
				elseif Type == "Highend" then
					SetVehicleWheelType(Spawn,Results["Initial"][1])
					SetVehicleMod(Spawn,Results["Initial"][2],Results["Initial"][3],Table[Index]["CustomTyres"]["Selected"])
				end
			end
		elseif Index == "PlateHolder" then
			SetVehicleNumberPlateTextIndex(Spawn,v[Mode])
		elseif Index == "Turbo" then
			ToggleVehicleMod(Spawn,Mods[Index],v[Mode])
		elseif Index == "VehicleExtras" then
			local Windows,Tyres,Doors = {},{},{}
			local Health = GetEntityHealth(Spawn)
			local Body = GetVehicleBodyHealth(Spawn)
			local Engine = GetVehicleEngineHealth(Spawn)

			for Number = 0,7 do
				Tyres[Number] = (GetTyreHealth(Spawn,Number) ~= 1000.0 and true or false)
			end

			for Number = 0,5 do
				Doors[Number] = IsVehicleDoorDamaged(Spawn,Number)
			end

			for Number = 0,5 do
				Windows[Number] = IsVehicleWindowIntact(Spawn,Number)
			end

			for Type,Results in pairs(Table[Index]) do
				SetVehicleExtra(Spawn,parseInt(Type),Boolean(Results))
				SetVehiclePetrolTankHealth(Spawn,4000.0)
			end

			SetVehicleEngineHealth(Spawn,Engine)
			SetVehicleBodyHealth(Spawn,Body)
			SetEntityHealth(Spawn,Health)

			for Number,Enable in pairs(Tyres) do
				if Enable then
					SetVehicleTyreBurst(Spawn,Number,true,1000.0)
				end
			end

			for Number,Enable in pairs(Windows) do
				if not Enable then
					SmashVehicleWindow(Spawn,Number)
				end
			end

			for Number,Enable in pairs(Doors) do
				if Enable then
					SetVehicleDoorBroken(Spawn,Number,true)
				end
			end
		elseif Index == "WindowTint" then
			SetVehicleWindowTint(Spawn,v[Mode])
		elseif Index == "Xenons" then
			local Information = v[Mode]["Enable"]

			ToggleVehicleMod(Spawn,Mods[Index],Information)
			SetVehicleHeadlightsColour(Spawn,v[Mode]["Color"] or 0)
		elseif Index == "Neons" then
			local Information = v[Mode]["Enable"]

			SetVehicleNeonLightEnabled(Spawn,0,Information)
			SetVehicleNeonLightEnabled(Spawn,1,Information)
			SetVehicleNeonLightEnabled(Spawn,2,Information)
			SetVehicleNeonLightEnabled(Spawn,3,Information)
			SetVehicleNeonLightsColour(Spawn,v[Mode]["Color"][1] or 0,v[Mode]["Color"][2] or 0,v[Mode]["Color"][3] or 0)
		elseif v["Installed"] ~= v["Selected"] then
			SetVehicleMod(Spawn,Mods[Index],v[Mode])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:Apply")
AddEventHandler("lscustoms:Apply",function(Spawn,Customize)
	local Spawn = Spawn
	local Customize = Customize
	if Customize then
		SetVehicleModKit(Spawn,0)
		SetVehicleLivery(Spawn,0)

		for Index,v in pairs(Customize) do
			if Index == "Respray" then
				SetVehicleColours(Spawn,v["PrimaryColour"]["Type"],v["SecondaryColour"]["Type"])
				SetVehicleCustomPrimaryColour(Spawn,v["PrimaryColour"]["Color"][1],v["PrimaryColour"]["Color"][2],v["PrimaryColour"]["Color"][3])
				SetVehicleCustomSecondaryColour(Spawn,v["SecondaryColour"]["Color"][1],v["SecondaryColour"]["Color"][2],v["SecondaryColour"]["Color"][3])
				SetVehicleExtraColours(Spawn,v["PearlescentColour"],v["WheelColour"])
				SetVehicleDashboardColor(Spawn,v["DashboardColour"])
				SetVehicleInteriorColor(Spawn,v["InteriorColour"])
			elseif Index == "Wheels" then
				if v["Category"] then
					SetVehicleWheelType(Spawn,Wheels[v["Category"]])
				end

				if v["Value"] then
					SetVehicleMod(Spawn,Mods[Index],v["Value"],v["CustomTyres"])
				end

				if v["TyreSmoke"] then
					ToggleVehicleMod(Spawn,Wheels["TyreSmoke"],true)
					SetVehicleTyreSmokeColor(Spawn,v["TyreSmoke"][1],v["TyreSmoke"][2],v["TyreSmoke"][3])
				end
			elseif Index == "PlateHolder" then
				SetVehicleNumberPlateTextIndex(Spawn,v)
			elseif Index == "Turbo" then
				ToggleVehicleMod(Spawn,Mods[Index],v)
			elseif Index == "VehicleExtras" then
				for Type,Results in pairs(Customize[Index]) do
					SetVehicleExtra(Spawn,parseInt(Type),Boolean(Results))
					SetVehiclePetrolTankHealth(Spawn,4000.0)
				end
			elseif Index == "WindowTint" then
				SetVehicleWindowTint(Spawn,v)
			elseif Index == "Xenons" then
				local Information = v["Enable"]

				ToggleVehicleMod(Spawn,Mods[Index],Information)
				SetVehicleHeadlightsColour(Spawn,v["Color"] or 0)
			elseif Index == "Neons" then
				local Information = v["Enable"]

				SetVehicleNeonLightEnabled(Spawn,0,Information)
				SetVehicleNeonLightEnabled(Spawn,1,Information)
				SetVehicleNeonLightEnabled(Spawn,2,Information)
				SetVehicleNeonLightEnabled(Spawn,3,Information)
				SetVehicleNeonLightsColour(Spawn,v["Color"][1] or 0,v["Color"][2] or 0,v["Color"][3] or 0)
			else
				SetVehicleMod(Spawn,Mods[Index],v)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	if not vSERVER.Save(Information["Model"],Information["Plate"],Initial) then
		Apply(Information["Vehicle"],Initial,"Installed")
	end

	Focus = false
	Opened = false
	SetNuiFocus(Focus,Focus)
	TriggerEvent("hud:Active",true)
	TriggerServerEvent("lscustoms:Network")
	FreezeEntityPosition(Information["Vehicle"],false)
	Information = {}
	Initial = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	Apply(Information["Vehicle"],Initial,"Installed")

	Focus = false
	Opened = false
	SetNuiFocus(Focus,Focus)
	TriggerEvent("hud:Active",true)
	TriggerServerEvent("lscustoms:Network")
	FreezeEntityPosition(Information["Vehicle"],false)
	Information = {}
	Initial = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Space",function(Data,Callback)
	SetNuiFocusKeepInput(Focus)
	Focus = not Focus

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not Opened and IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
				local Coords = GetEntityCoords(Ped)

				for Index,v in pairs(Locations) do
					if #(Coords - v["Coords"]["xyz"]) <= 2.5 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and vSERVER.Permission(Index) then
							SetEntityCoords(Vehicle,v["Coords"]["xyz"])
							SetEntityHeading(Vehicle,v["Coords"]["w"])
							Open(Vehicle,v["Logo"])
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:Open")
AddEventHandler("lscustoms:Open",function()
	local Ped = PlayerPedId()
	if not Opened and IsPedInAnyVehicle(Ped) then
		local Coords = GetEntityCoords(Ped)
		local Heading = GetEntityCoords(Ped)
		local Vehicle = GetVehiclePedIsUsing(Ped)

		if GetPedInVehicleSeat(Vehicle,-1) == Ped then
			SetEntityHeading(Vehicle,Heading)
			SetEntityCoords(Vehicle,Coords)
			Open(Vehicle,"lscustoms.png")
		end
	end
end)