---
-- @description Library ContentIcon
 module("ContentIcon")

--- ContentIcon:GetColor
-- @usage client
-- Returns the color set by ContentIcon:SetColor
--
-- @return table See Color structure
function GetColor() end

--- ContentIcon:GetContentType
-- @usage client
-- Returns the content type used to save and restore the content icon in a spawnlist.
--
-- @return string The content type, for example "entity" or "weapon".
function GetContentType() end

--- ContentIcon:GetNPCWeapon
-- @usage client
-- Returns a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.
--
-- @return table A table of weapon classes to be chosen from when user tries to spawn the NPC.
function GetNPCWeapon() end

--- ContentIcon:GetSpawnName
-- @usage client
-- Returns the internal "name" for the content icon, usually a class name for an entity.
--
-- @return string Internal "name" to be used when user left clicks the icon.
function GetSpawnName() end

--- ContentIcon:OpenMenu
-- @usage client
-- A hook for override, by default does nothing. Called when user right clicks on the content icon, you are supposed to open a DermaMenu here with additional options.
--
function OpenMenu() end

--- ContentIcon:SetAdminOnly
-- @usage client
-- Sets whether the content item is admin only. This makes the icon to display a admin icon in the top left corner of the icon.
--
-- @param  adminOnly boolean  Whether this content should be admin only or not
function SetAdminOnly( adminOnly) end

--- ContentIcon:SetColor
-- @usage client
-- Sets the color for the content icon. Currently is not used by the content icon panel.
--
-- @param  clr table  The color to set. See Color structure
function SetColor( clr) end

--- ContentIcon:SetContentType
-- @usage client
-- Sets the content type used to save and restore the content icon in a spawnlist.
--
-- @param  type string  The content type, for example "entity" or "weapon"
function SetContentType( type) end

--- ContentIcon:SetMaterial
-- @usage client
-- Sets the material to be displayed as the content icon.
--
-- @param  path string  Path to the icon to use.
function SetMaterial( path) end

--- ContentIcon:SetName
-- @usage client
-- Sets the tool tip and the "nice" name to be displayed by the content icon.
--
-- @param  name string  "Nice" name to display.
function SetName( name) end

--- ContentIcon:SetNPCWeapon
-- @usage client
-- Sets a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.
--
-- @param  weapons table  A table of weapon classes to be chosen from when user tries to spawn the NPC.
function SetNPCWeapon( weapons) end

--- ContentIcon:SetSpawnName
-- @usage client
-- Sets the internal "name" for the content icon, usually a class name for an entity.
--
-- @param  name string  Internal "name" to be used when user left clicks the icon.
function SetSpawnName( name) end
