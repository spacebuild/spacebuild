---
-- @description Library DColorCube
 module("DColorCube")

--- DColorCube:GetRGB
-- @usage client
-- Returns the color cube's current set color.
--
-- @return table The set color, uses Color structure.
function GetRGB() end

--- DColorCube:OnUserChanged
-- @usage client
-- Function which is called when the color cube slider is moved (through user input). Meant to be overridden.
--
-- @param  color table  The new color, uses Color structure.
function OnUserChanged( color) end

--- DColorCube:SetBaseRGB
-- @usage client
-- Sets the base color and the color used to draw the color cube panel itself.
--
-- @param  color table  The base color to set, uses Color structure.
function SetBaseRGB( color) end

--- DColorCube:SetColor
-- @usage client
-- Sets the base color of the color cube and updates the slider position.
--
-- @param  color table  The color to set, uses Color structure.
function SetColor( color) end

--- DColorCube:TranslateValues
-- @usage client
-- Updates the color cube RGB based on the given x and y position and returns its arguments. Similar to DColorCube:UpdateColor.
--
-- @param  x number  The x position to sample color from/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
-- @param  y number  The y position to sample color from/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).
-- @return number The given x position.
-- @return number The given y position.
function TranslateValues( x,  y) end

--- DColorCube:UpdateColor
-- @usage client
-- Updates the color cube RGB based on the given x and y position. Similar to DColorCube:TranslateValues.
--
-- @param  x number  The x position to set color to/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
-- @param  y number  The y position to set color to/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).
function UpdateColor( x,  y) end
