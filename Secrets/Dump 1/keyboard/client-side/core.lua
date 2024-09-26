-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("keyboard",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Results = false
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAILURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("failure",function(Data,Callback)
	Results = false
	Progress = false
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("success",function(Data,Callback)
	SetNuiFocus(false,false)
	Results = Data["data"]
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	Results = false
	Progress = false
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYBOARD
-----------------------------------------------------------------------------------------------------------------------------------------
function Keyboard(Data)
	if Progress then return end

	Progress = true
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ Action = "Open", Payload = Data })

	while Progress do
		Wait(0)
	end

	return Results
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

	if Array and Array["1"] and Array["1"]["input"] ~= "" then
		return { Array["1"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSTAGRAM
-----------------------------------------------------------------------------------------------------------------------------------------
function Instagram(First)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Selecione o campo abaixo",
		rows = {
			{
				id = 1,
				mode = "options",
				placeholder = "Selecione uma opção",
				options = First,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" then
		return { Array["1"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Options(First,Second)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "options",
				placeholder = "Selecione uma opção",
				options = Second,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Timeset(First,Second,Third)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			},{
				id = 3,
				mode = "options",
				placeholder = "Selecione uma opção",
				options = Third,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" and Array["3"] and Array["3"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"],Array["3"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Item(First,Second,Third,Fourth,Fifty)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			},{
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			},{
				id = 4,
				mode = "options",
				placeholder = "Selecione uma opção",
				options = Fourth,
				value = ""
			},{
				id = 5,
				mode = "text",
				placeholder = Fifty,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" and Array["3"] and Array["3"]["input"] ~= "" and Array["4"] and Array["4"]["input"] ~= "" and Array["5"] and Array["5"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"],Array["3"]["input"],Array["4"]["input"],Array["5"]["input"] }
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

	if Array and Array["1"] and Array["1"]["input"] ~= "" then
		return { Array["1"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SECONDARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Secondary(First,Second)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TERTIARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Tertiary(First,Second,Third)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			},{
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" and Array["3"] and Array["3"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"],Array["3"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUATERNARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Quaternary(First,Second,Third,Fourth)
	local Array = Keyboard({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			},{
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			},{
				id = 4,
				mode = "area",
				placeholder = Fourth,
				value = ""
			}
		}
	})

	if Array and Array["1"] and Array["1"]["input"] ~= "" and Array["2"] and Array["2"]["input"] ~= "" and Array["3"] and Array["3"]["input"] ~= "" and Array["4"] and Array["4"]["input"] ~= "" then
		return { Array["1"]["input"],Array["2"]["input"],Array["3"]["input"],Array["4"]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPY
-----------------------------------------------------------------------------------------------------------------------------------------
function Copy(First,Second)
	local Array = Keyboard({
		save = true,
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
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

	if Array and Array["1"] and Array["1"]["input"] ~= "" then
		return { Array["1"]["input"] }
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
-- PRIMARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Primary(First)
	return Primary(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SECONDARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Secondary(First,Second)
	return Secondary(First,Second)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TERTIARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Tertiary(First,Second,Third)
	return Tertiary(First,Second,Third)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUATERNARY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Quaternary(First,Second,Third,Fourth)
	return Quaternary(First,Second,Third,Fourth)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Area(First)
	return Area(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Copy(First,Message)
	return Copy(First,Message)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSTAGRAM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Instagram(First)
	return Instagram(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Options(First,Secondary)
	return Options(First,Secondary)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Timeset(First,Secondary,Third)
	return Timeset(First,Secondary,Third)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Item(First,Secondary,Third,Fourth,Fifty)
	return Item(First,Secondary,Third,Fourth,Fifty)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Item",Item)
exports("Area",Area)
exports("Copy",Copy)
exports("Options",Options)
exports("Timeset",Timeset)
exports("Primary",Primary)
exports("Password",Password)
exports("Tertiary",Tertiary)
exports("Secondary",Secondary)
exports("Instagram",Instagram)
exports("Quaternary",Quaternary)