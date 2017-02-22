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
local RD = {}
local status = false

--local functions

RD_OverLay_Distance = CreateClientConVar("rd_overlay_distance", "512", false, false)
RD_OverLay_Mode = CreateClientConVar("rd_overlay_mode", "-1", false, false)
local client_chosen_number = CreateClientConVar("number_to_send", "1", false, false)
local client_chosen_hold = CreateClientConVar("number_to_hold", "0", false, false)

--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function RD.__Construct()
	status = true
	return true
	--return false , "No Implementation yet"
end

--[[
	The Destructor for this Custom Addon Class
]]
function RD.__Destruct()
	status = false
	return true
	--return false , "No Implementation yet"
end

--[[
	Get the required Addons for this Addon Class
]]
function RD.GetRequiredAddons()
	return {}
end

--[[
	Get the Boolean Status from this Addon Class
]]
function RD.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function RD.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

local isuptodatecheck;
--[[
	Update check
]]
function RD.IsUpToDate(callBackfn)
	if not CAF.HasInternet then
		return
	end
	if isuptodatecheck ~= nil then
		callBackfn(isuptodatecheck);
		return
	end
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function RD.GetExtraOptions()
	return {}
end

--[[
	Gets a menu from this Custom Addon Class
]]
function RD.GetMenu(menutype, menuname) --Name is nil for main menu, String for others
	local data = {}
	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function RD.GetCustomStatus()
	return ; --CAF.GetLangVar("Not Implemented Yet")
end

--[[
	Returns a table containing the Description of this addon
]]
function RD.GetDescription()
	return {
				"Resource Distribution",
				"",
				""
			}
end
CAF.RegisterAddon("Resource Distribution", RD, "1")

--[[ Shared stuff ]]

function RD.GetNetResourceAmount(netid, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getResourceAmount(resource)
end

function RD.GetResourceAmount(ent, resource)
	if not resource then return 0, "No resource given" end
	if not ent.rdobject then return 0, "Not a valid resource container" end
	return ent.rdobject:getResourceAmount(resource)
end

function RD.GetNetNetworkCapacity(netid, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getMaxResourceAmount(resource)
end

function RD.GetNetworkCapacity(ent, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getMaxResourceAmount(resource)
end

function RD.AddProperResourceName(resource, name)
	local registry = SPACEBUILD:getResourceRegistry()
	if not resource or not name then return end
	local resObj = registry:getResourceInfoFromName(resource)
	if not resObj then error("Use SPACEBUILD:getResourceRegistry():registerResourceInfo(UNIQUE_ID, resource , name, ATTRIBUTES) instead.") end
end

function RD.GetProperResourceName(resource)
	local registry = SPACEBUILD:getResourceRegistry()
	if not resource then return end
	local resObj = registry:getResourceInfoFromName(resource)
	return resObj:getDisplayName()
end

-- end shared stuff

--Alternate Use Code--

local function GenUseMenu(ent)
	local SmallFrame = vgui.Create("DFrame")
	SmallFrame:SetPos( (ScrW()/2)-110,(ScrH()/2)-100)
	SmallFrame:SetSize( 220, (#ent.Inputs*40)+90 )
	SmallFrame:SetTitle( ent.PrintName )
	
	local ypos = 30
	
	local HoldSlider = vgui.Create( "DNumSlider", SmallFrame )
		HoldSlider:SetPos( 10,ypos )
		HoldSlider:SetSize( 200, 30 )
		HoldSlider:SetText( "Time to Hold:" )
		HoldSlider:SetMin( 0 )
		HoldSlider:SetMax( 10 )
		HoldSlider:SetDecimals( 1 )
		HoldSlider:SetConVar( "number_to_hold" )
		
		ypos = ypos + 40
	for k,v in pairs(ent.Inputs) do
		local NumSliderThingy = vgui.Create( "DNumSlider", SmallFrame )
		NumSliderThingy:SetPos( 10,ypos )
		NumSliderThingy:SetSize( 120, 30 )
		NumSliderThingy:SetText( v.." :" )
		NumSliderThingy:SetMin( 0 )
		NumSliderThingy:SetMax( 10 )
		NumSliderThingy:SetDecimals( 0 )
		NumSliderThingy:SetConVar( "number_to_send" )
		
		local SendButton = vgui.Create( "DButton", SmallFrame )
		SendButton:SetPos(140,ypos)
		SendButton:SetText("Send Command")
		SendButton:SizeToContents()
		SendButton.DoClick = function()
			RunConsoleCommand("send_input_selection_to_server",ent.serverindex,v,client_chosen_number:GetInt(),client_chosen_hold:GetFloat())
		end
		
		ypos = ypos + 40
	end
	
	SmallFrame:MakePopup()
end 

local function RecieveInputs(um)
	local last = um:ReadBool()
	local input = um:ReadString()
	local index = um:ReadShort()
	local ent = ents.GetByIndex(index)
	ent.serverindex = index
	if not ent.Inputs then ent.Inputs = {} end
	if not table.HasValue(ent.Inputs,input) then table.insert(ent.Inputs,input) end
	if last and last == true then
		GenUseMenu(ent)
	end
end
usermessage.Hook("RD_AddInputToMenu", RecieveInputs)
