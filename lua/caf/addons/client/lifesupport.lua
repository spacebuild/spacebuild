local SPACEBUILD = SPACEBUILD
local LS = {}

local status = false

--Hook Values

local log = SPACEBUILD.log

--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function LS.__Construct()
	status = true
	local RD = CAF.GetAddon("Resource Distribution")
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function LS.__Destruct()
	status = false
	return true
end

--[[
	Get the required Addons for this Addon Class
]]
function LS.GetRequiredAddons()
	return {"Resource Distribution"}
end

--[[
	Get the Boolean Status from this Addon Class
]]
function LS.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function LS.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end


local isuptodatecheck;
--[[
	Update check
]]
function LS.IsUpToDate(callBackfn)
	if not CAF.HasInternet then
		return
	end
	if isuptodatecheck ~= nil then
		callBackfn(isuptodatecheck);
		return
	end
	--[[http.Get("http://www.snakesvx.net/versions/ls.txt","",
		function(html,size)
			local version = tonumber(html);
			if(version) then
				local latest = version;
				if(latest > LS.GetVersion()) then
					isuptodatecheck = false;
					callBackfn(false)
				else
					isuptodatecheck = true;
					callBackfn(true)
				end
			end
		end
	);]]
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function LS.GetExtraOptions()
	return {}
end

--[[
	Gets a menu from this Custom Addon Class
]]
function LS.GetMenu(menutype, menuname) --Name is nil for main menu, String for others
	local data = {}
	if not menutype then
		--Create Info Menu
		data["Info"] = {}
		local tmp = data["Info"];
		tmp["Wiki Home"] = {}
		tmp["Wiki Home"].localurl = "test/test.html";
		tmp["Wiki Home"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support";
		
		--Create Help Menu
		data["Help"] = {}
		tmp = data["Help"];
		tmp["Wiki Home"] = {}
		tmp["Wiki Home"].localurl = "test/test.html";
		tmp["Wiki Home"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support";
		
	end
	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function LS.GetCustomStatus()
	return ; --CAF.GetLangVar("Not Implemented Yet")
end

function LS.AddResourcesToSend()
	
end

--[[
	Returns a table containing the Description of this addon
]]
function LS.GetDescription()
	return {
				"Life Support 3",
				"",
				""
			}
end
CAF.RegisterAddon("Life Support", LS, "2")


