--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 19/03/13
-- Time: 21:29
-- To change this template use File | Settings | File Templates.
--

local print = MsgN
local tonumber = tonumber

module("log")

NONE  = 0
INFO  = 1
WARN  = 2
ERROR = 3
DEBUG = 4

local level =  DEBUG

function setLevel(level)
   level = tonumber(level)
end

local function levelToString(lvl)
   return "[" ..((lvl == INFO and "info") or (lvl == WARN and "warn") or (lvl == ERROR and "error") or "debug").."]"
end

function log(message, lvl)
   if not lvl then lvl = DEBUG end
   if lvl <= level then
      print(levelToString(lvl)..message)
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