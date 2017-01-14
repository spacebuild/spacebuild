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
    --log.table(environment, log.DEBUG, "loaded environment update")
end)

net.Receive( "sbmu", function(length, ply)
    log.debug("Receiving environment effect data")
    local bloomOrColor = net.readTiny()
    local className = net.ReadString()
    local id = net.ReadString()

    local envData;
    if bloomOrColor == 1 then
        envData = SB:getEnvironmentColor(id)
        if not envData then
            envData = class.new(className)
            envData:setID(id)
            SB:addEnvironmentColor(envData)
        end
    elseif bloomOrColor == 2 then
        envData = SB:getEnvironmentBloom(id)
        if not envData then
            envData = class.new(className)
            envData:setID(id)
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
        if ent.environment ~= newEnvironment then
            ent.environment = newEnvironment
            log.debug("player ", ent:GetName(), " joined environment ", newEnvironment:getName(), " left environment ", oldEnvironment:getName())
        end
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

local function DrawSunEffects( )
    -- no pixel shaders? no sun effects!
    if not render.SupportsPixelShaders_2_0() or not SB:onSBMap() then return end
    -- render each star.
    for ent, Sun in pairs( SB:getEnvironments() ) do
        if Sun:isA("SunEnvironment") then
            -- calculate brightness.
            local entpos = Sun:getPosition() --Sun.ent:LocalToWorld( Vector(0,0,0) )
            local normVec = Vector( entpos - EyePos() )
            normVec:Normalize()
            local dot = math.Clamp( EyeAngles():Forward():DotProduct( normVec ), -1, 1 );
            dot = math.abs(dot)
            --local dist = Vector( entpos - EyePos() ):Length();
            local dist = entpos:Distance(EyePos())/1.5
            -- draw sunbeams.
            local sunpos = EyePos() + normVec * ( dist * 0.5 );
            local scrpos = sunpos:ToScreen();
            if( dist <= Sun:getBeamRadius() and dot > 0 ) then
                local frac = ( 1 - ( ( 1 / ( Sun:getBeamRadius() ) ) * dist ) ) * dot;
                -- draw sun.
                --DrawSunbeams( darken, multiply, sunsize, sunx, suny )
                DrawSunbeams(
                    0.95,
                    frac,
                    0.255,
                    scrpos.x / ScrW(),
                    scrpos.y / ScrH()
                );
            end
            -- can the sun see us?
            local trace = {
                start = entpos,
                endpos = EyePos(),
                filter = LocalPlayer(),
            };
            local tr = util.TraceLine( trace );
            -- draw!
            if( dist <= Sun:getRadius() and dot > 0 and tr.Fraction >= 1 ) then
                -- calculate brightness.
                local frac = ( 1 - ( ( 1 / Sun:getRadius() ) * dist ) ) * dot;
                -- draw bloom.
                DrawBloom(
                    0.428,
                    3 * frac,
                    15 * frac, 15 * frac,
                    5,
                    0,
                    1,
                    1,
                    1
                );
                --[[DrawBloom(
                    0,
                    0.75 * frac,
                    3 * frac, 3 * frac,
                    2,
                    3,
                    1,
                    1,
                    1
                );]]
                -- draw color.
                local tab = {
                    ['$pp_colour_addr']		= 0.35 * frac,
                    ['$pp_colour_addg']		= 0.15 * frac,
                    ['$pp_colour_addb']		= 0.05 * frac,
                    ['$pp_colour_brightness']	= 0.8 * frac,
                    ['$pp_colour_contrast']		= 1 + ( 0.15 * frac ),
                    ['$pp_colour_colour']		= 1,
                    ['$pp_colour_mulr']		= 0,
                    ['$pp_colour_mulg']		= 0,
                    ['$pp_colour_mulb']		= 0,
                };
                -- draw colormod.
                DrawColorModify( tab );
            end
        end
    end
end
hook.Add( "RenderScreenspaceEffects", "SunEffects", DrawSunEffects );
