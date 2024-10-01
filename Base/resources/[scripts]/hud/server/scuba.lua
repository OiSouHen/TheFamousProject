-----------------------------------------------------------------------------------------------------------------------------------------
-- OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Oxigen(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeOxigen(Passport, Value)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKHASZONES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckHasZones()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Player(source)["state"]["Scuba"] then
			TriggerClientEvent("Notify", source, "default", "Você está sem <b>" .. ItemName("scuba") .. "</b> e isso te causa alucinações e diversos efeitos colaterais.", "Área Radioativa", 5000)
			TriggerClientEvent("Radioative", source)
			vRP.UpgradeStress(Passport, 10)

			if not vRP.Medicplan(source) then
				vRP.UpgradeCough(Passport, 10)
			end
		end
	end
end