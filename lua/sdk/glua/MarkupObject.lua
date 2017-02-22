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
-- @description Library MarkupObject
 module("MarkupObject")

--- MarkupObject:Create
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return MarkupObject The created object.
function Create() end

--- MarkupObject:Draw
-- @usage client
-- Draws the computed markupobject to the screen.
--
-- @param  xOffset number  The X coordinate on the screen.
-- @param  yOffset number  The Y coordinate on the screen.
-- @param  xAlign number  The alignment of the x coordinate using TEXT_ALIGN_ Enums
-- @param  yAlign number  The alignment of the y coordinate using TEXT_ALIGN_ Enums
-- @param  alphaoverride=255 number  Sets the alpha of all drawn objects to this.
function Draw( xOffset,  yOffset,  xAlign,  yAlign,  alphaoverride) end

--- MarkupObject:GetHeight
-- @usage client
-- Gets computed the height of the markupobject.
--
-- @return number The computed height.
function GetHeight() end

--- MarkupObject:GetWidth
-- @usage client
-- Gets computed the width of the markupobject.
--
-- @return number The computed width.
function GetWidth() end

--- MarkupObject:Size
-- @usage client
-- Gets computed the width and height of the markupobject.
--
-- @return number The computed width.
-- @return number The computed height.
function Size() end
