local sb = sb
local const = sb.core.const

const.TEMPERATURE_SAFE_MIN = 283
const.TEMPERATURE_SAFE_MAX = 308
const.PRESSURE_SAFE_MAX = 1.5

const.BASE_OXYGEN_USE = 1
const.BASE_ENERGY_USE = 1
const.BASE_COOLANT_USE = 0

const.AMOUNTOFDEGREES_DIVIDER = 40
-- http://www.roymech.co.uk/Related/Thermos/Thermos_HeatTransfer.html
const.SUIT_THERMAL_CONDUCTIVITY = 0.25 -- used in the formula to calculate temperature changess (Nylon 6)

const.BASE_LS_DAMAGE = 5

const.colors = {
	white = Color(255, 255, 255, 255),
	yellow = Color(250, 250, 100),
	green = Color(100, 255, 100, 255),
	orange = Color(255, 127, 36, 255),
	red = Color(205, 51, 51, 255)
}

