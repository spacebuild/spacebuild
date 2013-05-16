--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 1.0
--
--  Module to create RDNetworks
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

local networks = {}
local id = 1;

local list = {}
list.__index = list
list.TYPE = "RDNetwork";

function list:Init()
	self.id = id;
	id = id + 1;
	networks[self.id] = self;
	self.resources = {}
	self.entities = {}
	self.haschanged = false;
	self.new = true;
	self.clear = false;
	self.connections = {}
	self.entity = nil;
end

--[[
	RDNetwork.Create()
		Call this to create a new RDNetwork
		
		Returns the new RDNetwork object
]]
function Create()
	tmp = {}
	setmetatable( tmp, list )
	tmp:Init();
	return tmp
end



