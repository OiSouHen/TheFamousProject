-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ModelExist(Hash)
	return IsModelInCdimage(Hash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOSCREENFADEOUT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DoScreenFadeOut()
	if IsScreenFadedIn() then
		DoScreenFadeOut(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWLOADSCENESTARTSPHERE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.NewLoadSceneStartSphere(Coords)
	NewLoadSceneStartSphere(Coords,100,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOSCREENFADEIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DoScreenFadeIn()
	if IsScreenFadedOut() then
		DoScreenFadeIn(2500)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.SetHealth(Health)
	local Ped = PlayerPedId()
	SetEntityHealth(Ped,Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpgradeHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)
	if Health > 100 then
		SetEntityHealth(Ped,Health + Number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DowngradeHealth(Number)
	local Ped = PlayerPedId()

	ApplyDamageToPed(Ped,Number,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlayingAnim(Dict,Name)
	return IsEntityPlayingAnim(PlayerPedId(),Dict,Name,3)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISENTITYINWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.IsEntityInWater()
	return IsEntityInWater(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPEDSWIMMING
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.IsPedSwimming()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Skin(Hash)
	if LoadModel(Hash) then
		local Pid = PlayerId()
		local Hash = GetHashKey(Hash)

		SetPlayerModel(Pid,Hash)
		SetModelAsNoLongerNeeded(Hash)

		ReloadCharacter()
		tvRP.ReloadCharacter()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ReloadCharacter()
	exports["skinshop"]:Apply()
	exports["barbershop"]:Apply()
	exports["tattooshop"]:Apply()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name,Inventory)
	LocalPlayer["state"]:set("Name",Name,true)
	LocalPlayer["state"]:set("Active",true,false)
	LocalPlayer["state"]:set("Passport",Passport,true)

	local Ped = PlayerPedId()
	SetEntityInvincible(Ped,true)
	FreezeEntityPosition(Ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(Ped,true,false)

	SetTimeout(10000,function()
		ReloadCharacter()
		SetEntityInvincible(Ped,false)

		if Inventory then
			for Slot,v in pairs(Inventory) do
				local Animation = ItemAnim(v["item"])

				if Animation then
					tvRP.PersistentBlock(v["item"],Animation)
				end

				if Slot == "104" then
					local Skinshop = ItemSkinshop(v["item"])
					if Skinshop then
						TriggerEvent("skinshop:Backpack",Skinshop)
					end
				end
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerHealthRechargeMultiplier(Pid,0.0)
		SetPlayerHealthRechargeLimit(Pid,0.0)

		if GetPlayerMaxArmour(Ped) ~= 100 then
			SetPlayerMaxArmour(Ped,100)
		end

		if GetPlayerMaxStamina(Pid) ~= 100.0 then
			SetPlayerMaxStamina(Pid,100.0)
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function ReloadCharacter()
	local Pid = PlayerId()
	local Ped = PlayerPedId()

	StopAudioScenes()
	RemovePickups(Pid)
	SetMaxWantedLevel(0)
	SetPedHelmet(Ped,false)
	SetDeepOceanScaler(0.0)
	SetPedMaxHealth(Ped,200)
	SetEntityMaxHealth(Ped,200)
	SetAiWeaponDamageModifier(0.5)
	SetPoliceIgnorePlayer(Ped,true)
	SetPlayerCanUseCover(Pid,false)
	SetPedSteersAroundPeds(Ped,true)
	SetEveryoneIgnorePlayer(Ped,true)
	SetAiMeleeWeaponDamageModifier(5.0)
	SetDispatchCopsForPlayer(Ped,false)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(Ped,false)
	SetPedCanLosePropsOnDamage(Ped,false,0)

	SetPedConfigFlag(Ped,48,true)
	SetPedConfigFlag(Ped,35,false)
	SetPedConfigFlag(Ped,438,true)
	SetForceFootstepUpdate(Ped,true)
	SetPedAudioFootstepLoud(Ped,true)
	SetPedAudioFootstepQuiet(Ped,true)

	DisableIdleCamera(true)
	SetRandomEventFlag(false)
	SetWeaponsNoAutoswap(true)
	SetBlipAlpha(GetNorthRadarBlip(),0)
	ReplaceHudColourWithRgba(116,88,101,242,225)

	SetAudioFlag("ActivateSwitchWheelAudio",false)
	SetAudioFlag("AllowAmbientSpeechInSlowMo",false)
	SetAudioFlag("AllowCutsceneOverScreenFade",false)
	SetAudioFlag("AllowForceRadioAfterRetune",false)
	SetAudioFlag("AllowPainAndAmbientSpeechToPlayDuringCutscene",false)
	SetAudioFlag("AllowPlayerAIOnMission",false)
	SetAudioFlag("AllowPoliceScannerWhenPlayerHasNoControl",false)
	SetAudioFlag("AllowRadioDuringSwitch",false)
	SetAudioFlag("AllowRadioOverScreenFade",false)
	SetAudioFlag("AllowScoreAndRadio",false)
	SetAudioFlag("AllowScriptedSpeechInSlowMo",false)
	SetAudioFlag("AvoidMissionCompleteDelay",false)
	SetAudioFlag("DisableAbortConversationForDeathAndInjury",true)
	SetAudioFlag("DisableAbortConversationForRagdoll",true)
	SetAudioFlag("DisableBarks",true)
	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("DisableReplayScriptStreamRecording",true)
	SetAudioFlag("EnableHeadsetBeep",false)
	SetAudioFlag("ForceConversationInterrupt",false)
	SetAudioFlag("ForceSeamlessRadioSwitch",false)
	SetAudioFlag("ForceSniperAudio",false)
	SetAudioFlag("FrontendRadioDisabled",true)
	SetAudioFlag("HoldMissionCompleteWhenPrepared",false)
	SetAudioFlag("IsDirectorModeActive",false)
	SetAudioFlag("IsPlayerOnMissionForSpeech",true)
	SetAudioFlag("ListenerReverbDisabled",true)
	SetAudioFlag("LoadMPData",false)
	SetAudioFlag("MobileRadioInGame",false)
	SetAudioFlag("OnlyAllowScriptTriggerPoliceScanner",false)
	SetAudioFlag("PlayMenuMusic",false)
	SetAudioFlag("PoliceScannerDisabled",true)
	SetAudioFlag("ScriptedConvListenerMaySpeak",true)
	SetAudioFlag("SpeechDucksScore",true)
	SetAudioFlag("SuppressPlayerScubaBreathing",true)
	SetAudioFlag("WantedMusicDisabled",true)
	SetAudioFlag("WantedMusicOnMission",false)

	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetScenarioGroupEnabled("Heist_Island_Peds",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_construction_01",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_background_main",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_exterior_lobby",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_interior_lobby",false)
	SetStaticEmitterEnabled("se_walk_radio_d_picked",false)
	StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)
	SetWeaponDamageModifier("WEAPON_BAT",0.25)
	SetWeaponDamageModifier("WEAPON_KATANA",0.25)
	SetWeaponDamageModifier("WEAPON_HAMMER",0.25)
	SetWeaponDamageModifier("WEAPON_WRENCH",0.25)
	SetWeaponDamageModifier("WEAPON_UNARMED",0.25)
	SetWeaponDamageModifier("WEAPON_HATCHET",0.25)
	SetWeaponDamageModifier("WEAPON_CROWBAR",0.25)
	SetWeaponDamageModifier("WEAPON_MACHETE",0.25)
	SetWeaponDamageModifier("WEAPON_POOLCUE",0.25)
	SetWeaponDamageModifier("WEAPON_KNUCKLE",0.25)
	SetWeaponDamageModifier("WEAPON_GOLFCLUB",0.25)
	SetWeaponDamageModifier("WEAPON_BATTLEAXE",0.25)
	SetWeaponDamageModifier("WEAPON_SWITCHBLADE",0.0)
	SetWeaponDamageModifier("WEAPON_FLASHLIGHT",0.25)
	SetWeaponDamageModifier("WEAPON_NIGHTSTICK",0.35)
	SetWeaponDamageModifier("WEAPON_SMOKEGRENADE",0.0)
	SetWeaponDamageModifier("WEAPON_STONE_HATCHET",0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPICKUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePickups(Pid)
	local Pickups = {
		`PICKUP_AMMO_BULLET_MP`,
		`PICKUP_AMMO_FIREWORK`,
		`PICKUP_AMMO_FIREWORK_MP`,
		`PICKUP_AMMO_FLAREGUN`,
		`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,
		`PICKUP_AMMO_HOMINGLAUNCHER`,
		`PICKUP_AMMO_MG`,
		`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,
		`PICKUP_AMMO_PISTOL`,
		`PICKUP_AMMO_RIFLE`,
		`PICKUP_AMMO_RPG`,
		`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,
		`PICKUP_AMMO_SNIPER`,
		`PICKUP_ARMOUR_STANDARD`,
		`PICKUP_CAMERA`,
		`PICKUP_CUSTOM_SCRIPT`,
		`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,
		`PICKUP_HEALTH_STANDARD`,
		`PICKUP_MONEY_CASE`,
		`PICKUP_MONEY_DEP_BAG`,
		`PICKUP_MONEY_MED_BAG`,
		`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,
		`PICKUP_MONEY_SECURITY_CASE`,
		`PICKUP_MONEY_VARIABLE`,
		`PICKUP_MONEY_WALLET`,
		`PICKUP_PARACHUTE`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
		`PICKUP_PORTABLE_PACKAGE`,
		`PICKUP_SUBMARINE`,
		`PICKUP_VEHICLE_ARMOUR_STANDARD`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE`,
		`PICKUP_VEHICLE_HEALTH_STANDARD`,
		`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
		`PICKUP_VEHICLE_MONEY_VARIABLE`,
		`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
		`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
		`PICKUP_VEHICLE_WEAPON_GRENADE`,
		`PICKUP_VEHICLE_WEAPON_MICROSMG`,
		`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,
		`PICKUP_VEHICLE_WEAPON_PISTOL50`,
		`PICKUP_VEHICLE_WEAPON_SAWNOFF`,
		`PICKUP_VEHICLE_WEAPON_SMG`,
		`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_ADVANCEDRIFLE`,
		`PICKUP_WEAPON_APPISTOL`,
		`PICKUP_WEAPON_ASSAULTRIFLE`,
		`PICKUP_WEAPON_ASSAULTRIFLE_MK2`,
		`PICKUP_WEAPON_ASSAULTSHOTGUN`,
		`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,
		`PICKUP_WEAPON_BAT`,
		`PICKUP_WEAPON_BATTLEAXE`,
		`PICKUP_WEAPON_BOTTLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE_MK2`,
		`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,
		`PICKUP_WEAPON_CARBINERIFLE_MK2`,
		`PICKUP_WEAPON_COMBATMG`,
		`PICKUP_WEAPON_COMBATMG_MK2`,
		`PICKUP_WEAPON_COMBATPDW`,
		`PICKUP_WEAPON_COMBATPISTOL`,
		`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,
		`PICKUP_WEAPON_CROWBAR`,
		`PICKUP_WEAPON_DAGGER`,
		`PICKUP_WEAPON_DBSHOTGUN`,
		`PICKUP_WEAPON_DOUBLEACTION`,
		`PICKUP_WEAPON_FIREWORK`,
		`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,
		`PICKUP_WEAPON_GOLFCLUB`,
		`PICKUP_WEAPON_GRENADE`,
		`PICKUP_WEAPON_GRENADELAUNCHER`,
		`PICKUP_WEAPON_GUSENBERG`,
		`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,
		`PICKUP_WEAPON_HEAVYPISTOL`,
		`PICKUP_WEAPON_HEAVYSHOTGUN`,
		`PICKUP_WEAPON_HEAVYSNIPER`,
		`PICKUP_WEAPON_HEAVYSNIPER_MK2`,
		`PICKUP_WEAPON_HOMINGLAUNCHER`,
		`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,
		`PICKUP_WEAPON_MACHETE`,
		`PICKUP_WEAPON_MACHINEPISTOL`,
		`PICKUP_WEAPON_MARKSMANPISTOL`,
		`PICKUP_WEAPON_MARKSMANRIFLE`,
		`PICKUP_WEAPON_MARKSMANRIFLE_MK2`,
		`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,
		`PICKUP_WEAPON_MINIGUN`,
		`PICKUP_WEAPON_MINISMG`,
		`PICKUP_WEAPON_MOLOTOV`,
		`PICKUP_WEAPON_MUSKET`,
		`PICKUP_WEAPON_NIGHTSTICK`,
		`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,
		`PICKUP_WEAPON_PISTOL`,
		`PICKUP_WEAPON_PISTOL_MK2`,
		`PICKUP_WEAPON_PISTOL50`,
		`PICKUP_WEAPON_POOLCUE`,
		`PICKUP_WEAPON_PROXMINE`,
		`PICKUP_WEAPON_PUMPSHOTGUN`,
		`PICKUP_WEAPON_PUMPSHOTGUN_MK2`,
		`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,
		`PICKUP_WEAPON_REVOLVER_MK2`,
		`PICKUP_WEAPON_RPG`,
		`PICKUP_WEAPON_SAWNOFFSHOTGUN`,
		`PICKUP_WEAPON_SMG`,
		`PICKUP_WEAPON_SMG_MK2`,
		`PICKUP_WEAPON_SMOKEGRENADE`,
		`PICKUP_WEAPON_SNIPERRIFLE`,
		`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SNSPISTOL_MK2`,
		`PICKUP_WEAPON_SPECIALCARBINE`,
		`PICKUP_WEAPON_SPECIALCARBINE_MK2`,
		`PICKUP_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_STONE_HATCHET`,
		`PICKUP_WEAPON_STUNGUN`,
		`PICKUP_WEAPON_SWITCHBLADE`,
		`PICKUP_WEAPON_VINTAGEPISTOL`,
		`PICKUP_WEAPON_WRENCH`,
		`PICKUP_WEAPON_RAYCARBINE`
	}

	for Number = 1,#Pickups do
		RemoveAllPickupsOfType(Pickups[Number])
		ToggleUsePickupsForPlayer(Pid,Pickups[Number],false)
	end
end