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

TOOL = nil


MsgN("Loading CAF Tools")

include( "tool_helpers.lua" )

for key, val in pairs(file.Find("CAF/Stools/*.lua", "LUA")) do
	local s_toolmode = string.sub(val, 0, -5)
	
	MsgN("\tloading stool: ",val)

	CAFToolSetup.open( s_toolmode )

	include( "caf/stools/"..val )
	
	CAFToolSetup.BaseCCVars()
	CAFToolSetup.BaseLang()
	CAFToolSetup.MaxLimit()
	CAFToolSetup.RegEnts()
	CAFToolSetup.MakeFunc()
	CAFToolSetup.MakeCP()
	CAFToolSetup.close()
end

CAFToolSetup = nil
