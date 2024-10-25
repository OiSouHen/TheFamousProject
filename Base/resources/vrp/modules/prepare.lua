-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT * FROM characters WHERE id = @id")
vRP.Prepare("characters/Phone","SELECT id FROM characters WHERE Phone = @Phone")
vRP.Prepare("characters/Delete","UPDATE characters SET Deleted = 1 WHERE id = @Passport")
vRP.Prepare("characters/SetSkin","UPDATE characters SET Skin = @Skin WHERE id = @Passport")
vRP.Prepare("characters/SetBadge","UPDATE characters SET Badge = @Badge WHERE id = @Passport")
vRP.Prepare("characters/UpdatePhone","UPDATE characters SET Phone = @Phone WHERE id = @Passport")
vRP.Prepare("characters/AddBank","UPDATE characters SET Bank = Bank + @Bank WHERE id = @Passport")
vRP.Prepare("characters/RemBank","UPDATE characters SET Bank = Bank - @Bank WHERE id = @Passport")
vRP.Prepare("characters/UpdateAvatar","UPDATE characters SET Avatar = @Avatar WHERE id = @Passport")
vRP.Prepare("characters/AddLikes","UPDATE characters SET Likes = (Likes + @Likes) WHERE id = @Passport")
vRP.Prepare("characters/RemLikes","UPDATE characters SET Likes = (Likes - @Likes) WHERE id = @Passport")
vRP.Prepare("characters/AddUnlikes","UPDATE characters SET Unlikes = (Unlikes + @Unlikes) WHERE id = @Passport")
vRP.Prepare("characters/RemUnlikes","UPDATE characters SET Unlikes = (Unlikes - @Unlikes) WHERE id = @Passport")
vRP.Prepare("characters/UserLicense","SELECT * FROM characters WHERE id = @id and License = @License")
vRP.Prepare("characters/Characters","SELECT * FROM characters WHERE License = @License and Deleted = 0")
vRP.Prepare("characters/LastLogin","UPDATE characters SET Login = UNIX_TIMESTAMP() WHERE id = @Passport")
vRP.Prepare("characters/InsertPrison","UPDATE characters SET Prison = (Prison + @Prison) WHERE id = @Passport")
vRP.Prepare("characters/ReducePrison","UPDATE characters SET Prison = (Prison - @Prison) WHERE id = @Passport")
vRP.Prepare("characters/CleanPrison","UPDATE characters SET Prison = 0 WHERE id = @Passport")
vRP.Prepare("characters/Count","SELECT COUNT(License) AS qtd FROM characters WHERE License = @License and Deleted = 0")
vRP.Prepare("characters/UpdateName","UPDATE characters SET Name = @Name, Lastname = @Lastname WHERE id = @Passport")
vRP.Prepare("characters/LastCharacter","SELECT id FROM characters WHERE License = @License ORDER BY id DESC LIMIT 1")
vRP.Prepare("characters/NewCharacter","INSERT INTO characters(License,Name,Lastname,Sex,Skin,Phone,Blood,Created) VALUES(@License,@Name,@Lastname,@Sex,@Skin,@Phone,@Blood,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/All","SELECT * FROM accounts")
vRP.Prepare("accounts/Account","SELECT * FROM accounts WHERE License = @License")
vRP.Prepare("accounts/NewAccount","INSERT INTO accounts(License) VALUES(@License)")
vRP.Prepare("accounts/Clean","UPDATE accounts SET Whitelist = 0 WHERE License = @License")
vRP.Prepare("accounts/SetWhitelist","UPDATE accounts SET Whitelist = @Whitelist WHERE id = @id")
vRP.Prepare("accounts/SetPremium","UPDATE accounts SET Premium = @Premium WHERE License = @License")
vRP.Prepare("accounts/UpgradePremium","UPDATE accounts SET Premium = Premium + 2592000 WHERE License = @License")
vRP.Prepare("accounts/AddGemstone","UPDATE accounts SET Gemstone = Gemstone + @Gemstone WHERE License = @License")
vRP.Prepare("accounts/UpdateCharacters","UPDATE accounts SET Characters = Characters + 1 WHERE License = @License")
vRP.Prepare("accounts/RemoveGemstone","UPDATE accounts SET Gemstone = Gemstone - @Gemstone WHERE License = @License")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT * FROM playerdata WHERE Passport = @Passport AND Name = @Name")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,Name,Information) VALUES(@Passport,@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT * FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata(Name,Information) VALUES(@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/All","SELECT * FROM vehicles")
vRP.Prepare("vehicles/Drift","UPDATE vehicles SET Drift = 1 WHERE Plate = @Plate")
vRP.Prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE Plate = @Plate")
vRP.Prepare("vehicles/UserVehicles","SELECT * FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/paymentArrest","UPDATE vehicles SET Arrest = 0 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET Plate = @Plate WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET Rental = Rental + 2592000 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/arrestVehicles","UPDATE vehicles SET Arrest = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET Tax = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET Rental = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(Passport,Vehicle,Plate,Weight,Work,Tax) VALUES(@Passport,@Vehicle,@Plate,@Weight,@Work,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(Passport,Vehicle,Plate,Weight,Work,Rental,Tax) VALUES(@Passport,@Vehicle,@Plate,@Weight,@Work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET Engine = @Engine, Body = @Body, Health = @Health, Fuel = @Fuel, Doors = @Doors, Windows = @Windows, Tyres = @Tyres, Brakes = @Brakes, Nitro = @Nitro WHERE Passport = @Passport AND Vehicle = @Vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds/GetBanned","SELECT * FROM banneds WHERE License = @License")
vRP.Prepare("banneds/RemoveBanned","DELETE FROM banneds WHERE License = @License")
vRP.Prepare("banneds/GetToken","SELECT * FROM banneds WHERE Token = @Token LIMIT 1")
vRP.Prepare("banneds/InsertToken","INSERT INTO banneds(License,Token) VALUES(@License,@Token)")
vRP.Prepare("banneds/InsertBanned","INSERT INTO banneds(License,Token,Time) VALUES(@License,@Token,UNIX_TIMESTAMP() + 86400 * @Time)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT * FROM chests WHERE Name = @Name")
vRP.Prepare("chests/AddChests","INSERT IGNORE INTO chests(Name,Permission) VALUES(@Name,@Name)")
vRP.Prepare("chests/UpdateWeight","UPDATE chests SET Weight = (Weight + (10 * @Multiplier)), Slots = (Slots + (5 * @Multiplier)) WHERE Name = @Name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("Races/User","SELECT * FROM races WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("Races/Consult","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 5")
vRP.Prepare("Races/Insert","INSERT INTO races(Race,Passport,Vehicle,Points) VALUES(@Race,@Passport,@Vehicle,@Points)")
vRP.Prepare("Races/Update","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Passport = @Passport")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fidentity/Result","SELECT * FROM fidentity WHERE id = @id")
vRP.Prepare("fidentity/GetIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.Prepare("fidentity/NewIdentity","INSERT INTO fidentity(Name,Lastname,Blood) VALUES(@Name,@Lastname,@Blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warehouse/All","SELECT * FROM warehouse")
vRP.Prepare("warehouse/Sell","DELETE FROM warehouse WHERE Name = @Name")
vRP.Prepare("warehouse/Informations","SELECT * FROM warehouse WHERE Name = @Name")
vRP.Prepare("warehouse/Password","UPDATE warehouse SET Password = @Password WHERE Name = @Name")
vRP.Prepare("warehouse/Transfer","UPDATE warehouse SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("warehouse/Acess","SELECT * FROM warehouse WHERE Name = @Name AND Password = @Password")
vRP.Prepare("warehouse/Tax","UPDATE warehouse SET Tax = UNIX_TIMESTAMP() + 2592000 WHERE Name = @Name")
vRP.Prepare("warehouse/Upgrade","UPDATE warehouse SET Weight = Weight + (10 * @Multiplier) WHERE Name = @Name")
vRP.Prepare("warehouse/Buy","INSERT INTO warehouse(Name,Password,Passport,Tax) VALUES(@Name,@Password,@Passport,UNIX_TIMESTAMP() + 2592000)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT * FROM propertys")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Exist","SELECT * FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Serial","SELECT * FROM propertys WHERE Serial = @Serial")
vRP.Prepare("propertys/Garages","SELECT * FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/AllUser","SELECT * FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Item","UPDATE propertys SET Item = (Item + 1) WHERE Name = @Name")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @Garage WHERE Name = @Name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @Serial WHERE Name = @Name")
vRP.Prepare("propertys/Count","SELECT COUNT(Passport) FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = (Vault + @Weight) WHERE Name = @Name")
vRP.Prepare("propertys/Transfer","UPDATE propertys SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = (Fridge + @Weight) WHERE Name = @Name")
vRP.Prepare("propertys/Check","SELECT * FROM propertys WHERE Name = @Name AND Passport = @Passport")
vRP.Prepare("propertys/Minimals","SELECT * FROM propertys WHERE (Tax + 1296000) <= UNIX_TIMESTAMP()")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = (UNIX_TIMESTAMP() + 2592000) WHERE Name = @Name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys(Name,Interior,Passport,Serial,Vault,Fridge,Tax) VALUES(@Name,@Interior,@Passport,@Serial,@Vault,@Fridge,@Tax)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT * FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines(Passport,Name,Date,Hour,Price,Message) VALUES(@Passport,@Name,@Date,@Hour,@Price,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/List","SELECT * FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Check","SELECT * FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs(Passport,Name,Date,Hour,Price,Message) VALUES(@Passport,@Name,@Date,@Hour,@Price,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Price,Balance,Timeset) VALUES(@Passport,@Type,@Date,@Price,@Balance,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("invoices/Remove","DELETE FROM invoices WHERE id = @id")
vRP.Prepare("invoices/Check","SELECT * FROM invoices WHERE id = @id")
vRP.Prepare("invoices/List","SELECT * FROM invoices WHERE Passport = @Passport")
vRP.Prepare("invoices/Add","INSERT INTO invoices(Passport,Received,Type,Reason,Holder,Price) VALUES(@Passport,@Received,@Type,@Reason,@Holder,@Price)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT * FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments(Passport,Deposit,Last) VALUES(@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = (Deposit + @Price), Last = (UNIX_TIMESTAMP() + 86400) WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = (Monthly + FLOOR((Deposit + Liquid) * 0.005)), Liquid = (Liquid + FLOOR((Deposit + Liquid) * 0.005)), Last = (UNIX_TIMESTAMP() + 86400) WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PANEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("panel/GetInformations","SELECT * FROM panel WHERE name = @name")
vRP.Prepare("panel/DowngradeBank","UPDATE panel SET bank = bank - @Value WHERE name = @name")
vRP.Prepare("panel/UpgradeBank","UPDATE panel SET bank = bank + @Value WHERE name = @name")
vRP.Prepare("panel/GetTransactions","SELECT * FROM paneltransactions WHERE name = @name ORDER BY id DESC LIMIT 12")
vRP.Prepare("panel/InsertTransaction","INSERT INTO paneltransactions (name, Type, Value) VALUES (@name, @Type, @Value)")
vRP.Prepare("panel/UpdateBuff","UPDATE panel SET buff = @buff WHERE name = @name")
vRP.Prepare("panel/SetPremium","UPDATE panel SET premium = @premium WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LB-PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("lb-phone/FindPhone","SELECT * FROM phone_phones WHERE phone_number = @phone")
vRP.Prepare("lb-phone/GetPhone","SELECT * FROM phone_phones WHERE id = @id AND owner = @owner")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("hensa/Playerdata","DELETE FROM playerdata WHERE Information = '[]' OR Information = '{}'")
vRP.Prepare("hensa/Entitydata","DELETE FROM entitydata WHERE Information = '[]' OR Information = '{}'")
vRP.Prepare("hensa/Transactions","DELETE FROM transactions WHERE UNIX_TIMESTAMP() >= Timeset")
vRP.Prepare("hensa/Premium","UPDATE accounts SET Premium = '0' WHERE UNIX_TIMESTAMP() >= Premium")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query("hensa/Premium")
	vRP.Query("hensa/Playerdata")
	vRP.Query("hensa/Entitydata")
	vRP.Query("hensa/Transactions")
end)