-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Weapon = ""
local Skins = {}
local Objects = {}
TakeWeapon = false
StoreWeapon = false
local Reloaded = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SKINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Skins")
AddEventHandler("inventory:Skins",function(Table)
	Skins = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	["WEAPON_KATANA"] = {
		["Bone"] = 24818,
		["x"] = 0.27,
		["y"] = -0.15,
		["z"] = 0.22,
		["RotX"] = 0.0,
		["RotY"] = 220.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_katana"
	},
	["WEAPON_CARBINERIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle"
	},
	["WEAPON_M4A4"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_m4a4"
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbineriflemk2"
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_advancedrifle"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpuprifle"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpupriflemk2"
	},
	["WEAPON_SPECIALCARBINE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbine"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbinemk2"
	},
	["WEAPON_MUSKET"] = {
		["Bone"] = 24818,
		["x"] = -0.1,
		["y"] = -0.14,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 0.8,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_musket"
	},
	["WEAPON_BAT"] = {
		["Bone"] = 24818,
		["x"] = -0.18,
		["y"] = -0.18,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 90.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_bat"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgun"
	},
	["WEAPON_RPG"] = {
		["Bone"] = 24818,
		["x"] = -0.20,
		["y"] = -0.22,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,2.5,
		["Model"] = "w_lr_rpg"
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgunmk2"
	},
	["WEAPON_SMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smg"
	},
	["WEAPON_SMG_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smgmk2"
	},
	["WEAPON_COMPACTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle_smg"
	},
	["WEAPON_ASSAULTSMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.07,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_assaultsmg"
	},
	["WEAPON_HEAVYRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_heavyrifleh"
	},
	["WEAPON_TACTICALRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle_reh"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_GUSENBERG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_gusenberg"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveWeapon")
AddEventHandler("inventory:RemoveWeapon",function(Name)
	local Name = SplitOne(Name)

	if Objects[Name] then
		TriggerServerEvent("DeleteObject",0,Name)
		Objects[Name] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CREATEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CreateWeapon")
AddEventHandler("inventory:CreateWeapon",function(Name)
	local Name = SplitOne(Name)
	if Config[Name] and not Objects[Name] then
		local Weapon = false
		local Ped = PlayerPedId()
		local Config = Config[Name]
		local Coords = GetEntityCoords(Ped)
		local Bone = GetPedBoneIndex(Ped,Config["Bone"])

		if Skins[Name] then
			local Hash = GetHashKey(Skins[Name])
			Weapon = GetWeaponComponentTypeModel(Hash)
		end

		local Network = vRPS.CreateObject(Config["Model"],Coords["x"],Coords["y"],Coords["z"],Name,Weapon)
		if Network then
			Objects[Name] = LoadNetwork(Network)
			if Objects[Name] then
				AttachEntityToEntity(Objects[Name],Ped,Bone,Config["x"],Config["y"],Config["z"],Config["RotX"],Config["RotY"],Config["RotZ"],true,true,false,true,2,true)
				SetEntityCompletelyDisableCollision(Objects[Name],false,true)
				SetModelAsNoLongerNeeded(Config["Model"])
				SetEntityLodDist(Objects[Name],0xFFFF)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadAnim("rcmjosh4")
	LoadAnim("weapons@pistol@")

	while true do
		local TimeDistance = 999
		if Actived and Weapon ~= "" then
			TimeDistance = 10

			local Ped = PlayerPedId()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

			if GetGameTimer() >= Reloaded and IsPedReloading(Ped) then
				vSERVER.PreventWeapons(Weapon,Ammo)
				Reloaded = GetGameTimer() + 100
			end

			if Ammo <= 0 or (Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)) or IsPedSwimming(Ped) then
				if Types ~= "" then
					vSERVER.RemoveThrowing(Types)
				else
					vSERVER.PreventWeapons(Weapon,Ammo)
				end

				TriggerEvent("inventory:CleanWeapons")
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(Item)
	local Name = SplitOne(Item)

	if Weapon == Name then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		if not vSERVER.VerifyWeapon(Weapon,Ammo) then
			TriggerEvent("inventory:CleanWeapons")
		end
	else
		vSERVER.VerifyWeapon(Name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CleanWeapons",function()
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

		if vSERVER.PreventWeapons(Weapon,Ammo) then
			TriggerEvent("inventory:CreateWeapon",Weapon)
		end

		TriggerEvent("hud:Weapon",false)
		RemoveAllPedWeapons(Ped,true)
		TriggerEvent("Weapon","")

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ReturnWeapon()
	return Weapon ~= "" and Weapon or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWeapon(Hash)
	return Weapon == Hash and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVECOMPONENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GiveComponent(Component)
	GiveWeaponComponentToPed(PlayerPedId(),Weapon,Component)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TakeWeapon(Name,Ammo,Components,Type,Skin)
	if not TakeWeapon then
		if not Ammo then
			Ammo = 0
		end

		if Ammo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]:set("Cancel",true,true)

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			TaskPlayAnim(Ped,"rcmjosh4","josh_leadout_cop2",8.0,8.0,-1,48,1,0,0,0)

			Wait(200)

			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)

			if Skin then
				GiveWeaponComponentToPed(Ped,Weapon,Skin)
			end

			if Components then
				for Item,_ in pairs(Components) do
					local Comp = WeaponAttach(Item,Weapon)
					GiveWeaponComponentToPed(Ped,Weapon,Comp)
				end
			end

			Wait(300)

			ClearPedTasks(Ped)
		else
			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)

			if Skin then
				GiveWeaponComponentToPed(Ped,Weapon,Skin)
			end

			if Components then
				for Item,_ in pairs(Components) do
					local Comp = WeaponAttach(Item,Weapon)
					GiveWeaponComponentToPed(Ped,Weapon,Comp)
				end
			end
		end

		if Type then
			Types = Type
		end

		TakeWeapon = false
		LocalPlayer["state"]:set("Cancel",false,true)

		if WeaponAmmo(Weapon) then
			TriggerEvent("hud:Weapon",true,Weapon)
		end

		if (IsPedInAnyVehicle(Ped) and not ItemVehicle(Weapon)) or vSERVER.CheckExistWeapons(Weapon) then
			TriggerEvent("inventory:CleanWeapons")
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StoreWeapon()
	if not StoreWeapon and Weapon ~= "" then
		StoreWeapon = true

		local Lasted = Weapon
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		LocalPlayer["state"]:set("Cancel",true,true)

		if not IsPedInAnyVehicle(Ped) then
			TaskPlayAnim(Ped,"weapons@pistol@","aim_2_holster",8.0,8.0,-1,48,1,0,0,0)

			Wait(450)

			ClearPedTasks(Ped)
		end

		StoreWeapon = false
		TriggerEvent("inventory:CleanWeapons")
		LocalPlayer["state"]:set("Cancel",false,true)

		return true,Ammo,Lasted
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InfoWeapon(Type)
	local Ammo = 0

	if Weapon ~= "" then
		Ammo = GetAmmoInPedWeapon(PlayerPedId(),Weapon)
	end

	return Weapon,Ammo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Reloading(Hash,Ammo)
	AddAmmoToPed(PlayerPedId(),Hash,Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Parachute()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
end