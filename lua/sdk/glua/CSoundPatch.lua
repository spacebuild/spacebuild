---
-- @description Library CSoundPatch
 module("CSoundPatch")

--- CSoundPatch:ChangePitch
-- @usage shared
-- Adjust the pitch, alias the speed at which the sound is being played.
--
-- @param  pitch number  The pitch can range from 0-255.
-- @param  deltaTime=0 number  The time to fade from previous to the new pitch.
function ChangePitch( pitch,  deltaTime) end

--- CSoundPatch:ChangeVolume
-- @usage shared
-- Adjusts the volume of the sound played.
--Appears to only work while the sound is being played.
--
-- @param  volume number  The volume ranges from 0 to 1.
-- @param  deltaTime=0 number  Time to fade the volume from previous to new value from.
function ChangeVolume( volume,  deltaTime) end

--- CSoundPatch:FadeOut
-- @usage shared
-- Fades out the volume of the sound from the current volume to 0 in the given amount of seconds.
--
-- @param  seconds number  Fade time.
function FadeOut( seconds) end

--- CSoundPatch:GetDSP
-- @usage shared
-- Returns the DSP ( Digital Signal Processor ) effect for the sound.
--
-- @return number The DSP effects of the sound List of DSP's are Pick from the here.
function GetDSP() end

--- CSoundPatch:GetPitch
-- @usage shared
-- Returns the current pitch.
--
-- @return number The current pitch, can range from 0-255.
function GetPitch() end

--- CSoundPatch:GetSoundLevel
-- @usage shared
-- Returns the current sound level.
--
-- @return number The current sound level, see SNDLVL_ Enums.
function GetSoundLevel() end

--- CSoundPatch:GetVolume
-- @usage shared
-- Returns the current volume.
--
-- @return number The current volume, ranging from 0 to 1.
function GetVolume() end

--- CSoundPatch:IsPlaying
-- @usage shared
-- Returns whenever the sound is being played.
--
-- @return boolean Is playing or not
function IsPlaying() end

--- CSoundPatch:Play
-- @usage shared
-- Starts to play the sound.
--
function Play() end

--- CSoundPatch:PlayEx
-- @usage shared
-- Same as CSoundPatch:Play but with 2 extra arguments allowing to set volume and pitch directly.
--
-- @param  volume number  The volume ranges from 0 to 1.
-- @param  pitch number  The pitch can range from 0-255.
function PlayEx( volume,  pitch) end

--- CSoundPatch:SetDSP
-- @usage shared
-- Sets the DSP ( Digital Signal Processor ) effect for the sound. Similar to Player:SetDSP
--
-- @param  dsp number  The DSP effect to set.  Pick from the list of DSP's
function SetDSP( dsp) end

--- CSoundPatch:SetSoundLevel
-- @usage shared
-- Sets the sound level in decibel.
--
-- @param  level number  The sound level in decibel. See SNDLVL_ Enums
function SetSoundLevel( level) end

--- CSoundPatch:Stop
-- @usage shared
-- Stops the sound from being played.
--
function Stop() end
