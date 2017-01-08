--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 26/12/2016
-- Time: 12:44
-- To change this template use File | Settings | File Templates.
--
local SPACEBUILD = SPACEBUILD
local log = SPACEBUILD.log

-- List of Silk Icons (gmod) materials/icon16/... (http://www.famfamfam.com/lab/icons/silk/previews/index_abc.png)

local base = "spacebuild/documentation/"
for _, fileName in pairs(file.Find(base.."contents/*.lua", "LUA")) do
    local isHtml = string.EndsWith( fileName, ".html.lua" )
    local newName = string.gsub( fileName, ".lua", ".txt" )
    local data = file.Read(base.."contents/"..fileName , "LUA" )
    if isHtml then
        string.gsub( data, ".lua", ".txt" )
    end
    log.debug("Writing menu file ", fileName, newName)
    file.Write( "sb/"..newName, data)
end
