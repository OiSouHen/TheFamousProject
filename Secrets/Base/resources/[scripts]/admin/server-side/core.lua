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
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin") then
		local Messages = ""
		local Groups = vRP.Groups()
		local OtherPassport = Message[1]
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherPassport] then
				Messages = Messages.."<b>Permissão:</b> "..Permission.."<br><b>Nível:</b> "..Data[OtherPassport].."<br>"
			end
		end

		if Messages ~= "" then
			TriggerClientEvent("Notify",source,"Grupos Pertencentes",Messages,"default",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skinshop",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("skinshop:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skinweapon",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("skinweapon:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lscustoms",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("lscustoms:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("postit",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("postit:initPostit",source,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("usource",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherSource = parseInt(Message[1])
	if Passport and OtherSource and OtherSource > 0 and vRP.Passport(OtherSource) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"Informações","<b>Passaporte:</b> "..vRP.Passport(OtherSource),"default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Camera") then
		TriggerClientEvent("freecam:Active",source,Message)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherPassport = parseInt(Message[1])
	if Passport and OtherPassport and OtherPassport > 0 and vRP.Identity(OtherPassport) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"Informações","<b>Passaporte:</b> "..OtherPassport.."<br><b>Nome:</b> "..vRP.FullName(OtherPassport),"default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] and vRPC.ModelExist(source,Message[2]) and vRP.HasGroup(Passport,"Admin") then
		local ClosestPed = vRP.Source(Message[1])
		if ClosestPed then
			vRPC.Skin(ClosestPed,Message[2])
			vRP.SkinCharacter(parseInt(Message[1]),Message[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin",2) then
		TriggerClientEvent("Notify",source,"Sucesso","Limpeza concluída.","verde",5000)
		vRP.ClearInventory(Message[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dima",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 and vRP.HasGroup(Passport,"Admin",1) then
		vRP.UpgradeGemstone(Message[1],Message[2],true)
		TriggerClientEvent("Notify",source,"Sucesso","Diamantes entregues.","verde",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		vRPC.BlipAdmin(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		if Message[1] then
			local OtherPassport = parseInt(Message[1])
			local ClosestPed = vRP.Source(OtherPassport)
			if ClosestPed then
				vRP.Revive(ClosestPed,300)
				vRP.UpgradeThirst(OtherPassport,10)
				vRP.UpgradeHunger(OtherPassport,10)
				vRP.DowngradeStress(OtherPassport,100)
				TriggerClientEvent("paramedic:Reset",ClosestPed)

				vRPC.Destroy(ClosestPed)
			end
		else
			vRP.Revive(source,300)
			vRP.SetArmour(source,100)
			vRP.UpgradeThirst(Passport,100)
			vRP.UpgradeHunger(Passport,100)
			vRP.DowngradeStress(Passport,100)
			TriggerClientEvent("paramedic:Reset",source)

			vRPC.Destroy(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] and ItemExist(Message[1]) and vRP.HasGroup(Passport,"Admin",2) then
		vRP.GenerateItem(Passport,Message[1],Message[2],true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] and Message[3] and ItemExist(Message[1]) and vRP.HasGroup(Passport,"Admin",1) then
		vRP.GenerateItem(Message[3],Message[1],Message[2],true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.HasGroup(Passport,"Admin",2) then
		vRP.Query("characters/Delete",{ id = Message[1] })
		TriggerClientEvent("Notify",source,"Sucesso","Personagem <b>"..Message[1].."</b> deletado.","verde",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		vRPC.noClip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 then
		local OtherSource = vRP.Source(Message[1])
		if OtherSource then
			TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..Message[1].."</b> expulso.","verde",5000)
			vRP.Kick(OtherSource,"Expulso da cidade.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[2]) > 0 and vRP.HasGroup(Passport,"Admin") and vRP.Identity(Message[1]) then
		vRP.Query("accounts/InsertBanned",{ License = vRP.AccountInformation(Message[1],"License"), Days = Message[2] })
		TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..Message[1].."</b> banido por <b>"..Message[2].."</b> dias.","verde",5000)

		local OtherSource = vRP.Source(Message[1])
		if OtherSource then
			vRP.Kick(OtherSource,"Banido.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin") and vRP.Identity(Message[1]) then
		vRP.Query("accounts/RemoveBanned",{ License = vRP.AccountInformation(Message[1],"License") })
		TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..Message[1].."</b> desbanido.","verde",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Keyboard = vKEYBOARD.Primary(source,"Cordenadas")
		if Keyboard then
			local Split = splitString(Keyboard[1],",")
			if Split[1] and Split[2] and Split[3] then
				vRP.Teleport(source,Split[1],Split[2],Split[3])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.DoesEntityExist(source) and vRP.HasGroup(Passport,"Admin") then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Heading = GetEntityHeading(Ped)

		vKEYBOARD.Copy(source,"Cordenadas",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"])..","..Optimize(Heading))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] and Message[3] and vRP.HasGroup(Passport,"Admin",2) then
		local Permission = Message[2]
		local OtherPassport = Message[1]

		if Permission == "Admin" and vRP.HasPermission(Passport,Permission) >= 2 then
			return false
		end

		if vRP.GroupType(Permission) then
			if not vRP.GetUserType(OtherPassport,"Work") then
				TriggerClientEvent("Notify",source,"Sucesso","Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.","verde",5000)
				vRP.SetPermission(OtherPassport,Permission,Message[3])
			else
				TriggerClientEvent("Notify",source,"Atenção","O passaporte já pertence a outro grupo.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Sucesso","Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.","verde",5000)
			vRP.SetPermission(OtherPassport,Permission,Message[3])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and Message[2] and vRP.HasGroup(Passport,"Admin",2) then
		TriggerClientEvent("Notify",source,"Sucesso","Removido <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.","verde",5000)
		vRP.RemovePermission(Message[1],Message[2])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin") then
		local ClosestPed = vRP.Source(Message[1])
		if ClosestPed and vRP.DoesEntityExist(source) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin") then
		local ClosestPed = vRP.Source(Message[1])
		if ClosestPed then
			local Ped = GetPlayerPed(ClosestPed)
			local Coords = GetEntityCoords(Ped)

			vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		vCLIENT.teleportWay(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		TriggerClientEvent("admin:Tuning",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Vehicle,Network,Plate = vRPC.VehicleList(source)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("target:RollVehicle",v,Network)
					TriggerClientEvent("inventory:RepairAdmin",v,Network,Plate)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"Listagem","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),"default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Doords")
AddEventHandler("admin:Doords",function(Coords,Model,Heading)
	vRP.Archive("coordenadas.txt","Coords = "..Coords..", Hash = "..Model..", Heading = "..Heading)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.DoesEntityExist(source) and vRP.HasGroup(Passport,"Admin") then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Heading = GetEntityHeading(Ped)

		vRP.Archive(Passport..".txt",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"])..","..Optimize(Heading))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.HasGroup(Passport,"Admin",2) then
		TriggerClientEvent("Notify",-1,"Prefeitura",History:sub(9),"vermelho",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"Prefeitura",History:sub(8),"vermelho",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	TriggerClientEvent("Notify",-1,"Prefeitura","Terremoto se aproxima em 5 minutos, se abriguem!","vermelho",60000)
	GlobalState["Weather"] = "RAIN"
	Wait(60000)

	TriggerClientEvent("Notify",-1,"Prefeitura","Terremoto se aproxima em 4 minutos, se abriguem!","vermelho",60000)
	Wait(60000)

	TriggerClientEvent("Notify",-1,"Prefeitura","Terremoto se aproxima em 3 minutos, se abriguem!","vermelho",60000)
	Wait(60000)

	TriggerClientEvent("Notify",-1,"Prefeitura","Terremoto se aproxima em 2 minutos, se abriguem!","vermelho",60000)
	Wait(60000)

	TriggerClientEvent("Notify",-1,"Prefeitura","Terremoto se aproxima em 1 minuto, se abriguem!","vermelho",60000)
	GlobalState["Weather"] = "THUNDER"
	Wait(60000)

	local List = vRP.Players()
	for _,Sources in pairs(List) do
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall2",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	local List = vRP.Players()
	for _,Sources in pairs(List) do
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(5 * 60000)
		TriggerEvent("SaveServer",true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		local List = vRP.Players()
		for OtherPlayer,_ in pairs(List) do
			async(function()
				vRP.GenerateItem(OtherPlayer,Message[1],Message[2],true)
			end)
		end

		TriggerClientEvent("Notify",source,"Aviso","Envio concluído.","amarelo",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RaceConfig(Left,Center,Right,Distance,Name)
	vRP.Archive(Name..".txt","{")

	vRP.Archive(Name..".txt","['Left'] = vec3("..Optimize(Left["x"])..","..Optimize(Left["y"])..","..Optimize(Left["z"]).."),")
	vRP.Archive(Name..".txt","['Center'] = vec3("..Optimize(Center["x"])..","..Optimize(Center["y"])..","..Optimize(Center["z"]).."),")
	vRP.Archive(Name..".txt","['Right'] = vec3("..Optimize(Right["x"])..","..Optimize(Right["y"])..","..Optimize(Right["z"]).."),")
	vRP.Archive(Name..".txt","['Distance'] = "..Distance)

	vRP.Archive(Name..".txt","},")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		if Spectate[Passport] then
			local Ped = GetPlayerPed(Spectate[Passport])
			if DoesEntityExist(Ped) then
				SetEntityDistanceCullingRadius(Ped,0.0)
			end

			TriggerClientEvent("admin:resetSpectate",source)
			Spectate[Passport] = nil
		else
			local nsource = vRP.Source(Message[1])
			if nsource then
				local Ped = GetPlayerPed(nsource)
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,999999999.0)
					Wait(1000)
					TriggerClientEvent("admin:initSpectate",source,nsource)
					Spectate[Passport] = nsource
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
RegisterCommand("quake",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		TriggerClientEvent("Notify",-1,"Terromoto","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","roxo",60000)
		GlobalState["Quake"] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Players = vRPC.Players(source)
		for _,Sources in pairs(Players) do
			async(function()
				vCLIENT.Limparea(Sources,Coords)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rename",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Keyboard = vKEYBOARD.Tertiary(source,"Passaporte","Nome","Sobrenome")
		if Keyboard then
			vRP.UpgradeNames(Keyboard[1],Keyboard[2],Keyboard[3])
			TriggerClientEvent("Notify",source,"Sucesso","Nome atualizado.","verde",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		local Keyboard = vKEYBOARD.Secondary(source,"Passaporte","Modelo")
		if Keyboard and Keyboard[1] and Keyboard[2] and VehicleExist(Keyboard[2]) then
			vRP.Query("vehicles/rentalVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2], Plate = vRP.GeneratePlate(), Weight = VehicleWeight(Keyboard[2]), Work = 0 })
			TriggerClientEvent("Notify",source,"Sucesso","Veículo <b>"..VehicleName(Keyboard[2]).."</b> entregue.","verde",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nitro",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") and vRP.InsideVehicle(source) then
		local Vehicle,Network,Plate = vRPC.VehicleList(source)
		if Vehicle then
			local Networked = NetworkGetEntityFromNetworkId(Network)
			if DoesEntityExist(Networked) then
				Entity(Networked)["state"]:set("Nitro",2000,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fuel",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") and vRP.InsideVehicle(source) then
		TriggerClientEvent("engine:FuelAdmin",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kill",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",2) and Message[1] and parseInt(Message[1]) > 0 then
		local ClosestPed = vRP.Source(Message[1])
		if ClosestPed then
			vRPC.SetHealth(ClosestPed,100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removewl",function(source,Message)
	if source == 0 then
		for _,v in pairs(vRP.Query("accounts/Minimals")) do
			vRP.Query("accounts/Clean",{ License = v["License"] })
			exports["discord"]:Content("Roles",v["Discord"].." 720476376871731241 Remover")

			Wait(1000)
		end

		print("Processo de remoção das allowlists finalizada.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removeveh",function(source,Message)
	if source == 0 then
		for _,v in pairs(vRP.Query("vehicles/Minimals")) do
			vRP.Query("entitydata/RemoveData",{ Name = "Mods:"..v["Passport"]..":"..v["Vehicle"] })
			vRP.Query("vehicles/removeVehicles",{ Passport = v["Passport"], Vehicle = v["Vehicle"] })
			vRP.Query("entitydata/RemoveData",{ Name = "Trunkchest:"..v["Passport"]..":"..v["Vehicle"] })

			Wait(1000)
		end

		print("Processo de remoção dos veículos finalizado.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPROP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removeprop",function(source,Message)
	if source == 0 then
		for _,v in pairs(vRP.Query("propertys/Minimals")) do
			vRP.RemSrvData("Vault:"..v["Name"])
			vRP.RemSrvData("Fridge:"..v["Name"])
			vRP.Query("propertys/Sell",{ Name = v["Name"] })

			Wait(1000)
		end

		print("Processo de remoção das propriedades finalizada.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removewr",function(source,Message)
	if source == 0 then
		for _,v in pairs(vRP.Query("warehouse/Minimals")) do
			vRP.RemSrvData("Warehouse:"..v["Name"])
			vRP.Query("warehouse/Sell",{ Name = v["Name"] })

			Wait(1000)
		end

		print("Processo de remoção dos warehouse finalizada.")
	end
end)