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
local class = SB.class
local log = SB.log

net.Receive( "sbrpu", function(length, ply)
    log.debug("receiving ls data start", "time=", CurTime())
    local ply = LocalPlayer()
    if not ply.suit then ply.suit = class.new("ls/Playersuit", ply) end
    ply.suit:receive()
    log.debug("receiving ls data end", "time=", CurTime())
end)
