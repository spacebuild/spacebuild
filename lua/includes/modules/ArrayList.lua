--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 0.1
--
--  A really simple module to allow the creation of Java like ArrayLists
--
--=============================================================================--

local table 	= table
local setmetatable 	= setmetatable
local type = type
local tostring = tostring
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local pairs = pairs

module( "ArrayList" )

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
function list:Create( thetype, isfunc )
	self:SetCheckType(thetype, isfunc)
	self.table = {}
end

--[[
	CheckType (  item )
		item is required,, this is the item you want to check
		
		This function will return true if this item is allowed into the ArrayList, false otherwise
	
]]
function list:CheckType( item )
	if self.hasType then
		if self.customCheck then
			local ok, err = pcall(self.func, item)
			if not ok then 
				return false, err
			else
				return err
			end
		elseif type(item) == self.type then
			return true
		else
			if self.type == "ent" then
				return IsValid(item)
			elseif self.type == "player" then
				return IsValid(item) and item:IsPlayer()
			elseif self.type == "vehicle" then
				return IsValid(item) and item:IsVehicle()
			elseif self.type == "npc" then
				return IsValid(item) and item:IsNPC()
			elseif self.type == "weapon" then
				return IsValid(item) and item:IsWeapon()
			elseif self.type == "entonly" then
				return IsValid(item) and not item:IsPlayer() and not item:IsVehicle() and not item:IsNPC() and not item:IsWeapon()
			end
		end	
		return false
	end
	return true
end

--[[
	Add ( item, index )
		item is required, the item you want to add (will be checked using CheckType)
		index is optional, if no index (or the index is out of the current range = more then 1 then the current last index)  is given it will automaticaly be put at the end of the of the current table
		
		This functions will try to add the given item to the ArrayList, returns true if succesfull
		
		/*local tmptable = {}
			if not self:IsEmpty() then
				for k, v in pairs(self.table) do
					if k == index then
						table.insert(tmptable, item)
					end
					table.insert(tmptable, v)
				end
			end
			self.table = tmptable*/

]]
function list:Add( item, index )
	local ok = self:CheckType( item )
	if ok then
		if index and index <= self:Size() then --Check if there is an index and if the index falls in the current range of keys
			table.insert(self.table, index,  item) -- Should be the valid way of doing it
		else --Add the value at the end of the table
			table.insert(self.table, item)
		end
	end
	return ok
end

--[[
	Add ( items, index )
		items is required, the items (table of items) you want to add (will be checked using CheckType)
		index is optional, if no index (or the index is out of the current range = more then 1 then the current last index)  is given it will automaticaly be put at the end of the of the current table
		
		This functions will try to add the given items to the ArrayList, returns true if succesfull


]]
function list:AddAll( items, index )
	local ok = true
	local amount = 0
	for k, v in pairs(items) do
		if not self:Add(v, index) then
			ok = false
			amount = amount + 1
		end
		index = index + 1
	end
	return ok, tostring(amount).."was the wrong type"
end

--[[
	Clear()
	
	
		This will clear the inner table
]]
function list:Clear()
	self.table = {}
end

--[[
	SetCheckType( type, isfunc)
		type is optional, if no type is given, the checking will be disabled
		isfunc is option,  needs to be true if thetype is custom function 
		
		Sets the type to check the item for (won't check the old values in the table !!!)

]]
function list:SetCheckType(thetype, isfunc)
	if thetype and isfunc then
		self.hasType = true
		self.type = nil
		self.customCheck = true
		self.func = thetype
	elseif thetype and type(thetype) == "string" then
		self.hasType = true
		self.type = thetype
	else
		self.hasType = false
		self.type = nil
	end
end

--[[
	GetCheckType()
	
		Returns the current type this Table checks for

]]
function list:GetCheckType()
	if self.customCheck then
		return true, self.func
	end
	return false, self.type
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

--[[
	SetTable( table)
		Table is a table and is required
	
		Sets the inner table (no items will be checked !!!)

]]
function list:SetTable( items)
	if items then
		self.table = items
	end
end

--[[
	Clone()
	
		Returns a copy of the current ArrayList()
]]
function list:Clone()
	tmp = {}
	setmetatable( tmp, list )
	tmp:Create(self.type)
	tmp:SetTable(self:ToTable())
	return tmp
end

--[[
	Contains(item)
		Item is required
		
		Returns true/false

]]
function list:Contains( item )
	return table.HasValue(self.table, item)
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
	IndexOf( item)
		Item is required
		
		Returns the index of the first occurence of this item

]]
function list:IndexOf( item )
	if not self:IsEmpty() then
		for k, v in pairs(self.table) do
			if v == item then
				return k
			end
		end
	end
	return -1
end

--[[
	IsEmpty()
	
		Returns true/false

]]
function list:IsEmpty()
	return table.Count(self.table) == 0
end

--[[
	LastIndexOf(  item)
		item is required
		
		Returns the index of the last occurence of this item

]]
function list:LastIndexOf( item ) 
	local last = -1
	if not self:IsEmpty() then
		for k, v in pairs(self.table) do
			if v == item then
				last = k
			end
		end
	end
	return last
end

--[[
	Remove(item)
		Item is required (can be either a index(number), if isindex = true, or an item)
		Isindex is optional, set this to true if you want to remove from a certain index 
		
		Removes this item or the item at the specific index
	
]]
function list:Remove( item, isindex )
	if isindex then
		table.remove(self.table, item)
	else
		for k, v in pairs(self.table) do
			if v == item then
				table.remove(self.table, k)
			end
		end
	end
end

--[[
	RemoveRange( start, end)
		Start is required and needs to be number
		End is optional and needs to be number, if not given remove from start index to the end of the ArrayList
		
		Removes all Items in the specific range

]]
function list:RemoveRange( start, tend )
	if not tend then
		tend = self:Size()
	end
	if start == tend then
		self:Remove(self:Get(start))
	else
		for i = start, tend do
			self:Remove(self:Get(start)) --the size and index change, so the index stays the same!
		end
	end
end

--[[
	Set( index, item)
		Index is required and needs to be a number
		Item is required
		
		Will replace the item at the given index with the new item, if index is out of bounds ( smaller then 1 and larger then the Size) then the item will be added to the end of the ArrayList

]]
function list:Set( index, item )
	if self:Size() < index or index <= 0 then
		table.insert(self.table, item)
	else
		self.table[index] = item
	end
	return true
end

--[[
	Size()
	
		Returns the size of the ArrayList

]]
function list:Size()
	return table.Count(self.table)
end

---------------------------------------------------------

--[[
	ArrayList.Create(  type, isfunc)
		Call this to create a new ArrayList, type is optional
		isfunc is option,  needs to be true if type is custom function 
		
		Returns the new ArrayList object
]]
function Create( thetype, isfunc )
	tmp = {}
	setmetatable( tmp, list )
	tmp:Create(thetype, isfunc )
	return tmp
end



