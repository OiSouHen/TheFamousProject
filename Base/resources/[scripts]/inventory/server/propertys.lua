-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PROPERTYSROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:PropertysRobbery")
AddEventHandler("inventory:PropertysRobbery",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true
		TriggerClientEvent("dynamic:Close",source)
		vRPC.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)

		if vRP.HasService(Passport,"Policia") or vRP.Task(source,10,10000) then
			if not Property[Name] then
				local Consult = vRP.Query("propertys/Exist",{ Name = Name })
				if Consult[1] then
					Property[Name] = Consult[1]["Interior"]
				else
					local Informations = exports["propertys"]:Informations()
					Property[Name] = Informations[math.random(#Informations)]
				end
			end

			if exports["party"]:DoesExist(Passport) then
				local Members = exports["party"]:Room(Passport,source,10)
				for _,v in pairs(Members) do
					if vRP.Passport(v["Source"]) then
						TriggerClientEvent("propertys:Enter",v["Source"],Name,Property[Name])
					end
				end
			else
				TriggerClientEvent("propertys:Enter",source,Name,Property[Name])
			end
		else
			TriggerClientEvent("player:Residual",source,"Resíduo de Alumínio")

			exports["vrp"]:CallPolice({
				["Source"] = source,
				["Passport"] = Passport,
				["Permission"] = "Policia",
				["Name"] = "Roubo a Propriedade",
				["Wanted"] = 300,
				["Code"] = 31,
				["Color"] = 44
			})
		end

		Active[Passport] = nil
		vRPC.Destroy(source)
	end
end)