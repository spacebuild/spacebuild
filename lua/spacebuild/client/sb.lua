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
end)
