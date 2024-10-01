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
Tunnel.bindInterface("notepad", Hensa)
vCLIENT = Tunnel.getInterface("notepad")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Notes = 0
GlobalState["Notepad"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.createNotepad(text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Notes = Notes + 1
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		local Notepad = GlobalState["Notepad"]
		Notepad[Notes] = { Passport = Passport, id = Notes, text = tostring(text), x = Coords["x"], y = Coords["y"],
			z = Coords["z"] }
		GlobalState:set("Notepad", Notepad, true)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.editNotepad(id, text)
	if GlobalState["Notepad"][id] then
		local Notepad = GlobalState["Notepad"]
		Notepad[id]["text"] = tostring(text)
		GlobalState:set("Notepad", Notepad, true)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.destroyNotepad(id)
	if GlobalState["Notepad"][id] then
		local Notepad = GlobalState["Notepad"]

		Notepad[id] = nil

		GlobalState:set("Notepad", Notepad, true)
	end
end
