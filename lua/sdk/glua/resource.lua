---
-- @description Library resource
 module("resource")

--- resource.AddFile
-- @usage server
-- Adds the specified and all related files to the files the client should download.
--
-- @param  path string  Path of the file to be added, relative to garrysmod/.
function AddFile( path) end

--- resource.AddSingleFile
-- @usage server
-- Adds the specified file to the files the client should download.
--
-- @param  path string  Path of the file to be added, relative to garrysmod/
function AddSingleFile( path) end

--- resource.AddWorkshop
-- @usage server
-- Adds a workshop addon for the client to download before entering the server.
--
-- @param  workshopid string  The workshop id of the file. This cannot be a collection.
function AddWorkshop( workshopid) end
