-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("spawn", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Route = 50000
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Characters()
	local source = source
	local License = vRP.Identities(source)

	Route = Route + 1
	TriggerEvent("vRP:BucketServer", source, "Enter", Route)

	local Consult = vRP.Query("characters/Characters",{ License = License })
	if Consult and Consult[1] then
		local Values = {}
		for k,v in pairs(Consult) do
			Values[#Values + 1] = {
				Passport = v["id"],
				Skin = vRP.UserData(v["id"],"Datatable")["Skin"],
				Nome = v["Name"].." "..v["Lastname"],
				Sexo = v["Sex"],
				Blood = Sanguine(v["Blood"]),
				Clothes = vRP.UserData(v["id"],"Clothings"),
				Barber = vRP.UserData(v["id"],"Barbershop"),
				Tattoos = vRP.UserData(v["id"],"Tatuagens"),
				Banco = v["Bank"]
			}
		end

		return Values
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ChosenCharacter(Passport)
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/UserLicense",{ id = Passport, License = License })
	if Consult and Consult[1] then
		TriggerEvent("vRP:BucketServer", source, "Exit")
		vRP.ChosenCharacter(source, Passport)
		return true
	else
		DropPlayer(source, "Conectando em personagem irregular.")
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.NewCharacter(Name, Lastname, Sex)
	local source = source
	if not Active[source] then
		Active[source] = true

		local License = vRP.Identities(source)
		local Account = vRP.Account(License)

		local AmountCharactersPremium = parseInt(Account["Characters"])
		if vRP.LicensePremium(License) then
			AmountCharactersPremium = AmountCharactersPremium + 2
		end

		local Consult = vRP.Query("characters/Count",{ License = License })
		if parseInt(Account["Characters"]) <= parseInt(Consult[1]["qtd"]) then
			TriggerClientEvent("Notify", source, "amarelo", "Limite de personagem atingido.", "Atenção", 5000)
			Active[source] = nil
			return false
		end

		local Sexo = "F"
		if Sex == "mp_m_freemode_01" then
			Sexo = "M"
		end

		vRP.Query("characters/NewCharacter",{ License = License, Name = Name, Lastname = Lastname, Sex = Sexo, Skin = Sex, Phone = vRP.GeneratePhone(), Blood = math.random(4) })

		local Last = vRP.Query("characters/LastCharacter",{ License = License })
		if Last[1] then
			TriggerEvent("vRP:BucketServer", source, "Exit")
			vRP.ChosenCharacter(source, Last[1]["id"], Sex)
		end

		Active[source] = nil

		return true
	end
end