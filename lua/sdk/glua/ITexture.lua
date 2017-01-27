---
-- @description Library ITexture
 module("ITexture")

--- ITexture:Download
-- @usage shared
-- Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.
--
function Download() end

--- ITexture:GetColor
-- @usage shared
-- Returns the color of the specified pixel, only works for textures created from PNG files.
--
-- @param  x number  The X coordinate.
-- @param  y number  The Y coordinate.
-- @return table The color of the pixel as a Color structure.
function GetColor( x,  y) end

--- ITexture:GetMappingHeight
-- @usage shared
-- Returns the true unmodified height of the texture.
--
-- @return number height
function GetMappingHeight() end

--- ITexture:GetMappingWidth
-- @usage shared
-- Returns the true unmodified width of the texture.
--
-- @return number width
function GetMappingWidth() end

--- ITexture:GetName
-- @usage shared
-- Returns the name of the texture, in most cases the path.
--
-- @return string name
function GetName() end

--- ITexture:Height
-- @usage shared
-- Returns the modified height of the texture, this value may be affected by mipmapping and other factors.
--
-- @return number height
function Height() end

--- ITexture:IsError
-- @usage shared
-- Returns whenever the texture is invalid or not.
--
-- @return boolean isError
function IsError() end

--- ITexture:Width
-- @usage shared
-- Returns the modified width of the texture, this value may be affected by mipmapping and other factors.
--
-- @return number width
function Width() end
