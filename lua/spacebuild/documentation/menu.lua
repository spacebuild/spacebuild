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

local SPACEBUILD = SPACEBUILD
local log = SPACEBUILD.log

-- List of Silk Icons (gmod) materials/icon16/... (http://www.famfamfam.com/lab/icons/silk/previews/index_abc.png)

local base = "spacebuild/documentation/"
for _, fileName in pairs(file.Find(base.."contents/*.lua", "LUA")) do
    local isHtml = string.EndsWith( fileName, ".html.lua" )
    local newName = string.gsub( fileName, ".lua", ".txt" )
    local data = file.Read(base.."contents/"..fileName , "LUA" )
    if isHtml then
        string.gsub( data, ".lua", ".txt" )
    end
    log.debug("Writing menu file ", fileName, newName)
    file.Write( "sb/"..newName, data)
end
