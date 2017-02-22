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
-- @description Library frame_blend
 module("frame_blend")

--- frame_blend.AddFrame
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function AddFrame() end

--- frame_blend.BlendFrame
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function BlendFrame() end

--- frame_blend.CompleteFrame
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function CompleteFrame() end

--- frame_blend.DrawPreview
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function DrawPreview() end

--- frame_blend.IsActive
-- @usage client
-- Returns whether frame blend post processing effect is enabled or not.
--
-- @return boolean Is frame blend enabled or not
function IsActive() end

--- frame_blend.IsLastFrame
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return boolean Whether the current frame is the last frame?
function IsLastFrame() end

--- frame_blend.RenderableFrames
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return number Amount of frames needed to render?
function RenderableFrames() end

--- frame_blend.ShouldSkipFrame
-- @usage client
-- Returns whether we should skip frame or not
--
-- @return boolean Should the frame be skipped or not
function ShouldSkipFrame() end
