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
-- @description Library notification
 module("notification")

--- notification.AddLegacy
-- @usage client_m
-- Adds a standard notification to your screen.
--
-- @param  Text string  The string to display
-- @param  Type number  Determines the method for displaying the notification. See the NOTIFY_ Enums
-- @param  Length number  The number of seconds to display the notification for
function AddLegacy( Text,  Type,  Length) end

--- notification.AddProgress
-- @usage client_m
-- Adds a notification with an animated progress bar.
--
-- @param  id any  Can be any type. It's used as an index.
-- @param  strText string  The text to show
function AddProgress( id,  strText) end

--- notification.Kill
-- @usage client_m
-- Removes the notification after 0.8 seconds.
--
-- @param  uid any  The unique ID of the notification
function Kill( uid) end
