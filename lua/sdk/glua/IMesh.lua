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
-- @description Library IMesh
 module("IMesh")

--- IMesh:BuildFromTriangles
-- @usage client
-- Builds the mesh from a table mesh vertexes.
--
-- @param  vertexes table  A table consisting of MeshVertex structures.
function BuildFromTriangles( vertexes) end

--- IMesh:Destroy
-- @usage client
-- Deletes the mesh and frees the memory used by it..
--
function Destroy() end

--- IMesh:Draw
-- @usage client
-- Renders the mesh with the active matrix.
--
function Draw() end
