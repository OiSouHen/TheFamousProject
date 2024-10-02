-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("target")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Cooldown = 0
local Focus = false
local Selected = {}
local Sucess = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dismantleds = 1
local FreezeDismantle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles", function()
	if not FreezeDismantle then
		FreezeDismantle = true
		Dismantleds = math.random(#Dismantle)
		TriggerEvent("NotifyPush", { code = 20, title = "Localização do Desmanche", x = Dismantle[Dismantleds]["x"], y = Dismantle[Dismantleds]["y"], z = Dismantle[Dismantleds]["z"], text = "Você pode me entregar o veículo ou também pode guardar na garagem para você usar por algum tempo.", blipColor = 60 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLERESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:DismantleReset")
AddEventHandler("target:DismantleReset", function()
	FreezeDismantle = false

	local Backup = Dismantleds
	repeat
		Dismantleds = math.random(#Dismantle)
	until Backup ~= Dismantleds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	RequestStreamedTextureDict("Targets",true)
	while not HasStreamedTextureDictLoaded("Targets") do
		RequestStreamedTextureDict("Targets",true)
		Wait(1)
	end

	RegisterCommand("+entityTarget",TargetEnable)
	RegisterCommand("-entityTarget",TargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddBoxZone("Bounties01", vec3(128.01, -1710.48, 29.57), 0.75, 0.75,{
		name = "Bounties01",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "crafting:DollarBounties",
				label = "Criar",
				tunnel = "client"
			}, {
				event = "crafting:TradeBounties",
				label = "Trocar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("Bounties02", vec3(-1413.03, -655.1, 29.0), 0.75, 0.75,{
		name = "Bounties02",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "crafting:DollarBounties",
				label = "Criar",
				tunnel = "client"
			}, {
				event = "crafting:TradeBounties",
				label = "Trocar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("Bounties03", vec3(485.89, -943.45, 27.47), 0.75, 0.75,{
		name = "Bounties03",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "crafting:DollarBounties",
				label = "Criar",
				tunnel = "client"
			}, {
				event = "crafting:TradeBounties",
				label = "Trocar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("Bounties04", vec3(-65.6, 6506.07, 31.86), 0.75, 0.75,{
		name = "Bounties04",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "crafting:DollarBounties",
				label = "Criar",
				tunnel = "client"
			}, {
				event = "crafting:TradeBounties",
				label = "Trocar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("Bounties05", vec3(123.06, 13.38, 68.62), 0.75, 0.75,{
		name = "Bounties05",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "crafting:DollarBounties",
				label = "Criar",
				tunnel = "client"
			}, {
				event = "crafting:TradeBounties",
				label = "Trocar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("PrisonPrison", vec3(1690.58, 2529.44, 45.91), 0.75, 0.75,{
		name = "Prison",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "police:Trade",
				label = "Audiência Pública",
				tunnel = "server"
			}, {
				event = "police:Escape",
				label = "Escapar",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("Recycling", vec3(2045.09, 3195.72, 45.5), 0.75, 0.75,{
		name = "Recycling",
		heading = 0.0,
	},{
		Distance = 1.75,
		options = {
			{
				event = "inventory:TrashBags",
				label = "Trocar sacos",
				tunnel = "server"
			}, {
				event = "shops:Recycle",
				label = "Vender materiais",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Medicplan01", vec3(307.52, -595.3, 43.13), 0.5, {
		name = "Medicplan01",
		heading = 0.0
	}, {
		Distance = 1.0,
		options = {
			{
				event = "target:Medicplan",
				label = "Plano de Saúde",
				tunnel = "proserver"
			}
		}
	})

	AddCircleZone("Cameras01", vec3(444.81, -982.0, 31.05), 0.5, {
		name = "Cameras01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "inventory:Cameras",
				label = "Painel de Cameras",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("AutoSchool", vec3(-39.13, -206.05, 45.76), 0.5, {
		name = "AutoSchool",
		heading = 0.0
	}, {
		Distance = 1.0,
		options = {
			{
				event = "autoschool:start",
				label = "Solicitar Habilitação",
				tunnel = "client"
			}, {
				event = "autoschool:UnseizeCnh",
				label = "Regularizar Habilitação",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("WorkCleaner", vec3(-1275.5, -1139.56, 6.79), 0.5, 0.5, {
		name = "WorkCleaner",
		heading = 266.46,
		minZ = 6.79 - 0.75,
		maxZ = 6.79 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "cleaner:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("GangsBank01", vec3(89.61, -1981.08, 20.23), 0.5, {
		name = "GangsBank01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:GangsVerify",
				label = "Abrir",
				tunnel = "proserver",
				service = "Ballas"
			}, {
				event = "player:GangsRobbery",
				label = "Roubar",
				tunnel = "proserver",
				service = "Ballas"
			}
		}
	})

	AddCircleZone("GangsBank02", vec3(-28.87, -1432.43, 31.17), 0.5, {
		name = "GangsBank02",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:GangsVerify",
				label = "Abrir",
				tunnel = "proserver",
				service = "Families"
			}, {
				event = "player:GangsRobbery",
				label = "Roubar",
				tunnel = "proserver",
				service = "Families"
			}
		}
	})

	AddCircleZone("GangsBank03", vec3(349.06, -2070.13, 20.73), 0.5, {
		name = "GangsBank03",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:GangsVerify",
				label = "Abrir",
				tunnel = "proserver",
				service = "Vagos"
			}, {
				event = "player:GangsRobbery",
				label = "Roubar",
				tunnel = "proserver",
				service = "Vagos"
			}
		}
	})

	AddCircleZone("GangsBank04", vec3(511.75, -1805.01, 28.31), 0.5, {
		name = "GangsBank04",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:GangsVerify",
				label = "Abrir",
				tunnel = "proserver",
				service = "Aztecas"
			}, {
				event = "player:GangsRobbery",
				label = "Roubar",
				tunnel = "proserver",
				service = "Aztecas"
			}
		}
	})

	AddCircleZone("GangsBank05", vec3(233.27, -1750.69, 28.84), 0.5, {
		name = "GangsBank05",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:GangsVerify",
				label = "Abrir",
				tunnel = "proserver",
				service = "Bloods"
			}, {
				event = "player:GangsRobbery",
				label = "Roubar",
				tunnel = "proserver",
				service = "Bloods"
			}
		}
	})

	AddCircleZone("Scuba01", vec3(282.23, 6792.7, 15.69), 0.5, {
		name = "Scuba01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "shops:BuyOxigen",
				label = "Comprar Roupa",
				tunnel = "server"
			}, {
				event = "shops:BuyCylinder",
				label = "Comprar Oxigênio",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Salary01", vec3(241.59, 226.01, 106.79), 0.5, {
		name = "Salary01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary02", vec3(243.38, 225.36, 106.79), 0.5, {
		name = "Salary02",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary03", vec3(246.78, 224.12, 106.82), 0.5, {
		name = "Salary03",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary04", vec3(248.56, 223.47, 106.83), 0.5, {
		name = "Salary04",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary05", vec3(251.93, 222.25, 106.84), 0.5, {
		name = "Salary05",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary06", vec3(253.72, 221.6, 106.86), 0.5, {
		name = "Salary06",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary07", vec3(-112.8, 6470.5, 32.16), 0.5, {
		name = "Salary07",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary08", vec3(-111.76, 6469.45, 32.17), 0.5, {
		name = "Salary08",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Salary09", vec3(-110.64, 6468.34, 32.15), 0.5, {
		name = "Salary09",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "Salary:Receive",
				label = "Receber Salário",
				tunnel = "server"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Salário",
				tunnel = "proserver",
				service = "Normal"
			}, {
				event = "Salary:Verify",
				label = "Verificar Conta Especial",
				tunnel = "proserver",
				service = "Special"
			}
		}
	})

	AddCircleZone("Yoga01", vec3(-492.83, -217.31, 35.61), 0.5, {
		name = "Yoga01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02", vec3(-492.87, -219.03, 36.55), 0.5, {
		name = "Yoga02",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03", vec3(-492.89, -220.68, 36.51), 0.5, {
		name = "Yoga03",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04", vec3(-490.21, -220.91, 36.51), 0.5, {
		name = "Yoga04",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05", vec3(-490.18, -219.24, 36.58), 0.5, {
		name = "Yoga05",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06", vec3(-490.16, -217.33, 36.63), 0.5, {
		name = "Yoga06",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Works01", vec3(-364.62, -249.13, 36.47), 0.5, {
		name = "Works01",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.5,
		options = {
			{
				event = "jobcenter:OpenJobCenter",
				label = "Abrir Central",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("WorkTaxi", vec3(896.13, -144.93, 76.92), 0.5, 0.5, {
		name = "WorkTaxi",
		heading = 331.66,
		minZ = 76.92 - 0.75,
		maxZ = 76.92 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:TaxiInit",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkCorrections", vec3(1852.16, 2582.58, 45.66), 0.5, 0.5, {
		name = "WorkCorrections",
		heading = 286.3,
		minZ = 45.66 - 0.75,
		maxZ = 45.66 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:CorrectionsInit",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkPatients", vec3(298.19, -600.69, 43.3), 0.5, 0.5, {
		name = "WorkPatients",
		heading = 158.75,
		minZ = 43.3 - 0.75,
		maxZ = 43.3 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:PatientsInit",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkPostOp", vec3(-496.07, -2910.98, 6.0), 0.5, 0.5, {
		name = "WorkPostOp",
		heading = 229.61,
		minZ = 6.0 - 0.75,
		maxZ = 6.0 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:PostOpInit",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkBus", vec3(453.47, -602.34, 28.59), 0.5, 0.5, {
		name = "WorkBus",
		heading = 266.46,
		minZ = 28.59 - 0.75,
		maxZ = 28.59 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "bus:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("BurgershotJuice", vec3(-1199.88, -896.28, 14.02), 0.2, {
		name = "BurgershotJuice",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "foodjuice"
			}
		}
	})

	AddCircleZone("BurgershotBurger", vec3(-1195.73, -897.23, 13.91), 0.2, {
		name = "BurgershotBurger",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "foodburger"
			}
		}
	})

	AddCircleZone("BurgershotBox", vec3(-1195.79, -895.99, 14.13), 0.2, {
		name = "BurgershotBox",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "foodbox"
			}, {
				event = "inventory:MakeProducts",
				label = "Montar Combo com Brinquedo",
				tunnel = "products",
				service = "foodboxtoy"
			}
		}
	})

	AddCircleZone("CallWorks01", vec3(-1197.43, -892.52, 14.09), 0.20, {
		name = "CallWorks01",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "target:Announces",
				label = "Anunciar",
				tunnel = "proserver",
				service = "Burgershot"
			}
		}
	})

	AddBoxZone("CallWorks02", vec3(311.83, -593.31, 43.08), 0.25, 0.25, {
		name = "CallWorks02",
		heading = 0.0,
		minZ = 43.00,
		maxZ = 43.25
	}, {
		Distance = 1.25,
		options = {
			{
				event = "target:Announces",
				label = "Anunciar",
				tunnel = "proserver",
				service = "Paramedico"
			}
		}
	})

	AddTargetModel({ 858993389, 2913180574 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Roubar Frutas",
				tunnel = "shop",
				service = "Fruits"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1281992692, 1158960338, 1511539537, -78626473, -429560270 }, {
		options = {
			{
				event = "target:Call",
				label = "Ligar para Prefeitura",
				tunnel = "proserver",
				service = "Admin"
			}, {
				event = "target:Call",
				label = "Ligar para Delegacia",
				tunnel = "proserver",
				service = "Policia"
			}, {
				event = "target:Call",
				label = "Ligar para Hospital",
				tunnel = "proserver",
				service = "Paramedico"
			}, {
				event = "target:Call",
				label = "Ligar para Mecânica",
				tunnel = "proserver",
				service = "Mecanico"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1207886863, 568309711, 200010599, 1888301071, 1677473970, 323971301 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Procurar Petróleo",
				tunnel = "shop",
				service = "Pumpjack"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -2007231801, 1339433404, 1694452750, 1933174915, -462817101, -469694731, -164877493, 486135101 }, {
		options = {
			{
				event = "shops:BuyGasoline",
				label = "Comprar Combustível",
				tunnel = "server"
			}, {
				event = "inventory:ObjectsVerify",
				label = "Roubar Combustível",
				tunnel = "shop",
				service = "Gasoline"
			}, {
				event = "shops:SellOil",
				label = "Vender Petróleo",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 654385216, 161343630, -430989390, 1096374064, -1519644200, -1932041857, 207578973, -487222358 }, {
		options = {
			{
				event = "slotmachine:Init",
				label = "Sentar",
				tunnel = "client"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -1691644768, -742198632 }, {
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher",
				tunnel = "products",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 200846641, -97646180, -366155374 }, {
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher",
				tunnel = "products",
				service = "emptybottle"
			},
		},
		Distance = 0.75
	})

	AddTargetModel({ 690372739 }, {
		options = {
			{
				event = "shops:Coffee",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -654402915, 1421582485 }, {
		options = {
			{
				event = "shops:Donut",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 992069095, 1114264700 }, {
		options = {
			{
				event = "shops:Soda",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 1129053052 }, {
		options = {
			{
				event = "shops:Hamburger",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -1581502570 }, {
		options = {
			{
				event = "shops:Hotdog",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 73774428 }, {
		options = {
			{
				event = "shops:Cigarette",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -272361894 }, {
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1099892058 }, {
		options = {
			{
				event = "shops:Water",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1711856655, -1672689514, -1951226014 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Bricks"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1940238623, 2108567945 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Parkimeter"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -2007495856, -1620823304 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Electric"
			}
		},
		Distance = 0.75
	})

	AddTargetModel( { 3630914197, 3462393972, 307287994, 1682622302 }, {
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "shop"
			}
		},
		Distance = 1.25
	})

	AddTargetModel( { 684586828, 577432224, -1587184881, -1426008804, -228596739, 1437508529, -1096777189, -468629664, 1143474856, -2096124444, -115771139, 1329570871, -130812911 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Lixeiro"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -206690185, 666561306, 218085040, -58485588, 1511880420, 682791951 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Lixeiro"
			}, {
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			}, {
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "server"
			}, {
				event = "chest:Open",
				label = "Abrir",
				tunnel = "entity",
				service = "Custom"
			}
		},
		Distance = 0.75
	})

	AddTargetModel( { 1898296526, 1069797899, 1434516869, -896997473, -1748303324, -1366478936, 2090224559, -52638650, 591265130, -915224107, -273279397, 322493792, 10106915, 1120812170 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "CarWreck"
			}
		},
		Distance = 1.00
	})

	AddCircleZone("Dealership01", vec3(-56.94, -1098.77, 26.42), 0.55, {
		name = "Dealership01",
		heading = 0.0
	}, {
		shop = "Santos",
		Distance = 1.5,
		options = {
			{
				event = "pdm:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("Dealership02", vec3(1224.78, 2728.01, 38.0), 0.5, {
		name = "Dealership02",
		heading = 0.0
	}, {
		shop = "Sandy",
		Distance = 2.0,
		options = {
			{
				event = "pdm:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("CassinoWheel", vec3(988.37, 43.06, 71.3), 0.5, {
		name = "CassinoWheel",
		heading = 0.0
	}, {
		Distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ 1211559620, 1363150739, -1186769817, 261193082, -756152956, -1383056703, 720581693 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Jornaleiro"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 1363150739 }, {
		options = {
			{
				event = "inventory:SendLetter",
				label = "Enviar Carta",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKCOOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 100
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Target"] or Sucess or GetGameTimer() <= Cooldown then
			TimeDistance = 1
			DisableControlAction(0,18,true)
			DisableControlAction(0,55,true)
			DisableControlAction(0,76,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,102,true)
			DisableControlAction(0,179,true)
			DisableControlAction(0,203,true)
			DisablePlayerFiring(Ped,true)

			if Focus then
				DisableControlAction(0,1,true)
				DisableControlAction(0,2,true)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetEnable()
	local Ped = PlayerPedId()
	if (not LocalPlayer["state"]["Admin"] and LocalPlayer["state"]["Invisible"]) or LocalPlayer["state"]["Cancel"] or LocalPlayer["state"]["Camera"] or LocalPlayer["state"]["Freecam"] or LocalPlayer["state"]["Carry"] or not LocalPlayer["state"]["Active"] or IsPauseMenuActive() or (LocalPlayer["state"]["Cellphone"] or LocalPlayer["state"]["Phone"]) or not MumbleIsConnected() or LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedInAnyVehicle(Ped) then
		return
	end

	SendNUIMessage({ Action = "Open" })
	Cooldown = GetGameTimer() + (999 * 60000)
	LocalPlayer["state"]:set("Target",true,false)

	while LocalPlayer["state"]["Target"] do
		local Hitable,HitCoords,Entitys = RayCastGamePlayCamera()

		if Hitable == 1 then
			local Coords = GetEntityCoords(Ped)

			for Index,v in pairs(Zones) do
				if #(Coords - Zones[Index]["center"]) <= 10 then
					SetDrawOrigin(Zones[Index]["center"]["x"],Zones[Index]["center"]["y"],Zones[Index]["center"]["z"])
					DrawSprite("Targets","Normal",0,0,0.02,0.02 * GetAspectRatio(false),0,255,255,255,255)
					ClearDrawOrigin()
				end

				if Zones[Index]:isPointInside(HitCoords) and #(Coords - Zones[Index]["center"]) <= v["targetoptions"]["Distance"] then
					if v["targetoptions"]["shop"] then
						Selected = v["targetoptions"]["shop"]
					end

					SendNUIMessage({ Action = "Valid", data = Zones[Index]["targetoptions"]["options"] })

					Sucess = true
					while Sucess do
						local Ped = PlayerPedId()
						local Coords = GetEntityCoords(Ped)
						local _,OtherCoords = RayCastGamePlayCamera()

						SetDrawOrigin(Zones[Index]["center"]["x"],Zones[Index]["center"]["y"],Zones[Index]["center"]["z"])
						DrawSprite("Targets","Selected",0,0,0.02,0.02 * GetAspectRatio(false),0,255,255,255,255)
						ClearDrawOrigin()

						if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
							SetCursorLocation(0.5,0.5)
							SetNuiFocus(true,true)
							Focus = true
						end

						if not Zones[Index]:isPointInside(OtherCoords) or #(Coords - Zones[Index]["center"]) > v["targetoptions"]["Distance"] then
							Sucess = false
						end

						Wait(1)
					end

					SendNUIMessage({ Action = "Left" })
				end
			end

			if GetEntityType(Entitys) ~= 0 then
				--TriggerServerEvent("admin:Doords",GetEntityCoords(Entitys),GetEntityModel(Entitys),GetEntityHeading(Entitys))

				if IsEntityAVehicle(Entitys) then
					local Plate = GetVehicleNumberPlateText(Entitys)
					if #(Coords - HitCoords) <= 1.0 and Plate ~= "PDMSPORT" then
						local Menu = {}
						local Network = nil
						local Combustivel = false
						local Vehicle = GetLastDrivenVehicle()

						SetEntityAsMissionEntity(Entitys,true,true)
						if NetworkGetEntityIsNetworked(Entitys) then
							Network = NetworkGetNetworkIdFromEntity(Entitys)
						end

						Selected = { Plate,GetEntityArchetypeName(Entitys),Entitys,Network,GetEntityModel(Entitys),false }

						for _,v in pairs(Fuels) do
							if #(Coords - v["Coords"]) <= 2.5 then
								Combustivel = true
								break
							end
						end

						if not Combustivel then
							if GetSelectedPedWeapon(Ped) == 883325847 then
								Selected[6] = true
								Menu[#Menu + 1] = { event = "engine:Supply", label = "Abastecer", tunnel = "client" }
							else
								if GlobalState["Plates"][Plate] then
									if GetVehicleDoorLockStatus(Entitys) == 1 then
										if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_WRENCH") then
											for Index,Tyre in pairs(Tyres) do
												local Wheel = GetEntityBoneIndexByName(Entitys,Index)
												if Wheel ~= -1 then
													local CoordsWheel = GetWorldPositionOfEntityBone(Entitys,Wheel)
													if #(Coords - CoordsWheel) <= 1.0 then
														Selected[6] = Tyre
														Menu[#Menu + 1] = { event = "inventory:RemoveTyres", label = "Retirar Pneu", tunnel = "server" }
													end
												end
											end
										end

										Menu[#Menu + 1] = { event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" }
										Menu[#Menu + 1] = { event = "player:checkTrunk", label = "Checar Porta-Malas", tunnel = "server" }
									end

									Menu[#Menu + 1] = { event = "garages:Key", label = "Criar Chave Cópia", tunnel = "police" }
									Menu[#Menu + 1] = { event = "inventory:ChangePlate", label = "Trocar Placa", tunnel = "server" }
								else
									if Selected[2] == "stockade" then
										Menu[#Menu + 1] = { event = "inventory:Stockade", label = "Vasculhar", tunnel = "server" }
									end

									if Selected[2] == "pounder" or Selected[2] == "pounder2" then
										Menu[#Menu + 1] = { event = "inventory:Pounder", label = "Vasculhar", tunnel = "server" }
									end
								end

								if not IsThisModelABike(Selected[5]) then
									local Rolling = GetEntityRoll(Entitys)
									if Rolling > 75.0 or Rolling < -75.0 then
										Menu[#Menu + 1] = { event = "player:RollVehicle", label = "Desvirar", tunnel = "server" }
									else
										if GetEntityBoneIndexByName(Entitys,"boot") ~= -1 then
											local Trunk = GetEntityBoneIndexByName(Entitys,"boot")
											local CoordsTrunk = GetWorldPositionOfEntityBone(Entitys,Trunk)
											if #(Coords - CoordsTrunk) <= 1.75 then
												if GetVehicleDoorLockStatus(Entitys) == 1 then
													Menu[#Menu + 1] = { event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" }
												else
													Menu[#Menu + 1] = { event = "trunkchest:forceTrunk", label = "Forçar Porta-Malas", tunnel = "server" }
												end

												Menu[#Menu + 1] = { event = "inventory:StealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" }
											end
										end
									end
								end

								if LocalPlayer["state"]["Policia"] then
									Menu[#Menu + 1] = { event = "police:Plate", label = "Verificar Placa", tunnel = "police" }
									Menu[#Menu + 1] = { event = "police:Impound", label = "Registrar Veículo", tunnel = "police" }

									if GlobalState["Plates"][Plate] then
										Menu[#Menu + 1] = { event = "police:ArrestVehicles", label = "Apreender Veículo", tunnel = "police" }
									end
								else
									if Plate == "DISM"..(1000 + LocalPlayer["state"]["Passport"]) then
										if #(Coords - Dismantle[Dismantleds]) <= 15 then
											Menu[#Menu + 1] = { event = "inventory:Dismantle", label = "Desmanchar", tunnel = "client" }
										end
									end

									if #(Coords - vec3(405.21, -1638.34, 29.28)) <= 15 then
										Menu[#Menu + 1] = { event = "inventory:Tow", label = "Rebocar", tunnel = "client" }
										Menu[#Menu + 1] = { event = "police:ImpoundCheck", label = "Impound", tunnel = "police" }
									end
								end

								Menu[#Menu + 1] = { event = "engine:Vehrify", label = "Verificar", tunnel = "client" }
							end
						else
							Menu[#Menu + 1] = { event = "engine:Supply", label = "Abastecer", tunnel = "client" }
						end

						SendNUIMessage({ Action = "Valid", data = Menu })

						Sucess = true
						while Sucess do
							local Ped = PlayerPedId()
							local Coords = GetEntityCoords(Ped)
							local _,OtherCoords,OtherEntity = RayCastGamePlayCamera()

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
								Focus = true
							end

							if GetEntityType(OtherEntity) == 0 or #(Coords - OtherCoords) > 1.0 then
								Sucess = false
							end

							Wait(1)
						end

						SendNUIMessage({ Action = "Left" })
					end
				elseif IsPedAPlayer(Entitys) then
					if #(Coords - HitCoords) <= 2.0 then
						local Index = NetworkGetPlayerIndexFromPed(Entitys)
						local source = GetPlayerServerId(Index)
						local Menu = {}

						Selected = { source }

						if LocalPlayer["state"]["Policia"] then
							Menu[#Menu + 1] = { event = "police:Inspect", label = "Revistar", tunnel = "paramedic" }
							Menu[#Menu + 1] = { event = "police:ArrestItens", label = "Apreender Itens", tunnel = "paramedic" }
							Menu[#Menu + 1] = { event = "autoschool:SeizeCnh", label = "Apreender CNH", tunnel = "paramedic" }
							Menu[#Menu + 1] = { event = "police:prisonClothes", label = "Uniforme Presidiário", tunnel = "police" }
						elseif LocalPlayer["state"]["Paramedico"] then
							if GetEntityHealth(Entitys) <= 100 then
								Menu[#Menu + 1] = { event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" }
							else
								Menu[#Menu + 1] = { event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "paramedic:Reposed", label = "Colocar de Repouso", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" }
							end

							Menu[#Menu + 1] = { event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" }
						end
						
						if GetEntityHealth(Entitys) <= 100 then
							Menu[#Menu + 1] = { event = "police:Inspect", label = "Saquear", tunnel = "paramedic" }
						end

						if IsEntityPlayingAnim(Entitys, "random@mugging3", "handsup_standing_base", 3) then
							Menu[#Menu + 1] = { event = "police:Inspect", label = "Revistar", tunnel = "paramedic" }
							Menu[#Menu + 1] = { event = "player:checkShoes", label = "Roubar Sapatos", tunnel = "paramedic" }
						end

						if GetEntityHealth(Entitys) > 100 then
							Menu[#Menu + 1] = { event = "player:Charge", label = "Cobrança", tunnel = "paramedic" }
							
							local Reputation = vPLAYER.GetReputation(source)
							if Reputation then
								Menu[#Menu + 1] = { event = "player:Like", label = "👍 Curtir ["..parseInt(Reputation[1]).."]", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "player:UnLike", label = "👎 Descurtir ["..parseInt(Reputation[2]).."]", tunnel = "paramedic" }
							end
						end

						if #Menu >= 1 then
							SendNUIMessage({ Action = "Valid", data = Menu })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _,OtherCoords,OtherEntity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
									Focus = true
								end

								if GetEntityType(OtherEntity) == 0 or #(Coords - OtherCoords) > 2.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					end
				else
					for Index,_ in pairs(Models) do
						if DoesEntityExist(Entitys) and Index == GetEntityModel(Entitys) then
							local OtherCoords = GetEntityCoords(Entitys)
							if #(Coords - OtherCoords) <= 10 then
								SetDrawOrigin(OtherCoords["x"],OtherCoords["y"],OtherCoords["z"] + 1)
								DrawSprite("Targets","Normal",0,0,0.02,0.02 * GetAspectRatio(false),0,255,255,255,255)
								ClearDrawOrigin()
							end

							if #(Coords - HitCoords) <= Models[Index]["Distance"] then
								SetEntityAsMissionEntity(Entitys,true,true)

								if not IsEntityAPed(Entitys) then
									FreezeEntityPosition(Entitys,true)
								end

								local Network = nil
								if NetworkGetEntityIsNetworked(Entitys) then
									Network = NetworkGetNetworkIdFromEntity(Entitys)
								end

								Selected = { Entitys,Index,Network,GetEntityCoords(Entitys),IsEntityDead(Entitys) }

								SendNUIMessage({ Action = "Valid", data = Models[Index]["options"] })

								Sucess = true
								while Sucess do
									local Ped = PlayerPedId()
									local Coords = GetEntityCoords(Ped)
									local EntityCoords = GetEntityCoords(Entitys)
									local _,OtherCoords,OtherEntity = RayCastGamePlayCamera()

									SetDrawOrigin(EntityCoords["x"],EntityCoords["y"],EntityCoords["z"] + 1)
									DrawSprite("Targets","Selected",0,0,0.02,0.02 * GetAspectRatio(false),0,255,255,255,255)
									ClearDrawOrigin()

									if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
										SetCursorLocation(0.5,0.5)
										SetNuiFocus(true,true)
										Focus = true
									end

									if GetEntityType(OtherEntity) == 0 or #(Coords - OtherCoords) > Models[Index]["Distance"] then
										Sucess = false
									end

									Wait(1)
								end

								SendNUIMessage({ Action = "Left" })
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle",function(Network)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetDisable()
	if Focus or not LocalPlayer["state"]["Target"] then
		return
	end

	TriggerEvent("target:Debug")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Select",function(Data,Callback)
	TriggerEvent("target:Debug")

	if not LocalPlayer["state"]["Cancel"] then
		if Data["tunnel"] == "client" then
			TriggerEvent(Data["event"],Selected)
		elseif Data["tunnel"] == "shop" then
			TriggerEvent(Data["event"],Selected,Data["service"])
		elseif Data["tunnel"] == "entity" then
			TriggerEvent(Data["event"],Selected[1],Data["service"])
		elseif Data["tunnel"] == "vehicle" then
			TriggerEvent(Data["event"],Selected[3])
		elseif Data["tunnel"] == "products" then
			TriggerEvent(Data["event"],Data["service"])
		elseif Data["tunnel"] == "server" then
			TriggerServerEvent(Data["event"],Selected)
		elseif Data["tunnel"] == "police" then
			TriggerServerEvent(Data["event"],Selected,Data["service"])
		elseif Data["tunnel"] == "paramedic" then
			TriggerServerEvent(Data["event"],Selected[1],Data["service"])
		elseif Data["tunnel"] == "proserver" then
			TriggerServerEvent(Data["event"],Data["service"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("target:Debug")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Debug")
AddEventHandler("target:Debug",function()
	Focus = false
	Sucess = false
	SetNuiFocus(false,false)
	Cooldown = GetGameTimer() + 3000
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]:set("Target",false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjuste = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.cos(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.sin(Adjuste[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local _,Hit,Coords,_,Entitys = GetShapeTestResult(Handle)

	return Hit,Coords,Entitys
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name]:destroy()
		Zones[Name] = nil
	end

	if Sucess then
		TriggerEvent("target:Debug")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelOptions(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
	Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("LabelOptions",LabelOptions)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)