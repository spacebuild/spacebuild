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

---
-- @description Library DFrame
 module("DFrame")

--- DFrame:Center
-- @usage client
-- Centers the frame relative to the whole screen and invalidates its layout. This overrides Panel:Center.
--
function Center() end

--- DFrame:Close
-- @usage client
-- Hides or removes the DFrame, and calls DFrame:OnClose.
--
function Close() end

--- DFrame:GetBackgroundBlur
-- @usage client
-- Gets whether the background behind the frame is being blurred.
--
-- @return boolean Whether or not background blur is enabled.
function GetBackgroundBlur() end

--- DFrame:GetDeleteOnClose
-- @usage client
-- Determines whether or not the DFrame will be removed when it is closed. This is set with DFrame:SetDeleteOnClose.
--
-- @return boolean Whether or not the frame will be removed on close.
function GetDeleteOnClose() end

--- DFrame:GetDraggable
-- @usage client
-- Gets whether or not the frame is draggable by the user.
--
-- @return boolean Whether the frame is draggable or not.
function GetDraggable() end

--- DFrame:GetIsMenu
-- @usage client
-- Gets whether or not the frame is part of a derma menu. This is set with DFrame:SetIsMenu.
--
-- @return boolean Whether or not this frame is a menu component.
function GetIsMenu() end

--- DFrame:GetMinHeight
-- @usage client
-- Gets the minimum height the DFrame can be resized to by the user.
--
-- @return number The minimum height the user can resize the frame to.
function GetMinHeight() end

--- DFrame:GetMinWidth
-- @usage client
-- Gets the minimum width the DFrame can be resized to by the user.
--
-- @return number The minimum width the user can resize the frame to.
function GetMinWidth() end

--- DFrame:GetPaintShadow
-- @usage client
-- Gets whether or not the shadow effect bordering the DFrame is being drawn.
--
-- @return boolean Whether or not the shadow is being drawn.
function GetPaintShadow() end

--- DFrame:GetScreenLock
-- @usage client
-- Gets whether or not the DFrame is restricted to the boundaries of the screen resolution.
--
-- @return boolean Whether or not the frame is restricted.
function GetScreenLock() end

--- DFrame:GetSizable
-- @usage client
-- Gets whether or not the DFrame can be resized by the user.
--
-- @return boolean Whether the frame can be resized or not.
function GetSizable() end

--- DFrame:IsActive
-- @usage client
-- Determines if the frame or one of its children has the screen focus.
--
-- @return boolean Whether or not the frame has focus.
function IsActive() end

--- DFrame:OnClose
-- @usage client
-- Called when the DFrame is closed with DFrame:Close. This applies when the close button in the DFrame's control box is clicked.
--
function OnClose() end

--- DFrame:SetBackgroundBlur
-- @usage client
-- Blurs background behind the frame.
--
-- @param  blur boolean  Whether or not to create background blur or not.
function SetBackgroundBlur( blur) end

--- DFrame:SetDeleteOnClose
-- @usage client
-- Determines whether or not the DFrame is removed when it is closed with DFrame:Close.
--
-- @param  shouldDelete boolean  Whether or not to delete the frame on close. This is true by default.
function SetDeleteOnClose( shouldDelete) end

--- DFrame:SetDraggable
-- @usage client
-- Sets whether the frame should be draggable by the user. The DFrame can only be dragged from its title bar.
--
-- @param  draggable boolean  Whether to be draggable or not.
function SetDraggable( draggable) end

--- DFrame:SetIsMenu
-- @usage client
-- Sets whether the frame is part of a derma menu or not.
--
-- @param  isMenu boolean  Whether or not this frame is a menu component.
function SetIsMenu( isMenu) end

--- DFrame:SetMinHeight
-- @usage client
-- Sets the minimum height the DFrame can be resized to by the user.
--
-- @param  minH number  The minimum height the user can resize the frame to.
function SetMinHeight( minH) end

--- DFrame:SetMinWidth
-- @usage client
-- Sets the minimum width the DFrame can be resized to by the user.
--
-- @param  minW number  The minimum width the user can resize the frame to.
function SetMinWidth( minW) end

--- DFrame:SetPaintShadow
-- @usage client
-- Sets whether or not the shadow effect bordering the DFrame should be drawn.
--
-- @param  shouldPaint boolean  Whether or not to draw the shadow. This is true by default.
function SetPaintShadow( shouldPaint) end

--- DFrame:SetScreenLock
-- @usage client
-- Sets whether the DFrame is restricted to the boundaries of the screen resolution.
--
-- @param  lock boolean  If true, the frame cannot be dragged outside of the screen bounds
function SetScreenLock( lock) end

--- DFrame:SetSizable
-- @usage client
-- Sets whether or not the DFrame can be resized by the user.
--
-- @param  sizeable boolean  Whether the frame should be resizeable or not.
function SetSizable( sizeable) end

--- DFrame:SetTitle
-- @usage client
-- Sets the title of the frame.
--
-- @param  title string  New title of the frame.
function SetTitle( title) end

--- DFrame:ShowCloseButton
-- @usage client
-- Determines whether the DFrame's control box (close, minimise and maximise buttons) is displayed.
--
-- @param  show boolean  false hides the control box; this is true by default.
function ShowCloseButton( show) end
