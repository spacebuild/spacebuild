--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 1.0
--
--  Module to create the data required for an entity for use in an RDNetwork
--
--=============================================================================--

local table 	= table
local setmetatable 	= setmetatable
local type = type
local tostring = tostring
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local pairs = pairs

module( "RDEntityData" )

local entities = {}

local list = {}
list.__index = list
list.TYPE = "RDEntityData";

function list:Init(entity)
	self.id = entity:EntIndex( );
	self.entity = entity;
	self.network = nil;
	self.resources = {}
	self.clear = false;
	self.new = true;
	self.haschanged = false;
	entities[entityID] = self;
end

--[[
	RDEntityData.Create()
		Call this to create a new RDEntityData
		
		Returns the new RDEntityData object
]]
function Create(entity)
	if not entity then
		return nil
	end
	tmp = {}
	setmetatable( tmp, list )
	tmp:Init(entity);
	return tmp
end



