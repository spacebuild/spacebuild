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
-- @description Library language
 module("language")

--- language.Add
-- @usage client_m
-- Adds a language item. Language placeholders preceded with "#" are replaced with full text in Garry's Mod once registered with this function.
--
-- @param  placeholder string  The key for this phrase, without the preceding "#".
-- @param  fulltext string  The phrase that should be displayed whenever this key is used.
function Add( placeholder,  fulltext) end

--- language.GetPhrase
-- @usage client_m
-- Retrieves the translated version of inputted string. Useful for concentrating multiple translated strings.
--
-- @param  phrase string  The phrase to translate
-- @return string The translated phrase
function GetPhrase( phrase) end
