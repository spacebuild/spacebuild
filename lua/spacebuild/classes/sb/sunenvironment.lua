--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

include("baseenvironment.lua")

-- Class Specific
local C = CLASS
require("sbnet")
local net = sbnet

-- Function Refs
local funcRef = {
	isA = C.isA,
	init = C.init,
	getPosition = C.getPosition,
	sendContent = C._sendContent,
	receiveSignal = C.receive,
	onSave = C.onSave,
	onLoad = C.onLoad
}

local DEFAULT_SUN_POSITION = Vector(0, 0, 0)

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "SunEnvironment"
end

function C:isStar()
	return true
end

function C:getPosition()
	return funcRef.getPosition(self) or DEFAULT_SUN_POSITION
end

function C:init(entid, data, resourceRegistry)
	funcRef.init(self, entid, data, resourceRegistry)
	self.radius = data.radius or 1500
	self.beamRadius = self.radius * 1.5
	local ent = self:getEntity()
	local SunAngle
	for key, value in pairs(data) do
		if ((key == "target") and (string.len(value) > 0)) then
			local targets = ents.FindByName( "sun_target" )
			for _, target in pairs( targets ) do
				SunAngle = (target:GetPos() - ent:GetPos()):Normalize()
				break --Sunangle set, all that was needed
			end
		end
	end
	if not SunAngle then
		--Sun angle still not set, but sun found
		local ang = ent:GetAngles()
		ang.p = ang.p - 180
		ang.y = ang.y - 180
		--get within acceptable angle values no matter what...
		ang.p = math.NormalizeAngle( ang.p )
		ang.y = math.NormalizeAngle( ang.y )
		ang.r = math.NormalizeAngle( ang.r )
		SunAngle = ang:Forward()
	end
	self.sunAngle = SunAngle
end

function C:getRadius()
	return self.radius;
end

function C:getBeamRadius()
	return self.beamRadius;
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified timestamp the client received information about this environment last
--
function C:_sendContent(modified)
	funcRef.sendContent(self, modified)
	net.writeShort(self.radius)
	net.writeShort(self.beamRadius)
	net.writeShort(self.sunAngle.p or 0)
	net.writeShort(self.sunAngle.y or 0)
	net.writeShort(self.sunAngle.r or -1)
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	funcRef.receiveSignal(self)
	self.radius = net.readShort()
	self.beamRadius = net.readShort()
	local p = net.readShort()
	local y = net.readShort()
	local r = net.readShort()
	self.sunAngle = Angle(p, y, r)
end

