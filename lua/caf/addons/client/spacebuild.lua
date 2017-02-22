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

list.Set( "PlayerOptionsModel",  "MedicMarine", "models/player/samzanemesis/MarineMedic.mdl" )
list.Set( "PlayerOptionsModel",  "SpecialMarine", "models/player/samzanemesis/MarineSpecial.mdl" ) 
list.Set( "PlayerOptionsModel",  "OfficerMarine", "models/player/samzanemesis/MarineOfficer.mdl" ) 
list.Set( "PlayerOptionsModel",  "TechMarine", "models/player/samzanemesis/MarineTech.mdl" )

local SPACEBUILD = SPACEBUILD
local SB = {}

local status = false

--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function SB.__Construct()
	status = true;
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function SB.__Destruct()
	status = false;
	return true
end

--[[
	Get the Boolean Status from this Addon Class
]]
function SB.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function SB.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function SB.GetExtraOptions()
	return {}
end

--[[
	Gets a menu from this Custom Addon Class
]]
function SB.GetMenu(menutype, menuname) --Name is nil for main menu, String for others
	local data = {}
	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function SB.GetCustomStatus()
	return
end

--[[
	Returns a table containing the Description of this addon
]]
function SB.GetDescription()
	return {
				"Spacebuild Addon",
				"",
				"Prviously a Gamemode",
				""
			}
end

CAF.RegisterAddon("Spacebuild",  SB, "1")


