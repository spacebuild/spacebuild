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
-- @description Library render
 module("render")

--- render.AddBeam
-- @usage client
-- Adds a beam segment to the beam started by render.StartBeam.
--
-- @param  startPos Vector  Beam start position.
-- @param  width number  The width of the beam.
-- @param  textureEnd number  The end coordinate of the texture used.
-- @param  color table  The color to be used. Uses the Color structure.
function AddBeam( startPos,  width,  textureEnd,  color) end

--- render.BlurRenderTarget
-- @usage client
-- Blurs the render target ( or a given texture )
--
-- @param  rendertarget ITexture  The texture to blur
-- @param  blurx number  Horizontal amount of blur
-- @param  blury number  Vertical amount of blur
-- @param  passes number  Amount of passes to go through
function BlurRenderTarget( rendertarget,  blurx,  blury,  passes) end

--- render.BrushMaterialOverride
-- @usage client
-- 
--
--WARNING
--
--This function is broken and does absolutely nothing
--
-- @param  mat=nil IMaterial   
function BrushMaterialOverride( mat) end

--- render.Capture
-- @usage client
-- Captures a part of the current render target and returns the data as a binary string in the given format.
--
-- @param  captureData table  Parameters of the capture. See RenderCaptureData structure
-- @return string binaryData
function Capture( captureData) end

--- render.CapturePixels
-- @usage client
-- Dumps the current render target and allows the pixels to be accessed by render.ReadPixel.
--
function CapturePixels() end

--- render.Clear
-- @usage client
-- Clears the current render target and the specified buffers.
--
-- @param  r number  Red component to clear to.
-- @param  g number  Green component to clear to.
-- @param  b number  Blue component to clear to.
-- @param  a number  Alpha component to clear to.
-- @param  clearDepth boolean  Clear the depth.
-- @param  clearStencil boolean  Clear the stencil.
function Clear( r,  g,  b,  a,  clearDepth,  clearStencil) end

--- render.ClearBuffersObeyStencil
-- @usage client
-- Clears the current rendertarget for obeying the current stencil buffer conditions.
--
-- @param  r number  Value of the red channel to clear the current rt with.
-- @param  g number  Value of the green channel to clear the current rt with.
-- @param  b number  Value of the blue channel to clear the current rt with.
-- @param  a number  Value of the alpha channel to clear the current rt with.
-- @param  depth boolean  Clear the depth buffer.
function ClearBuffersObeyStencil( r,  g,  b,  a,  depth) end

--- render.ClearDepth
-- @usage client
-- Resets the depth buffer.
--
function ClearDepth() end

--- render.ClearRenderTarget
-- @usage client
-- Clears a render target
--
-- @param  texture ITexture 
-- @param  color table  The color, see Color structure
function ClearRenderTarget( texture,  color) end

--- render.ClearStencil
-- @usage client
-- Resets all values in the stencil buffer to zero.
--
function ClearStencil() end

--- render.ClearStencilBufferRectangle
-- @usage client
-- Sets the stencil value in a specified rect.
--
-- @param  originX number  X origin of the rectangle.
-- @param  originY number  Y origin of the rectangle.
-- @param  endX number  The end X coordinate of the rectangle.
-- @param  endY number  The end Y coordinate of the rectangle.
-- @param  stencilValue number  Value to set cleared stencil buffer to.
function ClearStencilBufferRectangle( originX,  originY,  endX,  endY,  stencilValue) end

--- render.ComputeDynamicLighting
-- @usage client
-- Calculates the lighting caused by dynamic lights for the specified surface.
--
-- @param  position Vector  The position to sample from.
-- @param  normal Vector  The normal of the surface.
-- @return Vector A vector representing the light at that point.
function ComputeDynamicLighting( position,  normal) end

--- render.ComputeLighting
-- @usage client
-- Calculates the light color of a certain surface.
--
-- @param  position Vector  The position of the surface to get the light from.
-- @param  normal Vector  The normal of the surface to get the light from.
-- @return Vector A vector representing the light at that point.
function ComputeLighting( position,  normal) end

--- render.CopyRenderTargetToTexture
-- @usage client
-- Copies the currently active Render Target to the specified texture.
--
-- @param  Target ITexture  The texture to copy to
function CopyRenderTargetToTexture( Target) end

--- render.CopyTexture
-- @usage client
-- Copies the contents of one texture to another
--
-- @param  texture_from ITexture 
-- @param  texture_to ITexture 
function CopyTexture( texture_from,  texture_to) end

--- render.CullMode
-- @usage client
-- Changes the cull mode.
--
-- @param  cullMode number  Cullmode, see MATERIAL_CULLMODE_ Enums
function CullMode( cullMode) end

--- render.DepthRange
-- @usage client
-- Set's the depth range of the upcoming render.
--
-- @param  depthmin number  The minimum depth of the upcoming render. 0.0 = render normally; 1.0 = render nothing
-- @param  depthmax number  The maximum depth of the upcoming render. 0.0 = render everything (through walls); 1.0 = render normally
function DepthRange( depthmin,  depthmax) end

--- render.DrawBeam
-- @usage client
-- Draws textured beam.
--
-- @param  startPos Vector  Beam start position.
-- @param  endPos Vector  Beam end position.
-- @param  width number  The width of the beam.
-- @param  textureStart number  The start coordinate of the texture used.
-- @param  textureEnd number  The end coordinate of the texture used.
-- @param  color table  The color to be used. Uses the Color structure.
function DrawBeam( startPos,  endPos,  width,  textureStart,  textureEnd,  color) end

--- render.DrawBox
-- @usage client
-- Draws a box in 3D space.
--
-- @param  position Vector  Origin of the box.
-- @param  angles Angle  Orientation of the box.
-- @param  mins Vector  Start position of the box, relative to origin.
-- @param  maxs Vector  End position of the box, relative to origin.
-- @param  color table  The color of the box. Uses the Color structure.
-- @param  writeZ boolean  Should this render call write to the depth buffer.
function DrawBox( position,  angles,  mins,  maxs,  color,  writeZ) end

--- render.DrawLine
-- @usage client
-- Draws a line in 3D space.
--
-- @param  startPos Vector  Line start position in world coordinates.
-- @param  endPos Vector  Line end position in world coordinates.
-- @param  color table  The color to be used. Uses the Color structure.
-- @param  writeZ=false boolean  Whether or not to consider the Z buffer. If false, the line will be drawn over everything currently drawn, if true, the line will be drawn with depth considered, as if it were a regular object in 3D space.
function DrawLine( startPos,  endPos,  color,  writeZ) end

--- render.DrawQuad
-- @usage client
-- Draws 2 connected triangles.
--
-- @param  vert1 Vector  First vertex.
-- @param  vert2 Vector  The second vertex.
-- @param  vert3 Vector  The third vertex.
-- @param  vert4 Vector  The fourth vertex.
-- @param  color=Color( 255, 255, 255 ) table  The color of the quad. See Color
function DrawQuad( vert1,  vert2,  vert3,  vert4,  color) end

--- render.DrawQuadEasy
-- @usage client
-- Draws a quad.
--
-- @param  position Vector  Origin of the sprite.
-- @param  normal Vector  The face direction of the quad.
-- @param  width number  The width of the quad.
-- @param  height number  The height of the quad.
-- @param  color table  The color of the quad. Uses the Color structure.
-- @param  rotation number  The rotation of the quad in degrees.
function DrawQuadEasy( position,  normal,  width,  height,  color,  rotation) end

--- render.DrawScreenQuad
-- @usage client
-- Draws the the current material to the whole screen.
--
function DrawScreenQuad() end

--- render.DrawScreenQuadEx
-- @usage client
-- Draws the the current material to the area specified.
--
-- @param  startX number  X start position of the rect.
-- @param  startY number  Y start position of the rect.
-- @param  width number  Width of the rect.
-- @param  height number  Height of the rect.
function DrawScreenQuadEx( startX,  startY,  width,  height) end

--- render.DrawSphere
-- @usage client
-- Draws a sphere in 3D space. The material previously set with render.SetMaterial will be applied the sphere's surface.
--
-- @param  position Vector  Position of the sphere.
-- @param  radius number  Radius of the sphere.
-- @param  longitudeSteps number  The number of longitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.  In reality, the sphere has one less than the specified value.
-- @param  latitudeSteps number  The number of latitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.  In reality, the sphere has one less than the specified value.
-- @param  color table  The color of the sphere. Uses the Color structure.
function DrawSphere( position,  radius,  longitudeSteps,  latitudeSteps,  color) end

--- render.DrawSprite
-- @usage client
-- Draws a sprite in 3d space.
--
-- @param  position Vector  Position of the sprite.
-- @param  width number  Width of the sprite.
-- @param  height number  Height of the sprite.
-- @param  color table  Color of the sprite. Uses the Color structure.
function DrawSprite( position,  width,  height,  color) end

--- render.DrawTextureToScreen
-- @usage client
-- Draws a texture over the whole screen.
--
-- @param  tex ITexture  The texture to draw
function DrawTextureToScreen( tex) end

--- render.DrawTextureToScreenRect
-- @usage client
-- Draws a textured rectangle.
--
-- @param  tex ITexture  The texture to draw
-- @param  x number  The x coordinate of the rectangle to draw.
-- @param  y number  The y coordinate of the rectangle to draw.
-- @param  width number  The width of the rectangle to draw.
-- @param  height number  The height of the rectangle to draw.
function DrawTextureToScreenRect( tex,  x,  y,  width,  height) end

--- render.DrawWireframeBox
-- @usage client
-- Draws a wireframe box in 3D space.
--
-- @param  position Vector  Position of the box.
-- @param  angle Angle  Angles of the box.
-- @param  mins Vector  The lowest corner of the box.
-- @param  maxs Vector  The highest corner of the box.
-- @param  color table  The color of the box. Uses the Color structure.
-- @param  writeZ boolean  Sets whenever to write to the zBuffer.
function DrawWireframeBox( position,  angle,  mins,  maxs,  color,  writeZ) end

--- render.DrawWireframeSphere
-- @usage client
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @param  position Vector  Position of the sphere.
-- @param  radius number  The size of the sphere.
-- @param  longitudeSteps number  The amount of longitude steps.  The larger this number is, the smoother the sphere is.
-- @param  latitudeSteps number  The amount of latitude steps.  The larger this number is, the smoother the sphere is.
-- @param  color table  The color of the wireframe. Uses the Color structure.
-- @param  writeZ=false boolean  Whether or not to consider the Z buffer. If false, the wireframe will be drawn over everything currently drawn. If true, it will be drawn with depth considered, as if it were a regular object in 3D space.
function DrawWireframeSphere( position,  radius,  longitudeSteps,  latitudeSteps,  color,  writeZ) end

--- render.EnableClipping
-- @usage client
-- Sets the status of the clip renderer, returning previous state.
--
-- @param  state boolean  New clipping state.
-- @return boolean Previous clipping state.
function EnableClipping( state) end

--- render.EndBeam
-- @usage client
-- Ends the beam mesh of a beam started with render.StartBeam.
--
function EndBeam() end

--- render.FogColor
-- @usage client
-- Sets the color of the fog.
--
-- @param  red number  Red channel of the fog color, 0 - 255.
-- @param  green number  Green channel of the fog color, 0 - 255.
-- @param  blue number  Blue channel of the fog color, 0 - 255.
function FogColor( red,  green,  blue) end

--- render.FogEnd
-- @usage client
-- Sets the at which the fog reaches its max density.
--
-- @param  distance number  The distance at which the fog reaches its max density.    NOTE  If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook 
function FogEnd( distance) end

--- render.FogMaxDensity
-- @usage client
-- Sets the maximum density of the fog.
--
-- @param  maxDensity number  The maximum density of the fog, 0-1.
function FogMaxDensity( maxDensity) end

--- render.FogMode
-- @usage client
-- Sets the mode of fog.
--
-- @param  fogMode number  Fog mode, see MATERIAL_FOG_ Enums.
function FogMode( fogMode) end

--- render.FogStart
-- @usage client
-- Sets the distance at which the fog starts showing up.
--
-- @param  fogStart number  The distance at which the fog starts showing up.     NOTE  If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook 
function FogStart( fogStart) end

--- render.GetAmbientLightColor
-- @usage client
-- Returns the ambient color of the map.
--
-- @return Vector color
function GetAmbientLightColor() end

--- render.GetBlend
-- @usage client
-- Returns the current alpha blending.
--
-- @return number blend
function GetBlend() end

--- render.GetBloomTex0
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture The bloom texture
function GetBloomTex0() end

--- render.GetBloomTex1
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetBloomTex1() end

--- render.GetColorModulation
-- @usage client
-- Returns the current color modulation values as normals.
--
-- @return number r
function GetColorModulation() end

--- render.GetDXLevel
-- @usage client
-- Returns the maximum available directX version.
--
-- @return number dxLevel
function GetDXLevel() end

--- render.GetFogColor
-- @usage client
-- Returns the current fog color.
--
-- @return number Red part of the color.
-- @return number Green part of the color
-- @return number Blue part of the color
function GetFogColor() end

--- render.GetFogDistances
-- @usage client
-- Returns the fog start and end distance.
--
-- @return number Fog start distance set by render.FogStart
-- @return number For end distance set by render.FogEnd
-- @return number Fog Z distance set by render.SetFogZ
function GetFogDistances() end

--- render.GetFogMode
-- @usage client
-- Returns the fog mode.
--
-- @return number Fog mode, see MATERIAL_FOG_ Enums
function GetFogMode() end

--- render.GetFullScreenDepthTexture
-- @usage client
-- Returns the _rt_FullFrameDepth texture. Alias of _rt_PowerOfTwoFB
--
-- @return ITexture 
function GetFullScreenDepthTexture() end

--- render.GetLightColor
-- @usage client
-- Gets the light exposure on the specified position.
--
-- @param  position Vector  The position of the surface to get the light from.
-- @return Vector lightColor
function GetLightColor( position) end

--- render.GetMoBlurTex0
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetMoBlurTex0() end

--- render.GetMoBlurTex1
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetMoBlurTex1() end

--- render.GetMorphTex0
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetMorphTex0() end

--- render.GetMorphTex1
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetMorphTex1() end

--- render.GetPowerOfTwoTexture
-- @usage client
-- Returns the render target's power of two texture.
--
-- @return ITexture The power of two texture, which is _rt_poweroftwofb by default.
function GetPowerOfTwoTexture() end

--- render.GetRefractTexture
-- @usage client
-- Alias of render.GetPowerOfTwoTexture.
--
-- @return ITexture 
function GetRefractTexture() end

--- render.GetRenderTarget
-- @usage client
-- Returns the currently active render target.
--
-- @return ITexture The currently active Render Target
function GetRenderTarget() end

--- render.GetResolvedFullFrameDepth
-- @usage client
-- Returns the _rt_ResolvedFullFrameDepth texture for SSAO depth.
--
-- @return ITexture 
function GetResolvedFullFrameDepth() end

--- render.GetScreenEffectTexture
-- @usage client
-- Obtain an ITexture of the screen. You must call render.UpdateScreenEffectTexture in order to update this texture with the currently rendered scene.
--
-- @param  textureIndex=0 number  Max index is 3, but engine only creates the first two for you.
-- @return ITexture 
function GetScreenEffectTexture( textureIndex) end

--- render.GetSmallTex0
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetSmallTex0() end

--- render.GetSmallTex1
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return ITexture 
function GetSmallTex1() end

--- render.GetSuperFPTex
-- @usage client
-- Returns a floating point texture the same resolution as the screen.
--
-- @return ITexture Render target named "__rt_supertexture1"
function GetSuperFPTex() end

--- render.GetSuperFPTex2
-- @usage client
-- Returns a floating point texture the same resolution as the screen.
--
-- @return ITexture Render target named "__rt_supertexture2"
function GetSuperFPTex2() end

--- render.GetSurfaceColor
-- @usage client
-- Performs a render trace and returns the color of the surface hit, this uses a low res version of the texture.
--
-- @param  startPos Vector  The start position to trace from.
-- @param  endPos Vector  The end position of the trace.
-- @return Vector color
function GetSurfaceColor( startPos,  endPos) end

--- render.GetToneMappingScaleLinear
-- @usage client
-- Returns a vector representing linear tone mapping scale.
--
-- @return Vector The vector representing linear tone mapping scale.
function GetToneMappingScaleLinear() end

--- render.MaterialOverride
-- @usage client
-- Sets the render material override for all next calls of Entity:DrawModel. Also overrides render.MaterialOverrideByIndex.
--
-- @param  material IMaterial  The material to use as override, use nil to disable.
function MaterialOverride( material) end

--- render.MaterialOverrideByIndex
-- @usage client
-- Similar to render.MaterialOverride, but overrides the materials per index.
--
-- @param  index number  Starts with 0, the index of the material to override
-- @param  material IMaterial  The material to override with
function MaterialOverrideByIndex( index,  material) end

--- render.MaxTextureHeight
-- @usage client
-- Returns the maximum texture height the renderer can handle.
--
-- @return number maxTextureHeight
function MaxTextureHeight() end

--- render.MaxTextureWidth
-- @usage client
-- Returns the maximum texture width the renderer can handle.
--
-- @return number maxTextureWidth
function MaxTextureWidth() end

--- render.Model
-- @usage client
-- Creates a new ClientsideModel, renders it at the specified pos/ang, and removes it. Can also be given an existing CSEnt to reuse instead.
--
-- @param  settings table  Requires:   string model - The model to draw  Vector pos - The position to draw the model at  Angle angle - The angles to draw the model at
-- @param  ent=nil CSEnt  If provided, this entity will be reused instead of creating a new one with ClientsideModel. Note that the ent's model, position and angles will be changed, and Entity:SetNoDraw will be set to true.
function Model( settings,  ent) end

--- render.ModelMaterialOverride
-- @usage client
-- Sets a material to override a model's default material. Similar to Entity:SetMaterial except it uses an IMaterial argument and it can be used to change materials on models which are part of the world geometry.
--
-- @param  material IMaterial  The material override.
function ModelMaterialOverride( material) end

--- render.OverrideAlphaWriteEnable
-- @usage client
-- Overrides the write behaviour of all next rendering operations towards the alpha channel of the current render target.
--
-- @param  enable boolean  Enable or disable the override.
-- @param  shouldWrite boolean  If the previous argument is true, sets whether the next rendering operations should write to the alpha channel or not. Has no effect if the previous argument is false.
function OverrideAlphaWriteEnable( enable,  shouldWrite) end

--- render.OverrideColorWriteEnable
-- @usage client
-- Overrides the write behaviour of all next rendering operations towards the color channel of the current render target.
--
-- @param  enable boolean  Enable or disable the override.
-- @param  shouldWrite boolean  If the previous argument is true, sets whether the next rendering operations should write to the color channel or not. Has no effect if the previous argument is false.
function OverrideColorWriteEnable( enable,  shouldWrite) end

--- render.OverrideDepthEnable
-- @usage client
-- Overrides the write behaviour of all next rendering operations towards the depth buffer.
--
-- @param  enable boolean  Enable or disable the override.
-- @param  shouldWrite boolean  If the previous argument is true, sets whether the next rendering operations should write to the depth buffer or not. Has no effect if the previous argument is false.
function OverrideDepthEnable( enable,  shouldWrite) end

--- render.PerformFullScreenStencilOperation
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function PerformFullScreenStencilOperation() end

--- render.PopCustomClipPlane
-- @usage client
-- Removes the current active clipping plane from the clip plane stack.
--
function PopCustomClipPlane() end

--- render.PopFilterMag
-- @usage client
-- Pops the current texture magnification filter from the filter stack.
--
function PopFilterMag() end

--- render.PopFilterMin
-- @usage client
-- Pops the current texture minification filter from the filter stack.
--
function PopFilterMin() end

--- render.PopFlashlightMode
-- @usage client
-- Pops the current flashlight mode from the flashlight mode stack.
--
function PopFlashlightMode() end

--- render.PopRenderTarget
-- @usage client
-- Pops the last render target and viewport from the RT stack and sets them as the current render target and viewport.
--
function PopRenderTarget() end

--- render.PushCustomClipPlane
-- @usage client
-- Pushes a new clipping plane of the clip plane stack and sets it as active.
--
-- @param  normal Vector  The normal of the clipping plane.
-- @param  distance number  The distance of the plane from the world origin. You can use Vector:Dot between the normal and any point on the plane to find this, see Example 1.
function PushCustomClipPlane( normal,  distance) end

--- render.PushFilterMag
-- @usage client
-- Pushes a texture filter onto the magnification texture filter stack.
--
-- @param  texFilterType number  The texture filter type, see TEXFILTER_ Enums
function PushFilterMag( texFilterType) end

--- render.PushFilterMin
-- @usage client
-- Pushes a texture filter onto the minification texture filter stack.
--
-- @param  texFilterType number  The texture filter type, see TEXFILTER_ Enums
function PushFilterMin( texFilterType) end

--- render.PushFlashlightMode
-- @usage client
-- Enables the flashlight projection for the upcoming rendering.
--
-- @param  enable=false boolean  Whether the flashlight mode should be enabled or disabled.
function PushFlashlightMode( enable) end

--- render.PushRenderTarget
-- @usage client
-- Pushes the current render target and viewport to the RT stack then sets a new current render target and viewport. If the viewport is not specified, the dimensions of the render target are used instead.
--
-- @param  texture ITexture  The new render target to be used.
-- @param  x=0 number  X origin of the viewport.
-- @param  y=0 number  Y origin of the viewport.
-- @param  w=texture:Width() number  Width of the viewport.
-- @param  h=texture:Height() number  Height of the viewport
function PushRenderTarget( texture,  x,  y,  w,  h) end

--- render.ReadPixel
-- @usage client
-- Reads the color of the specified pixel from the RenderTarget sent by render.CapturePixels
--
-- @param  x number  The x coordinate.
-- @param  y number  The y coordinate.
-- @return number r
-- @return number g
-- @return number b
function ReadPixel( x,  y) end

--- render.RedownloadAllLightmaps
-- @usage client
-- This applies the changes made to map lighting using engine.LightStyle.
--
-- @param  DoStaticProps=false boolean  When true, this will also apply lighting changes to static props. This is really slow on large maps.
function RedownloadAllLightmaps( DoStaticProps) end

--- render.RenderHUD
-- @usage client
-- Renders the HUD on the screen.
--
-- @param  x number  X position for the HUD draw origin.
-- @param  y number  Y position for the HUD draw origin.
-- @param  w number  Width of the HUD draw.
-- @param  h number  Height of the HUD draw.
function RenderHUD( x,  y,  w,  h) end

--- render.RenderView
-- @usage client
-- Renders the scene with the specified viewData to the current active render target.
--
-- @param  view=nil table  The view data to be used in the rendering. See ViewData structure. Any missing value is assumed to be that of the current view. Similarly, you can make a normal render by simply not passing this table at all.
function RenderView( view) end

--- render.ResetModelLighting
-- @usage client
-- Resets the model lighting to the specified color.
--
-- @param  r number  The red part of the color, 0-1
-- @param  g number  The green part of the color, 0-1
-- @param  b number  The blue part of the color, 0-1
function ResetModelLighting( r,  g,  b) end

--- render.ResetToneMappingScale
-- @usage client
-- Resets the HDR tone multiplier to the specified value.
--
-- @param  scale number  The value which should be used as multiplier.
function ResetToneMappingScale( scale) end

--- render.SetAmbientLight
-- @usage client
-- Sets the ambient lighting for any upcoming render operation.
--
-- @param  r number  The red part of the color, 0-1.
-- @param  g number  The green part of the color, 0-1.
-- @param  b number  The blue part of the color, 0-1.
function SetAmbientLight( r,  g,  b) end

--- render.SetBlend
-- @usage client
-- Sets the alpha blending for every upcoming render operation.
--
-- @param  blending number  Blending value from 0-1.
function SetBlend( blending) end

--- render.SetColorMaterial
-- @usage client
-- Sets the current drawing material to "color".
--
function SetColorMaterial() end

--- render.SetColorMaterialIgnoreZ
-- @usage client
-- Sets the current drawing material to "color_ignorez".
--
function SetColorMaterialIgnoreZ() end

--- render.SetColorModulation
-- @usage client
-- Sets the color modulation.
--
-- @param  r number  The red channel multiplier normal ranging from 0-1.
-- @param  g number  The green channel multiplier normal ranging from 0-1.
-- @param  b number  The blue channel multiplier normal ranging from 0-1.
function SetColorModulation( r,  g,  b) end

--- render.SetFogZ
-- @usage client
-- If the fog mode is set to MATERIAL_FOG_LINEAR_BELOW_FOG_Z, the fog will only be rendered below the specified height.
--
-- @param  fogZ number  The fog Z.
function SetFogZ( fogZ) end

--- render.SetGoalToneMappingScale
-- @usage client
-- Sets the goal HDR tone mapping scale.
--
-- @param  scale number  The target scale.
function SetGoalToneMappingScale( scale) end

--- render.SetLightingMode
-- @usage client
-- Sets lighting mode when rendering something.
--
-- @param  Mode number  Lighting render mode 0 - Default 1 - Total fullbright, similar to mat_fullbright 1 but excluding some weapon view models 2 - Increased bright, models look fullbright    WARNING  Setting this to more than 2 seems to do nothing but setting this to negative numbers instacloses game!    NOTE  The HUD is affected by the lighting mode. Do not forget to restore the default value before the HUD rendering 
function SetLightingMode( Mode) end

--- render.SetLightingOrigin
-- @usage client
-- Sets the lighting origin.
--
-- @param  lightingOrigin Vector  The position from which the light should be "emitted".
function SetLightingOrigin( lightingOrigin) end

--- render.SetLightmapTexture
-- @usage client
-- Sets the texture to be used as the lightmap in upcoming rendering operations. This is required when rendering meshes using a material with a lightmapped shader such as LightmappedGeneric.
--
-- @param  tex ITexture  The texture to be used as the lightmap.
function SetLightmapTexture( tex) end

--- render.SetLocalModelLights
-- @usage client
-- Sets up the local lighting for any upcoming render operation. Up to 4 local lights can be defined, with one of three different types (point, directional, spot).
--
-- @param  lights={} table  A table containing up to 4 tables for each light source that should be set up. Each of these tables should contain the properties of its associated light source, see LocalLight structure.
function SetLocalModelLights( lights) end

--- render.SetMaterial
-- @usage client
-- Sets the material to be used in any upcoming render operation.
--
-- @param  mat IMaterial  The material to be used.
function SetMaterial( mat) end

--- render.SetModelLighting
-- @usage client
-- Sets up the ambient lighting for any upcoming render operation. Ambient lighting can be seen as a cube enclosing the object to be drawn, each of its faces representing a directional light source that shines towards the object. Thus, there is a total of six different light sources that can be configured separately.
--
-- @param  lightDirection number  The light source to edit, see BOX_ Enums.
-- @param  red number  The red component of the light color.
-- @param  green number  The green component of the light color.
-- @param  blue number  The blue component of the light color.
function SetModelLighting( lightDirection,  red,  green,  blue) end

--- render.SetRenderTarget
-- @usage client
-- Sets the render target to the specified rt.
--
-- @param  texture ITexture  The new render target to be used.
function SetRenderTarget( texture) end

--- render.SetRenderTargetEx
-- @usage client
-- Sets the render target with the specified index to the specified rt.
--
-- @param  rtIndex number  The index of the rt to set.
-- @param  texture ITexture  The new render target to be used.
function SetRenderTargetEx( rtIndex,  texture) end

--- render.SetScissorRect
-- @usage client
-- Sets a scissoring rect which limits the drawing area.
--
-- @param  startX number  X start coordinate of the scissor rect.
-- @param  startY number  Y start coordinate of the scissor rect.
-- @param  endX number  X end coordinate of the scissor rect.
-- @param  endY number  Y end coordinate of the scissor rect.
-- @param  enable boolean  Enable or disable the scissor rect.
function SetScissorRect( startX,  startY,  endX,  endY,  enable) end

--- render.SetShadowColor
-- @usage client
-- Sets the shadow color.
--
-- @param  red number  The red channel of the shadow color.
-- @param  green number  The green channel of the shadow color.
-- @param  blue number  The blue channel of the shadow color.
function SetShadowColor( red,  green,  blue) end

--- render.SetShadowDirection
-- @usage client
-- Sets the shadow projection direction.
--
-- @param  shadowDirections Vector  The new shadow direction.
function SetShadowDirection( shadowDirections) end

--- render.SetShadowDistance
-- @usage client
-- Sets the maximum shadow projection range.
--
-- @param  shadowDistance number  The new maximum shadow distance.
function SetShadowDistance( shadowDistance) end

--- render.SetShadowsDisabled
-- @usage client
-- Sets whether any future render operations will ignore shadow drawing.
--
-- @param M2 boolean 
function SetShadowsDisabled(M2) end

--- render.SetStencilCompareFunction
-- @usage client
-- Sets the compare function of the stencil.
--
-- @param  compareFunction number  Compare function, see STENCILCOMPARISONFUNCTION_ Enums, and STENCIL_ Enums for short.
function SetStencilCompareFunction( compareFunction) end

--- render.SetStencilEnable
-- @usage client
-- Sets whether stencil tests are carried out for each rendered pixel.
--
-- @param  newState boolean  The new state.
function SetStencilEnable( newState) end

--- render.SetStencilFailOperation
-- @usage client
-- Sets the operation to be performed on the stencil buffer values if the compare function was not successful.
--
-- @param  failOperation number  Fail operation function, see STENCILOPERATION_ Enums
function SetStencilFailOperation( failOperation) end

--- render.SetStencilPassOperation
-- @usage client
-- Sets the operation to be performed on the stencil buffer values if the compare function was successful.
--
-- @param  passOperation number  Pass operation function, see STENCILOPERATION_ Enums
function SetStencilPassOperation( passOperation) end

--- render.SetStencilReferenceValue
-- @usage client
-- Sets the reference value which will be used for all stencil operations. This is an unsigned integer.
--
-- @param  referenceValue number  Reference value.
function SetStencilReferenceValue( referenceValue) end

--- render.SetStencilTestMask
-- @usage client
-- Sets the unsigned 8-bit test bitflag mask to be used for any stencil testing.
--
-- @param  mask number  The mask bitflag.
function SetStencilTestMask( mask) end

--- render.SetStencilWriteMask
-- @usage client
-- Sets the unsigned 8-bit write bitflag mask to be used for any writes to the stencil buffer.
--
-- @param  mask number  The mask bitflag.
function SetStencilWriteMask( mask) end

--- render.SetStencilZFailOperation
-- @usage client
-- Sets the operation to be performed on the stencil buffer values if the stencil test is passed but the depth buffer test fails.
--
-- @param  zFailOperation number  Z fail operation function, see STENCILOPERATION_ Enums
function SetStencilZFailOperation( zFailOperation) end

--- render.SetToneMappingScaleLinear
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  vec Vector 
function SetToneMappingScaleLinear( vec) end

--- render.SetViewPort
-- @usage client
-- Changes the view port position and size.
--
-- @param  x number  X origin of the view port.
-- @param  y number  Y origin of the view port.
-- @param  w number  Width of the view port.
-- @param  h number  Height of the view port.
function SetViewPort( x,  y,  w,  h) end

--- render.SetWriteDepthToDestAlpha
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  enable boolean 
function SetWriteDepthToDestAlpha( enable) end

--- render.Spin
-- @usage client
-- Swaps the frame buffers/cycles the frame. In other words, this updates the screen.
--
function Spin() end

--- render.StartBeam
-- @usage client
-- Start a new beam draw operation.
--
-- @param  segmentCount number  Amount of beam segments that are about to be drawn.
function StartBeam( segmentCount) end

--- render.SupportsHDR
-- @usage client
-- Returns whether the game supports HDR, i.e. if the DirectX level is higher than or equal to 8.
--
-- @return boolean supportsHDR
function SupportsHDR() end

--- render.SupportsPixelShaders_1_4
-- @usage client
-- Returns if the current settings and the system allow the usage of pixel shaders 1.4.
--
-- @return boolean Whether Pixel Shaders 1.4 are supported or not.
function SupportsPixelShaders_1_4() end

--- render.SupportsPixelShaders_2_0
-- @usage client
-- Returns if the current settings and the system allow the usage of pixel shaders 2.0.
--
-- @return boolean Whether Pixel Shaders 2.0 are supported or not.
function SupportsPixelShaders_2_0() end

--- render.SupportsVertexShaders_2_0
-- @usage client
-- Returns if the current settings and the system allow the usage of vertex shaders 2.0.
--
-- @return boolean Whether Vertex Shaders 2.0 are supported or not.
function SupportsVertexShaders_2_0() end

--- render.SuppressEngineLighting
-- @usage client
-- Suppresses or enables any engine lighting for any upcoming render operation.
--
-- @param  suppressLighting boolean  True to suppress false to enable.
function SuppressEngineLighting( suppressLighting) end

--- render.TurnOnToneMapping
-- @usage client
-- Enables HDR tone mapping which influences the brightness.
--
function TurnOnToneMapping() end

--- render.UpdateFullScreenDepthTexture
-- @usage client
-- Updates the texture returned by render.GetFullScreenDepthTexture.
--
function UpdateFullScreenDepthTexture() end

--- render.UpdatePowerOfTwoTexture
-- @usage client
-- Updates the power of two texture.
--
-- @return ITexture Returns render.GetPowerOfTwoTexture.
function UpdatePowerOfTwoTexture() end

--- render.UpdateRefractTexture
-- @usage client
-- Pretty much alias of render.UpdatePowerOfTwoTexture but does not return the texture.
--
function UpdateRefractTexture() end

--- render.UpdateScreenEffectTexture
-- @usage client
-- Copies the entire screen to the screen effect texture, which can be acquired via render.GetScreenEffectTexture. This function is mainly intended to be used in GM:RenderScreenspaceEffects
--
function UpdateScreenEffectTexture() end
