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
-- User: Stijn
-- Date: 19/03/13
-- Time: 21:29
-- To change this template use File | Settings | File Templates.
--

local print = print
local unpack = unpack
local tonumber = tonumber
local PrintTable = PrintTable
local os = os

module("log")

NONE = 0
INFO = 1
WARN = 2
ERROR = 3
DEBUG = 4

local level = DEBUG

local function levelToString(lvl)
	return "[" .. ((lvl == INFO and "INFO") or (lvl == WARN and "WARN") or (lvl == ERROR and "ERRO") or "DEBUG") .. "]"
end

local function prettyTime()
	return os.date( "%d/%m/%Y - %H:%M:%S" , os.time() )
end

function setLevel(lvl)
	level = tonumber(lvl)
	print("Setting Loging to " .. levelToString(lvl))
end



function log(lvl, ...)
	if not lvl then lvl = DEBUG end
	if lvl <= level then
		print(levelToString(lvl), prettyTime(), ...)
	end
end

function info(...)
	log(INFO, ...)
end

function warn(...)
	log(WARN, ...)
end

function error(...)
	log(ERROR, ...)
end

function debug(...)
	log(DEBUG, ...)
end

function table(table, lvl, ...)
	if lvl <= level then
		log(lvl, ...)
		PrintTable(table)
	end
end