---
-- @description Library vgui
 module("vgui")

--- vgui.Create
-- @usage client_m
-- Creates a panel by the specified classname.
--
-- @param  classname string  Classname of the panel to create. Valid classnames are listed at: VGUI Element List.
-- @param  parent=nil Panel  Parent of the created panel.
-- @param  name=nil string  Name of the created panel.
-- @return Panel panel
function Create( classname,  parent,  name) end

--- vgui.CreateFromTable
-- @usage client_m
-- Creates a panel from table.
--
-- @param  metatable table  Your PANEL table
-- @param  parent=nil Panel  Which panel to parent the newly created panel to
-- @param  name=nil string  Name of your panel
-- @return Panel Created panel
function CreateFromTable( metatable,  parent,  name) end

--- vgui.CreateX
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  class string  Class of the panel to create
-- @param  parent=nil Panel  If specified, parents created panel to given one
-- @param  name=nil string  Name of the created panel
-- @return Panel Created panel
function CreateX( class,  parent,  name) end

--- vgui.CursorVisible
-- @usage client_m
-- Returns whenever the cursor is currently active and visible.
--
-- @return boolean isCursorVisible
function CursorVisible() end

--- vgui.FocusedHasParent
-- @usage client_m
-- Returns whether the currently focused panel is a child of the given one.
--
-- @param  parent Panel  The parent panel to check the currently focused one against. This doesn't need to be a direct parent (focused panel can be a child of a child and so on).
-- @return boolean Whether or not the focused panel is a child of the passed one.
function FocusedHasParent( parent) end

--- vgui.GetControlTable
-- @usage client_m
-- Gets the method table of this panel. Does not return parent methods!
--
-- @param  Panelname string  The name of the panel
-- @return table methods
function GetControlTable( Panelname) end

--- vgui.GetHoveredPanel
-- @usage client_m
-- Returns the panel the cursor is hovering above.
--
-- @return Panel The panel that the user is currently hovering over with their cursor.
function GetHoveredPanel() end

--- vgui.GetKeyboardFocus
-- @usage client_m
-- Returns the panel which is currently receiving keyboard input.
--
-- @return Panel The panel with keyboard focus
function GetKeyboardFocus() end

--- vgui.GetWorldPanel
-- @usage client_m
-- Returns the global world panel which is the parent to all others.
--
-- @return Panel The world panel
function GetWorldPanel() end

--- vgui.IsHoveringWorld
-- @usage client_m
-- Returns whenever the cursor is hovering the world panel.
--
-- @return boolean isHoveringWorld
function IsHoveringWorld() end

--- vgui.Register
-- @usage client_m
-- Registers a panel for later creation.
--
-- @param  classname string  Classname of the panel to create.
-- @param  panelTable table  The table containg the panel information.
-- @param  baseName string  Name of the base of the panel.
-- @return Panel panel
function Register( classname,  panelTable,  baseName) end

--- vgui.RegisterFile
-- @usage client_m
-- Registers a new VGUI panel from a file.
--
-- @param  file string  The file to register
-- @return table A table containing info about the panel. Can be supplied to vgui.CreateFromTable
function RegisterFile( file) end

--- vgui.RegisterTable
-- @usage client_m
-- Registers a table to use as a panel. All this function does is assigns Base key to your table and returns the table.
--
-- @param  panel table  The PANEL table
-- @param  base=Panel string  A base for the panel
-- @return table The PANEL table
function RegisterTable( panel,  base) end
