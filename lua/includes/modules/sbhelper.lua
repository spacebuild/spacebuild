---
-- Created by IntelliJ IDEA.
-- User: stijnvlaes
-- Date: 5/11/11
-- Time: 13:31
-- To change this template use File | Settings | File Templates.
--

local tostring = tostring;
local file = file;
require("Json");
local Json = Json

module("sbhelper")

local base_folder = "configs/"
local empty_config = {}
local temp;
local extension = ".txt";

function loadConfig(filename, basefolder)
    basefolder = basefolder or base_folder
    basefolder = tostring(basefolder)
    filename = tostring(filename);
    filename = basefolder .. filename .. extension
    if file.Exists(filename, "DATA" ) then
        temp = file.Read(filename);
        if temp then
            return Json.Decode(temp);
        end
    end
    return empty_config
end

function saveConfig(filename, data, basefolder)
    basefolder = basefolder or base_folder
    basefolder = tostring(basefolder)
    filename = tostring(filename);
    filename = basefolder .. filename .. extension
    temp = Json.Encode(data);
    file.Write(filename, temp)
end


