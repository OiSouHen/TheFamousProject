-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSWEATHER
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassWeather(Type)
	local Weather = "Limpo"

	if Type == "EXTRASUNNY" then
		Weather = "Ensolarado"
	elseif Type == "CLEAR" then
		Weather = "Limpo"
	elseif Type == "CLOUDS" then
		Weather = "Nublado"
	elseif Type == "SMOG" then
		Weather = "Poluído"
	elseif Type == "FOGGY" then
		Weather = "Enevoado"
	elseif Type == "OVERCAST" then
		Weather = "Nublado"
	elseif Type == "RAIN" then
		Weather = "Chuvoso"
	elseif Type == "THUNDER" then
		Weather = "Tempestuoso"
	elseif Type == "CLEARING" then
		Weather = "Instável"
	elseif Type == "NEUTRAL" then
		Weather = "Neutro"
	elseif Type == "SNOW" then
		Weather = "Nevando"
	elseif Type == "BLIZZARD" then
		Weather = "Nevasca"
	elseif Type == "SNOWLIGHT" then
		Weather = "Nevasca"
	elseif Type == "XMAS" then
		Weather = "Nevando"
	elseif Type == "HALLOWEEN" then
		Weather = "Apocalíptico"
	end

	return Weather
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassWork(Work)
	local Result = "Nenhum"

	if Work == "Bus" then
		Result = "Motorista de Ônibus"
	elseif Work == "Taxi" then
		Result = "Taxista"
	elseif Work == "Transporter" then
		Result = "Transportador de Valores"
	elseif Work == "Lumberman" then
		Result = "Lenhador"
	elseif Work == "Fruitman" then
		Result = "Agricultor"
	elseif Work == "Milkman" then
		Result = "Entregador de Leite"
	elseif Work == "Trucker" then
		Result = "Caminhoneiro"
	elseif Work == "Garbageman" then
		Result = "Lixeiro"
	elseif Work == "Tows" then
		Result = "Rebocador"
	elseif Work == "Diver" then
		Result = "Mergulhador"
	elseif Work == "PostOp" then
		Result = "Correios"
	elseif Work == "Cleaner" then
		Result = "Jardineiro"
	elseif Work == "Farmer" then
		Result = "Fazendeiro"
	elseif Work == "Minerman" then
		Result = "Minerador"
	elseif Work == "Hunter" then
		Result = "Caçador"
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassCategory(Number)
	local Level = 1

	if Number >= 250 and Number <= 500 then
		Level = 2
	elseif Number >= 501 and Number <= 1000 then
		Level = 3
	elseif Number >= 1001 and Number <= 2000 then
		Level = 4
	elseif Number >= 2001 and Number <= 3500 then
		Level = 5
	elseif Number >= 3501 and Number <= 5000 then
		Level = 6
	elseif Number >= 5001 and Number <= 7500 then
		Level = 7
	elseif Number >= 7501 and Number <= 10000 then
		Level = 8
	elseif Number >= 10001 and Number <= 15000 then
		Level = 9
	elseif Number >= 15001 then
		Level = 10
	end

	return Level
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDCOLOR
-----------------------------------------------------------------------------------------------------------------------------------------
function RandColor()
	return math.random(255)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANGUINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Sanguine(Number)
	local Types = { "A+","B+","A-","B-" }

	return Types[Number]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLE.MAXN
-----------------------------------------------------------------------------------------------------------------------------------------
function table.maxn(Table)
	local Number = 0

	for Index,_ in pairs(Table) do
		local Next = tonumber(Index)
		if Next and Next > Number then
			Number = Next
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUNTTALBE
-----------------------------------------------------------------------------------------------------------------------------------------
function CountTable(Table)
	local Number = 0

	for _ in pairs(Table) do
		Number = Number + 1
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODULE
-----------------------------------------------------------------------------------------------------------------------------------------
local modules = {}
function module(Resource,Patch)
	if not Patch then
		Patch = Resource
		Resource = "vrp"
	end

	local Key = Resource..Patch
	local Module = modules[Key]
	if Module then
		return Module
	else
		local File = LoadResourceFile(Resource,Patch..".lua")
		if File then
			local Float = load(File,Resource.."/"..Patch..".lua")
			if Float then
				local Accept,Result = xpcall(Float,debug["traceback"])
				if Accept then
					modules[Key] = Result

					return Result
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAIT
-----------------------------------------------------------------------------------------------------------------------------------------
local function wait(self)
	local rets = Citizen.Await(self.p)
	if not rets then
		if self.r then
			rets = self.r
		end
	end

	return table.unpack(rets,1,table.maxn(rets))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARETURN
-----------------------------------------------------------------------------------------------------------------------------------------
local function areturn(self,...)
	self.r = {...}
	self.p:resolve(self.r)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function async(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = wait, p = promise.new() },{ __call = areturn })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEINT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseInt(Number,Force)
	Number = tonumber(Number) or 0
	if Force and Number <= 0 then
		Number = 1
	end

	return math.floor(Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHOLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Whole(Value,Force)
	return parseInt(Value,Force)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANITIZESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function sanitizeString(String,Characteres)
	return String:gsub("[^"..Characteres.."]","")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITSTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(Full,Symbol)
	local Table = {}

	if not Symbol then
		Symbol = "-"
	end

	for Full in string.gmatch(Full,"([^"..Symbol.."]+)") do
		Table[#Table + 1] = Full
	end

	return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITONE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitOne(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITBOOLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitBoolean(Name,String,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1] == String and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITTWO
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitTwo(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[2]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITUNIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitUnique(Item)
	local Name = splitString(Item,"-")

	return Name[1]..":"..Name[3]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIMIZE
-----------------------------------------------------------------------------------------------------------------------------------------
function Optimize(Number)
	return math.ceil(Number * 100) / 100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOTTED
-----------------------------------------------------------------------------------------------------------------------------------------
function Dotted(Value)
	local Value = parseInt(Value)
	local Left,Number,Right = string.match(Value,"^([^%d]*%d)(%d*)(.-)$")
	return Left..(Number:reverse():gsub("(%d%d%d)","%1."):reverse())..Right
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CompleteTimers(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("<b>%d Dias</b>, <b>%d Horas</b>, <b>%d Minutos</b>",Days,Hours,Minutes)
	elseif Hours > 0 then
		return string.format("<b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",Hours,Minutes,Seconds)
	elseif Minutes > 0 then
		return string.format("<b>%d Minutos</b> e <b>%d Segundos</b>",Minutes,Seconds)
	elseif Seconds > 0 then
		return string.format("<b>%d Segundos</b>",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIMALTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function MinimalTimers(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("%d Dias e %d Horas",Days,Hours)
	elseif Hours > 0 then
		return string.format("%d Horas e %d Minutos",Hours,Minutes)
	elseif Minutes > 0 then
		return string.format("%d Minutos",Minutes)
	else
		return string.format("%d Segundos",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERZERO
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberZero(Number)
	if Number <= 9 then
		Number = "0"..Number
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERPOKEMON
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberPokemon(Number)
	if Number <= 9 then
		Number = "00"..Number
	elseif Number >= 10 and Number <= 99 then
		Number = "0"..Number
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberTimers(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	return NumberZero(Days)..":"..NumberZero(Hours)..":"..NumberZero(Minutes)..":"..NumberZero(Seconds)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERDAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberDays(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	return NumberZero(Hours)..":"..NumberZero(Minutes)..":"..NumberZero(Seconds)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERHOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberHours(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	return NumberZero(Minutes)..":"..NumberZero(Seconds)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMBERMINUTES
-----------------------------------------------------------------------------------------------------------------------------------------
function NumberMinutes(Seconds)
	local Seconds = parseInt(Seconds)
	local Minutes = math.floor(Seconds / 60)

	return NumberZero(Minutes)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONE
-----------------------------------------------------------------------------------------------------------------------------------------
function Bone(Number)
	return Bones[Number] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local BlockItem = {
	["anchovy"] = true,
	["catfish"] = true,
	["herring"] = true,
	["orangeroughy"] = true,
	["salmon"] = true,
	["sardine"] = true,
	["smallshark"] = true,
	["smalltrout"] = true,
	["yellowperch"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = true,
	["milkshake"] = true,
	["milkshakepeanut"] = true,
	["cappuccino"] = true,
	["applelove"] = true,
	["guarananatural"] = true,
	["water"] = true,
	["coffee"] = true,
	["coffeemilk"] = true,
	["energetic"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["friesbacon"] = true,
	["soda"] = true,
	["cookies"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["acerolajuice"] = true,
	["passionjuice"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["hamburger3"] = true,
	["onionrings"] = true,
	["chickenfries"] = true,
	["pizzamozzarella"] = true,
	["pizzabanana"] = true,
	["pizzachocolate"] = true,
	["calzone"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function BlockChest(Item)
	local Item = SplitOne(Item)

	if BlockItem[Item] then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERCENTAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Percentage(Number,Percent)
	local Number = parseInt(Number)
	local Percent = parseInt(Percent)

	return parseInt(Number * (Percent / 100))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDPERCENTAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function RandPercentage(Table)
	local PoolSize = 0
	for Number = 1,#Table do
		PoolSize = PoolSize + Table[Number]["Chance"]
	end

	local Selected = math.random(1,PoolSize)
	for Index,v in pairs(Table) do
		Selected = Selected - v["Chance"]
		if v["Min"] and v["Max"] then
			Table[Index]["Valuation"] = math.random(v["Min"],v["Max"])
		end

		if (Selected <= 0) then
			return Table[Index]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateString(Format)
	local Message = ""
	local LenByte = string.byte("A")
	local NumByte = string.byte("0")

	for Number = 1,#Format do
		local Lenght = string.sub(Format,Number,Number)
    	if Lenght == "D" then
    		Message = Message..string.char(NumByte + math.random(0,9))
		elseif Lenght == "L" then
			Message = Message..string.char(LenByte + math.random(0,25))
		else
			Message = Message..Lenght
		end
	end

	return Message
end