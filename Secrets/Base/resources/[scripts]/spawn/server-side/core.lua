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
Tunnel.bindInterface("spawn",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Route = 50000
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Characters()
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/Characters",{ License = License })

	Route = Route + 1
	exports["vrp"]:Bucket(source,"Enter",Route)

	local Characters = {}
	for _,v in pairs(Consult) do
		local Passport = parseInt(v["id"])

		Characters[#Characters + 1] = {
			["Passport"] = Passport,
			["Skin"] = v["Skin"],
			["Nome"] = v["Name"].." "..v["Lastname"],
			["Sexo"] = v["Sex"],
			["Banco"] = v["Bank"],
			["Blood"] = Sanguine(v["Blood"]),
			["Clothes"] = vRP.UserData(Passport,"Clothings"),
			["Barber"] = vRP.UserData(Passport,"Barbershop"),
			["Tattoos"] = vRP.UserData(Passport,"Tattooshop")
		}
	end

	return Characters
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CharacterChosen(Passport)
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/UserLicense",{ id = Passport, License = License })

	if Consult[1] then
		vRP.CharacterChosen(source,Passport)

		return true
	else
		DropPlayer(source,"Desconectado.")
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.NewCharacter(Name,Lastname,Sex)
	local source = source
	if not Active[source] then
		Active[source] = true

		local License = vRP.Identities(source)
		local Account = vRP.Account(License)

		if Account["Characters"] <= vRP.Scalar("characters/Count",{ License = License }) then
			TriggerClientEvent("Notify",source,"Atenção","Limite de personagem atingido.","amarelo",5000)
			Active[source] = nil

			return false
		end

		local Sexo = "M"
		if Sex == "mp_f_freemode_01" then
			Sexo = "F"
		end

		vRPC.DoScreenFadeOut(source)
		vRP.Query("characters/NewCharacter",{ License = License, Name = Name, Lastname = Lastname, Sex = Sexo, Skin = Sex, Phone = vRP.GeneratePhone(), Blood = math.random(4) })

		local Consult = vRP.Query("characters/LastCharacter",{ License = License })
		if Consult[1] then
			vRP.CharacterChosen(source,Consult[1]["id"],Sex)
		end

		Active[source] = nil

		return true
	end
end