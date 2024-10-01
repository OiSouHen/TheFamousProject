-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("keyboard", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Status = ""
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("success", function(Data, Callback)
	SetNuiFocus(false, false)
	Status = Data["data"]
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAILURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("failure", function(Data, Callback)
	SetNuiFocus(false, false)
	Status = "undefined"
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYBOARD
-----------------------------------------------------------------------------------------------------------------------------------------
function Keyboard(Data)
	if Progress then return end

	Progress = true
	SetNuiFocus(true, true)
	SendNUIMessage({ name = "Open", payload = Data })

	while Progress do
		Wait(0)
	end

	if Status ~= "undefined" then
		return Status
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
function Password(First)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "password",
				placeholder = First,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIMARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Primary(First)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SECONDARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Secondary(First, Second)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			}, {
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] or not Array[2]["input"] then
			return false
		end

		return { Array[1]["input"], Array[2]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TERTIARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Tertiary(First, Second, Third)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			}, {
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			}, {
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] or not Array[2]["input"] or not Array[3]["input"] then
			return false
		end

		return { Array[1]["input"], Array[2]["input"], Array[3]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUADRUPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Quadruple(First, Second, Third, Fourth)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			}, {
				id = 2,
				mode = "area",
				placeholder = Second,
				value = ""
			}, {
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			}, {
				id = 4,
				mode = "text",
				placeholder = Fourth,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] or not Array[2]["input"] or not Array[3]["input"] or not Array[4]["input"] then
			return false
		end

		return { Array[1]["input"], Array[2]["input"], Array[3]["input"], Array[4]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPY
-----------------------------------------------------------------------------------------------------------------------------------------
function Copy(First, Second)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 0,
				mode = "area",
				placeholder = First,
				value = Second
			}
		}
	})

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Area(First)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "area",
				placeholder = First,
				value = ""
			}
		}
	})

	if Array then
		if not Array[1]["input"] then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Password(First)
	return Password(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYSINGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Primary(First)
	return Primary(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYDOUBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Secondary(First, Second)
	return Secondary(First, Second)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYTRIPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Tertiary(First, Second, Third)
	return Tertiary(First, Second, Third)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYQUADRUPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Quadruple(First, Second, Third, Fourth)
	return Quadruple(First, Second, Third, Fourth)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Area(First)
	return Area(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYCOPY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Copy(First, Message)
	return Copy(First, Message)
end