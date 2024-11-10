-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	["Sends"] = {},
	["Active"] = false,
	["Cooldown"] = GetGameTimer(),
	["Init"] = vec4(68.93,-1569.81,29.59,48.19),
	["Washs"] = {
		vec3(149.83,-1041.33,29.59),
		vec3(314.17,-279.7,54.39),
		vec3(-350.98,-50.51,49.26),
		vec3(-2961.98,483.07,15.92),
		vec3(1174.91,2707.4,38.31),
		vec3(-1212.25,-331.17,38.0),
		vec3(25.16,-1347.97,29.52),
		vec3(1163.97,-322.05,69.21),
		vec3(373.06,325.62,103.59),
		vec3(-3241.53,1000.6,12.85),
		vec3(548.31,2671.95,42.18),
		vec3(2678.96,3279.67,55.26),
		vec3(-1821.11,794.37,138.1),
		vec3(-111.75,6469.43,31.86),
		vec3(1728.17,6414.32,35.06)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("MoneyWash",Config["Init"]["xyz"],0.75,0.75,{
		name = "MoneyWash",
		heading = Config["Init"]["w"],
		minZ = Config["Init"]["z"] - 1.0,
		maxZ = Config["Init"]["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "moneywash:Init",
				label = "Iniciar",
				tunnel = "client"
			},{
				event = "moneywash:Swap",
				label = "Trocar",
				tunnel = "server"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Init",function()
	if Config["Active"] then
		TriggerEvent("Notify","Central de Empregos","Você acaba finalizar sua jornada de trabalho, esperamos que você tenha aprendido bastante hoje.","default",5000)
		exports["target"]:LabelText("MoneyWash","Iniciar Expediente")
		Config["Active"] = false
		Config["Sends"] = {}
		CleanBlips()
	else
		if Config["Cooldown"] <= GetGameTimer() then
			Config["Cooldown"] = GetGameTimer() + (30 * 60000)
			exports["target"]:LabelText("MoneyWash","Finalizar Expediente")
			TriggerEvent("Notify","Central de Empregos","Você acaba de dar inicio a sua jornada de trabalho, lembrando que a sua vida não se resume só a isso.","default",5000)
			Config["Active"] = true
			MakeBlips()
		else
			TriggerEvent("Notify","Aviso","Aguarde seu tempo de descanso.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:SEND
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Send",function(Number,Value)
	if Config["Sends"][Number] and vSERVER.Washers(Value) then
		if DoesBlipExist(Config["Sends"][Number]) then
			RemoveBlip(Config["Sends"][Number])
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Number)
		Config["Sends"][Number] = nil

		if CountTable(Config["Sends"]) <= 0 then
			exports["target"]:LabelText("MoneyWash","Iniciar Expediente")
			Config["Active"] = false
			Config["Sends"] = {}
			CleanBlips()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanBlips()
	for Selected,Blips in pairs(Config["Sends"]) do
		if DoesBlipExist(Blips) then
			RemoveBlip(Blips)
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Selected)
		Config["Sends"][Selected] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	for Index = 1,7 do
		local Selected = math.random(#Config["Washs"])
		local Number = tostring(Selected)
		if Config["Sends"][Number] then
			repeat
				Selected = math.random(#Config["Washs"])
				Number = tostring(Selected)
			until not Config["Sends"][Number]
		end

		exports["target"]:AddCircleZone("MoneyWash:"..Selected,Config["Washs"][Selected],0.15,{
			name = "MoneyWash:"..Selected,
			heading = 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "moneywash:Send",
					label = "Entregar "..Currency.."1.000",
					tunnel = "client",
					service = 1000
				},{
					event = "moneywash:Send",
					label = "Entregar "..Currency.."2.000",
					tunnel = "client",
					service = 2000
				},{
					event = "moneywash:Send",
					label = "Entregar "..Currency.."3.000",
					tunnel = "client",
					service = 3000
				},{
					event = "moneywash:Send",
					label = "Entregar "..Currency.."4.000",
					tunnel = "client",
					service = 4000
				},{
					event = "moneywash:Send",
					label = "Entregar "..Currency.."5.000",
					tunnel = "client",
					service = 5000
				}
			}
		})

		Config["Sends"][Number] = AddBlipForCoord(Config["Washs"][Selected])
		SetBlipSprite(Config["Sends"][Number],434)
		SetBlipDisplay(Config["Sends"][Number],4)
		SetBlipAsShortRange(Config["Sends"][Number],true)
		SetBlipColour(Config["Sends"][Number],2)
		SetBlipScale(Config["Sends"][Number],0.75)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lavagem de Dinheiro")
		EndTextCommandSetBlipName(Config["Sends"][Number])
	end
end