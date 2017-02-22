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
-- @description Library Stack
 module("Stack")

--- Stack:Pop
-- @usage shared
-- Pop an item from the stack
--
-- @param  amount=1 number  Amount of items you want to pop.
function Pop( amount) end

--- Stack:Push
-- @usage shared
-- Push an item onto the stack
--
-- @param  object any  The item you want to push
function Push( object) end

--- Stack:Size
-- @usage shared
-- Returns the size of the stack
--
-- @return number The size of the stack
function Size() end

--- Stack:Top
-- @usage shared
-- Get the item at the top of the stack
--
-- @return any The item at the top of the stack
function Top() end
