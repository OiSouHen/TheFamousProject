-----------------------------------------------------------------------------------------------------------------------------------------
-- SHUTDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("shutdown",function(source)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
		GlobalState["Quake"] = true

		SetTimeout(60000, function()
			local List = vRP.Players()
			for _,Sources in pairs(List) do
				vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
				Wait(100)
			end

			TriggerEvent("SaveServer",false)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("quake",function(source)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
		GlobalState["Quake"] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source == 0 then
		local List = vRP.Players()
		for _,Sources in pairs(List) do
			vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end

		TriggerEvent("SaveServer",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"default",History:sub(9),"Prefeitura",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onlines",function(source)
	if source == 0 then
		print("Atualmente ^2"..ServerName.." ^0tem ^5"..GetNumPlayerIndices().." Onlines^0.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source == 0 then
		TriggerEvent("SaveServer",false)
	end
end)