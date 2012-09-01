local RD = {}

local status = false

--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function RD.__Construct()
	status = true
	return true , "No Implementation yet"
end

--[[
	The Destructor for this Custom Addon Class
]]
function RD.__Destruct()
	return false , "Can't disable"
end

--[[
	Get the required Addons for this Addon Class
]]
function RD.GetRequiredAddons()
	return {"Resource Distribution"}
end

--[[
	Get the Boolean Status from this Addon Class
]]
function RD.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function RD.GetVersion()
	return 3.05, "Beta"
end

local isuptodatecheck;
--[[
	Update check
]]
function RD.IsUpToDate(callBackfn)
	if not CAF.HasInternet then
		return
	end
	if isuptodatecheck ~= nil then
		callBackfn(isuptodatecheck);
		return
	end
	--[[http.Get("http://www.snakesvx.net/versions/lsents.txt","",
		function(html,size)
			local version = tonumber(html);
			if(version) then
				local latest = version;
				if(latest > RD.GetVersion()) then
					isuptodatecheck = false;
					callBackfn(false)
				else
					isuptodatecheck = true;
					callBackfn(true)
				end
			end
		end
	); ]]
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function RD.GetExtraOptions()
	return {}
end

--[[
	Gets a menu from this Custom Addon Class
]]
function RD.GetMenu(menutype, menuname) --Name is nil for main menu, String for others
	local data = {}
	if not menutype then
		data["Info"] = {}
		--Create Info Menu
		local tmp = data["Info"];
		tmp["Wiki Home"] = {}
		tmp["Wiki Home"].localurl = "test/test.html";
		tmp["Wiki Home"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support";
		
		tmp["Generators"] = {}
		tmp["Generators"].localurl = "test/test.html";
		tmp["Generators"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support_Generators"
		
		tmp["Storage Devices"] = {}
		tmp["Storage Devices"].localurl = "test/test.html";
		tmp["Storage Devices"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support_Storage_Devices"
		
		tmp["Special Devices"] = {}
		tmp["Special Devices"].localurl = "test/test.html";
		tmp["Special Devices"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support_Special_Devices"
		
		tmp["Environmental Controls"] = {}
		tmp["Environmental Controls"].localurl = "test/test.html";
		tmp["Environmental Controls"].interneturl = "http://www.snakesvx.net/index.php/module_Wiki/title_Garrysmod_Info_Life_Support_Environment_Controls"
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
function RD.GetCustomStatus()
	return ;
end

--[[
	Can the Status of the addon be changed?
]]
function RD.CanChangeStatus()
	return false;
end

--[[
	Returns a table containing the Description of this addon
]]
function RD.GetDescription()
	return {
				"Life Support Entities",
				"",
				""
			}
end

CAF.RegisterAddon("Life Support Entities", RD, "2")


