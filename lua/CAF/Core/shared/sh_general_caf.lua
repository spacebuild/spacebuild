local CAF2 = CAF;
local CAF3 = CAF2.CAF3;
local DEBUG = CAF3.DEBUG;
local Addons = CAF3.Addons
local addonlevel = CAF3.addonlevel
local hooks = CAF3.hooks

--Language Settings

local DefaultLang = "english"

function CAF2.begintime()
	return os.clock( );
end

function CAF2.endtime(begintime)
	return CAF2.begintime() - begintime;
end


--END Language Settings

CAF2.version = 0.5

--COLOR Settings

CAF2.colors = {}
CAF2.colors.red = Color(230, 0, 0, 230)
CAF2.colors.green = Color(0, 230, 0, 230)
CAF2.colors.white = Color(255, 255, 255, 255)

--END COLOR Settings

-- CAF Custom Status Saving

if (!sql.TableExists("CAF_Custom_Vars")) then
	sql.Query("CREATE TABLE IF NOT EXISTS CAF_Custom_Vars ( varname VARCHAR(255) , varvalue VARCHAR(255));")
end

local vars = {}

local function InsertVar(name, value)
	if not name or not value then return false, "Problem with the Parameters" end
	name = sql.SQLStr(name)
	value = sql.SQLStr(value)
	sql.Query("INSERT INTO CAF_Custom_Vars(varname, varvalue) VALUES("..name..", "..value..");")
end

function CAF2.SaveVar(name, value)
	if not name or not value then return false, "Problem with the Parameters" end
	CAF2.LoadVar(name, value);
	name = sql.SQLStr(name)
	value = sql.SQLStr(value)
	sql.Query("UPDATE CAF_Custom_Vars SET varvalue="..value.." WHERE varname="..name..";")
	vars[name] = value;
end

function CAF2.LoadVar(name, defaultvalue)
	if not defaultvalue then defaultvalue = "0" end
	if not name then return false, "Problem with the Parameters" end
	if vars[name] then return vars[name] end
	local data = sql.Query("SELECT * FROM CAF_Custom_Vars WHERE varname = '"..name.."';")
	if (!data) then
		print(sql.LastError())
		InsertVar(name, defaultvalue);
		
	else
		defaultvalue = string.TrimRight(data[1]["varvalue"])
	end
	Msg("-"..tostring(defaultvalue).."-\n")
	vars[name] = defaultvalue
	return defaultvalue;
end

-- END CAF Custom Status Saving

CAF2.currentlanguage = CAF2.LoadVar("CAF_LANGUAGE", DefaultLang)

function CAF3.Think()
	if CAF ~= CAF2 then
		CAF = CAF2
	end
	for k , v in pairs(hooks["think"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think Error: " ..err .."\n")
		end
	end
end
hook.Add("Think", "CAF Think", CAF3.Think) --Always on!!

function CAF3.Think2()
	for k , v in pairs(hooks["think2"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think2 Error: " ..err .."\n")
		end
	end
end


function CAF3.Think3()
	for k , v in pairs(hooks["think3"]) do
		local ok, err = pcall(v)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "Think3 Error: " ..err .."\n")
		end
	end
end

--[[
	This function can be called to register a Hook (similar to Hook.add)
	Possibly Hooks are:
		think: Just like the default Think Hook
		think2: Updates every 0.5 seconds
		think3: Updates every Second
		OnEntitySpawn: Get's called when an entity spawns (parameters: Entity, Type(string), Player who spawned it)
		OnAddonDestruct: Gets called when an addon gets disabled (Parameters: Name of addon)
		OnAddonConstruct: Get called when an addon gets Enabled (parameters: Name of addon)
		OnAddonExtraOptionChange: Gets called when an Extra option on an addon changes (Parameters: Addonname, CustomStatusname, NewStatus value)
		
]]
function CAF2.AddHook(HookName, func)
	if  not HookName then return false , CAF.GetLangVar("No HookName given") end
	if not func then return false , CAF.GetLangVar("No function given") end
	if not hooks[HookName] then return false , CAF.GetLangVar("This hook doesn't exist") end
	table.insert(hooks[HookName], func)
	if(HookName == "think") then

	elseif(HookName == "think2") then
		if(#hooks[HookName] == 1) then
			timer.Create( "CAF Think 2", 0.5, 0, CAF3.Think2 )
		end
	elseif(HookName == "think3") then
		if(#hooks[HookName] == 1) then
			timer.Create( "CAF Think 3", 1, 0, CAF3.Think3 )
		end
	end
	return true
end

--[[
	Remove the functions you added to a certain hook from here
]]
function CAF2.RemoveHook(HookName, func)
	if  not HookName then return false , CAF.GetLangVar("No HookName given") end
	if not func then return false , CAF.GetLangVar("No function given") end
	if not hooks[HookName] then return false , CAF.GetLangVar("This hook doesn't exist") end
	for k, v in pairs(hooks[HookName]) do
		if (v == func) then
			table.remove(hooks[HookName], k)
		end
	end
	if(HookName == "think") then
	
	elseif(HookName == "think2") then
		if(#hooks[HookName] == 0) then
			timer.Destroy("CAF Think 2")  
		end
	elseif(HookName == "think3") then
		if(#hooks[HookName] == 0) then
			timer.Destroy("CAF Think 3")  
		end
	end
	return true
end

--[[
	Returns the Status of an extra option of an Addon or nil when not found
]]
function CAF2.GetExtraOptionStatus(AddonName, OptionName)
	if not AddonName then return nil , CAF.GetLangVar("No AddonName given") end
	if not OptionName then return nil , CAF.GetLangVar("No OptionName given") end
	if( Addons[AddonName]) then
		if( Addons[AddonName].GetExtraOptions) then
			local tmp =  Addons[AddonName].GetExtraOptions()
			if (tmp) then
				if(tmp[OptionName]) then
					return tmp[OptionName].status
				end
				return nil , CAF.GetLangVar("This option wasn't found for this Addon")
			end
		end
		return nil , CAF.GetLangVar("No Extra options found for this Addon")
	end
	return nil , CAF.GetLangVar("Addon Not Found")	
end

--[[
	Returns the boolean status of an Addon
]]
function CAF2.GetAddonStatus(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, status = pcall(Addons[AddonName].GetStatus)
		if(ok) then
			return status
		end
	end
	return nil , "No Status Info Found"
end

--[[
	Returns the custom status of the addon (if available)
]]
function CAF2.GetAddonCustomStatus(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, status = pcall(Addons[AddonName].GetCustomStatus)
		if(ok) then
			return status
		end
	end
	return nil , "No Custom Status Info Found"
end

--[[
	Returns the Number and String version of this addon
]]
function CAF2.GetAddonVersion(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	if( Addons[AddonName]) then
		local ok, version, strver = pcall(Addons[AddonName].GetVersion)
		if(ok) then
			return version, strver
		end
	end
	return nil , "No Version Info Found"
end

--[[
	Returns the reference to the Custom Addon, nil if not existant
]]
function CAF2.GetAddon(AddonName)
	if not AddonName then return nil , "No AddonName given" end
	return Addons[AddonName]
end

--[[
	Registers an addon with the game name into the table
	Overwrites if 2 addons use the same name
]]
function CAF2.RegisterAddon(AddonName, AddonClass, level)
	if not AddonName then return nil , "No AddonName given" end
	if not AddonClass then return nil , "No AddonClass given" end
	if not level then level = 5 end
	level = tonumber(level)
	if level < 1 then
		level = 1
	elseif level > 5 then
		level = 5
	end
	Addons[AddonName] = AddonClass
	table.insert(addonlevel[level], AddonName)
	return  true
end

function CAF2.GetLangVar(name)
	if CAF2.LANGUAGE then
		if CAF2.LANGUAGE[CAF.currentlanguage] then
			return CAF2.LANGUAGE[CAF.currentlanguage][name] or name or "Unknown"
		end
		if CAF2.LANGUAGE[DefaultLang] then
			return CAF2.LANGUAGE[DefaultLang][name] or name or "Unknown"
		end
	end
	return name or "Unknown"
end

--Experimental Class system ???

CLASS = nil
PROTECTED_CLASS = nil
local current_obj_id = 0;
local next_obj_id = 1;

CAF2.class = {}

local function ClassFileExists(filename)
	return file.Exists("../lua/caf/classes/"..tostring(filename)..".lua", "LUA")
end

local function LoadClassFile(name)
	include("caf/classes/"..tostring(name)..".lua")
end

--[[local function CopyProccedures()
	local tab = {}
	for k, v in pairs(CLASS) do
		--Msg("Found "..tostring(k)..": ")
		if type(v) == "function" then
			--Msg("ok\n");
			tab[k] = v;
		--else
		--	Msg("not ok\n");
		end
	end
	return tab;
end]]

local function CopyMetaProccedures()
	local tab = {}
	tab.__index = CLASS.__index;
	tab.__newindex = CLASS.__newindex
	tab.__concat = CLASS.__concat
	tab.__tostring = CLASS.__tostring
	--Todo add others?
	tab.__add = CLASS.__add
	tab.__sub = CLASS.__sub
	tab.__mul = CLASS.__mul
	tab.__div = CLASS.__div
	tab.__mod = CLASS.__mod
	tab.__pow = CLASS.__pow
	tab.__unm = CLASS.__unm
	tab.__len = CLASS.__len
	tab.__eq  = CLASS.__eq
	tab.__lt  = CLASS.__lt
	tab.__le  = CLASS.__le
	tab.__call = CLASS.__call
	return tab
end

local hooks = {
	"Think"
}

local function CheckForHooks(obj)
	--Add hooks to functions with similar names fe: obj:Think() => hooks.add("Think", "some_name", function() obj:Think() end)
	local id = current_obj_id;
	for k, v in pairs(hooks) do
		local func = obj[v]
		if func and type(func) == "function" then
			hook.Add(v, "CAF OBJ "..tostring(v).." - "..tostring(id), function(...) func(obj, unpack({...})) end)
		end
	end
end

function CAF2.class.addMeta()
	function CLASS:__index(key) --returns datamembers
		--Msg("Calling __index "..tostring(key).."\n")
		local t = getmetatable(self)
		local var = rawget(t, key)
		local parent = rawget(t, "parent")
		if var then -- If key found in this class, return it's value
			return var
		elseif parent then -- If a parent is present, try the parent
			local var = parent:__index(key)
			-- We have to check if the returned var is a function or just a value, if it's function we have to modify it to keep the parent as the 'self' variable in the function, otherwise it will get replaced by the 'child' as it's self variable, which could mean double function calls
			if type(var) == "function" then
				return function(obj, ...)
					local arg = { ... }
					return var(parent, unpack(arg))
				end
			end
			return var
		end
		return nil;
	end

	function CLASS:__newindex(key, value) --sets datamembers
		--Msg("Calling __newindex "..tostring(key).." - "..tostring(value).."\n")
		local ok = false;
		local t = getmetatable(self)
		if rawget(t, key) then --If this class contains the key, set the value on this class
			rawset(t, key,  value);
			return true;
		elseif rawget(t, "parent") then -- If a parent is present, try the parent
			ok = rawget(t, "parent"):__newindex(key, value)
		end
		if not ok then
			rawset(t, key,  value); --Better to avoid, will add the var to every parent to!!
		end
		return ok;
	end

	function CLASS.__concat(str1, str2)
		--Msg("calling __concat\n")
		if str1 == self then
			return str1:ToString()..str2
		else
			return str1..str2:ToString()
		end
	end

	function CLASS:__tostring()
		--Msg("Calling __tostring\n")
		return self:ToString()
	end
end

function CAF2.class.new(name, ...)
	local arg = { ... }
	if not ClassFileExists(name) then error("Can't create non-existing class <"..tostring(name)..">") end
	local olclass = CLASS --Store oldclass (incase a new object is created while creating an object)
	local oldprotectedclass = PROTECTED_CLASS  --Store oldclassprotected (incase a new object is created while creating an object)
	--Set Obj ID for hooks
	local objid = current_obj_id
	current_obj_id = next_obj_id
	next_obj_id = next_obj_id + 1
	--end obj id stuff
	CLASS = {} --Start fresh
	PROTECTED_CLASS = {} --Start fresh
	CLASS.type = name;
	LoadClassFile(name) --Start loading the class file
	local obj = {}
	setmetatable( obj, CLASS )
	obj:__construct(unpack(arg)) --Call the constructor
	CheckForHooks(obj)
	CLASS = olclass --Restore the previous 'object' or nil
	PROTECTED_CLASS = oldprotectedclass --Restore the previous 'object' protected members or nil
	current_obj_id = objid; -- Set old obj id back (in case new objects get created while objects get created
	return obj -- return the object
end

function CAF2.class.extend(name)
	if not CLASS then return error("Can't extend a nil class") end
	if not ClassFileExists(name) then error("Can't extend from non-existing class <"..tostring(name)..">") end
	LoadClassFile(name) -- Start loading the parent class file
	local tmp = {}
	setmetatable( tmp, CLASS )
	CLASS = CopyMetaProccedures();
	CLASS.parent = tmp; --Add the parent object in the parent var for the object
end

local cl = CAF2.class.new("base2", 1, 2, 3, 4)

Msg(cl:ToString().."\n")
Msg("test "..cl)



