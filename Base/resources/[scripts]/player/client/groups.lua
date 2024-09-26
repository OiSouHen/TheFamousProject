-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Ballas", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_BALLAS"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Families", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_FAMILY"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Vagos", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_MEXICAN"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Marabunta", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_MARABUNTE"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Aztecas", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_MEXICAN"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("TheSouth", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_LOST"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("TheNorth", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_LOST"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Policia", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("COP"))

	SetRelationshipBetweenGroups(1, GetHashKey("ARMY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("ARMY"))

	SetRelationshipBetweenGroups(1, GetHashKey("PRISONER"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("PRISONER"))
end)