-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Commands"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID da Whitelist:","Status: (0 inativa, 1 ativa)")
			if Keyboard then
				TriggerClientEvent("Notify",source,"verde","Whitelist editada.","Sucesso",5000)
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** wl "..Keyboard[1].." "..Keyboard[2],0xa3c846)

				vRP.Query("accounts/SetWhitelist",{ Whitelist = Keyboard[2], id = Keyboard[1] })
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rename",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Tertiary(source,"ID:","Nome:","Sobrenome:")
			if Keyboard then
				vRP.UpgradeNames(Keyboard[1],Keyboard[2],Keyboard[3])
				TriggerClientEvent("Notify",source,"verde","Nome atualizado.","Sucesso",5000)
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** rename "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport, "Admin") then
			local Keyboard = vKEYBOARD.Primary(source, "ID:")
			if Keyboard then
				local Result = ""
				local Groups = vRP.Groups()
				local OtherPassport = Keyboard[1]
				for Permission, _ in pairs(Groups) do
					local Data = vRP.DataGroups(Permission)
					if Data[OtherPassport] then
						local Hierarchy = vRP.Hierarchy(Permission)[vRP.GetUserHierarchy(OtherPassport, Permission)]
						Result = Result .. "<br><b>Permissão:</b> " .. Permission .. "<br><b>Hierarquia:</b> " .. Hierarchy .. " [" .. Data[OtherPassport] .. "]<br>"
					end
				end

				if Result ~= "" then
					TriggerClientEvent("Notify", source, "azul", Result, "Grupos Pertencentes", 10000)
				else
					TriggerClientEvent("Notify", source, "vermelho", "O usuário não possui nenhum grupo.", "Aviso", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				TriggerClientEvent("dynamic:Close",source)

				local FullName = vRP.Identity(Keyboard[1])["Name"].." "..vRP.Identity(Keyboard[1])["Lastname"]
				if vRP.Request(Passport, "Inventário", "Você realmente deseja limpar o inventário de <b>"..FullName.."</b>?") then
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearinv "..Keyboard[1],0xa3c846)
					TriggerClientEvent("Notify",source,"verde","Limpeza concluída.","Sucesso",5000)
					vRP.ClearInventory(Keyboard[1])
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gemas",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Quantidade:")
			if Keyboard then
				local Amount = parseInt(Keyboard[2])
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					TriggerClientEvent("Notify",source,"verde",""..ItemName(DefaultSpecialMoney).." entregue.","Sucesso",5000)
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** gem "..Keyboard[1].." "..Keyboard[2],0xa3c846)

					vRP.UpgradeGemstone(OtherPassport,Amount)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			vRPC.BlipAdmin(source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("flash",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			vCLIENT.Flash(source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** god "..Keyboard[1],0xa3c846)

				local OtherPassport = parseInt(Keyboard[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeCough(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,200)

					TriggerClientEvent("paramedic:Reset",ClosestPed)

					vRPC.Destroy(ClosestPed)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GODALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("godall",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** godall",0xa3c846)

			local UsersList = vRP.Players()
			for k,v in pairs(UsersList) do
				local OtherPassport = parseInt(k)
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeCough(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,200)

					TriggerClientEvent("paramedic:Reset",ClosestPed)

					vRPC.Destroy(ClosestPed)

					TriggerClientEvent("Notify", ClosestPed, "default", "Você recebeu uma cura divina.", false, 5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("armour",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** armour "..Keyboard[1],0xa3c846)

				local OtherPassport = parseInt(Keyboard[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.SetArmour(ClosestPed,100)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"Nome do Item:","Quantidade:")
			if Keyboard then
				if ItemIndex(Keyboard[1]) ~= nil then
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					vRP.GenerateItem(Passport,Keyboard[1],parseInt(Keyboard[2]),true)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Tertiary(source,"ID:","Nome do Item:","Quantidade:")
			if Keyboard then
				if ItemIndex(Keyboard[2]) ~= nil then
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item2 "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)
					vRP.GenerateItem(parseInt(Keyboard[1]),Keyboard[2],parseInt(Keyboard[3]),true)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"Nome do Item:","Quantidade:")
			if Keyboard then
				if ItemIndex(Keyboard[1]) ~= nil then
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** itemall "..Keyboard[1].." "..Keyboard[2],0xa3c846)

					local List = vRP.Players()
					for AllPlayers,_ in pairs(List) do
						async(function()
							vRP.GenerateItem(AllPlayers,Keyboard[1],parseInt(Keyboard[2]),true)
						end)
					end

					TriggerClientEvent("Notify",source,"verde","Envio concluído.","Sucesso",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)

				TriggerClientEvent("dynamic:Close",source)

				if vRP.Request(source,"Deletar Conta","Você tem certeza?") then
					local OtherPassport = parseInt(Keyboard[1])
					vRP.Query("characters/Delete",{ Passport = OtherPassport })
					TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.","Sucesso",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Skin:")
			if Keyboard then
				local ClosestPed = vRP.Source(Keyboard[1])
				if ClosestPed then
					vRPC.Skin(ClosestPed,Keyboard[2])
					vRP.SkinCharacter(parseInt(Keyboard[1]),Keyboard[2])
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** skin "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					TriggerClientEvent("Notify",source,"verde","Skin <b>"..Keyboard[2].."</b> setada no ID "..parseInt(Keyboard[1])..".","Sucesso",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("resetskin",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				local ClosestPed = vRP.Source(Keyboard[1])
				if ClosestPed then
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						if Identity["Sex"] == "M" then
							vRPC.Skin(ClosestPed,"mp_m_freemode_01")
							vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_m_freemode_01")
						elseif Identity["Sex"] == "F" then
							vRPC.Skin(ClosestPed,"mp_f_freemode_01")
							vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_f_freemode_01")
						end

						exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** resetskin "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"verde","Skin do ID "..parseInt(Keyboard[1]).." foi resetada.","Sucesso",5000)
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			vRPC.noClip(source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				local OtherSource = vRP.Source(Keyboard[1])
				if OtherSource then
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Keyboard[1].."</b> expulso.","Sucesso",5000)
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** kick "..Keyboard[1],0xa3c846)
					vRP.Kick(OtherSource,"Expulso da cidade.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Dias:")
			if Keyboard then
				local Days = parseInt(Keyboard[2])
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					local OtherSource = vRP.Source(OtherPassport)
					if OtherSource then
						local Token = GetPlayerTokens(OtherSource)
						for k,v in pairs(Token) do
							vRP.Kick(OtherPassport,"Banido.")
							vRP.Query("banneds/InsertBanned",{ License = Identity["License"], Token = v, Time = Days })
						end

						exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ban "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.","Atenção",5000)
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					vRP.Query("banneds/RemoveBanned",{ License = Identity["License"] })
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.","Sucesso",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"Hora:","Minuto:")
			if Keyboard then
				GlobalState["Hours"] = parseInt(Keyboard[1])
				GlobalState["Minutes"] = parseInt(Keyboard[2])
				TriggerClientEvent("Notify",source,"amarelo","Você mudou a hora do mundo.","Atenção",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEATHERSET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("weatherset",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"Região:","Clima:")
			if Keyboard then
				if Keyboard[1] == "Sul" then
					GlobalState["WeatherS"] = Keyboard[2]
					TriggerClientEvent("Notify",source,"amarelo","Você mudou o clima do <b>Sul</b>.","Atenção",5000)
				elseif Keyboard[1] == "Norte" then
					GlobalState["WeatherN"] = Keyboard[2]
					TriggerClientEvent("Notify",source,"amarelo","Você mudou o clima do <b>Norte</b>.","Atenção",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPERATURESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("temperatureset",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"Região:","Temperatura:")
			if Keyboard then
				if Keyboard[1] == "Sul" then
					GlobalState["TemperatureS"] = parseInt(Keyboard[2])
					TriggerClientEvent("Notify",source,"amarelo","Você mudou a temperatura do <b>Sul</b>.","Atenção",5000)
				elseif Keyboard[1] == "Norte" then
					GlobalState["TemperatureN"] = parseInt(Keyboard[2])
					TriggerClientEvent("Notify",source,"amarelo","Você mudou a temperatura do <b>Norte</b>.","Atenção",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUTSET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blackoutset",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			if GlobalState["Blackout"] then
				GlobalState["Blackout"] = false
				TriggerClientEvent("Notify",source,"amarelo","Modo blackout desativado.","Atenção",5000)
			else
				GlobalState["Blackout"] = true
				TriggerClientEvent("Notify",source,"verde","Modo blackout ativado.","Sucesso",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)

			vKEYBOARD.Copy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(Heading))
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"Coordenada:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport, "Admin", 1) then
			local Keyboard = vKEYBOARD.Tertiary(source, "ID:", "Grupo:", "Hierarquia:")
			if Keyboard then
				local Level = Keyboard[3]
				local Permission = Keyboard[2]
				local OtherPassport = Keyboard[1]

				if tonumber(Level) then
					if vRP.GroupType(Permission) then
						if not vRP.GetUserType(OtherPassport, "Work") then
							exports["vrp"]:Embed("Admin", "**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level, 0xa3c846)
							TriggerClientEvent("Notify", source, "verde", "Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.", "Sucesso", 5000)
							vRP.SetPermission(OtherPassport, Permission, Level)
						else
							TriggerClientEvent("Notify", source, "amarelo", "O passaporte já pertence a outro grupo.", "Atenção", 5000)
						end
					else
						exports["vrp"]:Embed("Admin", "**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level, 0xa3c846)
						TriggerClientEvent("Notify", source, "verde", "Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.", "Sucesso", 5000)
						vRP.SetPermission(OtherPassport, Permission, Level)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Campo <b>Hierarquia</b> deve conter apenas números.", "Aviso", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Grupo:")
			if Keyboard then
				TriggerClientEvent("Notify",source,"verde","Removido <b>"..Keyboard[2].."</b> ao passaporte <b>"..Keyboard[1].."</b>.","Sucesso",5000)
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ungroup "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				vRP.RemovePermission(Keyboard[1],Keyboard[2])
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source, "ID:")
			if Keyboard then
				local ClosestPed = vRP.Source(Keyboard[1])
				if ClosestPed then
					local Ped = GetPlayerPed(source)
					local Coords = GetEntityCoords(Ped)

					vRP.Teleport(ClosestPed, Coords["x"], Coords["y"], Coords["z"])
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source, "ID:")
			if Keyboard then
				local ClosestPed = vRP.Source(Keyboard[1])
				if ClosestPed then
					local Ped = GetPlayerPed(ClosestPed)
					local Coords = GetEntityCoords(Ped)
					vRP.Teleport(source, Coords["x"], Coords["y"], Coords["z"])
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			vCLIENT.TeleportWay(source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("admin:Tuning", source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
			if Vehicle then
				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("inventory:RepairAdmin",v,Network,Plate)
					end)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fuel",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			if not vRPC.InsideVehicle(source) then
				local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
				if Vehicle then
					local Keyboard = vKEYBOARD.Primary(source, "Litros:")
					if Keyboard then
						local Networked = NetworkGetEntityFromNetworkId(Network)
						Entity(Networked)["state"]:set("Fuel", Keyboard[1], true)
						TriggerClientEvent("Notify",source,"verde","Veículo com <b>"..parseInt(Keyboard[1]).."% de Gasolina</b>.","Sucesso",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa sair do veículo.","Atenção",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKPICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lockpick",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Vehicle, Network, Plate, Model, Class = vRPC.VehicleList(source, 5)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)

				if not vRP.PassportPlate(Plate) then
					Entity(Networked)["state"]:set("Fuel", 100, true)
					Entity(Networked)["state"]:set("Nitro", 0, true)
					SetVehicleDoorsLocked(Networked, 1)
				else
					SetVehicleDoorsLocked(Networked, 1)
				end

				TriggerEvent("plateEveryone", Plate)
				TriggerEvent("platePlayers", Plate, Passport)

				TriggerClientEvent("Notify",source,"verde","Você destrancou o veículo.","Sucesso",5000)

				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** lockpick",0xa3c846)
			else
				TriggerClientEvent("Notify",source,"amarelo","Sem veículos próximos.","Atenção",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			vCLIENT.Limparea(source, Coords)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Vehicle = vRPC.VehicleHash(source)
			if Vehicle then
				vKEYBOARD.Copy(source,"Hash do veículo:",Vehicle)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setbank",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Quantidade:")
			if Keyboard then
				vRP.GiveBank(Keyboard[1],Keyboard[2])
				TriggerClientEvent("Notify",source,"verde","Envio concluído.","Sucesso",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMBANK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rembank",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source, "ID:", "Quantidade:")
			if Keyboard then
				vRP.RemoveBank(Keyboard[1],Keyboard[2])
				TriggerClientEvent("Notify",source,"verde","Remoção concluída.","Sucesso",5000)
				TriggerClientEvent("NotifyItem",source,{ "-", "dollars", Dotted(Keyboard[2]), "Dólares" })
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),false,5000)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("playersconnected",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local List = vRP.Players()
			local Players = ""
			for k,v in pairs(List) do
				local IDIdentity = vRP.Identity(k)
				Players = Players ..k..": "..IDIdentity["Name"].." "..IDIdentity["Lastname"].."\n"
			end

			vKEYBOARD.Copy(source,"Players Conectados:",Players)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Quaternary(source,"Tema:","Segundos:","Título:","Anúncio:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,Keyboard[1],Keyboard[2] * 1000,Keyboard[3],Keyboard[4])
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** announce "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3].." "..Keyboard[4] * 1000,0xa3c846)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chatannounce",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Area(source,"Anúncio:")
			if Keyboard then
				local Messages = Keyboard[1]:gsub("[<>]", "")
				TriggerClientEvent("chat:ClientMessage", -1, "Prefeitura", Messages, "Anúncio")
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** chatannounce "..Messages,0xa3c846)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setcar",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source, "ID:", "Veículo:")
			if Keyboard then
				local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2] })
				if Consult[1] then
					TriggerClientEvent("Notify",source,"amarelo","O veículo <b>"..Keyboard[2].."</b> já está adicionado.","Atenção",5000)
					return
				else
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** setcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					vRP.Query("vehicles/addVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2], Plate = vRP.GeneratePlate(), Work = "false" })
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","Veículo:")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** remcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				TriggerClientEvent("Notify",source,"verde","Veículo removido com sucesso.","Sucesso",5000)
				vRP.Query("vehicles/removeVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2] })
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVERLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("driverlicense",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin") then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","(0 Zerada, 1 Liberada, 2 Apreendida)")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** driverlicense "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				TriggerClientEvent("Notify",source,"verde","CNH atualizada.","Sucesso",5000)
				vRP.UpdateDriverLicense(Keyboard[1],Keyboard[2])
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearprison",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"ID:")
			if Keyboard then
				local OtherPlayer = vRP.Source(Keyboard[1])
				if OtherPlayer then
					exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearprison "..Keyboard[1],0xa3c846)
					TriggerClientEvent("Notify",source,"verde","Prisão zerada.","Sucesso",5000)
					Player(OtherPlayer)["state"]["Prison"] = false
					vRP.ClearPrison(Keyboard[1])
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("changemode",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","(Legal / Ilegal)")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** changemode "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				TriggerClientEvent("Notify",source,"verde","Modo de atividade modificado.","Sucesso",5000)
				vRP.ChangeMode(Keyboard[1], Keyboard[2])
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEWORK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("changework",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Secondary(source,"ID:","(Nenhum)")
			if Keyboard then
				exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** changework "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				TriggerClientEvent("Notify",source,"verde","Emprego modificado.","Sucesso",5000)
				vRP.ChangeWork(Keyboard[1], Keyboard[2])
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("commands",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.Primary(source,"Número: (0 = desativado / 1 = ativado)")
			if Keyboard then
				if tonumber(Keyboard[1]) == 1 then
					GlobalState["Commands"] = true
					TriggerClientEvent("Notify",source,"verde","Comandos ativados.","Sucesso",5000)
				elseif tonumber(Keyboard[1]) == 0 then
					GlobalState["Commands"] = false
					TriggerClientEvent("Notify",source,"amarelo","Comandos desativados.","Atenção",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",2) then
			TriggerClientEvent("admin:ToggleDebug", source)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("stats",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		local Service,TotalPolicia = vRP.NumPermission("Policia")
		local Service,TotalMecanico = vRP.NumPermission("Mecanico")
		local Service,TotalParamedico = vRP.NumPermission("Paramedico")
		TriggerClientEvent("Notify",source,"azul","Atualmente <b>"..parseInt(GetNumPlayerIndices()).."</b> pessoas conectadas.<br><br>Atualmente <b>"..parseInt(TotalPolicia).." Policiais</b> conectados.<br>Atualmente <b>"..parseInt(TotalMecanico).." Mecânicos</b> conectados.<br>Atualmente <b>"..parseInt(TotalParamedico).." Paramédicos</b> conectados.",ServerName,10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("usource",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherSource = parseInt(Message[1])
	if Passport and GlobalState["Commands"] and OtherSource and OtherSource > 0 and vRP.Passport(OtherSource) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> "..vRP.Passport(OtherSource),"Informações",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherPassport = parseInt(Message[1])
	if Passport and GlobalState["Commands"] and OtherPassport and OtherPassport > 0 and vRP.Identity(OtherPassport) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"azul","<b>Nome:</b> "..vRP.FullName(OtherPassport),false,5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] and vRP.GetHealth(source) <= 100 then
		vCLIENT.TeleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Commands"] then
		if vRP.HasGroup(Passport,"Admin",1) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil

				TriggerClientEvent("Notify",source,"amarelo","Modo espião desativado.","Atenção",5000)
			else
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					local OtherPassport = vRP.Passport(OtherSource)
					local OtherIdentity = vRP.Identity(OtherPassport)
					if OtherPassport and OtherIdentity then
						if vRP.Request(source,"Administração","Você realmente deseja espionar <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>?") then
							local Ped = GetPlayerPed(OtherSource)
							if DoesEntityExist(Ped) then
								SetEntityDistanceCullingRadius(Ped,999999999.0)
								Wait(1000)
								TriggerClientEvent("admin:initSpectate",source,OtherSource)
								Spectate[Passport] = OtherSource

								TriggerClientEvent("Notify",source,"verde","Você está espiando <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>.","Sucesso",5000)
							end
						end
					end
				end
			end
		end
	end
end)