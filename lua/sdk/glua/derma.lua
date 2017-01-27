---
-- @description Library derma
 module("derma")

--- derma.Color
-- @usage client_m
-- Gets the color from a Derma skin of a panel and returns default color if not found
--
-- @param  name string 
-- @param  pnl Panel 
-- @param  default table  The default color in case of failure.
function Color( name,  pnl,  default) end

--- derma.DefineControl
-- @usage client_m
-- Defines a new Derma control with an optional base
--
-- @param  name string  Name of the newly created control
-- @param  description string  Description of the control
-- @param  tab table  Table containing control methods and properties
-- @param  base string  Derma control to base the new control off of
-- @return table A table containing the new control's methods and properties
function DefineControl( name,  description,  tab,  base) end

--- derma.DefineSkin
-- @usage client_m
-- Defines a new skin so that it is usable by Derma. The default skin can be found in "garrysmod/lua/skins/default.lua"
--
-- @param  name string  Name of the skin
-- @param  descriptions string  Description of the skin
-- @param  skin table  Table containing skin data
function DefineSkin( name,  descriptions,  skin) end

--- derma.GetControlList
-- @usage client_m
-- Returns the derma.Controls table.
--
-- @return table A listing of all available derma-based controls.
function GetControlList() end

--- derma.GetDefaultSkin
-- @usage client_m
-- Returns the default skin table, which can be changed with the hook GM/ForceDermaSkin
--
-- @return table Skin table
function GetDefaultSkin() end

--- derma.GetNamedSkin
-- @usage client_m
-- Returns the skin table of the skin with the supplied name
--
-- @param  name string  Name of skin
-- @return table Skin table
function GetNamedSkin( name) end

--- derma.GetSkinTable
-- @usage client_m
-- Returns a copy of the table containing every Derma skin
--
-- @return table Table of every Derma skin
function GetSkinTable() end

--- derma.RefreshSkins
-- @usage client_m
-- Clears all cached panels so that they reassess which skin they should be using.
--
function RefreshSkins() end

--- derma.SkinChangeIndex
-- @usage client_m
-- Returns how many times derma.RefreshSkins has been called.
--
-- @return number Amount of times derma.RefreshSkins has been called.
function SkinChangeIndex() end

--- derma.SkinHook
-- @usage client_m
-- Calls the specified hook for the given panel
--
-- @param  type string  The type of hook to run
-- @param  name string  The name of the hook to run
-- @param  panel Panel  The panel to call the hook for
-- @param  w number  The width of the panel
-- @param  h number  The height of the panel
-- @return any The returned variable from the skin hook
function SkinHook( type,  name,  panel,  w,  h) end

--- derma.SkinTexture
-- @usage client_m
-- Returns a function to draw a specified texture of panels skin.
--
-- @param  name string  The identifier of the texture
-- @param  pnl Panel  Panel to get the skin of.
-- @param  fallback=nil any  What to return if we failed to retrieve the texture
-- @return function A function that is created with the GWEN library to draw a texture.
function SkinTexture( name,  pnl,  fallback) end
