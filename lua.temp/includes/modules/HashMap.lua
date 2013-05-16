--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 0.1
--
--  A really simple module to allow the creation of Java like HashMaps
--
--=============================================================================--

local table 	= table
local setmetatable 	= setmetatable
local type = type
local tostring = tostring
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local pairs = pairs

module( "HashMap" )

local list = {}
list.__index = list

--[[
	Possible Types to check
		- All default checktypes (number, string, vector, table, colour, nil, angle)
		- ent (Entities, includes players, vehicles, weapons, NPC's)
		- entonly (players, vehicles, weapons and npc's not allowed)
		- npc (NPC's)
		- player (players)
		- vehicle (vehicles)
		- weapon (weapons)
]]


--[[
	Create ( type , isfunc)
		type is optional, if a type is given this will be checked against the item before adding it to the internal Table
		isfunc is option,  needs to be true if type is custom function 
		
		This will set up the new ArrayList

]]
function list:Create( thetype, isfunc, thetype2, isfunc2 )
	self:SetCheckType(thetype, isfunc, thetype2, isfunc2)
	self.table = {}
end

--[[
	SetCheckType( type, isfunc, type2, isfunc2)
		type is optional, if no type is given, the checking will be disabled
		isfunc is option,  needs to be true if thetype is custom function 
		
		Sets the type to check the item for (won't check the old values in the table !!!)

]]
function list:SetCheckType(thetype, isfunc, thetype2, isfunc2)
	if thetype and isfunc then
		self.hasKeyType = true
		self.keytype = nil
		self.customKeyCheck = true
		self.func = thetype
	elseif thetype and type(thetype) == "string" then
		self.hasKeyType = true
		self.keytype = thetype
	else
		self.hasKeyType = false
		self.keytype = nil
	end
	
	if thetype2 and isfunc then
		self.hasValueType = true
		self.valuetype = nil
		self.customValueCheck = true
		self.valuefunc = thetype2
	elseif thetype2 and type(thetype2) == "string" then
		self.hasValueType = true
		self.valuetype = thetype2
	else
		self.hasValueType = false
		self.valuetype = nil
	end
end

--[[
	CheckType (  item )
		item is required,, this is the item you want to check
		
		This function will return true if this item is allowed into the ArrayList, false otherwise
	
]]
function list:CheckKeyType( item )
	if self.hasKeyType then
		if self.customKeyCheck then
			local ok, err = pcall(self.keyfunc, item)
			if not ok then 
				return false, err
			else
				return err
			end
		elseif type(item) == self.keytype then
			return true
		else
			if self.keytype == "ent" then
				return IsValid(item)
			elseif self.keytype == "player" then
				return IsValid(item) and item:IsPlayer()
			elseif self.keytype == "vehicle" then
				return IsValid(item) and item:IsVehicle()
			elseif self.keytype == "npc" then
				return IsValid(item) and item:IsNPC()
			elseif self.keytype == "weapon" then
				return IsValid(item) and item:IsWeapon()
			elseif self.keytype == "entonly" then
				return IsValid(item) and not item:IsPlayer() and not item:IsVehicle() and not item:IsNPC() and not item:IsWeapon()
			end
		end	
		return false
	end
	return true
end

function list:CheckValueType( item )
	if self.hasValueType then
		if self.customValueCheck then
			local ok, err = pcall(self.valuefunc, item)
			if not ok then 
				return false, err
			else
				return err
			end
		elseif type(item) == self.valuetype then
			return true
		else
			if self.valuetype == "ent" then
				return IsValid(item)
			elseif self.valuetype == "player" then
				return IsValid(item) and item:IsPlayer()
			elseif self.valuetype == "vehicle" then
				return IsValid(item) and item:IsVehicle()
			elseif self.valuetype == "npc" then
				return IsValid(item) and item:IsNPC()
			elseif self.valuetype == "weapon" then
				return IsValid(item) and item:IsWeapon()
			elseif self.valuetype == "entonly" then
				return IsValid(item) and not item:IsPlayer() and not item:IsVehicle() and not item:IsNPC() and not item:IsWeapon()
			end
		end	
		return false
	end
	return true
end

--[[
	Clear()
	
	
		This will clear the inner table
]]
function list:Clear()
	self.table = {}
end

--[[
	ContainsValue(item)
		Item is required
		
		Returns true/false

]]
function list:ContainsValue( item )
	return table.HasValue(self.table, item)
end

--[[
	ContainsKey(key)
		key is required
		
		Returns true/false

]]
function list:ContainsKey( key )
	return self.table[key]
end

--[[
	Get( index)
		Index is a number and is required
		
		returns the Item at this index or nil

]]
function list:Get( index )
	return self.table[index]
end

--[[
	IsEmpty()
	
		Returns true/false

]]
function list:IsEmpty()
	return table.Count(self.table) == 0
end

--[[
	KeySet()
	
		Returns a table with all the keys in it

]]
function list:KeySet()
	local tmp = {}
	if not self:IsEmpty() then
		for k, v in pairs(self.table) do
			table.insert(tmp, k)
		end
	end
	return tmp
end

--[[
	Put( key, item )
		item is required, the item you want to add 
		key is required
		
		This functions will try to add the given item to the HashMap, returns true if succesfull

]]
function list:Put( key, item )
	local ok = (self:CheckKeyType( key ) and self:CheckValueType( item ))
	if ok then
		self.table[key] = item
	end
	return ok
end

--[[
	Putall(Table)
		Table is required
		
		This functions will try to add the given items to the ArrayList, returns true if succesfull
		Existing values will be overriden if a matching key is in the to add table


]]
function list:PutAll( htable )
	local ok = true
	local amount = 0
	for k, v in pairs(htable) do
		if not self:Put(k, v) then
			ok = false
			amount = amount + 1
		end
	end
	return ok, tostring(amount).."was the wrong type"
end

--[[
	GetCheckType()
	
		Returns the current type this Table checks for

]]
function list:GetKeyCheckType()
	if self.customKeyCheck then
		return true, self.keyfunc
	end
	return false, self.keytype
end

--[[
	GetCheckType()
	
		Returns the current type this Table checks for

]]
function list:GetValueCheckType()
	if self.customValueCheck then
		return true, self.valuefunc
	end
	return false, self.valuetype
end

--[[
	Remove(key)
		The key of the to item to remove
		
		Removes the item at the specified key
	
]]
function list:Remove( key )
	self.table[key] = nil
end

--[[
	Size()
	
		Returns the size of the ArrayList

]]
function list:Size()
	return table.Count(self.table)
end

--[[
	Values()
	
		Returns all of the values in a table

]]
function list:Values()
	local tmp = {}
	if not self:IsEmpty() then
		for k,v in pairs(self.table) do
			table.insert(tmp, v)
		end
	end
	return tmp
end

--[[
	ToTable()
	
		Returns a copy of the the inner table

]]
function list:ToTable()
	local tab = {}
	if not self:IsEmpty() then
		tab = table.Copy(self.table)
	end
	return tab
end

---------------------------------------------------------

--[[
	HashMap.Create(  type, isfunc)
		Call this to create a new HashMap type(s) is optional
		isfunc is option,  needs to be true if type is custom function 
		
		Returns the new HashMap object
]]
function Create( thetype, isfunc, thetype2, isfunc2 )
	tmp = {}
	setmetatable( tmp, list )
	tmp:Create(thetype, isfunc, thetype2, isfunc2 )
	return tmp
end



