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
Tunnel.bindInterface("party", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Amounts = 0
local Config = {
	["Room"] = {},
	["Users"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROOMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.GetRooms()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Room = {}
		for Index, v in pairs(Config["Room"]) do
			if CountTable(v["Users"]) == 0 then
				Room[#Room + 1] = nil
				Config["Room"][#Room + 1] = nil
			else
				Room[#Room + 1] = {
					["Identity"] = v["Identity"],
					["Id"] = Index,
					["Name"] = v["Name"],
					["Password"] = v["Password"] or false,
					["Users"] = CountTable(v["Users"])
				}
			end
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
function Hensa.GetMembers(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Config["Room"][Number] and Config["Room"][Number]["Users"] then
		local Room = {}
		for OtherPassport, v in pairs(Config["Room"][Number]["Users"]) do
			Room[#Room + 1] = {
				["Passport"] = OtherPassport,
				["Name"] = vRP.FullName(OtherPassport)
			}
		end
		return {
			["Members"] = Room,
			["Created"] = Config["Room"][Number]["Identity"],
			["Identity"] = Config["Room"][Number]["Identity"],
			["Name"] = Config["Room"][Number]["Name"],
			["Users"] = CountTable(Config["Room"][Number]["Users"])
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CreateRoom(Name, Password)
	local source = source
	local Passport = vRP.Passport(source)

	if Passport and not Config["Users"][Passport] then
		Amounts = Amounts + 1

		Config["Room"][Amounts] = {
			["Created"] = Passport,
			["Identity"] = vRP.FullName(Passport),
			["Name"] = Name,
			["Password"] = Password,
			["Users"] = {
				[Passport] = source
			}
		}
		Config["Users"][Passport] = Amounts

		vRP.Create(source, Passport, tostring(Amounts))

		return {
			["room"] = {
				["Identity"] = Config["Room"][Amounts]["Identity"],
				["Id"] = Amounts,
				["Name"] = Name,
				["Password"] = Password or false,
				["Users"] = CountTable(Config["Room"][Amounts]["Users"])
			}
		}
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.EnterRoom(Number, Password)
	local source = source
	local Passport = vRP.Passport(source)

	if Config["Room"][Number] then
		if Config["Users"][Passport] then
			if Number ~= Config["Users"][Passport] then
				if Config["Users"][Passport] then
					Hensa.LeaveRoom(Config["Users"][Passport])
				end

				Config["Users"][Passport] = Number
				Config["Room"][Number]["Users"][Passport] = source
			end
		else
			Config["Users"][Passport] = Number
			Config["Room"][Number]["Users"][Passport] = source

			TriggerClientEvent("party:ResetNui", source)
		end
	end

	vRP.Add(source, Passport, tostring(Number))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.LeaveRoom(Room)
	local source = source
	local Passport = vRP.Passport(source)

	if not Room then
		Room = Config["Users"][Passport]
	end

	if Config["Room"][Room] then
		if Room then
			Config["Users"][Passport] = nil
			Config["Room"][Room]["Users"][Passport] = nil

			if CountTable(Config["Room"][Room]["Users"]) == 0 then
				Config["Room"][Room] = nil
			end
		end

		TriggerClientEvent("party:ResetNui", source)
	end

	vRP.Rem(source, Passport, tostring(Room))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.KickRoom(Kick, Passport)
	local source = source
	local MyPassport = vRP.Passport(source)

	if Passport ~= MyPassport then
		if Config["Users"][Passport] then
			local Room = Config["Users"][Passport]

			Config["Room"][Room]["Users"][Passport] = nil
			Config["Users"][Passport] = nil

			TriggerClientEvent("party:ResetNui", vRP.Source(Passport))

			vRP.Rem(source, Passport, tostring(Room))

			return Hensa.GetRooms()
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Config["Users"][Passport] then
		local source = vRP.Source(Passport)

		if not Room then
			Room = Config["Users"][Passport]
		end

		if Config["Room"][Room] then
			if Room then
				Config["Users"][Passport] = nil
				Config["Room"][Room]["Users"][Passport] = nil

				if CountTable(Config["Room"][Room]["Users"]) == 0 then
					Config["Room"][Room] = nil
				end
			end
		end

		vRP.Rem(source, Passport, tostring(Room))
	end
end)