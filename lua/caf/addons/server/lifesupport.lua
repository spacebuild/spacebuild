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

local SPACEBUILD = SPACEBUILD
local log = SPACEBUILD.log

local LS = {}

local status = false

--Stuff that can't be disabled
CreateConVar( "LS_AllowNukeEffect", "1" ) --Update to something changeable later on
--end

LS.generators = {}
LS.generators.air = {}
LS.generators.temperature = {}

-- End Local Functions


--[[
	The Constructor for this Custom Addon Class
]]
function LS.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then return false, CAF.GetLangVar("Resource Distribution is Required and needs to be Active!") end
	util.PrecacheSound( "vehicles/v8/skid_lowfriction.wav" )
	util.PrecacheSound( "NPC_Stalker.BurnFlesh" )
	util.PrecacheModel("models/player/charple.mdl")
	util.PrecacheSound( "streetwar.slimegurgle04" )
	util.PrecacheSound( "Player.FallGib" )
	LS.generators = {}
	LS.generators.air = {}
	LS.generators.temperature = {}
	status = true
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function LS.__Destruct()
	if not status then return false, CAF.GetLangVar("This addon wasn't on in the first place") end
	LS.generators = {}
	LS.generators.air = {}
	LS.generators.temperature = {}
	status = false
	return true
end

--[[
	Get the required Addons for this Addon Class
]]
function LS.GetRequiredAddons()
	return {}
end

--[[
	Get the Boolean Status from this Addon Class
]]
function LS.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function LS.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function LS.GetExtraOptions()
	return {}
end

--[[
	Get the Custom String Status from this Addon Class
]]
function LS.GetCustomStatus()
	return CAF.GetLangVar("Not Implemented Yet")
end

function LS.AddResourcesToSend()
end

CAF.RegisterAddon("Life Support", LS, "2")

--Extra Methodes
function LS.AddAirRegulator(ent)
	if ent.GetLSClass and ent:GetLSClass() == "air exchanger" then
		if table.insert(LS.generators.air, ent) then
		--table.insert(LS.generators.air, ent)
		--	Msg("Added Air Exchanger\n");
			return true
		end
		--Msg("Not Added Air Exchanger\n");
	end
	--Msg("Not Added Air Exchanger\n");
	return false
end

function LS.AddTemperatureRegulator(ent)
	if ent.GetLSClass and ent:GetLSClass() == "temperature exchanger" then
		if table.insert(LS.generators.temperature, ent) then
		--table.insert(LS.generators.temperature, ent)
			--Msg("Added Temp Exchanger\n");
			return true
		end
		--Msg("Not Added temp Exchanger\n");
	end
	--Msg("Not Added temp Exchanger\n");
	return false
end

function LS.RemoveAirRegulator(ent)
	for k, v in pairs(LS.generators.air) do
		if v == ent then
			table.remove(LS.generators.air, k)
		end
	end
end

function LS.RemoveTemperatureRegulator(ent)
	for k, v in pairs(LS.generators.temperature) do
		if v == ent then
			table.remove(LS.generators.temperature, k)
		end
	end
end

function LS.GetAirRegulators()
	return LS.generators.air or {}
end

function LS.GetTemperatureRegulators()
	return LS.generators.temperature or {}
end
