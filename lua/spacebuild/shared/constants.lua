-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

--
-- Created by IntelliJ IDEA.
-- User: stijn
-- Date: 18/06/2016
-- Time: 21:14
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD

local const, Color, int = SB.constants, Color, SB.internal

const.suit = {}
const.suit.MAX_OXYGEN = 2000
const.suit.MAX_ENERGY = 2000
const.suit.MAX_COOLANT = 2000

const.TEMPERATURE_SAFE_MIN = 283
const.TEMPERATURE_SAFE_MAX = 308
const.TEMPERATURE_DESTROY_MIN = 5000
const.PRESSURE_SAFE_MAX = 1.5

const.TIME_TO_NEXT_RD_SYNC = 1
const.TIME_TO_NEXT_LS_SYNC = 0.2
const.TIME_TO_NEXT_LS_ENV = 1
const.TIME_TO_NEXT_SB_SYNC = 3

const.BASE_OXYGEN_USE = 5
const.BASE_ENERGY_USE = 5
const.BASE_COOLANT_USE = 0

const.BASE_LS_DAMAGE = 5

const.colors = int.readOnlyTable({
	white = Color(255, 255, 255, 255),
	yellow = Color(250, 250, 100),
	green = Color(100, 255, 100, 255),
	orange = Color(255, 127, 36, 255),
	red = Color(205, 51, 51, 255)
})

