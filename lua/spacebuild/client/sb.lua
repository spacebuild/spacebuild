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
local class = SB.class
require("sbnet")
local net = sbnet

net.Receive( "sbeu", function(length, ply)
    local className = net.ReadString()
    local entId = net.readShort()
    log.debug("Receiving environment data", className, entId)

    local environment = SB:getEnvironment(entId)
    if not environment then
        local ent = ents.GetByIndex(entId)
        environment = class.new(className, entId, {}, SB:getResourceRegistry())
        ent.envobject = environment
        SB:addEnvironment(environment)
    end
    environment:receive()
    log.table(environment, log.DEBUG, "loaded environment update")
end)

net.Receive( "sbmu", function(length, ply)
    log.debug("Receiving environment effect data")
    local bloomOrColor = net.readTiny()
    local class = net.ReadString()
    local id = net.ReadString()

    local envData;
    if bloomOrColor == 1 then
        envData = SB:getEnvironmentColor(id)
        if not envData then
            envData = class.new("sb/LegacyColorInfo", {})
            SB:addEnvironmentColor(envData)
        end
    elseif bloomOrColor == 2 then
        envData = SB:getEnvironmentBloom(id)
        if not envData then
            envData = class.new("sb/LegacyBloomInfo", {})
            SB:addEnvironmentBloom(envData)
        end
    end
    envData:receive()
end)

net.Receive( "sbee", function(length, ply)
    log.debug("Receiving ent changed environment")
    local entId = net.readShort()
    local environmentId = net.readShort()
    local oldEnvironmentId = net.readShort()
    local ent = ents.GetByIndex(entId)
    if ent:IsPlayer() then
        local newEnvironment = SB:getEnvironment(environmentId)
        local oldEnvironment = SB:getEnvironment(oldEnvironmentId)
        ent.environment = newEnvironment
        log.debug("player ", ent:GetName(), " joined environment ", newEnvironment:getName(), " left environment ", oldEnvironment:getName())
    end
end)

local function RenderColorAndBloom( )
    local environment = LocalPlayer().environment;
    if environment then
        local bloom = environment.getEnvironmentBloom and environment:getEnvironmentBloom();
        local color = environment.getEnvironmentColor and environment:getEnvironmentColor();
        if bloom then
            bloom:render();
        end
        if color then
            color:render();
        end
    end
end
hook.Add( "RenderScreenspaceEffects", "VFX_Render", RenderColorAndBloom );
--hook.Add( "RenderScreenspaceEffects", "SunEffects", DrawSunEffects );
