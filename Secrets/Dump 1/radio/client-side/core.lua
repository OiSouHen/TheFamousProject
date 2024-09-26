-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Frequency = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:Open")
AddEventHandler("radio:Open",function()
	if not LocalPlayer["state"]["Prison"] then
		SetNuiFocus(true,true)
		SetCursorLocation(0.9,0.9)
		SendNUIMessage({ Action = "Radio", Show = true })

		if not IsPedInAnyVehicle(PlayerPedId()) then
			vRP.CreateObjects("cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioClose",function(Data,Callback)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioActive",function(Data,Callback)
	if MumbleIsConnected() and Frequency ~= Data["Frequency"] and vSERVER.Frequency(Data["Frequency"]) then
		if Frequency ~= 0 then
			exports["pma-voice"]:removePlayerFromRadio()
		end

		TriggerEvent("Notify","Radiofrequência","Entrou na frequência <b>"..Data["Frequency"].."</b>.","verde",5000)
		exports["pma-voice"]:setRadioChannel(Data["Frequency"])
		TriggerEvent("sounds:Private","radioon",0.5)
		TriggerEvent("hud:Radio",Data["Frequency"])
		Frequency = Data["Frequency"]
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOINATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioInative",function(Data,Callback)
	TriggerEvent("radio:RadioClean")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:RADIOCLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:RadioClean")
AddEventHandler("radio:RadioClean",function()
	if Frequency ~= 0 then
		TriggerEvent("sounds:Private","radiooff",1.0)
		exports["pma-voice"]:removePlayerFromRadio()
		TriggerEvent("hud:Radio","OFFLINE")
		Frequency = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("UpFrequency",function()
	local LastFrequency = Frequency + 1
	if MumbleIsConnected() and LastFrequency >= 911 and LastFrequency <= 920 and CheckPolice() and vSERVER.Frequency(LastFrequency) then
		TriggerEvent("Notify","Radiofrequência","Entrou na frequência <b>"..LastFrequency.."</b>.","roxo",5000)
		exports["pma-voice"]:setRadioChannel(LastFrequency)
		TriggerEvent("hud:Radio",LastFrequency)
		Frequency = LastFrequency
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("DownFrequency",function()
	local LastFrequency = Frequency - 1
	if MumbleIsConnected() and LastFrequency >= 911 and LastFrequency <= 920 and CheckPolice() and vSERVER.Frequency(LastFrequency) then
		TriggerEvent("Notify","Radiofrequência","Entrou na frequência <b>"..LastFrequency.."</b>.","roxo",5000)
		exports["pma-voice"]:setRadioChannel(LastFrequency)
		TriggerEvent("hud:Radio",LastFrequency)
		Frequency = LastFrequency
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("UpFrequency","Aumentar frequencia do rádio.","keyboard","PRIOR")
RegisterKeyMapping("DownFrequency","Diminuir frequencia do rádio.","keyboard","PAGEDOWN")