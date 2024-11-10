-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("police",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Locations = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Create")
AddEventHandler("prison:Create",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and vRP.HasService(Passport,"Policia") then
		Active[Passport] = os.time() + 1000

		local Keyboard = vKEYBOARD.Quaternary(source,"Passaporte","Serviços","Multas","Crimes")
		if Keyboard and Keyboard[1] and Keyboard[2] and Keyboard[3] and Keyboard[4] then
			TriggerClientEvent("Notify",source,"Boolingbroke","Prisão concluída, tenha um otimo dia e bom trabalho.","verde",5000)

			local Fines = parseInt(Keyboard[3])
			local Services = parseInt(Keyboard[2])
			local OtherPassport = parseInt(Keyboard[1])

			if Fines > 0 then
				exports["bank"]:AddFines(OtherPassport,Passport,Fines,Keyboard[4])
			end

			if Services > 0 then
				vRP.InsertPrison(OtherPassport,Services)

				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					Player(OtherSource)["state"]["Prison"] = true
					TriggerClientEvent("Notify",OtherSource,"Boolingbroke","Todas as lixeiras do pátio estão disponíveis para <b>vasculhar</b> em troca de redução penal.","amarelo",30000)
				end
			end
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Itens")
AddEventHandler("prison:Itens",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and OtherPassport and vRP.GetHealth(source) > 100 and vRP.HasService(Passport,"Policia") then
		TriggerClientEvent("Notify",source,"Sucesso","Objetos apreendidos.","verde",5000)
		vRP.ArrestItens(OtherPassport)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Vehicle")
AddEventHandler("prison:Vehicle",function(Entity)
	local source = source
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and vRP.Request(source,"Garagem","Apreender o veículo?") and vRP.PassportPlate(Plate) then
		local Vehicle = vRP.Query("vehicles/plateVehicles",{ Plate = Plate })
		if Vehicle[1] then
			if not Vehicle[1]["Arrest"] then
				vRP.Query("vehicles/Arrest",{ Plate = Plate })
				TriggerClientEvent("Notify",source,"Departamento Policial","Veículo apreendido.","policia",5000)
			else
				TriggerClientEvent("Notify",source,"Departamento Policial","Veículo já se encontra apreendido.","policia",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Plate")
AddEventHandler("prison:Plate",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") then
		local Keyboard = vKEYBOARD.Primary(source,"Placa")
		if Keyboard and Keyboard[1] then
			local OtherPassport = vRP.PassportPlate(Keyboard[1])
			if OtherPassport then
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					TriggerClientEvent("Notify",source,"Emplacamento","<b>Passaporte:</b> "..Identity["id"].."<br><b>Telefone:</b> "..vRP.Phone(OtherPassport).."<br><b>Nome:</b> "..Identity["Name"].." "..Identity["Lastname"],"policia",10000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Service")
AddEventHandler("prison:Service",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	if Passport and Identity and Identity["Prison"] > 0 then
		if not Locations[Passport] then
			Locations[Passport] = {}
		end

		if Locations[Passport][Number] then
			if os.time() >= Locations[Passport][Number] then
				Reduction(source,Passport,Number)
			else
				TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Locations[Passport][Number] - os.time())..".","amarelo",5000)
			end
		else
			Reduction(source,Passport,Number)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function Reduction(source,Passport,Number)
	if not Active[Passport] then
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Cancel"] = true
		Player(source)["state"]["Buttons"] = true
		Locations[Passport][Number] = os.time() + 300
		TriggerClientEvent("Progress",source,"Vasculhando",10000)
		vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				vRP.UpdatePrison(Passport,2)
				Player(source)["state"]["Cancel"] = false
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)