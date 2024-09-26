-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	["Sends"] = {},
	["Plate"] = nil,
	["Model"] = nil,
	["Active"] = false,
	["Cooldown"] = GetGameTimer(),
	["Init"] = vec4(68.93,-1569.81,29.59,48.19),
	["Coords"] = {
		vec4(60.72,-1568.76,29.27,48.19),
		vec4(56.73,-1573.35,29.27,48.19),
		vec4(52.66,-1578.06,29.27,48.19),
		vec4(48.7,-1582.78,29.27,48.19),
		vec4(39.06,-1570.52,29.1,232.45),
		vec4(35.13,-1575.23,29.08,229.61),
		vec4(31.24,-1579.97,29.07,232.45),
		vec4(27.2,-1584.54,29.03,229.61),
		vec4(23.54,-1588.95,29.05,232.45),
		vec4(44.73,-1587.44,29.27,48.19),
		vec4(40.81,-1592.18,29.27,48.19),
		vec4(55.03,-1551.58,29.27,232.45),
		vec4(59.04,-1546.91,29.27,232.45),
		vec4(62.96,-1542.19,29.27,232.45)
	},
	["Spawns"] = {
		"gt500","toros","sheava","surano","rapidgt","feltzer2","alpha","gp1","infernus","bullet","freecrawler","turismo2","zr350",
		"locust","seven70","caracara2","ruffian","enduro","specter","rebla","ruston","jester","banshee","cypher","voltic","rt3000",
		"sc1","carbonizzare","infernus2","imorgon","sultan2","elegy2","yosemite2","ninef","everon","double","jackal","sugoi",
		"penumbra","paragon","nero","komoda","ninef2","futo","buffalo3","banshee2","adder","schlagen","bestiagts","jester3","elegy",
		"cheetah2","khamelion","sanchez","diablous2","omnis","massacro","euros","cheetah","tyrus","kuruma","nero2","ardent","sultan3",
		"autarch","fmj","jester2","carbonrs","reever","gb200","sultanrs","pariah","vacca","zentorno","t20","issi7","penetrator",
		"emerus","revolter","sentinel3","bati","bf400","flashgt","dominator7","osiris","turismor","jester4","pfister811","italigtb2",
		"akuma","penumbra2","tempesta","raiden","vectre","entityxf","comet6","drafter","bati2","reaper","growler","tigon","italigtb",
		"visione","entity2","deveste","hakuchou","vagner","tyrant","krieger","furia","xa21","neon","taipan","jugular","paragon2",
		"hakuchou2","calico","zorrusso","italirsx","coquette4","italigto","cyclone","neo","shinobi","thrax"
	},
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
		exports["target"]:LabelText("MoneyWash","Iniciar")
		Config["Active"] = false
		Config["Sends"] = {}
		CleanBlips()
	else
		if Config["Cooldown"] <= GetGameTimer() then
			Config["Cooldown"] = GetGameTimer() + (10 * 60000)
			exports["target"]:LabelText("MoneyWash","Finalizar")
			TriggerEvent("Notify","Central de Empregos","Você acaba de dar inicio a sua jornada de trabalho, lembrando que la fora tem um veículo lhe esperando para ser utilizado em suas entregas nos próximo <b>30 minutos</b>.","default",5000)
			Config["Active"] = true
			MakeBlips()

			local Selected = math.random(#Config["Coords"])
			Config["Model"] = Config["Spawns"][math.random(#Config["Spawns"])]
			local Exist,Networked,_,__,Plate = vGARAGE.ServerVehicle(Config["Model"],Config["Coords"][Selected],nil,0,nil,1000,75,false,true)
			if Exist and Networked then
				local Network = LoadNetwork(Networked)
				if Network then
					Config["Plate"] = Plate

					local R = math.random(255)
					local G = math.random(255)
					local B = math.random(255)

					SetVehicleModKit(Network,0)
					ToggleVehicleMod(Network,18,true)
					SetVehicleCustomPrimaryColour(Network,R,G,B)
					SetVehicleCustomSecondaryColour(Network,R,G,B)
					SetVehicleMod(Network,11,GetNumVehicleMods(Network,11) - 1,false)
					SetVehicleMod(Network,12,GetNumVehicleMods(Network,12) - 1,false)
					SetVehicleMod(Network,13,GetNumVehicleMods(Network,13) - 1,false)
					SetVehicleMod(Network,15,GetNumVehicleMods(Network,15) - 1,false)

					SetVehicleOnGroundProperly(Network)
				end
			end
		else
			TriggerEvent("Notify","Aviso","Aguarde seu tempo de descanso.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:SEND
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Send",function(Number,Value)
	local Vehicle = GetPlayersLastVehicle()
	if Vehicle and GetEntityArchetypeName(Vehicle) == Config["Model"] and GetVehicleNumberPlateText(Vehicle) == Config["Plate"] and Config["Sends"][Number] and vSERVER.Washers(Config["Model"],Config["Plate"],Value) then
		if DoesBlipExist(Config["Sends"][Number]) then
			RemoveBlip(Config["Sends"][Number])
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Number)
		Config["Sends"][Number] = nil

		if CountTable(Config["Sends"]) <= 0 then
			exports["target"]:LabelText("MoneyWash","Iniciar")
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
					label = "Entregar $1.000",
					tunnel = "client",
					service = 1000
				},{
					event = "moneywash:Send",
					label = "Entregar $2.000",
					tunnel = "client",
					service = 2000
				},{
					event = "moneywash:Send",
					label = "Entregar $3.000",
					tunnel = "client",
					service = 3000
				},{
					event = "moneywash:Send",
					label = "Entregar $4.000",
					tunnel = "client",
					service = 4000
				},{
					event = "moneywash:Send",
					label = "Entregar $5.000",
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
		AddTextComponentString("Entrega")
		EndTextCommandSetBlipName(Config["Sends"][Number])
	end
end