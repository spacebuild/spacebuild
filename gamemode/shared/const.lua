local const, Color = GM.constants, Color

const.suit = {}
const.suit.MAX_OXYGEN = 2000
const.suit.MAX_ENERGY = 2000
const.suit.MAX_COOLANT = 2000

const.TEMPERATURE_SAFE_MIN = 283
const.TEMPERATURE_SAFE_MAX = 308
const.PRESSURE_SAFE_MAX = 1.5

const.TIME_TO_NEXT_RD_SYNC = 1
const.TIME_TO_NEXT_LS_SYNC = 0.2
const.TIME_TO_NEXT_LS_ENV = 1
const.TIME_TO_NEXT_SB_SYNC = 3

const.BASE_OXYGEN_USE = 1
const.BASE_ENERGY_USE = 1
const.BASE_COOLANT_USE = 0

const.AMOUNTOFDEGREES_DIVIDER = 40
-- http://www.roymech.co.uk/Related/Thermos/Thermos_HeatTransfer.html
-- used in the formula to calculate temperature changes (Nylon 6)
const.SUIT_THERMAL_CONDUCTIVITY = 0.91 -- used the emissivity of plastic, as this is for radiation

const.BOLTZMANN = 0.00000005673 -- Stefan Boltzman constant = 5.673 x10^-8 W m^-2 K^-4
const.EMISSIVITY = {
	skin = 0.98,
	plastic = 0.91,
	aluminium = 0.05
}

const.SPECIFIC_HEAT_CAPACITY = {  -- In J/Kg please
	skin = 3470, -- J/Kg
	plastic = 1.67*1000, --J/Kg
	aluminium = 0.91*1000, -- Get the value into Joules/Kg
}

const.PLY_MASS = 100 -- In Kg please

const.BODY_SURFACE_AREA = 1.9 -- For men the average BSA is 1.9 m^2

const.BASE_LS_DAMAGE = 5

const.colors = {
	white = Color(255, 255, 255, 255),
	yellow = Color(250, 250, 100),
	green = Color(100, 255, 100, 255),
	orange = Color(255, 127, 36, 255),
	red = Color(205, 51, 51, 255)
}

