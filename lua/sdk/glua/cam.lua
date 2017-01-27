---
-- @description Library cam
 module("cam")

--- cam.ApplyShake
-- @usage client
-- Shakes the screen at a certain position.
--
-- @param  pos Vector  Origin of the shake.
-- @param  angles Angle  Angles of the shake.
-- @param  factor number  The shake factor.
function ApplyShake( pos,  angles,  factor) end

--- cam.End
-- @usage client
-- Switches the renderer back to the previous drawing mode from a 3D context.
--
function End() end

--- cam.End2D
-- @usage client
-- Switches the renderer back to the previous drawing mode from a 2D context.
--
function End2D() end

--- cam.End3D
-- @usage client
-- Switches the renderer back to the previous drawing mode from a 3D context.
--
function End3D() end

--- cam.End3D2D
-- @usage client
-- Switches the renderer back to the previous drawing mode from a 3D2D context.
--
function End3D2D() end

--- cam.EndOrthoView
-- @usage client
-- Switches the renderer back to the previous drawing mode from a 3D orthographic rendering context.
--
function EndOrthoView() end

--- cam.IgnoreZ
-- @usage client
-- Tells the renderer to ignore the depth buffer and draw any upcoming operation "ontop" of everything that was drawn yet.
--
-- @param  ignoreZ boolean  Determines whenever to ignore the depth buffer or not.
function IgnoreZ( ignoreZ) end

--- cam.PopModelMatrix
-- @usage client
-- Pops the current active rendering matrix from the stack and reinstates the previous one.
--
function PopModelMatrix() end

--- cam.PushModelMatrix
-- @usage client
-- Pushes the specified matrix onto the render matrix stack. Unlike opengl, this will replace the current model matrix.
--
-- @param  matrix VMatrix  The matrix to push.
function PushModelMatrix( matrix) end

--- cam.Start
-- @usage client
-- Sets up a new rendering context. You can easily use this instead of cam.Start3D or cam.Start2D
--
-- @param  dataTbl table  Render context config. See RenderCamData structure
function Start( dataTbl) end

--- cam.Start2D
-- @usage client
-- Sets up a new 2D rendering context. Must be finished by cam.End2D.
--
function Start2D() end

--- cam.Start3D
-- @usage client
-- Sets up a new 3D rendering context. Must be finished by cam.End3D.
--
-- @param () Vector  Render cam position.
-- @param () Angle  Render cam angles.
-- @param  fov=nil number  Field of view.
-- @param  x=0 number  X coordinate of where to start the new view port.
-- @param  y=0 number  Y coordinate of where to start the new view port.
-- @param () number  Width of the new viewport.
-- @param () number  Height of the new viewport.
-- @param  zNear=nil number  Distance to near clipping plane.
-- @param  zFar=nil number  Distance to far clipping plane.
function Start3D((), (),  fov,  x,  y, (), (),  zNear,  zFar) end

--- cam.Start3D2D
-- @usage client
-- Sets up a new 2D rendering context. Must be finished by cam.End3D2D.
--
-- @param  pos Vector  Origin of the 3D2D context, ie. the top left corner, (0, 0).
-- @param  angles Angle  Angles of the 3D2D context. +x in the 2d context corresponds to +x of the angle (its forward direction).  +y in the 2d context corresponds to -y of the angle (its right direction).
-- @param  scale number  The scale of the render context.  If scale is 1 then 1 pixel in 2D context will equal to 1 unit in 3D context.
function Start3D2D( pos,  angles,  scale) end

--- cam.StartOrthoView
-- @usage client
-- Sets up a new 3d context using orthographic projection.
--
-- @param  leftOffset number  The left plane offset.
-- @param  topOffset number  The top plane offset.
-- @param  rightOffset number  The right plane offset.
-- @param  bottomOffset number  The bottom plane offset.
function StartOrthoView( leftOffset,  topOffset,  rightOffset,  bottomOffset) end
