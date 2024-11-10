-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("boosting",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Pendings = {}
local Cooldowns = {}
local ActiveMax = {}
local MaxContracts = 0
local TotalContracts = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTRACTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Contracts = {
	[1] = {
		{
			["Vehicle"] = "gt500",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "toros",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "sheava",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "surano",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "rapidgt",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "feltzer2",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "alpha",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "gp1",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "infernus",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "bullet",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "freecrawler",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "turismo2",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "zr350",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "locust",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "seven70",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "caracara2",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "ruffian",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		},{
			["Vehicle"] = "enduro",
			["Timer"] = 3600,
			["Value"] = 150,
			["Plate"] = "",
			["Class"] = 1,
			["Exp"] = 5
		}
	},
	[2] = {
		{
			["Vehicle"] = "specter",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "rebla",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "ruston",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "jester",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "banshee",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "cypher",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "voltic",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "rt3000",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "sc1",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "carbonizzare",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "infernus2",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "imorgon",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "sultan2",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "elegy2",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "yosemite2",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "ninef",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "everon",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		},{
			["Vehicle"] = "double",
			["Timer"] = 3600,
			["Value"] = 175,
			["Plate"] = "",
			["Class"] = 2,
			["Exp"] = 4
		}
	},
	[3] = {
		{
			["Vehicle"] = "jackal",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "sugoi",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "penumbra",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "paragon",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "nero",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "komoda",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "ninef2",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "futo",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "buffalo3",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "banshee2",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "adder",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "schlagen",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "bestiagts",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "jester3",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "elegy",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "cheetah2",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "khamelion",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "sanchez",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		},{
			["Vehicle"] = "diablous2",
			["Timer"] = 3600,
			["Value"] = 200,
			["Plate"] = "",
			["Class"] = 3,
			["Exp"] = 4
		}
	},
	[4] = {
		{
			["Vehicle"] = "omnis",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "massacro",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "euros",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "cheetah",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "tyrus",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "kuruma",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "nero2",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "ardent",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "sultan3",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "autarch",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "fmj",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "jester2",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "carbonrs",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		},{
			["Vehicle"] = "reever",
			["Timer"] = 3600,
			["Value"] = 225,
			["Plate"] = "",
			["Class"] = 4,
			["Exp"] = 3
		}
	},
	[5] = {
		{
			["Vehicle"] = "gb200",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "sultanrs",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "pariah",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "vacca",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "zentorno",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "t20",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "issi7",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "penetrator",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "emerus",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "revolter",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "sentinel3",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "bati",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		},{
			["Vehicle"] = "bf400",
			["Timer"] = 3600,
			["Value"] = 250,
			["Plate"] = "",
			["Class"] = 5,
			["Exp"] = 3
		}
	},
	[6] = {
		{
			["Vehicle"] = "flashgt",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "dominator7",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "osiris",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "turismor",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "jester4",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "pfister811",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "italigtb2",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		},{
			["Vehicle"] = "akuma",
			["Timer"] = 3600,
			["Value"] = 275,
			["Plate"] = "",
			["Class"] = 6,
			["Exp"] = 2
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
local Minimals = {
	[1] = {
		["Min"] = 300,
		["Max"] = 900
	},
	[2] = {
		["Min"] = 600,
		["Max"] = 1200
	},
	[3] = {
		["Min"] = 900,
		["Max"] = 1500
	},
	[4] = {
		["Min"] = 1200,
		["Max"] = 1800
	},
	[5] = {
		["Min"] = 1500,
		["Max"] = 2100
	},
	[6] = {
		["Min"] = 1800,
		["Max"] = 2700
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEVELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Levels = { 0,1000,2000,3500,5000,7500 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABOUTCLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
function AboutClasses(Experience)
	local Return = 1

	for Table = 1,#Levels do
		if Experience >= Levels[Table] then
			Return = Table
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60000)

		for Passport,v in pairs(Pendings) do
			if vRP.Source(Passport) then
				local Experience = vRP.GetExperience(Passport,"Boosting")
				local Level = AboutClasses(Experience)
				local Randomize = math.random(Level)

				if os.time() >= Cooldowns[Passport][Randomize] and CountTable(Pendings[Passport]) < 3 then
					if (Randomize == 6 and MaxContracts >= 3) or (Randomize == 6 and ActiveMax[Passport]) then
						goto SkipContracts
					end

					if Randomize == 6 then
						MaxContracts = MaxContracts + 1
						ActiveMax[Passport] = true
					end

					TotalContracts = TotalContracts + 1
					local Selected = math.random(#Contracts[Randomize])
					Pendings[Passport][TotalContracts] = Contracts[Randomize][Selected]
					Cooldowns[Passport][Randomize] = os.time() + math.random(Minimals[Randomize]["Min"],Minimals[Randomize]["Max"])
				end

				::SkipContracts::
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	local Experience = vRP.GetExperience(Passport,"Boosting") or 0

	return { Experience,Levels }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Actives()
	local Result = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] then
		if os.time() >= Active[Passport]["Timer"] then
			local Class = Active[Passport]["Class"]

			Cooldowns[Passport][Class] = os.time() + math.random(Minimals[Class]["Min"],Minimals[Class]["Max"])
			Active[Passport] = nil
		else
			Result = {
				["Number"] = Active[Passport]["Number"],
				["Vehicle"] = VehicleName(Active[Passport]["Vehicle"]),
				["Timer"] = Active[Passport]["Timer"] - os.time(),
				["Class"] = Active[Passport]["Class"],
				["Value"] = Active[Passport]["Value"],
				["Exp"] = Active[Passport]["Exp"]
			}
		end
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PENDINGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Pendings()
	local Results = {}
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Pendings[Passport] then
			Pendings[Passport] = {}
		end

		if not Cooldowns[Passport] then
			Cooldowns[Passport] = {
				[1] = os.time(),
				[2] = os.time(),
				[3] = os.time(),
				[4] = os.time(),
				[5] = os.time(),
				[6] = os.time()
			}
		end

		for Number,v in pairs(Pendings[Passport]) do
			Results[#Results + 1] = {
				["Number"] = Number,
				["Vehicle"] = VehicleName(v["Vehicle"]),
				["Timer"] = v["Timer"],
				["Class"] = v["Class"],
				["Value"] = v["Value"],
				["Exp"] = v["Exp"],
				["Scratch"] = false
			}
		end
	end

	return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Accept(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and vRP.TakeItem(Passport,"platinum",Pendings[Passport][Selected]["Value"]) then
		Active[Passport] = Pendings[Passport][Selected]
		Active[Passport]["Timer"] = os.time() + Pendings[Passport][Selected]["Timer"]
		Active[Passport]["Number"] = Selected

		TriggerClientEvent("boosting:Active",source,Active[Passport]["Vehicle"],Active[Passport]["Class"])

		Pendings[Passport][Selected] = nil

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRATCH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Scratch(Selected)
	local source = source

	return vRP.Passport(source) and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Transfer(Selected,OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Selected and OtherPassport and Pendings[Passport] and Pendings[OtherPassport] and Pendings[Passport][Selected] and CountTable(Pendings[OtherPassport]) < 3 then
		local Class = Pendings[Passport][Selected]["Class"]

		Cooldowns[Passport][Class] = os.time() + math.random(Minimals[Class]["Min"],Minimals[Class]["Max"])
		Pendings[OtherPassport][#Pendings[OtherPassport] + 1] = Pendings[Passport][Selected]
		Pendings[Passport][Selected] = nil

		TriggerClientEvent("Notify",source,"Sucessso","Transferência concluída.","verde",5000)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECLINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Decline(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Pendings[Passport] and Pendings[Passport][Selected] then
		local Class = Pendings[Passport][Selected]["Class"]

		Cooldowns[Passport][Class] = os.time() + math.random(Minimals[Class]["Min"],Minimals[Class]["Max"])
		Pendings[Passport][Selected] = nil

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Remove",function(Passport,Plate)
	if Active[Passport] and Active[Passport]["Plate"] == Plate then
		local Class = Active[Passport]["Class"]

		Cooldowns[Passport][Class] = os.time() + math.random(Minimals[Class]["Min"],Minimals[Class]["Max"])
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateVehicle(Model,Class,Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle = CreateVehicle(Model,Coords,true,true)

		while not DoesEntityExist(Vehicle) do
			Wait(1)
		end

		if DoesEntityExist(Vehicle) then
			local Plate = exports["inventory"]:GeneratePlate()

			Active[Passport]["Plate"] = Plate
			SetVehicleNumberPlateText(Vehicle,Plate)
			SetEntityIgnoreRequestControlFilter(Vehicle,true)

			Entity(Vehicle)["state"]:set("Fuel",100,true)
			Entity(Vehicle)["state"]:set("Tower",true,true)
			Entity(Vehicle)["state"]:set("Nitro",2000,true)

			TriggerEvent("inventory:Boosting",Plate,{
				["Amount"] = 0,
				["Source"] = source,
				["Passport"] = Passport,
				["Class"] = Class
			})

			TriggerClientEvent("NotifyPush",source,{ code = 31, title = "Informações do Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(Model).." - "..Plate, color = 44 })

			return NetworkGetNetworkIdFromEntity(Vehicle)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Payment",function(source,Passport)
	if Active[Passport] then
		if Active[Passport]["Timer"] >= os.time() then
			local Class = Active[Passport]["Class"]
			local GainExperience = Active[Passport]["Exp"]
			local Valuation = Active[Passport]["Value"] * 3
			local Total = math.random(Minimals[Class]["Min"],Minimals[Class]["Max"])

			if exports["party"]:DoesExist(Passport,2) then
				local Consult = exports["party"]:Room(Passport,source,25)

				for Number = 1,CountTable(Consult) do
					if vRP.Passport(Consult[Number]["Source"]) then
						local OtherPassport = Consult[Number]["Passport"]

						vRP.PutExperience(OtherPassport,"Boosting",GainExperience)
						vRP.GenerateItem(OtherPassport,"platinum",Valuation,true)
						vRP.RolepassPoints(OtherPassport,GainExperience,true)
						Cooldowns[OtherPassport][Class] = os.time() + Total
						Active[OtherPassport] = nil
					end
				end
			else
				vRP.PutExperience(Passport,"Boosting",GainExperience)
				vRP.GenerateItem(Passport,"platinum",Valuation,true)
				vRP.RolepassPoints(Passport,GainExperience,true)
				Cooldowns[Passport][Class] = os.time() + Total
			end
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport)
	if not Pendings[Passport] then
		Pendings[Passport] = {}
	end

	if not Cooldowns[Passport] then
		Cooldowns[Passport] = {
			[1] = os.time(),
			[2] = os.time(),
			[3] = os.time(),
			[4] = os.time(),
			[5] = os.time(),
			[6] = os.time()
		}
	end
end)