-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("autoschool", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LicensePrice = 1365
local UnseizeLicensePrice = 875
-----------------------------------------------------------------------------------------------------------------------------------------
-- LISTVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local SchoolPlate = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if not exports["hud"]:Wanted(Passport) then
				if vRP.GetDriverLicense(Passport) >= 1 then
					TriggerClientEvent("Notify", source, "amarelo", "Você já possui uma <b>Carteira de Habilitação</b>.", "Atenção", 5000)
				else
					local licensePrice = LicensePrice
					if GlobalState["Hours"] >= 8 and GlobalState["Hours"] <= 22 then
						if vRP.ConsultItem(Passport, "medicpass".."-"..Passport, 1) then
							if vRP.HasGroup(Passport, "Premium") then
								licensePrice = LicensePrice * 0.50
							end
							if vRP.Request(source, "Carteira de Habilitação", "Tentar tirar uma <b>Carteira de Habilitação</b> por <b>$"..Dotted(licensePrice).."</b>?") then
								if vRP.PaymentFull(Passport, licensePrice) then
									Active[Passport] = nil
									Player(source)["state"]["Route"] = Passport
									SetPlayerRoutingBucket(source, Passport)
									return true
								end
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Você precisa de <b>1x "..ItemName("medicpass").."</b>.", "Auto Escola", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "azul", "Estamos fechados por agora, nosso horário de funcionamento é das <b>08</b> ás <b>22 Horas</b>.", "Auto Escola", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não pode fazer isso agora.", "Atenção", 5000)
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Finish()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpdateDriverLicense(Passport, 1)
		vRP.GenerateItem(Passport, "cnh".."-"..Passport, 1, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:SEIZECNH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("autoschool:SeizeCnh")
AddEventHandler("autoschool:SeizeCnh", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local otherDriverLicense = vRP.GetDriverLicense(OtherPassport)
		if otherDriverLicense == 0 then
			TriggerClientEvent("Notify", source, "amarelo", "<b>"..vRP.FullName(OtherPassport).."</b> não possui <b>"..ItemName("cnh").."</b>.", "Atenção", 5000)
		elseif otherDriverLicense == 1 then
			if vRP.Request(source, "Carteira de Habilitação", "Apreender a <b>"..ItemName("cnh").."</b> de <b>"..vRP.FullName(OtherPassport).."</b>?") then
				vRP.UpdateDriverLicense(Entity, 2)
				TriggerClientEvent("Notify", Entity, "amarelo", "Sua <b>"..ItemName("cnh").."</b> foi apreendida.", "Atenção", 5000)
				TriggerClientEvent("Notify", source, "amarelo", "Você apreendeu a <b>"..ItemName("cnh").."</b> de <b>"..vRP.FullName(OtherPassport).."</b>.", "Atenção", 5000)
			end
		elseif otherDriverLicense == 2 then
			TriggerClientEvent("Notify", source, "amarelo", "<b>"..vRP.FullName(OtherPassport).."</b> já possui a <b>"..ItemName("cnh").."</b> apreendida.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:UNSEIZECNH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("autoschool:UnseizeCnh")
AddEventHandler("autoschool:UnseizeCnh", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["Hours"] >= 8 and GlobalState["Hours"] <= 22 then
			local driverLicense = vRP.GetDriverLicense(Passport)
			if driverLicense == 2 then
				if vRP.ConsultItem(Passport, "medicpass".."-"..Passport, 1) then
					local message = "Regularizar a sua <b>Carteira de Habilitação</b> por <b>$"..Dotted(UnseizeLicensePrice).."</b>?"
					if vRP.Request(source, "Carteira de Habilitação", message) then
						if vRP.PaymentFull(Passport, UnseizeLicensePrice) then
							vRP.UpdateDriverLicense(source, 1)
							TriggerClientEvent("Notify", source, "verde", "Você regularizou sua <b>Carteira de Habilitação</b>.", "Sucesso", 5000)
							return
						end
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Você precisa de <b>1x "..ItemName("medicpass").."</b>.", "Auto Escola", 5000)
					return
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Sua <b>Carteira de Habilitação</b> está regularizada.", "Atenção", 5000)
				return
			end
		else
			TriggerClientEvent("Notify", source, "azul", "Estamos fechados por agora, nosso horário de funcionamento é das <b>08</b> às <b>22 Horas</b>.", "Auto Escola", 5000)
			return
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StartDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		SchoolPlate[Passport] = "PDMSPORT"
		TriggerEvent("plateEveryone", SchoolPlate[Passport])

		return true, SchoolPlate[Passport]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RemoveDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("plateReveryone", SchoolPlate[Passport])

		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source, 0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if SchoolPlate[Passport] then
		SchoolPlate[Passport] = nil
	end
end)