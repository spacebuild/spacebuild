-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

--
-- Created by IntelliJ IDEA.
-- User: stijn
-- Date: 18/06/2016
-- Time: 21:14
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local log = SB.log
require("sbnet")
local net = sbnet

net.Receive( "sbru", function(length, ply)
    log.debug("receiving rd data start", "time=", CurTime())
    local id = net.readShort()
    local rdtype = net.readShort()
    log.debug("Receiving rd entity update", id)
    local container = SB:getDeviceInfo(id)
    if not container then
        container =SB:registerDevice(Entity(id), rdtype)
    end
    container:receive()
    log.debug("receiving rd data end", "time=", CurTime())
end)

list.Add( "BeamMaterials", "cable/rope_icon" )
list.Add( "BeamMaterials", "cable/cable2" )
list.Add( "BeamMaterials", "cable/xbeam" )
list.Add( "BeamMaterials", "cable/redlaser" )
list.Add( "BeamMaterials", "cable/blue_elec" )
list.Add( "BeamMaterials", "cable/physbeam" )
list.Add( "BeamMaterials", "cable/hydra" )

--holds the materials
local beamMat = {}

for _,mat in pairs(list.Get( "BeamMaterials" )) do
    beamMat[mat] = Material(mat)
end

local xbeam = Material("cable/xbeam")
function SB:drawBeams(ent)
    if ent.rdobject  then
        local beamCount = table.Count(ent.rdobject:getBeams())
        if beamCount > 0 then
            local texcoord, targetcoord, startPos, endPos
            for _, beam in pairs(ent.rdobject:getBeams()) do
                -- set material
                render.SetMaterial( beamMat[beam:getMaterial()] or xbeam )
                startPos = ent:GetPos()
                endPos = beam:getTargetEntity():GetPos()
                texcoord = math.Rand( 0, 1 )
                targetcoord = texcoord + ((startPos - endPos):Length() /10)
                render.DrawBeam(startPos, endPos, beam:getWidth(), texcoord, targetcoord, beam:getColor())
            end
        end
    end
end
