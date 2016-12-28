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


