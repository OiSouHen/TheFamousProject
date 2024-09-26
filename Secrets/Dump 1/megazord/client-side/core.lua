-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("megazord")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Weapon = ""
local Injected = {}
local LastAimX = nil
local LastAimY = nil
local SkriptKeys = { 8,9,32,33,34,35 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Scripts = { "AtbDsMgwVoaGQNJqkW" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local Textures = { "HydroMenu","BartowMenu","Hoax","FendinX","Hammenu","Lynxmenu","Oblivious","malossimenuv","memeeee","tiago","absoluteeulen","KekHack","Maestro","SkidMenu","Brutan","FiveSense","NeekerMan","Auttaja","Blood-X","Dopamine","Fallout","Luxmenu","CKGang","InfinityMenu","hugeware","wave menu","weapon_icons","meow","meow2","meow3","John","darkside","ISMMENU","dopatest","fm","wave","wave1","adb831a7fdd83d_Guest_d1e2a309ce7591dff86","hugev_gif_DSGUHSDGISDG","MM","wm","last_logo","menu_gif","mpmissmarkers256","adb831a7fdd83d_Guest_d1e2a309ce7591dff86","__REAPER6__","__REAPER5__","__REAPER4__","__REAPER3__","__REAPER1__","__REAPER__","__REAPER8__","__REAPER9__","__REAPER11__","timerbars","mprankbadge","commonmenu","header","mp_arrowxlarge","arrownonfill","hud_target","mp_modeselected_gradient","gradient_bgd","mp_modenotselected_gradient","mpentry","arrowleft","timerbar_sr","TXDDict2","TXDDict","cock_lsc","cockmenuuu","shared","arrowfill","deadline","srange_gen","rampage_tr_main","MenyooExtras","shopui_title_graphics_franklin","deadline","shop_box_tick","shop_box_blank","srange_gen","trafficcam","radar_centre","logoz1","self1","logoarme1","voiture1","digitaloverlay","pause_menu_pages_char_mom_dad","char_creator_portraits","wave","fs2","fs3","fs4","fs5","fs52","fs7","fs","custompistol","Guest8","srange_gen","mptattoos2","Guest9","Guest7","shopui_title_sm_hangar","mpinventory","shopui_title_gr_gunmod","sprraces","static","logo","tikthaia","CHAR_JIMMY","heisthud","KentasMenu","BonePed","LoadGifPed","KentasCheckboxDict","checkbox","checkboxdict","felipemenueohype","thefov","banner","rounded","checkon","checkoff","RATINHOPIKA","RATINHOPIKA2","sdjcircle","yagFixx","FovFoxx","Urubu","sapo","Sapo","grade","off","checkboxoff" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local HackerEvents = { "yourweapons","rpv_uber:success","xex_streetfight:pay","lester:vendita","esx:jackingcar","esx_vehicletrunk:giveDirty","esx_moneywash:deposit","Esx-MenuPessoal:Boss_recruterplayer","esx_blackmoney:washMoney","esx_ambulancejob:setDeathStatus","esx_carthief:alertcops","esx_dmvschool:addLicense","esx_skin:setPlayerInvisible","esx_bank:withdraw","esx:enterpolicecar","esx_handcuffs:cuffing","esx_jail:sendToJail","esx_jail:unjailQuest","esx_jailer:unjailTime","esx_mecanojob:onNPCJobCompleted","esx_mechanicjob:startHarvest","esx_mechanicjob:startCraft","esx-qalle-hunting:reward","esx-qalle-hunting:sell","esx_skin:responseSaveSkin","esx_society:setJob","esx_skin:responseSaDFWMveSkin","esx_dmvschool:addLiceDFWMnse","esx_mechanicjob:starDFWMtCraft","esx_drugs:startHarvestWDFWMeed","esx_drugs:startTransfoDFWMrmWeed","esx_drugs:startSellWeDFWMed","esx_drugs:startHarvestDFWMCoke","esx_drugs:startTransDFWMformCoke","esx_drugs:startSellCDFWMoke","esx_drugs:startHarDFWMvestMeth","esx_drugs:startTDFWMransformMeth","esx_drugs:startSellMDFWMeth","esx_drugs:startHDFWMarvestOpium","esx_drugs:startSellDFWMOpium","esx_drugs:starDFWMtTransformOpium","esx_blanchisDFWMseur:startWhitening","esx_drugs:stopHarvDFWMestCoke","esx_drugs:stopTranDFWMsformCoke","esx_drugs:stopSellDFWMCoke","esx_drugs:stopHarvesDFWMtMeth","esx_drugs:stopTranDFWMsformMeth","esx_drugs:stopSellMDFWMeth","esx_drugs:stopHarDFWMvestWeed","esx_drugs:stopTDFWMransformWeed","esx_drugs:stopSellWDFWMeed","esx_drugs:stopHarvestDFWMOpium","esx_drugs:stopTransDFWMformOpium","esx_drugs:stopSellOpiuDFWMm","esx_society:openBosDFWMsMenu","esx_tankerjob:DFWMpay","esx_vehicletrunk:givDFWMeDirty","esx_vehicleshop:setVehicleOwnedPlayerId","esx_drugs:pickedUpCDFWMannabis","esx_drugs:processCDFWMannabis","esx-qalle-hunting:DFWMreward","esx-qalle-hunting:seDFWMll","esx_mecanojob:onNPCJobCDFWMompleted","esx_society:putVehicleDFWMInGarage","esx:clientLog","esx:triggerServerCallback","esx:setJob","checkpolice:antiplayerLoaded","esx:playerLoaded","esx:createMissingPickups","esx:updateLoadout","esx:updateLastPosition","esx:removeInventoryItem","esx:useItem","esx:onPickup","esx_jobs:startWork","esx_jobs:stopWork","esx_fueldDFWMelivery:pay","esx_carthDFWMief:pay","esx_godiDFWMrtyjob:pay","esx_pizza:pDFWMay","esx_ranger:pDFWMay","esx_garbageDFWMjob:pay","esx_truckDFWMerjob:pay","esx_jobs:caDFWMution","esx_carthief:alertcoDFWMps","esx:getShDFWMaredObjDFWMect","esx_society:getOnlDFWMinePlayers","esx_jailer:unjailTiDFWMme","esx_ambulancejob:reDFWMvive","esx_moneywash:depoDFWMsit","esx_moneywash:witDFWMhdraw","esx_handcuffs:cufDFWMfing","esx_policejob:haDFWMndcuff","esx-qalle-jail:jailPDFWMlayer","esx_dmvschool:pDFWMay","esx_biDFWMlling:sendBill","esx_jDFWMailer:sendToJail","esx_jaDFWMil:sendToJail","esx_goDFWMpostaljob:pay","esx_baDFWMnksecurity:pay","esx_sloDFWMtmachine:sv:2","esx:giDFWMveInventoryItem","esx_vehicleshop:setVehicleOwnedDFWM","esx_mafiajob:confiscateDFWMPlayerItem","OG_cuffs:cuffCheckNearest","CheckHandcuff","arisonarp:wiezienie","gambling:spend","265df2d8-421b-4727-b01d-b92fd6503f5e","mission:completed","truckerJob:success","c65a46c5-5485-4404-bacf-06a106900258","paycheck:salary","MF_MobileMeth:RewardPlayers","lscustoms:UpdateVeh","xk3ly-farmer:paycheck","AdminMenu:giveDirtyMoney","Tem2LPs5Para5dCyjuHm87y2catFkMpV","dqd36JWLRC72k8FDttZ5adUKwvwq9n9m","antilynxr4:detect","antilynxr6:detection","ynx8:anticheat","antilynx8r4a:anticheat","lynx8:anticheat","AntiLynxR4:kick","AntiLynxR4:log","esx_spectate:kick","Banca:withdraw","BsCuff:Cuff696999","cuffServer","cuffGranted","DFWM:adminmenuenable","DFWM:askAwake","DFWM:checkup","DFWM:cleanareaentity","DFWM:cleanareapeds","DFWM:cleanareaveh","DFWM:enable","DFWM:invalid","DFWM:log","DFWM:openmenu","DFWM:spectate","DFWM:ViolationDetected","eden_garage:payhealth","ems:revive","hentailover:xdlol","JailUpdate","js:removejailtime","LegacyFuel:PayFuel","ljail:jailplayer","mellotrainer:adminTempBan","mellotrainer:adminKick","mellotrainer:s_adminKill","NB:destituerplayer","NB:recruterplayer","paramedic:revive","police:cuffGranted","unCuffServer","uncuffGranted","whoapd:revive","lscustoms:pDFWMayGarage","vrp_slotmachDFWMine:server:2","Banca:dDFWMeposit","bank:depDFWMosit","give_back","AdminMeDFWMnu:giveBank","AdminMDFWMenu:giveCash","NB:recDFWMruterplayer","LegacyFuel:PayFuDFWMel","OG_cuffs:cuffCheckNeDFWMarest","CheckHandcDFWMuff","cuffSeDFWMrver","cuffGDFWMranted","police:cuffGDFWMranted","bank:withdDFWMraw","dmv:succeDFWMss","gambling:speDFWMnd","AdminMenu:giveDirtyMDFWMoney","mission:completDFWMed","truckerJob:succeDFWMss","99kr-burglary:addMDFWMoney","DiscordBot:plaDFWMyerDied","js:jaDFWMiluser","h:xd","adminmenu:setsalary","adminmenu:cashoutall","bank:tranDFWMsfer","paycheck:bonDFWMus","paycheck:salDFWMary","HCheat:TempDisableDetDFWMection","BsCuff:Cuff696DFWM999","veh_SR:CheckMonDFWMeyForVeh","mellotrainer:adminTeDFWMmpBan","mellotrainer:adminKickDFWM","tigoanticheat:getSharedObject","tigoanticheat:triggerServerCallback","tigoanticheat:triggerServerEvent","tigoanticheat:serverCallback","tigoanticheat:triggerClientCallback","tigoanticheat:clientCallback","tigoanticheat:getServerConfig","tigoanticheat:banPlayer","tigoanticheat:playerResourceStarted","tigoanticheat:logToConsole","tigoanticheat:stillAlive","tigoanticheat:storeSecurityToken","modmenu","esx:getSharedObject","esx_ambulancejob:revive","esx_society:openBossMenu","esx_status:set","esx_policejob:handcuff","esx_handcuffs:cuffClosestPlayer","LegacyFuel:RefundFuel","esx_jailer:wysylandoo","esx_godirtyjob:pay","esx_pizza:pay","esx_slotmachine:sv:2","esx_banksecurity:pay","esx_truckerjob:pay","esx_carthief:pay","esx_garbagejob:pay","esx_ranger:pay","esx_truckersjob:payy","esx_blanchisseur:washMoney","esx_moneywash:withdraw","esx_blanchisseur:startWhitening","esx_billing:sendBill","esx_dmvschool:pay","esx_jailer:sendToJail","esx_jailler:sendToJail","esx-qalle-jail:jailPlayer","esx-qalle-jail:jailPlayerNew","esx_jailer:sendToJailCatfrajerze","esx_policejob:billPlayer","esx_skin:openRestrictedMenu","esx_inventoryhud:openPlayerInventory","bank:transfer","advancedFuel:setEssence","display","tost:zgarnijsiano","Sasaki_kurier:pay","wojtek_ubereats:napiwek","wojtek_ubereats:hajs","xk3ly-barbasz:getfukingmony","xk3ly-farmer:paycheck","tostzdrapka:wygranko","laundry:washcash","projektsantos:mandathajs","program-keycard:hacking","6a7af019-2b92-4ec2-9435-8fb9bd031c26","211ef2f8-f09c-4582-91d8-087ca2130157","neweden_garage:pay","8321hiue89js","js:jailuser","wyspa_jail:jailPlayer","wyspa_jail:jail","ambulancier:selfRespawn","UnJP","esx-qalle-jail:openJailMenu","esx:spawnVehicle","HCheat:TempDisableDetection","bank:deposit","bank:withdraw","cacador-vender","esx:giveInventoryItem","esx_jobs:caution","esx_fueldelivery:pay","esx_society:getOnlinePlayers","esx_vehicleshop:setVehicleOwned","gcPhone:tchatchannel","gcPhone:internalAddMessage","AdminMenu:giveBank","AdminMenu:giveCash","vrp_slotmachine:server:2","Banca:deposit","lscustoms:payGarage","LegacyFuel:PayFuel","blarglebus:finishRoute","dmv:success","departamento-vender","reanimar:pagamento","adminmenu:allowall","d0pamine_xyz:getFuckedNigger","chat:server:ServerPSA","antilynx8:anticheat","DiscordBot:playerDie","esx_fueldeliver","PayForRepairNow","esx_jobs:caution","bank:transfer","lscustoms:payGarag","esx_vangelico_robbery:gioielli1","99kr-burglary:addMoney","esx_truckerJob2:payout","es_truckerJob:pay","burglary:money","lenzh_chopshop:sell","esx_deliveries:AddCashMoney","loffe_prisonwork","esx_tankerjob:pay","esx_society:sendMoney","esx_drugs:sellAll","esx_drugs:sellCocaine","esx_drugs:sellCoke","esx_drugs:sellWeed","esx_drugs:sellMeth","esx_drugs:sellOpium","esx_mechanicjob:repairCurrentVehicle","napadtransport:graczZrobilnapad","tost:zgarnijsiano","esx_loffe_fangelse:Pay","esx_mugging:giveMoney","esx_robnpc:giveMoney","esx_vehicletrunk:giveDirty","esx_gopostaljob:pay","f0ba1292-b68d-4d95-8823-6230cdf282b6",":tunnel_req","gambling:spend","265df2d8-421b-4727-b01d-b92fd6503f5e","AdminMenu:giveDirtyMoney","esx_moneywash:deposit","esx_moneywash:withdraw","esx_moneywash:deposit","mission:completed","truckerJob:success","esx_moneywash:getMoney","AdminMenu:addMoney","esx_fishing:receiveFish","c65a46c5-5485-4404-bacf-06a106900258","dropOff","truckerfuel:success","delivery:success","esx_brinksjob:pay","esx_postejob:pay","esx_garbage:pay","esx_carteirojob:pay","esx_pilot:success","esx_taxijob:success","adminmenu:setsalary","esx_mugging:giveMoney","paycheck:salary","vrp_slotmachine:server:2","DiscordBot:playerDied","esx_drugs:startHarvestWeed","esx_drugs:startTransformWeed","esx_drugs:startSellWeed","esx_drugs:startHarvestCoke","esx_drugs:startTransformCoke","esx_drugs:startSellCoke","esx_drugs:startHarvestMeth","esx_drugs:startTransformMeth","esx_drugs:startSellMeth","esx_drugs:startHarvestOpium","esx_drugs:startTransformOpium","esx_drugs:startSellOpium","esx_drugs:stopTransformCoke","esx_handcuffs:unlocking","esx_policejob:requestarrest","esx_policejob:handcuffPasta","17A34C820A685513C5B4ADDD85968B9E905CC300A261EB55D299ABCB6C90AAA872712B3B6C13DC41913FCC2BE84A07EF9300DC4E89669A4B0E6FBB344A69D239","llotrainer:adminKick","esx_mafiajob:confiscatePlayerItem","InteractSound_SV:PlayOnAll","SEM_InteractionMenu:Jail","SEM_InteractionMenu:DragNear","KorioZ-PersonalMenu:Weapon_addAmmoToPedS","KorioZ-PersonalMenu:Admin_BringS","KorioZ-PersonalMenu:Admin_giveCash","KorioZ-PersonalMenu:Admin_giveBank","KorioZ-PersonalMenu:Admin_giveDirtyMoney","KorioZ-PersonalMenu:Boss_promouvoirplayer","KorioZ-PersonalMenu:Boss_destituerplayer","KorioZ-PersonalMenu:Boss_recruterplayer","KorioZ-PersonalMenu:Boss_virerplayer","Admin2Menu:giveCash","Admin2Menu:giveBank","Admin2Menu:giveDirtyMoney" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event ~= "CEventNetworkPlayerCollectedPickup" then
		return
	end

	if not Injected["Pickup"] then
		vSERVER.Warning("Pickups")
		Injected["Pickup"] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Weapon",function(Value)
	Weapon = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CountResources = GetNumResources()

	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		if not Injected["Scripts"] then
			for _,Name in pairs(Scripts) do
				if GetResourceState(Name) == "started" then
					vSERVER.Warning("onResourceStart - "..Name)
					Injected["Scripts"] = true
					break
				end
			end
		end

		if IsPedArmed(Ped,7) and Weapon == "" then
			if not Injected["Weaspawn"] then
				vSERVER.Warning("Spawn Weapons")
				Injected["Weaspawn"] = true
			end

			RemoveAllPedWeapons(Ped,true)
		end

		if Weapon ~= "" and not Injected["Lockon"] then
			if GetLockonDistanceOfCurrentPedWeapon(Ped) > 500.0 then
				vSERVER.Warning("Lock Player")
				Injected["Lockon"] = true

				SetPlayerLockon(Pid,false)
				SetPlayerLockonRangeOverride(Pid,-1.0)
			end
		end

		for Number = 1,#Textures do
			if HasStreamedTextureDictLoaded(Textures[Number]) and not Injected["Texture-"..Textures[Number]] then
				vSERVER.Warning("Texture - "..Textures[Number])
				Injected["Texture-"..Textures[Number]] = true
			end
		end

		if not Injected["Franklin"] and AnimpostfxIsRunning("CamPushInFranklin") then
			vSERVER.Warning("Franklin Modify")
			Injected["Franklin"] = true
		end

		local _,CurrentWeapon = GetCurrentPedWeapon(Ped)
		if not Injected["DamageModify"] and not LocalPlayer["state"]["DamageModify"] and (GetPlayerWeaponDefenseModifier(Pid) > 1.0 or GetPlayerMeleeWeaponDefenseModifier(Pid) > 1.0 or GetPlayerMeleeWeaponDamageModifier(Pid) > 1.0 or GetPlayerVehicleDamageModifier(Pid) > 1.0 or GetPlayerWeaponDamageModifier(Pid) > 1.0 or GetPlayerMeleeWeaponDefenseModifier(Pid) > 1.0 or GetWeaponDamageModifier(CurrentWeapon) > 1.0) then
			vSERVER.Warning("Weapons Damaged Modify")
			Injected["DamageModify"] = true
		end

		if not Injected["Spectate"] and not LocalPlayer["state"]["Spectate"] and NetworkIsInSpectatorMode() then
			vSERVER.Warning("Spectated")
			Injected["Spectate"] = true
		end

		if not Injected["FreeCam"] and not LocalPlayer["state"]["Spectate"] and not LocalPlayer["state"]["Freecam"] then
			local Camera = GetRenderingCam()
			if Camera and DoesCamExist(Camera) and IsCamActive(Camera) and not IsScreenFadedOut() and not IsCutsceneActive() and not IsPauseMenuActive() and not IsWarningMessageActive() and not IsPlayerCamControlDisabled() and not IsControlEnabled(0,9) and not IsControlEnabled(0,34) then
				local Coords = GetEntityCoords(Ped)
				local CamCoords = GetCamCoord(Camera)

				Coords = Coords - vec3(0.0,0.0,Coords["z"])
				CamCoords = CamCoords - vec3(0.0,0.0,CamCoords["z"])

				if #(CamCoords - Coords) > 15.0 then
					vSERVER.Warning("Free Camera")
					Injected["FreeCam"] = true
				end
			end
		end

		if not Injected["SuperJump"] and IsPedDoingBeastJump(Ped) then
			vSERVER.Warning("Super Jumper")
			Injected["SuperJump"] = true
		end

		if not Injected["PlayerCam"] and IsPlayerCamControlDisabled() ~= false and not LocalPlayer["state"]["Freecam"] then
			vSERVER.Warning("Player Camera")
			Injected["PlayerCam"] = true
		end

		if not Injected["Invincible"] and not LocalPlayer["state"]["Cyndaquil"] and (GetPlayerInvincible(Ped) or GetPlayerInvincible_2(Ped) or not GetEntityCanBeDamaged(Ped)) then
			vSERVER.Warning("Player Invincible")
			Injected["Invincible"] = true
		end

		if not Injected["ChangePerson"] and GetPedConfigFlag(Ped,223,true) then
			vSERVER.Warning("Change Person")
			Injected["ChangePerson"] = true
		end

		if not Injected["NightVision"] and GetUsingnightvision() then
			vSERVER.Warning("Night Vision")
			Injected["NightVision"] = true
		end

		if not Injected["ThermalVision"] and GetUsingseethrough() then
			vSERVER.Warning("Thermal Vision")
			Injected["ThermalVision"] = true
		end

		if not Injected["TaskActive"] then
			local Tasks = { 101,151,221,222 }

			for _,Number in pairs(Tasks) do
				if GetIsTaskActive(Ped,Number) then
					vSERVER.Warning("Task Actived")
					Injected["TaskActive"] = true
				end
			end
		end

		if not Injected["CountResources"] and CountResources ~= GetNumResources() then
			vSERVER.Warning("Limite de Resources")
			Injected["CountResources"] = true
		end

		if not Injected["TinyPed"] and GetPedConfigFlag(Ped,223,true) then
			vSERVER.Warning("Player Tiny")
			Injected["TinyPed"] = true
		end

		if not Injected["Invisible"] and not LocalPlayer["state"]["Chikorita"] and not IsEntityVisible(Ped) then
			vSERVER.Warning("Player Invisible")
			Injected["Invisible"] = true
		end

		if not Injected["Ragdoll"] and not CanPedRagdoll(Ped) and not IsPedInAnyVehicle(Ped) and not IsEntityDead(Ped) and not IsPedJumpingOutOfVehicle(Ped) and not IsPedJacking(Ped) and IsPedRagdoll(Ped) then
			vSERVER.Warning("Player Ragdoll")
			Injected["Ragdoll"] = true
		end

		if not Injected["SkripKeys"] then
			for Number = 1,#SkriptKeys do
				if IsPlayerControlOn(Pid) and GetDisabledControlNormal(0,SkriptKeys[Number]) == 1.0 and IsControlEnabled(0,SkriptKeys[Number]) and GetControlNormal(0,SkriptKeys[Number]) == 0.0 then
					vSERVER.Warning("Skript Keys")
					Injected["SkripKeys"] = true
				end
			end
		end

		if not Injected["SilentAim"] then
			local Model = GetEntityModel(Ped)
			local Min,Max = GetModelDimensions(Model)
			if Min["y"] < -0.30 or Max["z"] > 0.99 then
				vSERVER.Warning("Silent Aims")
				Injected["SilentAim"] = true
			end
		end

		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsIn(Ped)
			if not Injected["VehicleHealth"] and IsVehicleDamaged(Vehicle) and GetEntityHealth(Vehicle) > GetEntityMaxHealth(Vehicle) then
				vSERVER.Warning("Vehicle Health Check")
				Injected["VehicleHealth"] = true
			end

			if not Injected["VehicleInvisible"] and IsVehicleVisible(Vehicle) then
				vSERVER.Warning("Vehicle Invisible")
				Injected["VehicleInvisible"] = true
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
for Number = 1,#HackerEvents do
	RegisterNetEvent(HackerEvents[Number])
	AddEventHandler(HackerEvents[Number],function()
		vSERVER.Warning("Hacker Events")
		Injected["HackerEvents"] = true
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
	if not Injected["Scripts"] then
		for _,Name in pairs(Scripts) do
			if Resource then
				vSERVER.Warning("onResourceStart - "..Resource)
				Injected["Scripts"] = true
				break
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if not Injected["Scripts"] then
		for _,Name in pairs(Scripts) do
			if Resource then
				vSERVER.Warning("onResourceStart - "..Resource)
				Injected["Scripts"] = true
				break
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStop",function(Resource)
	if not Injected["Resources"] then
		vSERVER.Warning("onResourceStop - "..Resource)
	end

	if GetCurrentResourceName() == Resource then
		CancelEvent()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(Resource)
	if not Injected["Resources"] then
		vSERVER.Warning("onResourceStop - "..Resource)
	end

	if GetCurrentResourceName() == Resource then
		CancelEvent()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEGAZORD:SCREENSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("megazord:Screenshot")
AddEventHandler("megazord:Screenshot",function(Webhook)
	exports["screenshot-basic"]:requestScreenshotUpload(Webhook,"files[]",function(Data) end)
end)