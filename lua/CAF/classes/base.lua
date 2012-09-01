--[[
	Metatable functions
]]

CAF.class.addMeta()

--[[
	End Metatable functions
]]

PROTECTED_CLASS.test1 = "I'm shared and visible inside of this clas and it's children, but not outside";

--[[
	__construct([data])

	Constructor called when creating an object of this type
]]
function CLASS:__construct(data) --Constructor
	Msg("In Base Class Constructor: "..tostring(self.type).."\n");
end

--[[
	Equals(o1 [, o2])
	
	Checks if the 2 objects are equal (reference or memberwise)
	
	Since the base class has no real members, it can only check on reference
]]
function CLASS:Equals(o1, o2)
	if o1 then
		if o2 then
			return o1 == o2
		end
		return self == o1
	end
	return false
end

--[[
	Hashcode()
	
	Provides a unique identifier for each 'unique' object
	Should be based on datamembers
	Objects with the same datamember (values) should generate the same hashcode

]]
function CLASS:HashCode()
	local PRIME = 31;
    local result = 1;
	result = PRIME * result; -- + value for a datamember
	return result;
end


--[[
	GetType()
	
	Returns the type of this 'class'
]]
function CLASS:GetType()
	return self.type
end

--[[
	ToString()

	Returns a string representation of this object
]]
function CLASS:ToString()
	return "Class("..self.type..")";
end