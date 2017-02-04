---
-- @description Library physenv
 module("physenv")

--- physenv.AddSurfaceData
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
-- @param  properties string  The properties to add.
function AddSurfaceData( properties) end

--- physenv.GetAirDensity
-- @usage shared
-- Returns the air density.
--
-- @return number airDensity
function GetAirDensity() end

--- physenv.GetGravity
-- @usage shared
-- Gets the global gravity.
--
-- @return Vector gravity
function GetGravity() end

--- physenv.GetPerformanceSettings
-- @usage shared
-- Gets the current performance settings in table form.
--
-- @return table Performance settings. See PhysEnvPerformanceSettings structure
function GetPerformanceSettings() end

--- physenv.SetAirDensity
-- @usage shared
-- Sets the air density.
--
-- @param  airDensity number  The new air density.
function SetAirDensity( airDensity) end

--- physenv.SetGravity
-- @usage shared
-- Sets the directional gravity, does not work on players.
--
-- @param  gravity Vector  The new gravity.
function SetGravity( gravity) end

--- physenv.SetPerformanceSettings
-- @usage shared
-- Sets the performance settings.
--
-- @param  performanceSettings table  The new performance settings. See PhysEnvPerformanceSettings structure
function SetPerformanceSettings( performanceSettings) end
