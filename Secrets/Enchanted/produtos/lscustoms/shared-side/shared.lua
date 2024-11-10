-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Locations = {
	{
		["Logo"] = "lscustoms.png",
		--["Permission"] = "Mecanico",
		["Coords"] = vec4(-339.15,-136.66,39.01,87.88)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODS
-----------------------------------------------------------------------------------------------------------------------------------------
Mods = {
	Spoiler = 0,
	FrontBumper = 1,
	RearBumper = 2,
	SideSkirt = 3,
	Exhaust = 4,
	RollCage = 5,
	Grille = 6,
	Hood = 7,
	LeftFender = 8,
	RightFender = 9,
	Roof = 10,
	EngineUpgrade = 11,
	BrakeUpgrade = 12,
	TransmissionUpgrade = 13,
	Horns = 14,
	SuspensionUpgrade = 15,
	ShieldingUpgrade = 16,
	-- 17
	Turbo = 18,
	-- 19
	-- 20
	-- 21
	Xenons = 22,
	Wheels = 23,
	-- 24
	PlateHolder = 25,
	PlateVanity = 26,
	TrimA = 27,
	Ornaments = 28,
	Dashboard = 29,
	Dial = 30,
	DoorSpeaker = 31,
	Seats = 32,
	SteeringWheel = 33,
	ShifterLeaver = 34,
	Plaque = 35,
	Speaker = 36,
	Trunk = 37,
	Hydraulic = 38,
	EngineBlock = 39,
	AirFilter = 40,
	Strut = 41,
	ArchCover = 42,
	Aerial = 43,
	TrimB = 44,
	FuelTank = 45,
	Window = 46,
	-- 47
	Livery = 48,
	VehicleExtras = 99
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VALUES
-----------------------------------------------------------------------------------------------------------------------------------------
Values = {
	TrimA = 615,
	TrimB = 615,
	Livery = 525,
	Spoiler = 1225,
	ShifterLeaver = 675,
	Speaker = 715,
	DoorSpeaker = 915,
	Aerial = 715,
	Seats = 925,
	EngineBlock = 575,
	Horns = 375,
	Hood = 1125,
	ArchCover = 575,
	Ornaments = 525,
	Exhaust = 875,
	VehicleExtras = 375,
	AirFilter = 515,
	RollCage = 1325,
	Grille = 715,
	Hydraulic = 875,
	PlateIndex = 2250,
	VanityPlates = 1275,
	Window = 525,
	Dial = 625,
	Neons = 1250,
	Dashboard = 675,
	FrontBumper = 1725,
	RearBumper = 1425,
	RightFender = 825,
	LeftFender = 825,
	WindowTint = 1250,
	Respray = 2725,
	Plaque = 475,
	Trunk = 925,
	Wheels = 1250,
	SideSkirt = 575,
	Strut = 725,
	FuelTank = 975,
	Roof = 1275,
	Turbo = 9275,
	SuspensionUpgrade = { 100,200,300,400,500,600 },
	TransmissionUpgrade = { 100,200,300,400,500,600 },
	ShieldingUpgrade = { 100,200,300,400,500,600 },
	EngineUpgrade = { 100,200,300,400,500,600 },
	BrakeUpgrade = { 100,200,300,400,500,600 },
	SteeringWheel = 725,
	Xenons = 1275
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELS
-----------------------------------------------------------------------------------------------------------------------------------------
Wheels = {
	CustomTyres = -1,
	TyreSmoke = 20,
	Bespokes = 9,
	Highend = 7,
	Lowrider = 2,
	Muscle = 1,
	Offroad = 4,
	Originals = 8,
	Sport = 0,
	Streets = 11,
	Super = 6,
	Suv = 3,
	Trackers = 12,
	Tuner = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
Resprays = {
	PrimaryColour = 0,
	SecondaryColour = 1,
	PearlescentColour = 2,
	WheelColour = 3,
	DashboardColour = 4,
	InteriorColour = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Calculate(Table,Vehicle)
	local Payment = 0
	for Index,v in pairs(Table) do
		local Price = 0
		local Selected = v["Selected"]
		local Installed = v["Installed"]

		if Index == "VehicleExtras" then
			for _,w in pairs(v) do
				if w["Installed"] ~= w["Selected"] then
					Price = Price + (Values[Index] or 100)
				end
			end
		elseif Index == "Respray" then
			for Name,w in pairs(v) do
				if Name == "PrimaryColour" or Name == "SecondaryColour" then
					if w["Installed"]["Type"] ~= w["Selected"]["Type"] then
						Price = Price + (Values[Index] or 100)
					end

					if (w["Installed"]["Color"][1] ~= w["Selected"]["Color"][1] or w["Installed"]["Color"][2] ~= w["Selected"]["Color"][2] or w["Installed"]["Color"][3] ~= w["Selected"]["Color"][3]) then
						Price = Price + (Values[Index] or 100)
					end
				else
					if w["Installed"] ~= w["Selected"] and w["Selected"] > -1 then
						Price = Price + (Values[Index] or 100)
					end
				end
			end
		elseif Index == "Wheels" then
			for Name,w in pairs(v) do
				if Name == "TyreSmoke" then
					if (w["Installed"][1] ~= w["Selected"][1] or w["Installed"][2] ~= w["Selected"][2] or w["Installed"][3] ~= w["Selected"][3]) then
						Price = Price + (Values[Index] or 100)
					end
				elseif Name == "CustomTyres" then
					if w["Installed"] ~= w["Selected"] then
						Price = Price + (Values[Index] or 100)
					end
				else
					if w["Installed"] ~= w["Selected"] and w["Selected"] > -1 then
						Price = Price + (Values[Index] or 100)
					end
				end
			end
		elseif Index == "Turbo" or Index == "PlateHolder" then
			if Installed ~= Selected then
				Price = Price + (Values[Index] or 100)
			end
		elseif Index == "Neons" or Index == "Xenons" then
			if Installed["Enable"] ~= Selected["Enable"] then
				Price = Price + (Values[Index] or 100)
			end

			if Index == "Neons" and Installed["Color"][1] ~= Selected["Color"][1] and Installed["Color"][2] ~= Selected["Color"][2] and Installed["Color"][3] ~= Selected["Color"][3] then
				Price = Price + (Values[Index] or 100)
			elseif Index == "Xenons" and Installed["Color"] ~= Selected["Color"] then
				Price = Price + (Values[Index] or 100)
			end
		else
			if type(Values[Index]) == "table" and Installed ~= Selected and Selected > -1 then
				if Index == "SuspensionUpgrade" or Index == "TransmissionUpgrade" or Index == "ShieldingUpgrade" or Index == "EngineUpgrade" or Index == "BrakeUpgrade" then
					local VehiclePrice = VehiclePrice(Vehicle)

					Values[Index] = { parseInt(VehiclePrice * 0.1), parseInt(VehiclePrice * 0.2), parseInt(VehiclePrice * 0.3), parseInt(VehiclePrice * 0.4), parseInt(VehiclePrice * 0.5), parseInt(VehiclePrice * 0.6) }
				end

				local Total = #Values[Index]
				if Selected >= Total then
					Price = Values[Index][Total] or 100
				else
					Price = Values[Index][Selected + 1] or 100
				end
			elseif Installed ~= Selected and Selected > -1 then
				Price = (Values[Index] or 100)
			end
		end

		Payment = Payment + Price
	end

	return parseInt(Payment)
end