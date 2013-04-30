-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 28/04/13
-- Time: 0:59
-- To change this template use File | Settings | File Templates.
--

local GM = GM

local function spawnItem(len, ply)
    local category = net.ReadString()
    local item = net.ReadString()
    MsgN("Spawning item " ..item .. " from category "..category)
    local items = GM:getItems()
    local credits = player_manager.RunClass( ply, "getCredits")

    if not items[category] then
       -- Fail
        return
    end
    if not items[category].items[item] then
       -- Fail
        return
    end
    item = items[category].items[item]

    if item.price > credits then
        -- Fail
        return
    end

    local canSpawn = true
    if item.canSpawn then
       canSpawn = item.canSpawn(ply)
    end

    if not canSpawn then
        -- Fail
        return
    end

    -- Spawn the prop
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()

    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 2048)
    trace.filter = ply

    local tr = util.TraceLine( trace )

    local ent = ents.Create( item.class )
    if not IsValid( ent ) then return end

    local ang = ply:EyeAngles()
    ang.yaw = ang.yaw + 180 -- Rotate it 180 degrees in my favour
    ang.roll = 0
    ang.pitch = 0

    ent:SetModel( item.model )
    if item.skin then
        ent:SetSkin( item.skin )
    end
    ent:SetAngles( ang )
    ent:SetPos( tr.HitPos )
    ent:Spawn()
    ent:Activate()

    -- Attempt to move the object so it sits flush
    -- We could do a TraceEntity instead of doing all
    -- of this - but it feels off after the old way

    local vFlushPoint = tr.HitPos - ( tr.HitNormal * 512 )	-- Find a point that is definitely out of the object in the direction of the floor
    vFlushPoint = ent:NearestPoint( vFlushPoint )			-- Find the nearest point inside the object to that point
    vFlushPoint = ent:GetPos() - vFlushPoint				-- Get the difference
    vFlushPoint = tr.HitPos + vFlushPoint					-- Add it to our target pos


    -- Set new position
    ent:SetPos( vFlushPoint )

    player_manager.RunClass( ply, "setCredits", credits - item.price)
    if item.onSpawn then
       item.onSpawn(ent, ply)
    end
end
net.Receive("SPAWNITEM", spawnItem)