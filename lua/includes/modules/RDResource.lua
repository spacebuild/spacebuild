--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 0.1
--
--  A module for ResourceData for use with both RDEntityData as an RDNetwork
--
--=============================================================================--

local table 	= table
local setmetatable 	= setmetatable
local type = type
local tostring = tostring
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local pairs = pairs

module( "RDNetwork" )

local resources = {}

local id = 1;

local list = {}
list.__index = list
list.TYPE = "RDResource";

function list:Init(resource)
	self.id = id;
	id = id + 1;
	resources[self.id] = self;
	self.resource = resource;
	self.value = 0;
	self.haschanged = false;
	self.maxvalue = 0;
end

--[[
	RDResource.Create()
		Call this to create a new RDResource
		
		Returns the new RDResource object
]]
function Create(resource)
	if not resource then
		return nil
	end
	tmp = {}
	setmetatable( tmp, list )
	tmp:Init(resource);
	return tmp
end



