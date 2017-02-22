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
-- @description Library sound
 module("sound")

--- sound.Add
-- @usage shared
-- Creates a sound script. It can also override sounds, which seems to only work when set on the server.
--
-- @param  soundData table  The sounds properties. See SoundData structure
function Add( soundData) end

--- sound.AddSoundOverrides
-- @usage shared
-- Overrides sounds defined inside of a txt file; typically used for adding map-specific sounds.
--
-- @param  filepath string  Path to the script file to load.
function AddSoundOverrides( filepath) end

--- sound.Generate
-- @usage client
-- Creates a sound from a function.
--
-- @param  indentifier string  An unique identified for the sound. You cannot override already existing ones.
-- @param  samplerate number  The sample rate of the sound. Must be 11025, 22050 or 44100.
-- @param  length number  The length in seconds of the sound to generate.
-- @param  callback function  A function which will be called to generate every sample on the sound. This function gets the current sample number passed as the first argument. The return value must be between -1.0 and 1.0. Other values will wrap back to the -1 to 1 range and basically clip. There are 65535 possible quantifiable values between -1 and 1.
function Generate( indentifier,  samplerate,  length,  callback) end

--- sound.GetProperties
-- @usage shared
-- Returns properties of the soundscript.
--
-- @param  name string  The name of the sound script
-- @return table The properties of the soundscript. See SoundData structure
function GetProperties( name) end

--- sound.GetTable
-- @usage shared
-- Returns a list of all registered sound scripts.
--
-- @return table The list of all registered sound scripts
function GetTable() end

--- sound.Play
-- @usage shared
-- Plays a sound from the specified position in the world.
--If you want to play a sound without a position, such as a UI sound, use surface.PlaySound instead.
--
-- @param  Name string  A string path to the sound.
-- @param  Pos Vector  A vector describing where the sound should play.
-- @param  Level number  Sound level in decibels. 75 is normal. Ranges from 20 to 180, where 180 is super loud. This affects how far away the sound will be heard.
-- @param  Pitch number  An integer describing the sound pitch. Range is from 0 to 255. 100 is normal pitch.
-- @param  Volume number  A float ranging from 0-1 describing the output volume of the sound.
function Play( Name,  Pos,  Level,  Pitch,  Volume) end

--- sound.PlayFile
-- @usage client
-- Plays a file from GMod directory. You can find a list of all error codes here
--
-- @param  path string  The path to the file to play.  Unlike other sound functions and structures, the path is relative to garrysmod/ instead of garrysmod/sound/
-- @param  flags string  Flags for the sound. Can be one or more of following, separated by a space (" "):   3d - Makes the sound 3D, so you can set its position  mono - Forces the sound to have only one channel  noplay - Forces the sound not to play as soon as this function is called  noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime.  If you don't want to use any of the above, you can just leave it as "".
-- @param  callback function  Callback function that is called as soon as the the stream is loaded. It has next arguments: IGModAudioChannel soundchannel - The sound channel number errorID - ID of an error, if an error has occured string errorName - Name of an error, if an error has occured  
function PlayFile( path,  flags,  callback) end

--- sound.PlayURL
-- @usage client
-- Allows you to play external sound files, as well as online radio streams.
--You can find a list of all error codes here
--
-- @param  url string  The URL of the sound to play
-- @param  flags string  Flags for the sound. Can be one or more of following, separated by a space (" "):   3d - Makes the sound 3D, so you can set its position  mono - Forces the sound to have only one channel  noplay - Forces the sound not to play as soon as this function is called  noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime.  If you don't want to use any of the above, you can just leave it as "".
-- @param  callback function  Callback function that is called as soon as the the stream is loaded. It has next arguments: IGModAudioChannel soundchannel - The sound channel number errorID - ID of an error, if an error has occured string errorName - Name of an error, if an error has occured  
function PlayURL( url,  flags,  callback) end
