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
-- @description Library steamworks
 module("steamworks")

--- steamworks.ApplyAddons
-- @usage menu
-- Refreshes clients addons.
--
function ApplyAddons() end

--- steamworks.Download
-- @usage client_m
-- Downloads a file from the supplied addon and saves it as a .cache file in garrysmod/cache folder.
--
-- @param  workshopPreviewID string  The Preview ID of workshop item.
-- @param  uncompress boolean  Whether to uncompress the file or not, assuming it was compressed with LZMA.  You will usually want to set this to true.
-- @param  resultCallback function  The function to process retrieved data. The first and only argument is a string, containing path to the saved file.
function Download( workshopPreviewID,  uncompress,  resultCallback) end

--- steamworks.FileInfo
-- @usage client_m
-- Retrieves info about supplied Steam Workshop addon.
--
-- @param  workshopItemID string  The ID of Steam Workshop item.
-- @param  resultCallback function  The function to process retrieved data. The first and only argument is a table, containing all the info.
function FileInfo( workshopItemID,  resultCallback) end

--- steamworks.GetList
-- @usage client_m
-- Retrieves a customized list of Steam Workshop addons.
--
-- @param  type string  The type of items to retrieve.
-- @param  tags table  A table of tags to match.
-- @param  offset number  How much of results to skip from first one. Mainly used for pages.
-- @param  numRetrieve number  How much addons to retrieve.
-- @param  days number  When getting Most Popular content from Steam, this determines a time period. ( 7 = most popular addons in last 7 days, 1 = most popular addons today, etc )
-- @param  userID string  "0" to retrieve all addons, "1" to retrieve addons only published by you.
-- @param  resultCallback function  The function to process retrieved data. The first and only argument is a table, containing all the info.
function GetList( type,  tags,  offset,  numRetrieve,  days,  userID,  resultCallback) end

--- steamworks.GetPlayerName
-- @usage client_m
-- Retrieves players name by his 64bit SteamID.
--
-- @param  steamID64 string  The 64bit Steam ID ( aka Community ID ) of the player
-- @return string The name of that player
function GetPlayerName( steamID64) end

--- steamworks.IsSubscribed
-- @usage client_m
-- Returns whenever the client is subscribed to the specified Steam Workshop item.
--
-- @param  workshopItemID string  The ID of the Steam Workshop item.
-- @return boolean Is the client subscribed to the addon or not.
function IsSubscribed( workshopItemID) end

--- steamworks.OpenWorkshop
-- @usage client_m
-- Opens the workshop website in the steam overlay browser.
--
function OpenWorkshop() end

--- steamworks.Publish
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  tags table  The workshop tags to apply
-- @param  filename string  Path to the file to upload
-- @param  image string  Path to the image to use as icon
-- @param  name string  Name of the Workshop submission
-- @param  desc string  Description of the Workshop submission
function Publish( tags,  filename,  image,  name,  desc) end

--- steamworks.RequestPlayerInfo
-- @usage client_m
-- Requests information of the player with SteamID64 for later use with steamworks.GetPlayerName.
--
-- @param  steamID64 string  The 64bit Steam ID of player.
function RequestPlayerInfo( steamID64) end

--- steamworks.SetFileCompleted
-- @usage menu
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  workshopid string  The Steam Workshop item id
-- @return string Whatever you have put in as first argument
function SetFileCompleted( workshopid) end

--- steamworks.SetFilePlayed
-- @usage menu
-- Sets whether you have played this addon or not. This will be shown to the user in the Steam Workshop itself:
--
--
-- @param  workshopid string  The Steam Workshop item ID
-- @return string Whatever you have put in as first argument
function SetFilePlayed( workshopid) end

--- steamworks.SetShouldMountAddon
-- @usage menu
-- Sets if an addon should be enabled or disabled. Call steamworks.ApplyAddons afterwards to update.
--
-- @param  workshopItemID string  The ID of the Steam Workshop item we should enable/disable
-- @param  shouldMount boolean  true to enable the item, false to disable.
function SetShouldMountAddon( workshopItemID,  shouldMount) end

--- steamworks.ShouldMountAddon
-- @usage client_m
-- Returns whenever the specified Steam Workshop addon will be mounted or not.
--
-- @param  workshopItemID string  The ID of the Steam Workshop
-- @return boolean Will the workshop item be mounted or not
function ShouldMountAddon( workshopItemID) end

--- steamworks.Subscribe
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  workshopItemID string  The ID of the Steam Workshop item we should subscribe to
function Subscribe( workshopItemID) end

--- steamworks.Unsubscribe
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  workshopItemID string  The ID of the Steam Workshop item we should unsubscribe from.
function Unsubscribe( workshopItemID) end

--- steamworks.ViewFile
-- @usage client_m
-- Opens the workshop website for specified Steam Workshop item in the Steam overlay browser.
--
-- @param  workshopItemID string  The ID of workshop item.
function ViewFile( workshopItemID) end

--- steamworks.Vote
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  workshopItemID string  The ID of workshop item.
-- @param  upOrDown boolean  Sets if the user should vote up/down. True makes them upvote, false down
function Vote( workshopItemID,  upOrDown) end

--- steamworks.VoteInfo
-- @usage client_m
-- Retrieves vote info of supplied addon.
--
-- @param  workshopItemID string  The ID of workshop item.
-- @param  resultCallback function  The function to process retrieved data. The first and only argument is a table, containing all the info.
function VoteInfo( workshopItemID,  resultCallback) end
