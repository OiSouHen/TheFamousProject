-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEVELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Levels = { 0,250,500,1000,2000,3500,5000,7500,10000,15000 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassCategory(Experience)
	local Return = 1

	for Table = 1,#Levels do
		if Experience >= Levels[Table] then
			Return = Table
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLELEVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TableLevel()
	return Levels
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPTYSPACE
-----------------------------------------------------------------------------------------------------------------------------------------
function EmptySpace(Message)
	return Message:gsub("%s+","")
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
	if not rets and self.r then
		rets = self.r
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
	Seconds = Seconds % 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds % 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds % 60

	if Days > 0 then
		if Hours > 0 then
			return string.format("%d Dias e %d Horas",Days,Hours)
		else
			return string.format("%d Dias",Days)
		end
	elseif Hours > 0 then
		if Minutes > 0 then
			return string.format("%d Horas e %d Minutos",Hours,Minutes)
		else
			return string.format("%d Horas",Hours)
		end
	elseif Minutes > 0 then
		if Seconds > 0 then
			return string.format("%d Minutos e %d Segundos",Minutes,Seconds)
		else
			return string.format("%d Minutos",Minutes)
		end
	else
		return string.format("%d Segundos",Seconds)
	end
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE64
-----------------------------------------------------------------------------------------------------------------------------------------
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function Base64(data)
	return ((data:gsub(".",function(x)
		local r, b = "", x:byte()
		for i = 8,1,-1 do
			r = r..(b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
		end

		return r
	end).."0000"):gsub("%d%d%d?%d?%d?%d?",function(x)
		if (#x < 6) then return "" end
		local c = 0
			for i = 1, 6 do
			c = c + (x:sub(i,i) == "1" and 2 ^ (6 - i) or 0)
		end

		return b:sub(c + 1,c + 1)
	end)..({ "","==","=" })[#data % 3 + 1])
end