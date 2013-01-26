--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:30
-- To change this template use File | Settings | File Templates.
--

include("sb/classes/BaseEnvironment.lua")

-- Lua Specific
local type = type

-- Gmod specific
local Entity = Entity
local CurTime = CurTime
require("sbnet")
local net = sbnet

-- Class Specific
local C = CLASS
local sb = sb;
local core = sb.core

-- Function Refs
local funcRef = {
    isA = C.isA,
    init = C.init,
    sendContent = C._sendContent,
    receiveSignal = C.receive,
    onSave = C.onSave,
    onLoad = C.onLoad
}

--local DEFAULT_SUN_ANGLE = Vector(0,0,-1)
local DEFAULT_SUN_POSITION = Vector(0, 0, 0)

function C:isA(className)
    return funcRef.isA(self, className) or className == "SunEnvironment"
end

--[[function C:init(entid, data)
    funcRef.init(self, entid, data)
    local ent = self:getEntity()
    if ent then
        local target = data["target"]
        if string.len(target) > 0 then
            --TODO mod this
            local targets = ents.FindByName( "sun_target" )
            for _, target in pairs( targets ) do
                self.sunAngle = (target:GetPos() - ent:GetPos()):Normalize()
                break
            end
        end
        if not self.sunAngle then
            local ang = ent:GetAngles()
            ang.p = ang.p - 180
            ang.y = ang.y - 180
            --get within acceptable angle values no matter what...
            ang.p = math.NormalizeAngle( ang.p )
            ang.y = math.NormalizeAngle( ang.y )
            ang.r = math.NormalizeAngle( ang.r )
            self.sunAngle = ang:Forward()
        end
        self.sunPos = ent:GetPos()
    else
        self.sunAngle = DEFAULT_SUN_ANGLE
        self.sunPos = DEFAULT_SUN_POSITION
    end
end]]

function C:getPos()
   return (self:getEntity() and self:getEntity():GetPos()) or DEFAULT_SUN_POSITION
end

