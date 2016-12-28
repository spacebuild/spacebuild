-- Much love to the WireMod team for their superb LUA coding
-- Based on the RD2 base_rd_entity made by Thresher and TAD2020

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Resource Distribution 3 Entity"
ENT.Author = "SnakeSVx"
ENT.Purpose = "Base for all RD Sents"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:GetResourceAmount(resource)
    return self.rdobject and self.rdobject:getResourceAmount(resource) or 0
end

---
-- @param resource [string] Resource name
-- @return [number] the max network capacity this resources has
-- @deprecated use ENT:GetCapacity(resource)
--
function ENT:GetUnitCapacity(resource)
    return self:GetCapacity(resource)
end

---
-- @param resource [string] Resource name
-- @return [number] the max network capacity this resources has
-- @deprecated use ENT:GetCapacity(resource)
--
function ENT:GetNetworkCapacity(resource)
    return self:GetCapacity(resource)
end

---
-- @param resource [string] Resource name
-- @return [number] the max (network) capacity this resources has
--
function ENT:GetCapacity(resource)
    return self.rdobject and self.rdobject:getResourceAmount(resource) or 0
end
