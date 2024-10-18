-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60000)

		for Route,Table in pairs(Drops) do
			for Number,v in pairs(Table) do
				if Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["timer"] <= os.time() then
					if ItemUnique(Drops[Route][Number]["key"]) then
						vRP.RemoveServerData(SplitUnique(Drops[Route][Number]["key"]))
					end

					TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
					Drops[Route][Number] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Drops(Item,Slot,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Amount >= 1 and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRPC.InsideVehicle(source) then
		if not vRP.CheckDamaged(Item) then
			if vRP.TakeItem(Passport,Item,Amount,false) then
				exports["inventory"]:Drops(Passport,source,Item,Amount)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("inventory:Notify",source,"Aviso","Utilize as lixeiras para jogar itens danificados.","vermelho")
		end
	else
		TriggerClientEvent("inventory:Update",source,"Backpack")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Drops",function(Passport,source,Item,Amount)
	Active[Passport] = true

	local Split = splitString(Item)
	local Route = GetPlayerRoutingBucket(source)

	if not Drops[Route] then
		Drops[Route] = {}
	end

	repeat
		Selected = GenerateString("DDLLDDLL")
	until Selected and not Drops[Route][Selected]

	local Provisory = {
		["key"] = Item,
		["route"] = Route,
		["id"] = Selected,
		["amount"] = Amount,
		["name"] = ItemName(Item),
		["weight"] = ItemWeight(Item),
		["index"] = ItemIndex(Item),
		["rarity"] = ItemRarity(Item),
		["economy"] = ItemEconomy(Item),
		["desc"] = ItemDescription(Item),
		["coords"] = vCLIENT.EntityCoordsZ(source),
		["timer"] = os.time() + 1800
	}

	if not Provisory["desc"] then
		if Split[1] == "vehkey" and Split[2] then
			Provisory["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
		elseif ItemNamed(Split[1]) and Split[2] then
			Provisory["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
		end
	end

	if Split[2] then
		local Loaded = ItemLoads(Item)
		if Loaded then
			Provisory["charges"] = parseInt(Split[2] * (100 / Loaded))
		end

		local Durability = ItemDurability(Item)
		if Durability then
			Provisory["durability"] = parseInt(os.time() - Split[2])
			Provisory["days"] = Durability
		end
	end

	Active[Passport] = nil
	Drops[Route][Selected] = Provisory
	TriggerClientEvent("inventory:DropsAdicionar",-1,Route,Selected,Drops[Route][Selected])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Pickup(Number,Route,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["key"] and Drops[Route][Number]["timer"] > os.time() then
		Active[Passport] = true

		if vRP.CheckWeight(Passport,Drops[Route][Number]["key"],Amount) then
			local Inv = vRP.Inventory(Passport)
			if not Drops[Route] or not Drops[Route][Number] or not Drops[Route][Number]["key"] or not Drops[Route][Number]["amount"] or Drops[Route][Number]["amount"] < Amount or (Inv[Target] and Inv[Target]["item"] ~= Drops[Route][Number]["key"]) or vRP.MaxItens(Passport,Drops[Route][Number]["key"],Amount) then
				TriggerClientEvent("inventory:Update",source,"Backpack")
				Active[Passport] = nil

				return false
			end

			vRP.GiveItem(Passport,Drops[Route][Number]["key"],Amount,false,Target)
			Drops[Route][Number]["amount"] = Drops[Route][Number]["amount"] - Amount

			if Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["amount"] then
				if parseInt(Drops[Route][Number]["amount"]) <= 0 then
					TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
					Drops[Route][Number] = nil
				else
					TriggerClientEvent("inventory:DropsAtualizar",-1,Route,Number,Drops[Route][Number]["amount"])
				end
			end

			TriggerClientEvent("inventory:Update",source,"Backpack")
		else
			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
		end

		Active[Passport] = nil
	else
		TriggerClientEvent("inventory:Update",source,"Backpack")
	end
end