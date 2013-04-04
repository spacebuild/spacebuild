local EXT = EXT

local string = string
local AddCSLuaFile = AddCSLuaFile
local pairs = pairs

AddCSLuaFile()

function EXT:init(config)
	self.hidden = true
	self.active = false
	self.version = 1
	self.name = "Base Extension"
	self.config = config or {}
	self.options = {}
	self.description = "The Default Description for a Base Extension. I am making this longer to check if it will wrap around the panel if not i will have to implement something hacky probably to stop it."
	self.clientside = false
end

function EXT:isClientSide()
	return self.clientside
end

function EXT:isHidden()
	return self.hidden
end

function EXT:setActive(active)
	self.active = active
end

function EXT:isActive()
	return self.active
end

function EXT:getVersion()
	return self.version
end

function EXT:getName()
	return self.name
end

function EXT:getDescription()
	return self.description
end

function EXT:hasOptions()
   return table.Count(self.options) > 0
end

function EXT:getOptions()
	return self.options
end

function EXT:getSyncKey()
--Since the name shouldn't change we are only going to generate it once!!
	if self.generated_key == nil then
		local generated_key = 23
		self:getName():gsub(".", function(c)
			generated_key =  generated_key * (string.byte(c) - 64) -- A = 65, a = 97
		end)
		generated_key = generated_key + string.len(self:getName())
		generated_key = generated_key % 32767 --We don't want more then a SHORT INTEGER
		print("Generated key for extension "..tostring(self:getName())..": "..tostring(generated_key))
		self.generated_key = generated_key
	end
	return self.generated_key
end


