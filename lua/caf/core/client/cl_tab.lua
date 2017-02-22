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

--
--	Custom Addon Framework Tab Module and Tool Helper
--

include("caf/core/shared/caf_tools.lua")

local usetab = CreateClientConVar("CAF_UseTab", "1", true, false)

local function CAFTab()
    if usetab:GetBool() then
        spawnmenu.AddToolTab("Spacebuild", "Spacebuild")
    end
end

hook.Add("AddToolMenuTabs", "CAFTab", CAFTab)

function CAF_BuildCPanel(cp, toolname, listname, custom)
    cp:AddControl("CheckBox", { Label = "Don't Weld", Command = toolname .. "_DontWeld" })
    cp:AddControl("CheckBox", { Label = "Allow welding to world", Command = toolname .. "_AllowWorldWeld" })
    cp:AddControl("CheckBox", { Label = "Make Frozen", Command = toolname .. "_Frozen" })
    local ListControl = vgui.Create("CAFControl")
    cp:AddPanel(ListControl)
    ListControl:SetList(toolname, listname)
end

