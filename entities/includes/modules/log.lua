-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 19/03/13
-- Time: 21:29
-- To change this template use File | Settings | File Templates.
--

local print = MsgN
local tonumber = tonumber
local PrintTable = PrintTable

module("log")

NONE = 0
INFO = 1
WARN = 2
ERROR = 3
DEBUG = 4

local level = DEBUG

local function levelToString(lvl)
	return "[" .. ((lvl == INFO and "info") or (lvl == WARN and "warn") or (lvl == ERROR and "error") or "debug") .. "]"
end

function setLevel(lvl)
	level = tonumber(lvl)
	print("Setting Loging to " .. levelToString(lvl))
end



function log(message, lvl)
	if not lvl then lvl = DEBUG end
	if lvl <= level then
		print(levelToString(lvl) .. message)
	end
end

function info(message)
	log(message, INFO)
end

function warn(message)
	log(message, WARN)
end

function error(message)
	log(message, ERROR)
end

function debug(message)
	log(message, DEBUG)
end

function table(table, message, lvl)
	if lvl <= level then
		log(message, lvl)
		PrintTable(table)
	end
end