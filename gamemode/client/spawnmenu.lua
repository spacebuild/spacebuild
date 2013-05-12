--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 21/12/12
-- Time: 13:38
-- To change this template use File | Settings | File Templates.
--

local GM = GM
local spawnMenu

--[[---------------------------------------------------------
	If false is returned then the spawn menu is never created.
	This saves load times if your mod doesn't actually use the
	spawn menu for any reason.
-----------------------------------------------------------]]
function GM:SpawnMenuEnabled()
    return true
end

--[[---------------------------------------------------------
  Called when spawnmenu is trying to be opened.
   Return false to dissallow it.
-----------------------------------------------------------]]
function GM:SpawnMenuOpen()
    return true

end

--[[---------------------------------------------------------
  Called when context menu is trying to be opened.
   Return false to dissallow it.
-----------------------------------------------------------]]
function GM:ContextMenuOpen()
    return false
end


--[[---------------------------------------------------------
  Called to populate the Scripted Tool menu. Overridden
   by the sandbox gamemode.
-----------------------------------------------------------]]
function GM:PopulateSTOOLMenu()
end


--[[---------------------------------------------------------
  Called right before the Lua Loaded tool menus are reloaded
-----------------------------------------------------------]]
function GM:PreReloadToolsMenu()

end

--[[---------------------------------------------------------
  Called right after the Lua Loaded tool menus are reloaded
  This is a good place to set up any ControlPanels
-----------------------------------------------------------]]
function GM:PostReloadToolsMenu()
end

--[[---------------------------------------------------------
	Guess what this does. See the bottom of stool.lua
-----------------------------------------------------------]]
function GM:PopulateToolMenu()
end

function GM:OnSpawnMenuOpen()

    if ( IsValid(spawnMenu) ) then return end
    spawnMenu = vgui.Create('DSBMenu2')

    spawnMenu:Show()

end

function GM:OnSpawnMenuClose()

    if ( IsValid(spawnMenu) ) then
        spawnMenu:close()
        spawnMenu = nil
    end

end
