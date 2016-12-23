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

CreateConVar("SB_NoClip", "1")
CreateConVar("SB_AdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_SuperAdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_PlanetNoClipOnly", "1") -- Make it so admins can let players no clip in space.

CreateConVar("SB_EnableDrag", "1") -- Make it drag also gets affected, on by default.
CreateConVar("SB_InfiniteResources", "0") -- Makes it so that a planet can't run out of resources, off by default.
CreateConVar("SB_StaticEnvironment", "0") -- @DEPRECATED, use SB_InfiniteResources instead

SB.config = {

    noclip = {
        get = function() return GetConVar("SB_NoClip"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_NoClip", val:toNumber()) end
    },
    adminspacenoclip = {
        get = function() return GetConVar("SB_AdminSpaceNoclip"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_AdminSpaceNoclip", val:toNumber()) end
    },
    superadminspacenoclip = {
        get = function() return GetConVar("SB_SuperAdminSpaceNoclip"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_SuperAdminSpaceNoclip", val:toNumber()) end
    },
    planetnocliponly = {
        get = function() return GetConVar("SB_PlanetNoClipOnly"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_PlanetNoClipOnly", val:toNumber()) end
    },
    drag = {
        get = function() return GetConVar("SB_EnableDrag"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_EnableDrag", val:toNumber()) end
    },
    resources = {
        get = function() return GetConVar("SB_InfiniteResources"):GetBool() or GetConVar("SB_StaticEnvironment"):GetBool() end,
        set = function(val) game.ConsoleCommand("SB_InfiniteResources", val:toNumber()) end
    }
}