---
-- @description Library Material
 module("Material")

--- Material:SetAlpha
-- @usage client
-- Sets the alpha value of the Material panel.
--
-- @param  alpha number  The alpha value, from 0 to 255.
function SetAlpha( alpha) end

--- Material:SetMaterial
-- @usage client
-- Sets the material used by the panel.
--
-- @param  matname string  The file path of the material to set (relative to "garrysmod/materials/").
function SetMaterial( matname) end
