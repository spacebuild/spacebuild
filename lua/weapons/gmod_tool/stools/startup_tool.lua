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


SPACEBUILD:loadTools()

include("caf/core/shared/tool_manifest.lua")

TOOL = ToolObj:Create()
local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.sb")
TOOL.Mode = "startup_tool"
TOOL.Name = "CAF Tools Startup"
TOOL.Command = nil
TOOL.ConfigName = nil
TOOL.AddToMenu = false
TOOL.Tab = "Spacebuild"


function TOOL:LeftClick(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end

function TOOL:RightClick(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end

function TOOL:Reload(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end