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
-- @description Library mesh
 module("mesh")

--- mesh.AdvanceVertex
-- @usage client
-- Pushes the new vertex data onto the render stack.
--
function AdvanceVertex() end

--- mesh.Begin
-- @usage client
-- Starts a new dynamic mesh. If an IMesh is passed, it will use that mesh instead.
--
-- @param  mesh=nil IMesh  Mesh to build. This argument can be removed if you wish to build a "dynamic" mesh. See examples below.
-- @param  primitiveType number  Primitive type, see MATERIAL_ Enums.
-- @param  primiteCount number  The amount of primitives.
function Begin( mesh,  primitiveType,  primiteCount) end

--- mesh.Color
-- @usage client
-- Sets the color to be used for the next vertex.
--
-- @param  r number  Red component.
-- @param  g number  Green component.
-- @param  b number  Blue component.
-- @param  a number  Alpha component.
function Color( r,  g,  b,  a) end

--- mesh.End
-- @usage client
-- Ends the mesh and renders it.
--
function End() end

--- mesh.Normal
-- @usage client
-- Sets the normal to be used for the next vertex.
--
-- @param  normal Vector  The normal of the vertex.
function Normal( normal) end

--- mesh.Position
-- @usage client
-- Sets the position to be used for the next vertex.
--
-- @param  position Vector  The position of the vertex.
function Position( position) end

--- mesh.Quad
-- @usage client
-- Draws a quad using 4 vertices.
--
-- @param  vertex1 Vector  The first vertex.
-- @param  vertex2 Vector  The second vertex.
-- @param  vertex3 Vector  The third vertex.
-- @param  vertex4 Vector  The fourth vertex.
function Quad( vertex1,  vertex2,  vertex3,  vertex4) end

--- mesh.QuadEasy
-- @usage client
-- Draws a quad using a position, a normal and the size.
--
-- @param  position Vector  The center of the quad.
-- @param  normal Vector  The normal of the quad.
-- @param  sizeX number  X size in pixels.
-- @param  sizeY number  Y size in pixels.
function QuadEasy( position,  normal,  sizeX,  sizeY) end

--- mesh.Specular
-- @usage client
-- Sets the specular map values.
--
-- @param  r number  The red channel multiplier of the specular map.
-- @param  g number  The green channel multiplier of the specular map.
-- @param  b number  The blue channel multiplier of the specular map.
-- @param  a number  The alpha channel multiplier of the specular map.
function Specular( r,  g,  b,  a) end

--- mesh.TangentS
-- @usage client
-- Sets the s tangent to be used.
--
-- @param  sTanger Vector  The s tangent.
function TangentS( sTanger) end

--- mesh.TangentT
-- @usage client
-- Sets the T tangent to be used.
--
-- @param  tTanger Vector  The t tangent.
function TangentT( tTanger) end

--- mesh.TexCoord
-- @usage client
-- Sets the texture coordinates for the next vertex.
--
-- @param  stage number  The stage of the texture coordinate.
-- @param  u number  U coordinate.
-- @param  v number  V coordinate.
function TexCoord( stage,  u,  v) end

--- mesh.VertexCount
-- @usage client
-- Returns the amount of vertex that have yet been pushed.
--
-- @return number vertexCount
function VertexCount() end
