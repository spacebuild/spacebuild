---
-- @description Library debugoverlay
 module("debugoverlay")

--- debugoverlay.Axis
-- @usage shared
-- Displays an axis indicator at the specified position.
--
-- @param  origin Vector  Position origin
-- @param  ang Angle  Angle of the axis
-- @param  size number  Size of the axis
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  ignoreZ=false boolean  If true, will draw on top of everything; ignoring the Z buffer
function Axis( origin,  ang,  size,  lifetime,  ignoreZ) end

--- debugoverlay.Box
-- @usage shared
-- Displays a solid coloured cube at the specified position.
--
-- @param  origin Vector  Position origin
-- @param  mins Vector  Minimum bounds of the cube
-- @param  maxs Vector  Maximum bounds of the cube
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
function Box( origin,  mins,  maxs,  lifetime,  color) end

--- debugoverlay.BoxAngles
-- @usage shared
-- Displays a solid colored rotated cube at the specified position.
--
-- @param  pos Vector  World position
-- @param  mins Vector  The mins of the cube ( Lowest corner )
-- @param  maxs Vector  The maxs of the cube ( Highest corner )
-- @param  ang Angle  The angle to draw the box at
-- @param  lifetime=1 number  Amount of seconds to show the box
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
function BoxAngles( pos,  mins,  maxs,  ang,  lifetime,  color) end

--- debugoverlay.Cross
-- @usage shared
-- Creates a coloured cross at the specified position for the specified time.
--
-- @param  position Vector  Position origin
-- @param  size number  Size of the cross
-- @param  lifetime=1 number  Number of seconds the cross to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the cross. Uses the Color structure
-- @param  ignoreZ=false boolean  If true, will draw on top of everything; ignoring the Z buffer
function Cross( position,  size,  lifetime,  color,  ignoreZ) end

--- debugoverlay.EntityTextAtPosition
-- @usage shared
-- Displays 2D text at the specified coordinates.
--
-- @param  pos Vector  The position in 3D to display the text.
-- @param  line number  Line of text, will offset text on the to display the new line unobstructed
-- @param  text string  The text to display
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
function EntityTextAtPosition( pos,  line,  text,  lifetime,  color) end

--- debugoverlay.Grid
-- @usage shared
-- Draws a 3D grid of limited size in given position.
--
-- @param  position Vector 
function Grid( position) end

--- debugoverlay.Line
-- @usage shared
-- Displays a coloured line at the specified position.
--
-- @param  pos1 Vector  First position of the line
-- @param  pos2 Vector  Second position of the line
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the line. Uses the Color structure
-- @param  ignoreZ=false boolean  If true, will draw on top of everything; ignoring the Z buffer
function Line( pos1,  pos2,  lifetime,  color,  ignoreZ) end

--- debugoverlay.ScreenText
-- @usage shared
-- Displays text triangle at the specified coordinates.
--
-- @param  x number  The position of the text, from 0 ( left ) to 1 ( right ).
-- @param  y number  The position of the text, from 0 ( top ) to 1 ( bottom ).
-- @param  text string  The text to display
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
function ScreenText( x,  y,  text,  lifetime,  color) end

--- debugoverlay.Sphere
-- @usage shared
-- Displays a coloured sphere at the specified position.
--
-- @param  origin Vector  Position origin
-- @param  size number  Size of the sphere
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the sphere. Uses the Color structure
-- @param  ignoreZ=false boolean  If true, will draw on top of everything; ignoring the Z buffer
function Sphere( origin,  size,  lifetime,  color,  ignoreZ) end

--- debugoverlay.SweptBox
-- @usage shared
-- Displays "swept" box, two boxes connected with lines by their verices.
--
-- @param  vStart Vector  The start position of the box.
-- @param  vEnd Vector  The end position of the box.
-- @param  vMins Vector  The "minimum" edge of the box.
-- @param  vMaxs Vector  The "maximum" edge of the box.
-- @param  ang Angle 
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
function SweptBox( vStart,  vEnd,  vMins,  vMaxs,  ang,  lifetime,  color) end

--- debugoverlay.Text
-- @usage shared
-- Displays text at the specified position.
--
-- @param  origin Vector  Position origin
-- @param  text string  String message to display
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  viewCheck=false boolean  Clip text that is obscured
function Text( origin,  text,  lifetime,  viewCheck) end

--- debugoverlay.Triangle
-- @usage shared
-- Displays a colored triangle at the specified coordinates.
--
-- @param  pos1 Vector  First point of the triangle
-- @param  pos2 Vector  Second point of the triangle
-- @param  pos3 Vector  Third point of the triangle
-- @param  lifetime=1 number  Number of seconds to appear
-- @param  color=Color( 255, 255, 255 ) table  The color of the box. Uses the Color structure
-- @param  ignoreZ=false boolean  If true, will draw on top of everything; ignoring the Z buffer
function Triangle( pos1,  pos2,  pos3,  lifetime,  color,  ignoreZ) end
