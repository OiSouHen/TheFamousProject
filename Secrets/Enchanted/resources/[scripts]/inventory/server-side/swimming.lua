-----------------------------------------------------------------------------------------------------------------------------------------
-- SWIMMING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Swimming()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inventory = vRP.Inventory(Passport)
		for Slot,v in pairs(Inventory) do
			local Name = ItemLostWater(v["item"])
			if Name and vRP.TakeItem(Passport,v["item"],v["amount"],false,Slot) and type(Name) == "string" then
				vRP.GenerateItem(Passport,Name,v["amount"])
			end
		end
	end
end