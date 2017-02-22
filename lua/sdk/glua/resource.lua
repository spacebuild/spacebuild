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
