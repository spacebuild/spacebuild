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
local net = net

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

function C:isA(className)
    return funcRef.isA(self, className) or className == "LegacyPlanet"
end

function C:init(entid, data)
    funcRef.init(self, entid, data)
    self.name = "Planet "..tostring(entid)
    if data[1] == "planet" then
        self.radius = tonumber(data[2])
        self.gravity = tonumber(data[3])
        self.atmosphere = tonumber(data[4])
        self.temperature = tonumber(data[5])
        self.hightemperature = tonumber(data[6])
        if string.len(data[7]) > 0 then
           self.color_id = data[7]
        end
        if string.len(data[8]) > 0 then
            self.bloom_id = data[8]
        end
        local flags = tonumber(data[16])
        -- TODO

    elseif data[1] == "planet2" then
        self.radius = tonumber(data[2])
        self.gravity = tonumber(data[3])
        self.atmosphere = tonumber(data[4])
        -- Ignore data[5] (pressure)
        self.temperature = tonumber(data[5])
        self.hightemperature = tonumber(data[7])
        local flags = tonumber(data[8])
        --TODO
        local oxygenpercentage = tonumber(data[9])
        local co2percentage = tonumber(data[10])
        local nitrogenpercentage = tonumber(data[11])
        local hydrogenpercentage = tonumber(data[12])
        -- TODO
        self.name = (string.len(data[13]) > 0 and data[13]) or self.name
        if string.len(data[15]) > 0 then
            self.color_id = data[15]
        end
        if string.len(data[16]) > 0 then
            self.bloom_id = data[16]
        end
    elseif data[1] == "star" then
        self.radius = 512
        self.gravity = 0
        self.atmosphere = 0
        self.temperature = 10000
        self.hightemperature = 10000
    elseif data[1] == "star2" then
        self.radius = tonumber(data[2])
        self.temperature = tonumber(data[3])
        self.hightemperature = tonumber(data[5])
        self.name = (string.len(data[6]) > 0 and data[6]) or self.name
    end
end

function C:getVolume()
    return math.Round((4/3) * math.pi * self.radius * self.radius)
end

function C:getTemperature(ent)
    --TODO
    return self.temperature
end


