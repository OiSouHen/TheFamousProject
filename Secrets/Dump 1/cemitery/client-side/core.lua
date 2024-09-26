-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = nil
local Selected = 1
local Checkouts = 0
local Init = vec4(-1741.52,-219.85,56.14,255.12)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local Locates = {
	vec4(-1731.62,-287.05,49.84,280.63),
	vec4(-1740.59,-298.19,48.48,272.13),
	vec4(-1747.95,-299.18,47.8,283.47),
	vec4(-1757.38,-284.38,47.38,283.47),
	vec4(-1782.43,-259.35,47.47,325.99),
	vec4(-1784.46,-257.43,47.35,323.15),
	vec4(-1798.49,-252.72,44.72,311.82),
	vec4(-1804.53,-265.8,43.78,320.32),
	vec4(-1749.27,-277.75,48.86,286.3),
	vec4(-1766.21,-260.46,49.25,331.66),
	vec4(-1794.43,-236.91,49.03,297.64),
	vec4(-1795.91,-232.15,49.1,280.63),
	vec4(-1769.85,-241.41,51.9,325.99),
	vec4(-1760.79,-247.41,51.93,325.99),
	vec4(-1758.88,-248.9,51.88,325.99),
	vec4(-1751.01,-254.55,51.43,328.82),
	vec4(-1767.95,-221.72,53.75,311.82),
	vec4(-1769.96,-219.62,53.67,314.65),
	vec4(-1742.21,-225.62,55.47,351.5),
	vec4(-1746.02,-224.94,55.12,343.0),
	vec4(-1749.32,-223.35,55.03,340.16),
	vec4(-1759.25,-209.92,56.14,317.49),
	vec4(-1757.02,-204.26,56.78,314.65),
	vec4(-1759.04,-202.21,56.65,314.65),
	vec4(-1731.33,-225.27,56.18,357.17),
	vec4(-1714.78,-234.4,55.27,0.0),
	vec4(-1624.73,-181.54,55.72,34.02),
	vec4(-1622.79,-180.21,55.77,31.19),
	vec4(-1639.93,-182.82,55.86,34.02),
	vec4(-1637.72,-165.61,56.9,31.19),
	vec4(-1642.7,-169.04,57.09,31.19),
	vec4(-1640.75,-154.23,57.63,119.06),
	vec4(-1642.1,-152.1,57.74,121.89),
	vec4(-1661.1,-137.4,59.46,110.56),
	vec4(-1659.54,-140.67,59.01,116.23),
	vec4(-1655.47,-160.83,57.47,121.89),
	vec4(-1656.76,-158.86,57.54,124.73),
	vec4(-1683.56,-137.36,59.78,99.22),
	vec4(-1682.63,-140.37,59.75,104.89),
	vec4(-1681.6,-143.09,59.41,104.89)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	"g_m_y_mexgang_01","g_m_y_lost_01","u_m_o_finguru_01","g_m_y_salvagoon_01","g_f_y_lost_01","a_m_y_business_02","s_m_m_postal_01",
	"g_m_y_korlieut_01","s_m_m_trucker_01","g_m_m_armboss_01","mp_m_shopkeep_01","ig_dale","u_m_y_baygor","cs_gurk","ig_casey",
	"s_m_y_garbage","a_m_o_ktown_01","a_f_y_eastsa_03"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("WorkCemitery",Init["xyz"],0.75,0.75,{
		name = "WorkCemitery",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.25,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEMITERY:INITBODY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("cemitery:initBody",function()
	if Peds then
		if Selected then
			exports["target"]:RemCircleZone("Cemitery:"..Selected)
		end

		if DoesEntityExist(Peds) then
			DeleteEntity(Peds)
		end

		Peds = nil
	end

	if not Peds then
		Checkouts = 0
		local Hash = math.random(#List)
		Selected = math.random(#Locates)

		if LoadModel(List[Hash]) then
			Peds = CreatePed(4,List[Hash],Locates[Selected]["x"],Locates[Selected]["y"],Locates[Selected]["z"] - 1,Locates[Selected]["w"] - 180.0,false,false)

			SetPedArmour(Peds,100)
			SetEntityInvincible(Peds,true)
			FreezeEntityPosition(Peds,true)
			SetBlockingOfNonTemporaryEvents(Peds,true)

			SetModelAsNoLongerNeeded(List[Hash])

			if LoadAnim("dead") then
				TaskPlayAnim(Peds,"dead","dead_a",8.0,8.0,-1,1,1,0,0,0)
			end

			exports["target"]:AddCircleZone("Cemitery:"..Selected,vec3(Locates[Selected]["x"],Locates[Selected]["y"],Locates[Selected]["z"] - 0.75),0.5,{
				name = "Cemitery:"..Selected,
				heading = 0.0,
				useZ = true
			},{
				Distance = 1.25,
				options = {
					{
						event = "cemitery:Body",
						label = "Roubar Pertences",
						tunnel = "client"
					}
				}
			})

			TriggerEvent("Notify","Observação","Parece que estão efetuando uma limpeza em um dos túmulos, guarde essa informação e veja se você encontra alguns objetos de valor.","default",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEMITERY:BODY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("cemitery:Body",function()
	TriggerServerEvent("inventory:Products","Cemitery")
	Checkouts = Checkouts + 1

	if Checkouts >= 5 then
		exports["target"]:RemCircleZone("Cemitery:"..Selected)
		Selected = nil
	end
end)