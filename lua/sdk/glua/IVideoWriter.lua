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
-- @description Library IVideoWriter
 module("IVideoWriter")

--- IVideoWriter:AddFrame
-- @usage client
-- Adds the current framebuffer to the video stream.
--
-- @param  frameTime number  Usually set to what FrameTime is, or simply 1/fps.
-- @param  downsample boolean  If true it will downsample the whole screenspace to the videos width and height, otherwise it will just record from the top left corner to the given width and height and therefor not the whole screen.
function AddFrame( frameTime,  downsample) end

--- IVideoWriter:Finish
-- @usage client
-- Ends the video recording and dumps it to disk.
--
function Finish() end

--- IVideoWriter:Height
-- @usage client
-- Returns the height of the video stream.
--
-- @return number height
function Height() end

--- IVideoWriter:SetRecordSound
-- @usage client
-- Sets whether to record sound or not.
--
-- @param  record boolean  Record.
function SetRecordSound( record) end

--- IVideoWriter:Width
-- @usage client
-- Returns the width of the video stream.
--
-- @return number width
function Width() end
