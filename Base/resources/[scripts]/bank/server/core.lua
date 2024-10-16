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
Tunnel.bindInterface("bank", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Cooldown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if os.time() >= Cooldown then
			Cooldown = os.time() + 3600
			vRP.Query("investments/Actives")
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Home()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Yield = 0
		local Identity = vRP.Identity(Passport)

		local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		if InvestmentCheck[1] then
			Yield = InvestmentCheck[1]["Monthly"]
		end

		return {
			["yield"] = Yield,
			["balance"] = Identity["Bank"],
			["transactions"] = Transactions(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONHISTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TransactionHistory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Transactions(Passport,50)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Deposit(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(Valuation) > 0 then
		Active[Passport] = true

		if vRP.ConsultItem(Passport,DefaultMoneyOne,Valuation) and vRP.TakeItem(Passport,DefaultMoneyOne,Valuation) then
			vRP.GiveBank(Passport,Valuation)
		end

		Active[Passport] = nil

		return {
			["balance"] = vRP.Identity(Passport)["Bank"],
			["transactions"] = Transactions(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Withdraw(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(Valuation) > 0 and not exports["bank"]:CheckFines(Passport) then
		Active[Passport] = true

		vRP.WithdrawCash(Passport,Valuation)

		Active[Passport] = nil

		return {
			["balance"] = vRP.Identity(Passport)["Bank"],
			["transactions"] = Transactions(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Transfer(OtherPassport,Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and OtherPassport ~= Passport and parseInt(Valuation) > 0 and not exports["bank"]:CheckFines(Passport) then
		Active[Passport] = true

		if vRP.Identity(OtherPassport) and vRP.PaymentBank(Passport,Valuation,true) then
			vRP.GiveBank(OtherPassport,Valuation)
		end

		Active[Passport] = nil
	end

	return {
		["balance"] = vRP.Identity(Passport)["Bank"],
		["transactions"] = Transactions(Passport)
	}
end
----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Transactions(Passport,Limit)
	local Transaction = {}
	local TransactionList = vRP.Query("transactions/List",{ Passport = Passport, Limit = Limit or 4 })
	if TransactionList[1] then
		for _,v in pairs(TransactionList) do
			Transaction[#Transaction + 1] = {
				["type"] = v["Type"],
				["date"] = v["Date"],
				["value"] = v["Price"],
				["balance"] = v["Balance"]
			}
		end
	end

	return Transaction
end
----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
function Fines(Passport)
	local Fines = {}
	local FineList = vRP.Query("fines/List",{ Passport = Passport })
	if FineList[1] then
		for _,v in pairs(FineList) do
			Fines[#Fines + 1] = {
				["id"] = v["id"],
				["name"] = v["Name"],
				["value"] = v["Price"],
				["date"] = v["Date"],
				["hour"] = v["Hour"],
				["message"] = v["Message"]
			}
		end
	end

	return Fines
end
----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FineList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Fines(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFINES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CheckFines",function(Passport)
	if Passport and vRP.Query("fines/List",{ Passport = Passport })[1] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FinePayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Fine = vRP.Query("fines/Check",{ Passport = Passport, id = Number })
		if Fine[1] then
			if vRP.PaymentBank(Passport,Fine[1]["Price"]) then
				vRP.Query("fines/Remove",{ Passport = Passport, id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FinePaymentAll()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local FineList = vRP.Query("fines/List",{ Passport = Passport })
		if FineList[1] then
			for _,v in pairs(FineList) do
				if vRP.PaymentBank(Passport,v["Price"]) then
					vRP.Query("fines/Remove",{ Passport = Passport, id = v["id"] })
				end
			end
		end

		Active[Passport] = nil

		return Fines(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
function Taxs(Passport)
	local Taxs = {}
	local TaxList = vRP.Query("taxs/List",{ Passport = Passport })
	if TaxList[1] then
		for _,v in pairs(TaxList) do
			Taxs[#Taxs + 1] = {
				["id"] = v["id"],
				["name"] = v["Name"],
				["value"] = v["Price"],
				["date"] = v["Date"],
				["hour"] = v["Hour"],
				["message"] = v["Message"]
			}
		end
	end

	return Taxs
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TaxList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Taxs(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TaxPayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Tax = vRP.Query("taxs/Check",{ Passport = Passport, id = Number })
		if Tax[1] then
			if vRP.PaymentBank(Passport,Tax[1]["Price"]) then
				vRP.Query("taxs/Remove",{ Passport = Passport, id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CheckTaxs",function(Passport)
	if Passport and vRP.Query("taxs/List",{ Passport = Passport })[1] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvoiceList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Invoices(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.MakeInvoice(OtherPassport,Valuation,Reason)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and OtherPassport ~= Passport and parseInt(Valuation) > 0 then
		Active[Passport] = true

		local OtherSource = vRP.Source(OtherPassport)
		if OtherSource then
			if vRP.Request(OtherSource,"Banco","<b>"..vRP.FullName(Passport).."</b> lhe enviou uma fatura de <b>R$"..Dotted(Valuation).."</b>, deseja aceita-la?") then
				vRP.Query("invoices/Add",{ Passport = OtherPassport, Received = Passport, Type = "received", Reason = Reason, Holder = vRP.FullName(Passport), Price = Valuation })
				vRP.Query("invoices/Add",{ Passport = Passport, Received = OtherPassport, Type = "sent", Reason = Reason, Holder = "Você", Price = Valuation })
				Active[Passport] = nil

				return Invoices(Passport)
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvoicePayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Invoice = vRP.Query("invoices/Check",{ id = Number })
		if Invoice[1] then
			if vRP.PaymentBank(Passport,Invoice[1]["Price"]) then
				vRP.GiveBank(Invoice[1]["Received"],Invoice[1]["Price"])
				vRP.Query("invoices/Remove",{ id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoices(Passport)
	local Invoices = {}
	local InvoiceList = vRP.Query("invoices/List",{ Passport = Passport })
	if InvoiceList[1] then
		for _,v in pairs(InvoiceList) do
			local Type = v["Type"]

			if not Invoices[Type] then
				Invoices[Type] = {}
			end

			Invoices[Type][#Invoices[Type] + 1] = {
				["id"] = v["id"],
				["reason"] = v["Reason"],
				["holder"] = v["Holder"],
				["value"] = v["Price"]
			}
		end
	end

	return Invoices
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Investments()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Total,Brute,Liquid,Deposit = 0,0,0,0
		local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		if InvestmentCheck[1] then
			Total = InvestmentCheck[1]["Deposit"] + InvestmentCheck[1]["Liquid"]
			Brute = InvestmentCheck[1]["Deposit"]
			Liquid = InvestmentCheck[1]["Liquid"]
			Deposit = InvestmentCheck[1]["Deposit"]
		end

		return {
			["total"] = Total,
			["brute"] = Brute,
			["liquid"] = Liquid,
			["deposit"] = Deposit
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Invest(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(Valuation) > 0 then
		Active[Passport] = true

		if vRP.PaymentBank(Passport,Valuation) then
			local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
			if InvestmentCheck[1] then
				vRP.Query("investments/Invest",{ Passport = Passport, Price = Valuation })
			else
				vRP.Query("investments/Add",{ Passport = Passport, Deposit = Valuation })
			end

			Active[Passport] = nil

			return true
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvestRescue()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		if InvestmentCheck[1] then
			local Valuation = InvestmentCheck[1]["Deposit"] + InvestmentCheck[1]["Liquid"]
			vRP.Query("investments/Remove",{ Passport = Passport })
			vRP.GiveBank(Passport,Valuation)
		end

		Active[Passport] = nil
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTaxs",function(Passport,source,Name,Valuation,Message)
	if vRP.UserPremium(Passport) then
		local Hierarchy = vRP.GetUserHierarchy(Passport,"Premium")
		if Hierarchy == 1 then
			Valuation = Valuation * 0.0125
		elseif Hierarchy == 2 then
			Valuation = Valuation * 0.0250
		else
			Valuation = Valuation * 0.0375
		end
	else
		Valuation = Valuation * 0.05
	end

	vRP.Query("taxs/Add",{ Passport = Passport, Name = Name, Date = os.date("%d/%m/%Y"), Hour = os.date("%H:%M"), Price = parseInt(Valuation), Message = Message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTransactions",function(Passport,Type,Valuation)
	vRP.Query("transactions/Add",{ Passport = Passport, Type = Type, Date = os.date("%d/%m/%Y"), Price = Valuation, Balance = vRP.GetBank(Passport) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddFines",function(Passport,OtherPassport,Valuation,Message)
	vRP.Query("fines/Add",{ Passport = Passport, Name = vRP.FullName(OtherPassport), Date = os.date("%d/%m/%Y"), Hour = os.date("%H:%M"), Price = Valuation, Message = Message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Taxs",Taxs)
exports("Fines",Fines)
exports("Invoices",Invoices)
exports("Dependents",Dependents)
exports("Transactions",Transactions)