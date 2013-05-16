AddCSLuaFile("includes/modules/ArrayList.lua")
AddCSLuaFile("includes/modules/HashMap.lua")
AddCSLuaFile("includes/modules/caf_util.lua")
AddCSLuaFile("includes/modules/Json.lua")
AddCSLuaFile("includes/modules/cache.lua")

require("ArrayList")
require("HashMap")
require("caf_util")
require("Json")
require("CustomAttack")
require("CustomArmor")
require("cache")


--[[
local c = cache.create(20, 1) --20 items max, 1 second ttl

local item = 0;

timer.Create( "test_timer", 0.5, 3, function()
	local e = item
	for i = e + 1, e + 11, 1 do
		item = i
		--print("adding", i)
		c:add(i, i)
	end
	PrintTable(c:getList());
end )
]]

local meta = FindMetaTable("Entity")

--[[meta.caf = {}
meta.caf.custom = {}
meta.caf.custom.canreceivedamage = true
meta.caf.custom.canreceiveheatdamage = true]]

function meta:getCustomArmor()
    return self.caf.custom.armor
end

function meta:setCustomArmor(armor)
    self.caf.custom.armor = armor
end


function meta:WaterLevel2()
    local waterlevel = self:WaterLevel()
    if (self:GetPhysicsObject():IsValid() and self:GetPhysicsObject():IsMoveable()) then
        --Msg("Normal WaterLEvel\n")
        return waterlevel --this doesn't look like it works when ent is welded to world, or not moveable
    else
        --Msg("Special WaterLEvel\n") --Broken in Gmod SVN!!!
        if (waterlevel ~= 0) then
            return waterlevel
        end
        local trace = {}
        trace.start = self:GetPos()
        trace.endpos = self:GetPos()
        trace.filter = { self }
        trace.mask = 16432 -- MASK_WATER
        local tr = util.TraceLine(trace)
        if (tr.Hit) then
            return 3
        end
    end
    return 0
end

-- Module Testing 
--[[
--ArrayList tests!!
ErrorNoHalt("BeginArrayTest\n")
local array = ArrayList.Create("number")
local nr = 1
Msg("Checktype: " ..tostring(array:CheckType( nr )).."\n")
array:Add(nr)
Msg("PrintTable: values: 1\n")
PrintTable(array:ToTable())

array:Add( 2, 1)

array:Add("lalala")

Msg("PrintTable: values: 2 1\n")
PrintTable(array:ToTable())

array:AddAll( {3, 4}, 2)

Msg("PrintTable: values: 2 3 4 1\n")
PrintTable(array:ToTable())
Msg("Printout: ")
for k, v in pairs(array:ToTable()) do
	Msg("("..tostring(k)..")"..tostring(v).." ")
end
Msg("\n")

--Msg("Checktype: "..tostring(array:GetCheckType()[1])..", "..tostring(array:GetCheckType()[2]).."\n")

local array2 = array:Clone()
array2:Add(5)

Msg("PrintTable: original: 2 3 4 1\n")
PrintTable(array:ToTable())

Msg("PrintTable: clone: 2 3 4 1 5\n")
PrintTable(array2:ToTable())

Msg("Contains 1: "..tostring(array:Contains(1)).."\n")

Msg(" Get[1] = 2: "..tostring(array:Get(1)).."\n")

Msg("Indexof(2) = 1 : "..tostring(array:IndexOf(2)).."\n")

Msg("IsEmpty(): "..tostring(array:IsEmpty()).."\n")

array:Add(2)

Msg("LastIndexOf(2) == 5?: "..tostring(array:LastIndexOf(2)).."\n")

Msg("Remove(2)\n")
array:Remove(2)
Msg("PrintTable: original: 3 4 1\n")
PrintTable(array:ToTable())

Msg("Remove(4, 2)\n")
array:Remove(4)
array:Add(6)
array:Remove(3, true)
Msg("PrintTable: original: 3 1\n")
PrintTable(array:ToTable())

Msg("RemoveRange( 1, 1 )\n")
array:RemoveRange(1, 1)
Msg("PrintTable: original: 1\n")
PrintTable(array:ToTable())

Msg("Set( 1, 2 )\n")
array:Set(1, 2)
Msg("PrintTable: original: 2\n")
PrintTable(array:ToTable())

Msg("Size: "..tostring(array:Size()).."\n")

ErrorNoHalt("EndArrayTest\n")

--JSon Tests
ErrorNoHalt("JsonTest\n")
 -- Lua script:
 local t = { 
	["name1"] = "value1",
	["name2"] = {1, false, true, 23.54, "a \021 string"},
	name3 = Json.Null() 
 }

 local json = Json.Encode (t)
 print (json) 
 --> {"name1":"value1","name3":null,"name2":[1,false,true,23.54,"a \u0015 string"]}

 local t = Json.Decode(json)
 print(t.name2[4])
 --> 23.54
ErrorNoHalt("EndJsonTest\n")
]]










