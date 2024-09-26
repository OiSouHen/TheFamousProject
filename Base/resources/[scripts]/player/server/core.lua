-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("player", Hensa)
vCLIENT = Tunnel.getInterface("player")
vMEMORY = Tunnel.getInterface("memory")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local CardPrice = 225
local WashPrice = 125
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Charge")
AddEventHandler("player:Charge", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			local Keyboard = vKEYBOARD.Primary(source, "Valor da Cobrança.")
			if Keyboard then
				local amount = tonumber(Keyboard[1])
				if amount then
					local formattedAmount = Dotted(amount)
					local confirmationMessage = "Aceitar a cobrança de <b>$" .. formattedAmount .. "</b> feita por <b>".. vRP.FullName(Passport) .."</b>?"

					if vRP.Request(Entity, "Cobrança", confirmationMessage) then
						local senderBank = vRP.GetBank(Entity)

						if senderBank >= amount then
							TriggerClientEvent("NotifyItens", Entity, { "-", "dollars", formattedAmount, "Dólares" })
							vRP.RemoveBank(OtherPassport, amount)
							vRP.GiveBank(Passport, amount)
						else
							TriggerClientEvent("Notify", Entity, "vermelho", "<b>Saldo</b> insuficiente.", "Aviso", 5000)
							TriggerClientEvent("Notify", source, "vermelho", "<b>".. vRP.FullName(OtherPassport) .."</b> não possui saldo suficiente.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Pedido recusado.", "Cobrança", 5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUITEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {
	["MRPD"] = {
		["Distance"] = 1.50,
		["Dimension"] = 1.25,
		["Label"] = "Quadro Branco",
		["Coords"] = vec3(439.47, -985.85, 35.99),
		["Link"] = "https://creative-rp.com/Quadro.png",
		["Dict"] = "prop_planning_b1",
		["Texture"] = "prop_base_white_01b",
		["Width"] = 550,
		["Weight"] = 450
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:TEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Texture")
AddEventHandler("player:Texture", function(Name)
	local source = source
	local Keyboard = vKEYBOARD.Primary(source, "Link:")
	if Keyboard then
		DuiTextures[Name]["Link"] = Keyboard[1]
		TriggerClientEvent("player:DuiUpdate", -1, Name, DuiTextures[Name])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOWNGRADECOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:DowngradeCough")
AddEventHandler("player:DowngradeCough", function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeCough(Passport, Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:DowngradeStress")
AddEventHandler("player:DowngradeStress", function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeStress(Passport, Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:UpgradeStress")
AddEventHandler("player:UpgradeStress", function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpgradeStress(Passport, Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me", function(source, Message, History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local message = string.sub(History:sub(4), 1, 100)

		local Players = vRPC.Players(source)
		for _, v in pairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe", v, source, message, 10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if Message[2] == "friend" then
			local ClosestPed = vRPC.ClosestPed(source, 2)
			if ClosestPed then
				if vRP.GetHealth(ClosestPed) > 100 and not Player(ClosestPed)["state"]["Handcuff"] then
					local Identity = vRP.Identity(Passport)
					if vRP.Request(ClosestPed, "Animação", "Pedido de <b>" .. Identity["Name"] .. "</b> da animação <b>" .. Message[1] .. "</b>?") then
						TriggerClientEvent("emotes", ClosestPed, Message[1])
						TriggerClientEvent("emotes", source, Message[1])
					end
				end
			end
		else
			TriggerClientEvent("emotes", source, Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source, 2)
		if ClosestPed then
			if vRP.HasService(Passport, "Paramedico") then
				TriggerClientEvent("emotes", ClosestPed, Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport, "Admin", 2) then
			local Players = vRPC.ClosestPeds(source, 50)
			for _, v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes", v, Message[1])
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle, Network = vRPC.VehicleList(source, 5)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _, v in pairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors", v, Network, Number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions", function(Mode)
	local source = source
	local vehicle, Network = vRPC.VehicleList(source, 10)
	if vehicle then
		TriggerClientEvent("player:syncWins", source, Network, Mode)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	if Mode == "rv" then
		Distance = 10
	end

	local source = source
	local Passport = vRP.Passport(source)
	local OtherSource = vRPC.ClosestPed(source,Distance)
	if Passport and OtherSource then
		if Player(OtherSource)["state"]["Handcuff"] or vRP.ConsultItem(Passport,"rope",1) or vRP.HasService(Passport,"Emergencia") then
			local Vehicle,Network = vRPC.VehicleList(source,5)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)

				if GetVehicleDoorLockStatus(Networked) <= 1 then
					if Mode == "rv" then
						vCLIENT.RemoveVehicle(OtherSource)
					elseif Mode == "cv" then
						vCLIENT.PlaceVehicle(OtherSource,Network)
						TriggerEvent("inventory:CarryDetach",source,Passport)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and (vRP.HasService(Passport,"Policia") or vRP.HasService(Passport,"Paramedico")) and Preset[Number] then
		local Model = vRP.ModelPlayer(source)

		if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
			TriggerClientEvent("skinshop:Apply",source,Preset[Number][Model])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES", 2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVIT
-----------------------------------------------------------------------------------------------------------------------------------------
local Removit = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit", function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
		if Mode == "aplicar" then
			local Result = vRP.GetServerData("Outfit:"..Passport)
			if Result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,Result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.","Sucesso",5000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.","Atenção",5000)
			end
		elseif Mode == "salvar" then
			local Custom = vSKINSHOP.Customization(source)
			if Custom then
				vRP.SetServerData("Outfit:"..Passport,Custom)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.","Sucesso",5000)
			end
		elseif Mode == "aplicarpre" then
			if vRP.HasGroup(Passport,"Premium") then
				local Result = vRP.GetServerData("PremiumOutfit:"..Passport)
				if Result["pants"] ~= nil then
					TriggerClientEvent("skinshop:Apply",source,Result)
					TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.","Sucesso",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.","Atenção",5000)
				end
			end
		elseif Mode == "salvarpre" then
			if vRP.HasGroup(Passport,"Premium") then
				local Custom = vSKINSHOP.Customization(source)
				if Custom then
					vRP.SetServerData("PremiumOutfit:"..Passport,Custom)
					TriggerClientEvent("Notify",source,"verde","Roupas salvas.","Sucesso",5000)
				end
			end
		elseif Mode == "remover" then
			local Model = vRP.ModelPlayer(source)

			if Removit[Model] then
				TriggerClientEvent("skinshop:Apply",source,Removit[Model])
			end
		else
			TriggerClientEvent("skinshop:set"..Mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(PedSource,OtherSource)
	local Passport = vRP.Passport(PedSource)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and OtherPassport and Passport ~= OtherPassport then
		local Identity = vRP.Identity(Passport)
		local OtherIdentity = vRP.Identity(OtherPassport)
		if Identity and OtherIdentity then
			local Coords = vRP.GetEntityCoords(PedSource)
			local OtherCoords = vRP.GetEntityCoords(OtherSource)

			exports["vrp"]:Embed("Deaths","**Passaporte do Assassino:** "..OtherPassport.."\n**Localização do Assassino:** "..SplitUnique(OtherCoords["x"])..","..SplitUnique(OtherCoords["y"])..","..SplitUnique(OtherCoords["z"]).."\n\n**Passaporte da Vítima:** "..Passport.."\n**Localização da Vítima:** "..SplitUnique(Coords["x"])..","..SplitUnique(Coords["y"])..","..SplitUnique(Coords["z"]).."\n\n**Data & Hora:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"),0xa3c846)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GETCARD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:GetCard")
AddEventHandler("player:GetCard",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.MaxItens(Passport,"bankcard",1) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
		else
			if vRP.Request(source,"Banco","Deseja emitir <b>1x "..ItemName("bankcard").."</b> por <b>$"..Dotted(CardPrice).."</b> dólares?") then
				if vRP.PaymentBank(Passport,CardPrice) then
					vRP.GenerateItem(Passport,"bankcard",1,true)
					exports["bank"]:AddTaxs(Passport,source,"Prefeitura",CardPrice,"Emissão de Cartão Bancário.")
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Saldo</b> insuficiente.","Aviso",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GETSCRATCHCARD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:GetScratchCard")
AddEventHandler("player:GetScratchCard",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.MaxItens(Passport,"scratchcard",1) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
		else
			if vRP.Request(source,"Banco","Deseja comprar <b>1x "..ItemName("scratchcard").."</b> por <b>$100</b> dólares?") then
				if vRP.PaymentBank(Passport,100) then
					vRP.GenerateItem(Passport,"scratchcard",1,true)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Saldo</b> insuficiente.","Aviso",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYWASH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PayWash()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Car Wash","A limpeza do veículo custa <b>$"..Dotted(WashPrice).."</b> Dólares, deseja prosseguir?") then
			if vRP.PaymentFull(Passport,WashPrice) then
				exports["bank"]:AddTaxs(Passport,source,"Prefeitura",WashPrice,"Lavagem de Veículo")

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.KickPlayer(Reason)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Kick(source, Reason)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.EnterTrash()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.Medicplan(source) then
		local randItem = math.random(100)
		if parseInt(randItem) >= 50 and parseInt(randItem) <= 100 then
			TriggerClientEvent("Notify", source, "amarelo", "Você foi contaminado.", "Atenção", 5000)
			vRP.UpgradeCough(Passport, math.random(10, 20))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Debug[Passport] or os.time() > Debug[Passport] then
		TriggerClientEvent("Notify", source, "verde", "Você refrescou o seu personagem.", "Sucesso", 5000)
		TriggerClientEvent("target:Debug",source)
		TriggerEvent("DebugObjects",Passport)
		Debug[Passport] = os.time() + 300
		vRPC.ReloadCharacter(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:LIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Like")
AddEventHandler("player:Like",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			if vRP.TakeItem(Passport,"vote",1,true) then
				vRP.GiveLikes(OtherPassport,1)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..ItemName("vote").."</b>.","Atenção",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:UNLIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:UnLike")
AddEventHandler("player:UnLike",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			if vRP.TakeItem(Passport,"vote",1,true) then
				vRP.GiveUnLikes(OtherPassport,1)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..ItemName("vote").."</b>.","Atenção",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.GetReputation(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Reputation = {
			[1] = vRP.GetLikes(Passport),
			[2] = vRP.GetUnLikes(Passport)
		}

		return Reputation
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.BikesBackpack()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Amount = 10
		local Weight = vRP.GetWeight(Passport)

		if parseInt(Weight) < 45 then
			Amount = 15
		elseif parseInt(Weight) >= 45 and parseInt(Weight) <= 79 then
			Amount = 10
		elseif parseInt(Weight) >= 80 and parseInt(Weight) <= 95 then
			Amount = 5
		elseif parseInt(Weight) >= 100 and parseInt(Weight) <= 148 then
			Amount = 2
		elseif parseInt(Weight) >= 150 then
			Amount = 1
		end

		vRP.SetWeight(Passport,Amount)
		TriggerClientEvent("Notify",source,"verde","Você recebeu <b>+"..Amount.."Kgs</b> na <b>Mochila</b>.","Sucesso",5000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ELEVATOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Elevator")
AddEventHandler("player:Elevator", function(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Value then
			TriggerClientEvent("dynamic:Close", source)
			TriggerClientEvent("sounds:Private", source, "elevator", 0.5)
			TriggerClientEvent("Progress", source, "Usando elevador", 4000)

			vRPC.DoScreenFadeOut(source)

			SetTimeout(4000, function()
				local Split = splitString(Value, ",")
				local x, y, z = tonumber(Split[1] or 0), tonumber(Split[2] or 0), tonumber(Split[3] or 0)
				vRP.Teleport(source, x, y, z)
				vRPC.DoScreenFadeIn(source)
			end)
		else
			TriggerClientEvent("Notify", source, "amarelo", "Destino não encontrado.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("player:DuiTable", source, DuiTextures)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Debug[Passport] then
		Debug[Passport] = nil
	end
end)