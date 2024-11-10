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
Tunnel.bindInterface("party",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local AmountRooms = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	["Room"] = {},
	["Users"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROOMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetRooms()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Room = {}
		for Index,v in pairs(Config["Room"]) do
			Room[#Room + 1] = {
				["Value"] = "",
				["Id"] = v["Id"],
				["Created"] = Index,
				["Name"] = v["Name"],
				["Identity"] = v["Identity"],
				["Password"] = v["Password"] or false,
				["Users"] = CountTable(v["Users"])
			}
		end

		return {
			["group"] = Config["Users"][Passport] or false,
			["room"] = Room
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMEMBERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetMembers(Room)
	local source = source
	local Room = parseInt(Room)
	local Passport = vRP.Passport(source)
	if Passport and Config["Room"][Room] and Config["Room"][Room]["Users"] then
		local Table = {}
		for OtherPassport,v in pairs(Config["Room"][Room]["Users"]) do
			Table[#Table + 1] = {
				["Passport"] = OtherPassport,
				["Name"] = vRP.FullName(OtherPassport)
			}
		end

		return {
			["Id"] = Room,
			["Members"] = Table,
			["Created"] = Config["Room"][Room]["Created"],
			["Identity"] = Config["Room"][Room]["Identity"],
			["Name"] = Config["Room"][Room]["Name"],
			["Users"] = CountTable(Config["Room"][Room]["Users"])
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateRoom(Name,Password)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Config["Users"][Passport] then
		AmountRooms = AmountRooms + 1

		Config["Room"][AmountRooms] = {
			["Id"] = AmountRooms,
			["Created"] = Passport,
			["Identity"] = vRP.FullName(Passport),
			["Name"] = Name,
			["Password"] = Password,
			["Users"] = {
				[Passport] = source
			}
		}

		Config["Users"][Passport] = AmountRooms

		return {
			["group"] = AmountRooms,
			["room"] = {
				["Id"] = AmountRooms,
				["Created"] = Passport,
				["Identity"] = Config["Room"][AmountRooms]["Identity"],
				["Name"] = Name,
				["Password"] = Password,
				["Users"] = CountTable(Config["Room"][AmountRooms]["Users"])
			}
		}
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.LeaveRoom()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Config["Users"][Passport] then
		local Room = Config["Users"][Passport]
		if Config["Room"][Room] and Config["Room"][Room]["Users"] and Config["Room"][Room]["Users"][Passport] then
			for _,Sources in pairs(Config["Room"][Room]["Users"]) do
				async(function()
					TriggerClientEvent("party:Dismiss",Sources,source)
				end)
			end

			Config["Users"][Passport] = nil
			Config["Room"][Room]["Users"][Passport] = nil

			TriggerClientEvent("party:Clear",source)

			if Config["Room"][Room]["Created"] == Passport then
				for OtherPassport,v in pairs(Config["Room"][Room]["Users"]) do
					TriggerClientEvent("party:ResetNui",v)
					Config["Users"][OtherPassport] = nil
				end

				Config["Room"][Room] = nil
			elseif CountTable(Config["Room"][Room]["Users"]) <= 0 then
				Config["Room"][Room] = nil
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.KickRoom(Room,OtherPassport)
	local source = source
	local Room = parseInt(Room)
	local Passport = vRP.Passport(source)
	local OtherSource = vRP.Source(OtherPassport)
	if Passport and Config["Users"][OtherPassport] and Config["Room"][Room] and Config["Room"][Room]["Created"] == Passport and Config["Room"][Room]["Created"] ~= OtherPassport and Config["Room"][Room]["Users"] and Config["Room"][Room]["Users"][OtherPassport] then
		if OtherSource then
			TriggerClientEvent("party:Clear",OtherSource)
			TriggerClientEvent("party:ResetNui",OtherSource)

			for _,Sources in pairs(Config["Room"][Room]["Users"]) do
				async(function()
					TriggerClientEvent("party:Dismiss",Sources,OtherSource)
				end)
			end
		end

		Config["Users"][OtherPassport] = nil
		Config["Room"][Room]["Users"][OtherPassport] = nil

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.EnterRoom(Room,Password)
	local source = source
	local Room = parseInt(Room)
	local Passport = vRP.Passport(source)
	if Passport and not Config["Users"][Passport] and Config["Room"][Room] and Config["Room"][Room]["Users"] and CountTable(Config["Room"][Room]["Users"]) <= 9 and not Config["Room"][Room]["Users"][Passport] then
		if Config["Room"][Room]["Password"] and Config["Room"][Room]["Password"] ~= Password then
			return false
		end

		Config["Users"][Passport] = Room
		Config["Room"][Room]["Users"][Passport] = source

		for Passports,Sources in pairs(Config["Room"][Room]["Users"]) do
			TriggerClientEvent("party:Invite",source,Sources,vRP.LowerName(Passports))

			async(function()
				TriggerClientEvent("party:Invite",Sources,source,vRP.LowerName(Passport))
			end)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Room",function(Passport,source,Radius)
	local Members = {}
	local Room = Config["Users"][Passport]

	if Room and Config["Room"][Room] then
		if vRP.DoesEntityExist(source) then
			local Coords = vRP.GetEntityCoords(source)

			for OtherPassport,Sources in pairs(Config["Room"][Room]["Users"]) do
				if vRP.DoesEntityExist(Sources) then
					local OtherCoords = vRP.GetEntityCoords(Sources)

					if #(Coords - OtherCoords) <= Radius then
						Members[#Members + 1] = {
							["Passport"] = OtherPassport,
							["Source"] = Sources
						}
					end
				end
			end
		end
	end

	return Members,CountTable(Members)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOESEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
exports("DoesExist",function(Passport,Players)
	local Return = false

	if Players then
		if Config["Users"][Passport] then
			local source = vRP.Source(Passport)
			local Members = exports["party"]:Room(Passport,source,25)
			if CountTable(Members) >= Players then
				Return = Members
			end
		end
	else
		Return = Config["Users"][Passport]
	end

	return Return
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Config["Users"][Passport] then
		local Room = Config["Users"][Passport]

		for _,Sources in pairs(Config["Room"][Room]["Users"]) do
			async(function()
				TriggerClientEvent("party:Dismiss",Sources,source)
			end)
		end

		Config["Users"][Passport] = nil
		Config["Room"][Room]["Users"][Passport] = nil

		if CountTable(Config["Room"][Room]["Users"]) <= 0 then
			Config["Room"][Room] = nil
		end
	end
end)