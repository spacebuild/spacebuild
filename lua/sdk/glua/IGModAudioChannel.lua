---
-- @description Library IGModAudioChannel
 module("IGModAudioChannel")

--- IGModAudioChannel:EnableLooping
-- @usage client
-- Enables or disables looping of audio channel, requires noblock flag.
--
-- @param  enable boolean  Enable or disable looping of this audio channel.
function EnableLooping( enable) end

--- IGModAudioChannel:FFT
-- @usage client
-- Computes the DFT (discrete Fourier transform) of the sound channel.
--
-- @param  tbl table  The table to output the DFT magnitudes (numbers between 0 and 1) into. Indices start from 1.
-- @param  size number  The number of samples to use. See FFT_ Enums
-- @return number The number of frequency bins that have been filled in the output table.
function FFT( tbl,  size) end

--- IGModAudioChannel:Get3DCone
-- @usage client
-- Returns 3D cone of the sound channel. See IGModAudioChannel:Set3DCone.
--
-- @return number The angle of the inside projection cone in degrees.
-- @return number The angle of the outside projection cone in degrees.
-- @return number The delta-volume outside the outer projection cone.
function Get3DCone() end

--- IGModAudioChannel:Get3DFadeDistance
-- @usage client
-- Returns 3D fade distances of a sound channel.
--
-- @return number The minimum distance. The channel's volume is at maximum when the listener is within this distance
-- @return number The maximum distance. The channel's volume stops decreasing when the listener is beyond this distance
function Get3DFadeDistance() end

--- IGModAudioChannel:GetBitsPerSample
-- @usage client
-- Retrieves the number of bits per sample of the sound channel.
--
-- @return number Number of bits per sample, or 0 if unknown.
function GetBitsPerSample() end

--- IGModAudioChannel:GetFileName
-- @usage client
-- Returns the filename for the sound channel.
--
-- @return string The file name. This will not be always what you have put into the sound.PlayURL as first argument.
function GetFileName() end

--- IGModAudioChannel:GetLength
-- @usage client
-- Returns the length of sound played by the sound channel.
--
-- @return number The length of the sound. This value seems to be less then 0 for continuous radio streams.
function GetLength() end

--- IGModAudioChannel:GetLevel
-- @usage client
-- Returns the right and left levels of sound played by the sound channel.
--
-- @return number The left sound level. The value is between 0 and 1.
-- @return number The right sound level. The value is between 0 and 1.
function GetLevel() end

--- IGModAudioChannel:GetPlaybackRate
-- @usage client
-- Returns the playback rate of the sound channel.
--
-- @return number The current playback rate of the sound channel
function GetPlaybackRate() end

--- IGModAudioChannel:GetPos
-- @usage client
-- Returns position of the sound channel
--
-- @return Vector The position of the sound channel, previously set by IGModAudioChannel:SetPos
function GetPos() end

--- IGModAudioChannel:GetSamplingRate
-- @usage client
-- Returns the sample rate for currently playing sound.
--
-- @return number The sample rate in MHz. This should always be 44100.
function GetSamplingRate() end

--- IGModAudioChannel:GetState
-- @usage client
-- Returns the state of a sound channel
--
-- @return number The state of the sound channel, see GMOD_CHANNEL_ Enums
function GetState() end

--- IGModAudioChannel:GetTime
-- @usage client
-- Returns the current time of the sound channel
--
-- @return number The current time of the stream
function GetTime() end

--- IGModAudioChannel:GetVolume
-- @usage client
-- Returns volume of a sound channel
--
-- @return number The volume of the sound channel
function GetVolume() end

--- IGModAudioChannel:Is3D
-- @usage client
-- Returns if the sound channel is in 3D mode or not.
--
-- @return boolean Is 3D or not.
function Is3D() end

--- IGModAudioChannel:IsBlockStreamed
-- @usage client
-- Returns whether the audio stream is block streamed or not.
--
-- @return boolean Is the audio stream block streamed or not.
function IsBlockStreamed() end

--- IGModAudioChannel:IsLooping
-- @usage client
-- Returns if the sound channel is looping or not.
--
-- @return boolean Is looping or not.
function IsLooping() end

--- IGModAudioChannel:IsOnline
-- @usage client
-- Returns if the sound channel is streamed from the Internet or not.
--
-- @return boolean Is online or not.
function IsOnline() end

--- IGModAudioChannel:IsValid
-- @usage client
-- Returns if the sound channel is valid or not.
--
-- @return boolean Is the sound channel valid or not
function IsValid() end

--- IGModAudioChannel:Pause
-- @usage client
-- Pauses the stream. It can be started again using IGModAudioChannel:Play
--
function Pause() end

--- IGModAudioChannel:Play
-- @usage client
-- Starts playing the stream.
--
function Play() end

--- IGModAudioChannel:Set3DCone
-- @usage client
-- Sets 3D cone of the sound channel.
--
-- @param  innerAngle number  The angle of the inside projection cone in degrees.  Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
-- @param  outerAngle number  The angle of the outside projection cone in degrees.  Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
-- @param  outerVolume number  The delta-volume outside the outer projection cone.  Range is from 0 (silent) to 1 (same as inside the cone), less than 0 = leave current.
function Set3DCone( innerAngle,  outerAngle,  outerVolume) end

--- IGModAudioChannel:Set3DFadeDistance
-- @usage client
-- Sets 3D fade distances of a sound channel.
--
-- @param  min number  The minimum distance. The channel's volume is at maximum when the listener is within this distance.  0 or less = leave current.
-- @param  max number  The maximum distance. The channel's volume stops decreasing when the listener is beyond this distance.  0 or less = leave current.
function Set3DFadeDistance( min,  max) end

--- IGModAudioChannel:SetPlaybackRate
-- @usage client
-- Sets the playback rate of the sound channel. May not work with high values for radio streams.
--
-- @param  rate number  Playback rate to set to. 1 is normal speed, 0.5 is half the normal speed, etc.
function SetPlaybackRate( rate) end

--- IGModAudioChannel:SetPos
-- @usage client
-- Sets position of sound channel in case the sound channel has a 3d option set.
--
-- @param  pos Vector  The position to put the sound into
-- @param  dir=Vector( 0, 0, 0 ) Vector  The direction of the sound
function SetPos( pos,  dir) end

--- IGModAudioChannel:SetTime
-- @usage client
-- Sets the sound channel to specified time ( Rewind to that position of the song ). Does not work on online radio streams.
--
-- @param  secs number  The time to set the stream to, in seconds.
function SetTime( secs) end

--- IGModAudioChannel:SetVolume
-- @usage client
-- Sets the volume of a sound channel
--
-- @param  volume number  Volume to set, a number between 0 and 1
function SetVolume( volume) end

--- IGModAudioChannel:Stop
-- @usage client
-- 
--
--WARNING
--
--This is currently broken and causes the object to become invalid. It will not play again. Issue #1497
--
function Stop() end
