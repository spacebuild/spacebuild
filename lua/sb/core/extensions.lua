--[[
		Addon: SB core
		Filename: core/extensions.lua
		Author(s): Radon
		Website: http://www.snakesvx.net
		
		Description:
			Handles loading and inclusion of extensions under sb/extensions/

		License: http://creativecommons.org/licenses/by-sa/3.0/
--]]


local sb = sb
local include = include
local AddCSLuaFile = AddCSLuaFile

local setmetatable = setmetatable
local ipairs = ipairs
local rawset = rawset
local debug = debug
local pairs = pairs
local print = print
local string = string

local util = sb.util
local generated_key

--- Extension Base Table Literal
-- Defined within are all the functions that an extension should posses in default form.
local extBase = {

    construct = function(self,config)

        -- Basic implementation, override using configs in your own extension.
        self.hidden = true
        self.active = false
        self.version = 1
        self.name = "Base Extension"
        self.config = config or {}

    end;

    isActive = function(self)
        return self.active
    end;

    start = function(self)
        self.active = 1
    end;

    stop = function(self)
        self.active = 0
    end;

    isHidden = function(self)
        return self.hidden
    end;

    setHidden = function(self,hidden)
        if type(hidden) == "number" then
            self.hidden = hidden
        else
            print("'"..hidden.."' is not a valid number")
        end
    end;

    getVersion = function(self)
        return self.version
    end;

    getName = function(self)
        return self.name
    end;

    getConfig = function(self)
        return self.config
    end;

    setConfig = function(self,config)
        self.config = config
    end;

    getDependancies = function(self)
        return {}
    end;

    getSyncKey = function(self)
    --Since the name shouldn't change we are only going to generate it once!!
        if not generated_key then
            generated_key = 23
            for k, v in self.name do
                generated_key = generated_key * (string.byte(v) - 64) -- A = 65, a = 97
            end
            generated_key = generated_key + string.len(self.name)
            --generated_key = generated_key %  2,147,483,647 --We don't want more then a LONG INTEGER
            generated_key = generated_key % 32767 --We don't want more then a SHORT INTEGER
        end
        return generated_key
    end
}

--- Registering Extensions. Responsible for assigning values and keys on the extensions table.
-- Such as sb.extensions.key = value
-- @param name The name of the extension, or the name used to store it on the extensions table
-- @param value The value you wish to store at that key on the table. Usually another table, for extensions.
function sb.extensions:register(name,value)
    if not self[name] then
        local execPath = debug.getinfo(2).source -- Get the file that called this function, caution uses debug library
        local _,_,folder = string.find(execPath,"sb/extensions/(.-)/") -- Find what the folder is, will be third return from string.find


        value.basePath = "sb/extensions/"..folder.."/" -- Restructure the basePath. Add trailing /
        value = util.mergeTable(extBase,value) -- Make value table inherit from extensions base.
        rawset(self,name,value) -- Set the key and value using rawset as writing metamethod has been disabled.
    else
        print("That key already exists in the table") -- To stop duplicate entries, or overrides.
    end
end

--- Getter function, retreive values from the sb.extensions table.
-- Simply a getter, however normal sb.extensions["key"] or sb.extensions.key should work.
-- @param name The name of the key to retreive the value of.
function sb.extensions:get(name)
    return self[name] or false
end


-- After declaring the setter and getter methods, now make the table read only!
sb.extensions = util.createReadOnlyTable(sb.extensions)

local basePath = "sb/extensions/"
local exts = sb.wrappers:Find("dir","sb/extensions/*","LUA") -- table for storing exts in.

--- Extension Loading function
-- @param scope Which scope you wish to load, server/client/shared
-- @param send Whether to send the file to the client or not. Using AddCSLuaFile
-- Searches through each extension folder under the relevant scope folder, eg "server/" for any lua files,
-- and based upon 'send' will either send them or just include.

local function loadExts(scope,send)

    for k,v in pairs(exts) do
        for i,j in ipairs(sb.wrappers:Find("file",basePath.. v.. "/autorun/".. scope.. "*", "LUA")) do
            if send then
                AddCSLuaFile(basePath.. v.. "/autorun/".. scope..j)
            else
                include(basePath.. v.. "/autorun/".. scope.. j)
            end
        end
    end
end

if SERVER then
    loadExts(util.SCOPES.SERVER)
    loadExts(util.SCOPES.CLIENT, true)
    loadExts(util.SCOPES.SHARED, true)
    loadExts(util.SCOPES.SHARED)
else
    loadExts(util.SCOPES.CLIENT)
    loadExts(util.SCOPES.SHARED)
end