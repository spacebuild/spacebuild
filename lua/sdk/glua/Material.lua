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
