--Variable Declarations
local CAF2 = {}
CAF = CAF2;
local CAF3 = {}
CAF2.CAF3 = CAF3;

CAF2.StartingUp = false;

local DEBUG = true
CAF3.DEBUG = DEBUG;
local Addons = {}
CAF3.Addons = Addons

local addonlevel = {}
CAF3.addonlevel = addonlevel
addonlevel[1] = {}
addonlevel[2] = {}
addonlevel[3] = {}
addonlevel[4] = {}
addonlevel[5] = {}

local hooks = {}
CAF3.hooks = hooks;
hooks["think"] = {}
hooks["think2"] = {}
hooks["think3"] = {}
hooks["OnEntitySpawn"] = {}
hooks["OnAddonDestruct"] = {}
hooks["OnAddonConstruct"] = {}
hooks["OnAddonExtraOptionChange"] = {}
hooks["TOOL_Allow_Entity_Spawn"] = {}

function CAF2.AllowSpawn(type, sub_type, class, model)
	for k , v in pairs(hooks["TOOL_Allow_Entity_Spawn"]) do
		local ok, err = pcall(type, sub_type, class, model)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "TOOL_Allow_Entity_Spawn Error: " .. err .."\n")
		else
			if err == true then
				return true;
			elseif err == false then
				return false;
			end
		end
	end
	return true
end


local function ErrorOffStuff(String)
	Msg("----------------------------------------------------------------------\n")
	Msg("-----------Custom Addon Management Framework Error----------\n")
	Msg("----------------------------------------------------------------------\n")
	Msg(tostring(String).."\n")
end

AddCSLuaFile("autorun/client/cl_caf_autostart.lua")
CAF2.CAF3 = CAF3;
include("CAF/Core/shared/sh_general_caf.lua")
CAF2.CAF3 = nil;

if (not sql.TableExists("CAF_AddonStatus")) then

	sql.Query("CREATE TABLE IF NOT EXISTS CAF_AddonStatus ( id VARCHAR(50) PRIMARY KEY , status TINYINT(1));")

end

--function Declarations

--Local functions

local function UpdateAddonStatus(addon, status)
	if not addon or not status then return false, "Missing parameter(s)" end
	local id = sql.SQLStr(addon)
	local stat = sql.SQLStr(status)
	sql.Query("UPDATE CAF_AddonStatus SET status="..stat.." WHERE id='"..id.."';")
end

local function SaveAddonStatus(addon, status)
	if not addon or not status then return false, "Missing parameter(s)" end
	local id = sql.SQLStr(addon)
	local stat = sql.SQLStr(status)
	local data = sql.Query("INSERT INTO CAF_AddonStatus(id, status) VALUES('"..id.."', "..stat..");")
	if data then 
		Msg("Error making a profile for "..ply:Nick().."\n"..data.."\n") 
	end
end

local function LoadAddonStatus( addon, defaultstatus )
	if not addon then return false, "No Addon Given" end
	local id = sql.SQLStr(addon)
	local data = sql.Query("SELECT * FROM CAF_AddonStatus WHERE id = '"..id.."';")
	if defaultstatus == nil then
		defaultstatus = 1;
	else
		if defaultstatus then
			defaultstatus = 1
		else
			defaultstatus = 0
		end
	end
	if (not data) then
		SaveAddonStatus(addon, defaultstatus)
	else
		return util.tobool(data[1]["status"])
	end
	return util.tobool(defaultstatus);
end

local function OnEntitySpawn(ent , enttype , ply)
	if ent == NULL then
		return
	end	
	ent.caf = ent.caf or {}
	ent.caf.custom = ent.caf.custom or {}
	if ent.caf.custom.canreceivedamage == nil then
		ent.caf.custom.canreceivedamage = true
	end
	if ent.caf.custom.canreceiveheatdamage == nil then
		ent.caf.custom.canreceiveheatdamage = true
	end
	for k , v in pairs(hooks["OnEntitySpawn"]) do
		local ok, err = pcall(v, ent , enttype , ply)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "OnEntitySpawn Error: " .. err .."\n")
		end
	end
end

local function  OnAddonDestruct(name)
	if not name then return end
	umsg.Start("CAF_Addon_Destruct")
		umsg.String(name)
	umsg.End()
	if not CAF2.StartingUp then
		for k , v in pairs(hooks["OnAddonDestruct"]) do
			local ok, err = pcall(v, name)
			if not (ok) then
				CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonDestruct Error: " .. err .. "\n")
			end
		end
	end
end

local function OnAddonConstruct(name)
	if not name then return end
	--for k, ply in pairs(player.GetAll( )) do
		umsg.Start("CAF_Addon_Construct")--, ply
			umsg.String(name)
		umsg.End()
	--end
	if not CAF2.StartingUp then
		for k , v in pairs(hooks["OnAddonConstruct"]) do
			local ok, err = pcall(v, name)
			if not (ok) then
				CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonConstruct Error: " .. err .. "\n")
			end
		end
	end
end

local function OnAddonExtraOptionChange(AddonName, OptionName, NewStatus)
	if not AddonName or not OptionName then return nil, "Missing Argument" end
	for k , v in pairs(hooks["OnAddonExtraOptionChange"]) do
		local ok, err = pcall(v, AddonName, OptionName, NewStatus)
		if not (ok) then
			CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonExtraOptionChange Error: " .. err .. "\n")
		end
	end
end

--Gmod Spawn Hooks

local function SpawnedSent( ply , ent )
	--Msg("Sent Spawned\n")
	OnEntitySpawn(ent , "SENT" , ply)
end

local function SpawnedVehicle( ply , ent)
	--Msg("Vehicle Spawned\n")
	OnEntitySpawn(ent , "VEHICLE" , ply)
end	

local function SpawnedEnt( ply , model , ent )
	--Msg("Prop Spawned\n")
	OnEntitySpawn(ent , "PROP" , ply)
end

local function PlayerSpawn(ply)
	--Msg("Prop Spawned\n")
	OnEntitySpawn(ply , "PLAYER" , ply)
end

local function NPCSpawn(ply, ent)
	--Msg("Prop Spawned\n")
	OnEntitySpawn(ent , "NPC" , ply)
end
hook.Add( "PlayerSpawnedNPC", "CAF NPC Spawn", NPCSpawn )
hook.Add( "PlayerInitialSpawn", "CAF PLAYER Spawn", PlayerSpawn )
hook.Add( "PlayerSpawnedProp", "CAF PROP Spawn", SpawnedEnt )
hook.Add( "PlayerSpawnedSENT", "CAF SENT Spawn", SpawnedSent )
hook.Add( "PlayerSpawnedVehicle", "CAF VEHICLE Spawn", SpawnedVehicle )

--Global function
--[[

]]

--[[
	WriteToDebugFile
	This function will write the selected message to 
		1) the console
		2) the specified file into the CAF_DEBUG/Server/ folder
			If the file doesn't exist it will be created
]]
function CAF2.WriteToDebugFile(filename, message)
	if not filename or not message then return nil , "Missing Argument" end
	if DEBUG then
		ErrorNoHalt("Filename: "..tostring(filename)..", Message: "..tostring(message).."\n")
	end
	local contents = file.Read("CAF_Debug/server/"..filename..".txt") 
	contents = contents or "" 
	contents = contents .. message
	file.Write("CAF_Debug/server/"..filename..".txt", contents)
end

--[[
	ClearDebugFile
		This function will clear the given file in the debug folder
		It will return the content that was in the file before it got cleared
]]
function CAF2.ClearDebugFile(filename)
	if not filename then return nil , "Missing Argument" end
	local contents = file.Read("CAF_Debug/server/"..filename..".txt") 
	contents = contents or "" 
	file.Write("CAF_Debug/server/"..filename..".txt", "")
	return content
end

--[[
	GetSavedAddonStatus
		This function will return the the status that was stored in the SQL file last time to make it easier so admins won't need to disable Addons again every time.
]]
function CAF2.GetSavedAddonStatus( addon, defaultstatus )
	return LoadAddonStatus( addon , defaultstatus)
end


--[[
	Start
		This function loads all the Custom Addons on Startup
]]
function CAF2.Start()
	Msg("Starting CAF Addons\n");
	CAF2.StartingUp = true
	umsg.Start("CAF_Start_true")
	umsg.End()
	CAF2.AddServerTag("CAF")
	for level, tab in pairs(addonlevel) do
		print("Loading Level "..tostring(level).." Addons\n")
		for k, v in pairs(tab) do
			if Addons[v] then
				print("-->", "Loading addon "..tostring(v).."\n")
				if Addons[v].AddResourcesToSend then
					local ok, err = pcall(Addons[v].AddResourcesToSend)
					if not ok then
						CAF2.WriteToDebugFile("CAF_ResourceSend", "AddResourcesToSend Error: " .. err .. "\n")
					end
				end
				if Addons[v].GetStatus  and not Addons[v].GetStatus() then
					local ok = true
					if Addons[v].GetRequiredAddons and Addons[v].GetRequiredAddons() then
						for l, w in pairs(Addons[v].GetRequiredAddons()) do
							if not Addons[w] then
								ok = false
							end
						end
					end
					if ok then
						local state = CAF2.GetSavedAddonStatus(v, Addons[v].DEFAULTSTATUS)
						if Addons[v].__AutoStart then
							local ok2 , err = pcall(Addons[v].__AutoStart, state)
							if not ok2 then
								CAF2.WriteToDebugFile("CAF_AutoStart", "Couldn't call AutoStart for "..v .. ": " .. err .. "\n")
							else
								OnAddonConstruct(v)
								print("-->", "Auto Started Addon: " .. v.."\n")
							end
						elseif state then 
							local ok2 , err = pcall(Addons[v].__Construct)
							if not ok2 then
								CAF2.WriteToDebugFile("CAF_Construct", "Couldn't call constructor for "..v .. ": " .. err .. "\n")
							else
								OnAddonConstruct(v)
								print("-->", "Loaded addon: " .. v.."\n")
							end
						end
					end
				end
			end
		end
	end
	CAF2.StartingUp = false
	umsg.Start("CAF_Start_false")
	umsg.End()
end
hook.Add( "InitPostEntity", "CAF_Start", CAF2.Start)

--[[
	This function will call the destruct function of an addon  and return if it's was succesfull or not (+ the errormessage)
]]
function CAF2.Destruct(addon)
	if not addon then return false, "No Addon Name Given" end
	if not Addons[addon] then return false, "No Addon Registered With This Name" end
	local ok, mes = Addons[addon].__Destruct()
	if ok then
		OnAddonDestruct(addon)
		UpdateAddonStatus(addon, 0)
	end
	return ok, mes
end

--[[
	This function will call the construct function of an addon  and return if it's was succesfull or not (+ the errormessage)
]]
function CAF2.Construct(addon)
	if not addon then return end
	if not Addons[addon] then return end
	local ok, mes = Addons[addon].__Construct()
	if ok then
		OnAddonConstruct(addon)
		UpdateAddonStatus(addon, 1)
	end
	return ok, mes
end

--[[
	This function will receive the construct info from the clientside VGUI menu
]]
local function AddonConstruct(ply, com, args)
	if not ply:IsAdmin() then ply:ChatPrint("You are not allowed to Construct a Custom Addon") return end
	if not args then ply:ChatPrint("You forgot to provide arguments") return end
	if not args[1] then ply:ChatPrint("You forgot to enter the Addon Name") return end
	if table.Count(args) > 1 then --Construct the Addon name if it had spaces in it
		for k , v in pairs(args) do
			if k ~= 1 then
				args[1] = args[1] .. " " .. v
			end
		end
	end
	local ok, mes = CAF2.Construct(args[1])
	if ok then
		ply:ChatPrint("Addon Succesfully Enabled")
	else
		ply:ChatPrint("Couldn't Enable the Addon for the following reason: "..tostring(mes))
	end
end
concommand.Add( "CAF_Addon_Construct", AddonConstruct ) 

--[[
	This function will receive the destruct info from the clientside VGUI menu
]]
local function AddonDestruct(ply, com, args)
	if not ply:IsAdmin() then ply:ChatPrint("You are not allowed to Destruct a Custom Addon") return end
	if not args then ply:ChatPrint("You forgot to provide arguments") return end
	if not args[1] then ply:ChatPrint("You forgot to enter the Addon Name") return end
	if table.Count(args) > 1 then --Construct the Addon name if it had spaces in it
		for k , v in pairs(args) do
			if k ~= 1 then
				args[1] = args[1] .. " " .. v
			end
		end
	end
	local ok, mes = CAF2.Destruct(args[1])
	if ok then
		ply:ChatPrint("Addon Succesfully Disabled")
	else
		ply:ChatPrint("Couldn't Disable the Addon for the following reason: "..tostring(mes))
	end
end
concommand.Add( "CAF_Addon_Destruct", AddonDestruct ) 

local kickgarry = false;
--[[
	This function will update the Client with all active addons
]]
function CAF2.PlayerSpawn(ply)
	if kickgarry then
		pcall(function()
			if ply:SteamID() == "STEAM_0:1:7099" then
				ply:Kick("We don't want you here!");
			end
		end);
	end
	ply:ChatPrint("This server is using the Custom Addon Framework\n")
	ply:ChatPrint("Report any bugs during the beta on http://www.snakesvx.net\n")
	
	ply:ChatPrint("\n\nIf you have any suggestions for future versions of CAF, SB, LS, RD, ... please report them on http://www.snakesvx.net\n\n")
	for k, v in pairs(Addons) do
		if v.GetStatus and v.GetStatus() then
			umsg.Start("CAF_Addon_Construct", ply)
				umsg.String(k)
			umsg.End()
		end
	end
	
	ply:ChatPrint("\n\nNOTE: If you encounter any issues with RD3.1 (alpha) report them on http://www.snakesvx.net!!!!!\n\n")
end
hook.Add( "PlayerInitialSpawn", "CAF_In_Spawn", CAF2.PlayerSpawn )


local oldcreate = ents.Create

ents.Create = function(class)
	local ent = oldcreate(class)
	timer.Simple( 0.1, OnEntitySpawn, ent, "SENT" )
	return ent;
end

--msg, location, color, displaytime
function CAF2.POPUP(ply, msg, location, color, displaytime)
	if msg then
		location = location or "top"
		color = color or CAF2.colors.white
		displaytime = displaytime or 1
		umsg.Start("CAF_Addon_POPUP", ply)
			umsg.String(msg)
			umsg.String(location)
			umsg.Short(color.r)
			umsg.Short(color.g)
			umsg.Short(color.b)
			umsg.Short(color.a)
			umsg.Short(displaytime)
		umsg.End()
	end
end

local servertags = nil;
function CAF2.AddServerTag(tag)
	if not servertags or not CAF2.StartingUp then
		servertags = GetConVarString("sv_tags")
	end
	if servertags == nil then
		RunConsoleCommand("sv_tags", tag)
	elseif not string.find(servertags, tag) then
		servertags = servertags .. ","..tag
		RunConsoleCommand("sv_tags", servertags)
	end
end

function CAF2.RemoveServerTag(tag)
	if not servertags or not CAF2.StartingUp then
		servertags = GetConVarString("sv_tags")
	end
	if servertags then
		servertags = string.Replace(servertags, ","..tag, "" )
		RunConsoleCommand("sv_tags", servertags)
	end
end

CAF = CAF2

--[[
	The following code sends the clientside and shared files to the client and includes CAF core code
]]
--Send Client and Shared files to the client and Include the ServerAddons

--Core files

local Files = file.FindInLua( "CAF/Core/server/*.lua" )
for k, File in ipairs(Files) do
	Msg("Loading: "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/Core/server/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Loaded: Successfully\n")
	end
end

Files = file.FindInLua("CAF/Core/client/*.lua")
for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(AddCSLuaFile, "CAF/Core/client/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

Files = file.FindInLua("CAF/Core/shared/*.lua")
for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(AddCSLuaFile, "CAF/Core/shared/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

Files = file.FindInLua("CAF/LanguageVars/*.lua")
for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(AddCSLuaFile, "CAF/LanguageVars/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/LanguageVars/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

--Main Addon
local Files = file.FindInLua( "CAF/Addons/server/*.lua" )
for k, File in ipairs(Files) do
	Msg("Loading: "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/Addons/server/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Loaded: Successfully\n")
	end
end

Files = file.FindInLua("CAF/Addons/client/*.lua")
for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(AddCSLuaFile, "CAF/Addons/client/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

Files = file.FindInLua("CAF/Addons/shared/*.lua")
for k, File in ipairs(Files) do
	Msg("Sending: "..File.."...")
	local ErrorCheck, PCallError = pcall(AddCSLuaFile, "CAF/Addons/shared/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end
