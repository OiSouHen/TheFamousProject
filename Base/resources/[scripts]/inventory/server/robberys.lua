-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberys = {
	["weaponshop"] = {
		["Cops"] = 6,
		["Duration"] = 300,
		["Name"] = "Loja de Armas",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["tattooshop"] = {
		["Cops"] = 6,
		["Duration"] = 300,
		["Name"] = "Loja de Tatuagem",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["fleecas"] = {
		["Cops"] = 10,
		["Duration"] = 600,
		["Name"] = "Banco Fleeca",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 125000,
			["Max"] = 150000
		}
	},
	["departmentshop"] = {
		["Cops"] = 8,
		["Duration"] = 300,
		["Name"] = "Loja de Departamento",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 75000,
			["Max"] = 100000
		}
	},
	["clotheshop"] = {
		["Cops"] = 6,
		["Duration"] = 300,
		["Name"] = "Loja de Roupas",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["barbershop"] = {
		["Cops"] = 6,
		["Duration"] = 300,
		["Name"] = "Barbearia",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 25000,
			["Max"] = 30000
		}
	},
	["banks"] = {
		["Cops"] = 12,
		["Duration"] = 600,
		["Name"] = "Banco",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 225000,
			["Max"] = 250000
		}
	},
	["jewelry"] = {
		["Cops"] = 8,
		["Duration"] = 600,
		["Name"] = "Joalheria",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 100000,
			["Max"] = 125000
		}
	},
	["eletronics"] = {
		["Cops"] = 6,
		["Duration"] = 30,
		["Name"] = "Caixa Eletrônico",
		["Cooldown"] = 900,
		["Mode"] = "eletronic",
		["Payment"] = {
			["Item"] = "dirtydollar",
			["Min"] = 5225,
			["Max"] = 6725
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Robberys")
AddEventHandler("inventory:Robberys",function(Crime)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Robberys[Crime] then
		local Mode = Robberys[Crime]["Mode"]

		if not Cooldown[Mode] or os.time() > Cooldown[Mode] then
			if vRP.AmountService("Policia") >= Robberys[Crime]["Cops"] then
				vRPC.AnimActive(source)
				vRP.FreezePlayer(source,true)
				Player(source)["state"]["Buttons"] = true
				Cooldown[Mode] = os.time() + Robberys[Crime]["Cooldown"]
				Active[Passport] = os.time() + Robberys[Crime]["Duration"]
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
				TriggerClientEvent("Progress",source,"Roubando",Robberys[Crime]["Duration"] * 1000)

				exports["vrp"]:CallPolice({
					["Source"] = source,
					["Passport"] = Passport,
					["Permission"] = "Policia",
					["Name"] = "Roubo a "..Robberys[Crime]["Name"],
					["Wanted"] = Robberys[Crime]["Duration"] * 3,
					["Code"] = 31,
					["Color"] = 22
				})

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						vRP.FreezePlayer(source,false)
						Player(source)["state"]["Buttons"] = false
						TriggerClientEvent("player:Residual",source,"Resquício de Línter")

						vRP.GenerateItem(Passport,Robberys[Crime]["Payment"]["Item"],math.random(Robberys[Crime]["Payment"]["Min"],Robberys[Crime]["Payment"]["Max"]),true)
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify",source,"Atenção","Contingente indisponível.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Cooldown[Mode] - os.time())..".","amarelo",5000)
		end
	end
end)