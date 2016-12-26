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

local MsgC = MsgC
local tonumber = tonumber
local PrintTable = PrintTable
local os = os
local Color = Color
local pairs = pairs
local type = type
local isClient = CLIENT
local isServer = SERVER

module("log")

local errorColor = Color(255, 0, 0)
local infoColor = Color(166, 217, 106)
local warnColor = Color(253, 174, 97)
local debugColor = Color(75, 196, 213)
local clientColor = Color(255, 222, 102)
local serverColor = Color(137, 222, 255)

NONE = 0
INFO = 3
WARN = 2
ERROR = 1
DEBUG = 4

local level = DEBUG

local function levelToString(lvl)
	return "[" .. ((lvl == INFO and "INFO ") or (lvl == WARN and "WARN ") or (lvl == ERROR and "ERROR") or "DEBUG") .. "]"
end

local function levelToColor(lvl)
	return (lvl == INFO and infoColor) or (lvl == WARN and warnColor) or (lvl == ERROR and errorColor) or debugColor
end

local function prettyTime()
	return os.date( "%d/%m/%Y - %H:%M:%S" , os.time() )
end

local function print(color, msg)
	MsgC(color, msg)
end

local function printServerOrClient()
	if isClient then
		MsgC(clientColor, "[CLIENT] ")
	end
	if isServer then
		MsgC(serverColor, "[SERVER] ")
	end
end

function setLevel(lvl)
	level = tonumber(lvl)
	print(levelToColor(lvl), "Setting Loging to " .. levelToString(lvl).."\n")
end



function log(lvl, ...)
	if not lvl then lvl = DEBUG end
	if lvl <= level then
		local color = levelToColor(lvl);
		print(color, levelToString(lvl).." ")
		printServerOrClient()
		print(color, prettyTime().." ")
		if type(...) == "table" then
			for k, v in pairs(...) do
				print(color, v)
				print(color, "\n")
			end
		else
			print(color, ...)
		end
		print(color, "\n")
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