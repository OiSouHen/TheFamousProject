-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("bank:Open", function()
	if not exports["hud"]:Wanted() then
		TriggerEvent("Progress", "Abrindo", 3500)
		LocalPlayer["state"]:set("Cancel", true, true)
		LocalPlayer["state"]:set("Buttons", true, true)
		vRP.PlayAnim(false, { "amb@prop_human_atm@male@enter", "enter" }, false)

		SetTimeout(3500, function()
			SetNuiFocus(true, true)
			LocalPlayer["state"]:set("Cancel", false, true)
			LocalPlayer["state"]:set("Buttons", false, true)
			SendNUIMessage({ Action = "Open", name = LocalPlayer["state"]["Name"] })
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	SetNuiFocus(false, false)
	SendNUIMessage({ Action = "Hide" })
	TriggerEvent("Progress", "Fechando", 3500)
	LocalPlayer["state"]:set("Cancel", true, true)
	LocalPlayer["state"]:set("Buttons", true, true)
	vRP.PlayAnim(false, { "amb@prop_human_atm@male@exit", "exit" }, false)

	SetTimeout(3500, function()
		LocalPlayer["state"]:set("Cancel", false, true)
		LocalPlayer["state"]:set("Buttons", false, true)
		vRP.Destroy()
	end)

	Callback(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Home", function(Data, Callback)
	Callback(vSERVER.Home())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Deposit", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Deposit(Data["value"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Withdraw", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.Withdraw(Data["value"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Transfer", function(Data, Callback)
	if Data["targetId"] and Data["value"] and MumbleIsConnected() then
		Callback(vSERVER.Transfer(Data["targetId"], Data["value"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Investments", function(Data, Callback)
	Callback(vSERVER.Investments())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Invest", function(Data, Callback)
	if Data["value"] and MumbleIsConnected() then
		Callback(vSERVER.Invest(Data["value"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvestRescue", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.InvestRescue())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONHISTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("TransactionHistory", function(Data, Callback)
	Callback(vSERVER.TransactionHistory())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MakeInvoice", function(Data, Callback)
	if Data["passport"] and Data["value"] and Data["reason"] and MumbleIsConnected() then
		Callback(vSERVER.MakeInvoice(Data["passport"], Data["value"], Data["reason"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvoicePayment", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.InvoicePayment(Data["id"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvoiceList", function(Data, Callback)
	Callback(vSERVER.InvoiceList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FineList", function(Data, Callback)
	Callback(vSERVER.FineList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FinePayment", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.FinePayment(Data["id"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FinePaymentAll", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.FinePaymentAll())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Taxes", function(Data, Callback)
	Callback(vSERVER.TaxList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("TaxPayment", function(Data, Callback)
	if MumbleIsConnected() then
		Callback(vSERVER.TaxPayment(Data["id"]))
	end
end)