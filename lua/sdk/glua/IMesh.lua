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
