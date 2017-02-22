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
-- @description Library DBubbleContainer
 module("DBubbleContainer")

--- DBubbleContainer:OpenForPos
-- @usage client
-- Sets the speech bubble position and size along with the dialog point position.
--
-- @param  x number  The x position of the dialog point. If this is set to a value greater than half of the set width, the entire bubble container will be moved in addition to the dialog point.
-- @param  y number  The y position of the bubble container. Has no effect unless set to a value greater than the set height + 64 pixels.
-- @param  w number  The width of the bubble container.
-- @param  h number  The height of the bubble container.
function OpenForPos( x,  y,  w,  h) end
