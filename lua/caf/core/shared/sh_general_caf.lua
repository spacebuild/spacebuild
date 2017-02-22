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

local CAF2 = CAF;
local CAF3 = CAF2.CAF3;
local DEBUG = CAF3.DEBUG;
local Addons = CAF3.Addons
local addonlevel = CAF3.addonlevel
local hooks = CAF3.hooks

--Language Settings

local DefaultLang = "english"

function CAF2.begintime()
	return os.clock( );
end

function CAF2.endtime(begintime)
	return CAF2.begintime() - begintime;
end


--END Language Settings

CAF2.version = 0.5

--COLOR Settings

CAF2.colors = {}
CAF2.colors.red = Color(230, 0, 0, 230)
CAF2.colors.green = Color(0, 230, 0, 230)
CAF2.colors.white = Color(255, 255, 255, 255)

--END COLOR Settings

CAF2.currentlanguage = GetConVar("gmod_language"):GetString()

function CAF3.Think()
	if CAF ~= CAF2 then
		CAF = CAF2
	end
	for k , v in pairs(hooks["think"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think Error: " ..err .."\n")
		end
	end
end
hook.Add("Think", "CAF Think", CAF3.Think) --Always on!!

function CAF3.Think2()
	for k , v in pairs(hooks["think2"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think2 Error: " ..err .."\n")
		end
	end
end


function CAF3.Think3()
	for k , v in pairs(hooks["think3"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think3 Error: " ..err .."\n")
		end
	end
end

--[[
	This function can be called to register a Hook (similar to Hook.add)
	Possibly Hooks are:
		think: Just like the default Think Hook
		think2: Updates every 0.5 seconds
		think3: Updates every Second
		OnEntitySpawn: Get's called when an entity spawns (parameters: Entity, Type(string), Player who spawned it)
		OnAddonDestruct: Gets called when an addon gets disabled (Parameters: Name of addon)
		OnAddonConstruct: Get called when an addon gets Enabled (parameters: Name of addon)
		OnAddonExtraOptionChange: Gets called when an Extra option on an addon changes (Parameters: Addonname, CustomStatusname, NewStatus value)
		
]]
function CAF2.AddHook(HookName, func)
	if  not HookName then return false , CAF.GetLangVar("No HookName given") end
	if not func then return false , CAF.GetLangVar("No function given") end
	if not hooks[HookName] then return false , CAF.GetLangVar("This hook doesn't exist") end
	table.insert(hooks[HookName], func)
	if(HookName == "think") then

	elseif(HookName == "think2") then
		if(#hooks[HookName] == 1) then
			timer.Create( "CAF Think 2", 0.5, 0, CAF3.Think2 )
		end
	elseif(HookName == "think3") then
		if(#hooks[HookName] == 1) then
			timer.Create( "CAF Think 3", 1, 0, CAF3.Think3 )
		end
	end
	return true
end

--[[
	Remove the functions you added to a certain hook from here
]]
function CAF2.RemoveHook(HookName, func)
	if  not HookName then return false , CAF.GetLangVar("No HookName given") end
	if not func then return false , CAF.GetLangVar("No function given") end
	if not hooks[HookName] then return false , CAF.GetLangVar("This hook doesn't exist") end
	for k, v in pairs(hooks[HookName]) do
		if (v == func) then
			table.remove(hooks[HookName], k)
		end
	end
	if(HookName == "think") then
	
	elseif(HookName == "think2") then
		if(#hooks[HookName] == 0) then
			timer.Destroy("CAF Think 2")  
		end
	elseif(HookName == "think3") then
		if(#hooks[HookName] == 0) then
			timer.Destroy("CAF Think 3")  
		end
	end
	return true
end

--[[
	Returns the Status of an extra option of an Addon or nil when not found
]]
function CAF2.GetExtraOptionStatus(AddonName, OptionName)
	if not AddonName then return nil , CAF.GetLangVar("No AddonName given") end
	if not OptionName then return nil , CAF.GetLangVar("No OptionName given") end
	if( Addons[AddonName]) then
		if( Addons[AddonName].GetExtraOptions) then
			local tmp =  Addons[AddonName].GetExtraOptions()
			if (tmp) then
				if(tmp[OptionName]) then
					return tmp[OptionName].status
				end
				return nil , CAF.GetLangVar("This option wasn't found for this Addon")
			end
		end
		return nil , CAF.GetLangVar("No Extra options found for this Addon")
	end
	return nil , CAF.GetLangVar("Addon Not Found")	
end

--[[
	Returns the boolean status of an Addon
]]
function CAF2.GetAddonStatus(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, status = pcall(Addons[AddonName].GetStatus)
		if(ok) then
			return status
		end
	end
	return nil , "No Status Info Found"
end

--[[
	Returns the custom status of the addon (if available)
]]
function CAF2.GetAddonCustomStatus(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, status = pcall(Addons[AddonName].GetCustomStatus)
		if(ok) then
			return status
		end
	end
	return nil , "No Custom Status Info Found"
end

--[[
	Returns the Number and String version of this addon
]]
function CAF2.GetAddonVersion(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, version, strver = pcall(Addons[AddonName].GetVersion)
		if(ok) then
			return version, strver
		end
	end
	return nil , "No Version Info Found"
end

--[[
	Returns the reference to the Custom Addon, nil if not existant
]]
function CAF2.GetAddon(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	return Addons[AddonName]
end

--[[
	Registers an addon with the game name into the table
	Overwrites if 2 addons use the same name
]]
function CAF2.RegisterAddon(AddonName, AddonClass, level)
	if not AddonName then return nil , "No AddonName given" end
	if not AddonClass then return nil , "No AddonClass given" end
	if not level then level = 5 end
	level = tonumber(level)
	if level < 1 then
		level = 1
	elseif level > 5 then
		level = 5
	end
	Addons[AddonName] = AddonClass
	table.insert(addonlevel[level], AddonName)
	return  true
end

function CAF2.GetLangVar(name)
	if CAF2.LANGUAGE then
		if CAF2.LANGUAGE[CAF.currentlanguage] then
			return CAF2.LANGUAGE[CAF.currentlanguage][name] or name or "Unknown"
		end
		if CAF2.LANGUAGE[DefaultLang] then
			return CAF2.LANGUAGE[DefaultLang][name] or name or "Unknown"
		end
	end
	return name or "Unknown"
end





