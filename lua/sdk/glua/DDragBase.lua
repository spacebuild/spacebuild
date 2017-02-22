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
-- @description Library DDragBase
 module("DDragBase")

--- DDragBase:MakeDroppable
-- @usage client
-- Makes the panel a receiver for any droppable panel with the same DnD name.
--
-- @param  name string  The unique name for the receiver slot. Only droppable panels with the same DnD name as this can be dropped on the panel.
-- @param  allowCopy boolean  Whether or not to allow droppable panels to be copied when the Ctrl key is held down.
function MakeDroppable( name,  allowCopy) end
