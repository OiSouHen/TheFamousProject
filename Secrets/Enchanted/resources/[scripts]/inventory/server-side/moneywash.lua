-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local Itens = {
	["promissory1000"] = {
		["Value"] = 1000,
		["Percentage"] = 0.750,
		["Permission"] = 0.950,
		["Police"] = 875
	},
	["promissory2000"] = {
		["Value"] = 2000,
		["Percentage"] = 0.725,
		["Permission"] = 0.925,
		["Police"] = 775
	},
	["promissory3000"] = {
		["Value"] = 3000,
		["Percentage"] = 0.700,
		["Permission"] = 0.900,
		["Police"] = 675
	},
	["promissory4000"] = {
		["Value"] = 4000,
		["Percentage"] = 0.675,
		["Permission"] = 0.875,
		["Police"] = 575
	},
	["promissory5000"] = {
		["Value"] = 5000,
		["Percentage"] = 0.650,
		["Permission"] = 0.850,
		["Police"] = 475
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WASHERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Washers(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.TakeItem(Passport,"wetdollar",Value) then
		exports["vrp"]:CallPolice({
			["Source"] = source,
			["Passport"] = Passport,
			["Permission"] = "Policia",
			["Name"] = "Lavagem de Dinheiro",
			["Percentage"] = Itens["promissory"..Value]["Police"],
			["Wanted"] = 60,
			["Code"] = 31,
			["Color"] = 22
		})

		vRP.GenerateItem(Passport,"promissory"..Value,1,true)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:SWAP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("moneywash:Swap")
AddEventHandler("moneywash:Swap",function()
	local source = source
	local Notification = false
	local Passport = vRP.Passport(source)
	if Passport then
		for Item,v in pairs(Itens) do
			local Consult = vRP.InventoryItemAmount(Passport,Item)
			if Consult[1] > 0 and Consult[2] ~= "" and vRP.TakeItem(Passport,Consult[2],Consult[1]) then
				local Value = v["Value"] * (vRP.HasGroup(Passport,"MoneyWash") and v["Permission"] or v["Percentage"])

				vRP.GenerateItem(Passport,"dollar",Consult[1] * Value)
				Notification = true
			end
		end

		if Notification then
			TriggerClientEvent("Notify",source,"Sucesso","Troca concluída.","verde",5000)
		else
			TriggerClientEvent("Notify",source,"Aviso","Promissórias não encontradas.","amarelo",5000)
		end
	end
end)