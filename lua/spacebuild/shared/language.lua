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

local SB = SPACEBUILD
local lang = SB.lang
local languages = {}
local defaultLanguage = "en"
local selectedLanguage = GetConVar("gmod_language"):GetString() or defaultLanguage

lang.add = function(language, code, message)
    if not languages[language] then languages[language] = {} end
    languages[language][code] = message
end

lang.get = function(code, default)
    return (languages[selectedLanguage] and languages[selectedLanguage][code]) or languages[defaultLanguage][code] or default or code
end

lang.register = function(code, default)
    language.Add( code, lang.get(code, default) )
end

include("spacebuild/languages/include.lua")

