--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]



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

local util = sb.core.util
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
		
		--Start of Sam Code:
		self.description = "The Default Description for a Base Extension"
		--End of Sam Code
    end;
	
	--Start of Sam Code:
	getDesc = function(self)
		return self.description
	end;
	--End of Sam Code
	
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
-- Such as sb.core.extensions.key = value
-- @param name The name of the extension, or the name used to store it on the extensions table
-- @param value The value you wish to store at that key on the table. Usually another table, for extensions.
function sb.core.extensions:register(name,value)
    if not self[name] then
        --local execPath = debug.getinfo(2).source -- Get the file that called this function, caution uses debug library
        --local _,_,folder = string.find(execPath,"sb/extensions/(.-)/") -- Find what the folder is, will be third return from string.find


        --value.basePath = "sb/extensions/"..folder.."/" -- Restructure the basePath. Add trailing /

        value.basePath = self:getBasePath(debug.getinfo(2).source)

        value = util.mergeTable(extBase,value) -- Make value table inherit from extensions base.
        rawset(self,name,value) -- Set the key and value using rawset as writing metamethod has been disabled.
    else
        print("That key already exists in the table") -- To stop duplicate entries, or overrides.
    end
end


--- Getting your basePath from an extension without registering.
-- So you can get your basePath for use in shared includes.

function sb.core.extensions:getBasePath(source)

    local execPath = source or debug.getinfo(2).source
    local _,_,folder = string.find(execPath,"sb/extensions/(.-)/") -- Find what the folder is, will be third return from string.find

    local basePath = "sb/extensions/"..folder.."/"

    return basePath

end


--- Getter function, retreive values from the sb.core.extensions table.
-- Simply a getter, however normal sb.core.extensions["key"] or sb.core.extensions.key should work.
-- @param name The name of the key to retreive the value of.
function sb.core.extensions:get(name)
    return self[name] or false
end


-- After declaring the setter and getter methods, now make the table read only!
--sb.core.extensions = util.createReadOnlyTable(sb.core.extensions)

local basePath = "sb/extensions/"
local exts = sb.core.wrappers:Find("dir","sb/extensions/*","LUA") -- table for storing exts in.

--- Extension Loading function
-- @param scope Which scope you wish to load, server/client/shared
-- @param send Whether to send the file to the client or not. Using AddCSLuaFile
-- Searches through each extension folder under the relevant scope folder, eg "server/" for any lua files,
-- and based upon 'send' will either send them or just include.

local function loadExts(scope,send)

    for k,v in pairs(exts) do
        for i,j in ipairs(sb.core.wrappers:Find("file",basePath.. v.. "/autorun/".. scope.. "*", "LUA")) do
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



if (CLIENT) then
	--This will contain all the Extension Panels
	--TODO: Talk to Radon about using the unique IDs instead of incrementally inserting them. This would allow extensions to change their own panel.
	
	local ExtsPnls = {}
	local vgui = vgui
	
	
	function DrawExtensionsMenu( panel ) 
		local exts = 1;
		for k,v in pairs(sb.core.extensions) do
			if (v:getName()) then
				
				index = table.insert(ExtsPnls,v:GetSyncKey,{}) --TODO: Talk to Radon about using SyncKeys or incrementally. Basically should the extension be able to change its panel
				
				--TODO: Colour scheme to fit in with everything else such as the FluixHud colours
				
				--Create the base panel
				ExtsPnls[index][1] = vgui.Create( "DPanel",panel )
				ExtsPnls[index][1]:SetPos( 10, (exts * 100) + (10 * (exts - 1))) --TODO: Play around with the spacing (<10 perhaps)
				ExtsPnls[index][1]:SetSize( panel.GetWidth - 20, 100  ) --TODO: Play around with value 100
				--Increments the amount of Extensions so we know where to place the next Panel
				exts = exts + 1
				
				--Create the Title Text in the panel
				ExtsPnls[index][2] = vgui.Create( "DLabel",ExtsPnls[index][1])
				ExtsPnls[index][2]:SetPos( 5, 5 ) --TODO: Play around with these values 
				--ExtsPnls[index][2]:SetFont() TODO: Create a font for title
				ExtsPnls[index][2]:SetText(v:GetName())
				ExtsPnls[index][2]:SizeToContents() -- TODO: Check this function isn't deprecated
				
				
				--Create the description Text in the panel
				ExtsPnls[index][3] = vgui.Create( "DLabel",ExtsPnls[index][1])
				ExtsPnls[index][3]:SetPos( 5, 10) --TODO: Play with Values, Possibly indent the text against the title
				ExtsPnls[index][3]:SetFont( ) --TODO: Create a font for description
				ExtsPnls[index][3]:SetText(v:GetDesc()) --TODO: Create or find the the equivalent function that returns the description
				ExtsPnls[index][3]:SizeToContents() 
				
				--Create the options button
				ExtsPnls[index][4] = vgui.Create( "DButton",ExtsPnls[index][1])
				ExtsPnls[index][4]:SetPos()
				ExtsPnls[index][4]:SetSize()
			
				--Create the disable button 
				ExtsPnls[index][5] = vgui.Create( "DButton",ExtsPnls[index][1])
				ExtsPnls[index][5]:SetPos()
				ExtsPnls[index][5]:SetSize()
				
				--Disable the button if the localplayer isn't an admin.
				-- I'm guessing this is how it is meant to be
				if not (LocalPlayer():IsAdmin()) then
					--TODO: Confirm this disables the button.
					ExtsPnls[index][5]:SetDisabled(true)
				end		
				
				ExtsPnls[index][5].DoClick() = function() 
				--If the extension is already disabled.
					if (v:IsDisabled) then
						--The button should enable the addon and change the color to red and say Disable Disable addon

						--TODO: Ashley enabling code goes here.
						sb.core.extension:enable(k)
						--Set the color to green because the extension is Enabled
						ExtsPnls[index][5]:ColorTo( Color(0,255,0,255),1, 0 )
						-- Set the button to disable the extenison
						ExtsPnls[index][5]:SetText( "Disable the Extension" )
						
					else
						
						--TODO: Ashley disabling code for extension "v" goes here.
						sb.core.extensions:disable(k)
						--Set the color to red because the extension is disabled
						ExtsPnls[index][5]:ColorTo( Color(255,0,0,255),1, 0 )
						-- Set the button to enable the extenison
						ExtsPnls[index][5]:SetText( "Enable the Extension" )	
				end
				

				
			end	
	end
	
	spawnmenu.AddToolMenuOption( "SB", "Options", "Extensions", "","",DrawExtensionsMenu,{})
end