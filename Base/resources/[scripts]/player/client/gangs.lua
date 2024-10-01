-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GANGSVERIFYPANEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:GangsVerifyPanel")
AddEventHandler("player:GangsVerifyPanel", function(Gang, Value)
	if LocalPlayer["state"]["Active"] then
		exports["dynamic"]:SubMenu(Gang,"Saldo disponível: <b>$"..Value.."</b>.",Gang)
		exports["dynamic"]:AddButton("Esvaziar","Clique para sacar o valor atual.","player:GangsWithdraw",Gang,Gang,true)

		exports["dynamic"]:openMenu()
	end
end)