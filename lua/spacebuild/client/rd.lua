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

local SB = SPACEBUILD
local log = SB.log
require("sbnet")
local net = sbnet

net.Receive( "sbru", function(length, ply)
    local id = net.readShort()
    local rdtype = net.readShort()
    local container = SB:getDeviceInfo(id)
    -- TODO, since the entity has to register itself clientside as well, this shouldn't be need anymore once all entities have been updated
    if not container then
        container = SB:registerDevice(Entity(id), rdtype)
    end
    container:receive()
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
