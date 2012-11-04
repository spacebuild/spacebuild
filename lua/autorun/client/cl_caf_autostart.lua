local gmod_version_required = 145;
if ( VERSION < gmod_version_required ) then
	error("SB CORE: Your gmod is out of date: found version ", VERSION, "required ", gmod_version_required)
end

local net = net

--Variable Declarations
local CAF2 = {}
CAF = CAF2;
local CAF3 = {}
CAF2.StartingUp = false;
CAF2.HasInternet = false;
CAF2.InternetEnabled = true --Change this to false if you crash when CAF2 loads clientside


surface.CreateFont( "GModCAFNotify", {font = "verdana", size = 15, weight = 600} ) 


--nederlands, english

local DEBUG = true
CAF3.DEBUG = DEBUG;
local Addons = {}
CAF3.Addons = Addons

--Derma stuff
local MainInfoMenuData = nil;
--local MainStatusMenuData = nil;
--local TopFrame = nil;
--local TopFrameHasText = false;
--local TopLabel = nil
--End Derma stuff

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
hooks["OnAddonDestruct"] = {}
hooks["OnAddonConstruct"] = {}
hooks["OnAddonExtraOptionChange"] = {}

local function ErrorOffStuff(String)
	Msg( "----------------------------------------------------------------------\n" )
	Msg("-----------Custom Addon Management Framework Error----------\n")
	Msg("----------------------------------------------------------------------\n")
	Msg(tostring(String).."\n")
end

CAF2.CAF3 = CAF3;
include("CAF/Core/shared/sh_general_caf.lua")
CAF2.CAF3 = nil;

local function OnAddonDestruct(name)
	if not name then return end
	if(CAF2.GetAddonStatus(name)) then
		local ok, err = pcall(Addons[name].__Destruct);
		if not ok then
			CAF2.WriteToDebugFile("CAF_Destruct", "Couldn't call destructor for "..name .. " error: " .. err .."\n")
			AddPopup(CAF.GetLangVar("Error unloading Addon")..": " .. CAF.GetLangVar(name), "top", CAF2.colors.red);
		else
			if err then
				AddPopup(CAF.GetLangVar("Addon")..": " .. CAF.GetLangVar(name) .. " "..CAF.GetLangVar("got disabled"),"top", CAF2.colors.green);
			else
				AddPopup(CAF.GetLangVar("An error occured when trying to disable Addon")..": " .. CAF.GetLangVar(name),"top", CAF2.colors.red);
			end
		end
	end
	if not CAF2.StartingUp then
		for k , v in pairs(hooks["OnAddonDestruct"]) do
			local ok, err = pcall(v, name)
			if not ok then
				CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonDestruct Error " .. err .. "\n")
			end
		end
		CAF2.RefreshMainMenu();
	end
end

local function OnAddonConstruct(name)
	if not name then return end
	if(not CAF2.GetAddonStatus(name)) then
		if Addons[name] then
			local test, err = pcall(Addons[name].__Construct);
			if not test then
				CAF2.WriteToDebugFile("CAF_Construct", "Couldn't call constructor for "..name .. " error: " .. err .."\n")
				AddPopup(CAF.GetLangVar("Error loading Addon")..": " .. CAF.GetLangVar(name), "top", CAF2.colors.red);
			else
				if err then
					AddPopup(CAF.GetLangVar("Addon")..": " .. CAF.GetLangVar(name) .. " "..CAF.GetLangVar("got enabled"),"top", CAF2.colors.green);
				else
					AddPopup(CAF.GetLangVar("An error occured when trying to enable Addon")..": " .. CAF.GetLangVar(name),"top", CAF2.colors.red);
				end
			end
		end
	end
	if not CAF2.StartingUp then
		for k , v in pairs(hooks["OnAddonConstruct"]) do
			local ok, err = pcall(v, name)
			if not ok then
				CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonConstruct Error " .. err .. "\n")
			end
		end
		CAF2.RefreshMainMenu();
	end
end

local function OnAddonExtraOptionChange(AddonName, OptionName, NewStatus)
	if not AddonName or not OptionName then return nil, CAF.GetLangVar("Missing Argument") end
	for k , v in pairs(hooks["OnAddonExtraOptionChange"]) do
		local ok, err = pcall(v, AddonName, OptionName, NewStatus)
		if not ok then
			CAF2.WriteToDebugFile("CAF_Hooks", "OnAddonExtraOptionChange Error " .. err .. "\n")
		end
	end
end

--Global function

function CAF2.WriteToDebugFile(filename, message)
	if not filename or not message then return nil , CAF.GetLangVar("Missing Argument") end
	if DEBUG then
		ErrorNoHalt("Filename: "..tostring(filename)..", Message: "..tostring(message).."\n")
	end
	local contents = file.Read("CAF_Debug/client/"..filename..".txt")
	contents = contents or "" 
	contents = contents .. message
	file.Write("CAF_Debug/client/"..filename..".txt", contents)
end

function CAF2.ClearDebugFile(filename)
	if not filename then return nil , CAF.GetLangVar("Missing Argument") end
	local contents = file.Read("CAF_Debug/client/"..filename..".txt")
	contents = contents or "" 
	file.Write("CAF_Debug/client/"..filename..".txt", "")
	return content
end

--Server-Client Synchronisation
function CAF2.ConstructAddon(len, client)
    local name = net.ReadString()
    OnAddonConstruct(name)
    --RunConsoleCommand("Main_CAF_Menu");
end
net.Receive("CAF_Addon_Construct", CAF2.ConstructAddon)

function CAF2.DestructAddon(len, client)
	local name = net.ReadString()
	OnAddonDestruct(name)
	--RunConsoleCommand("Main_CAF_Menu");
end
net.Receive("CAF_Addon_Destruct", CAF2.DestructAddon)

function CAF2.Start(len, client)
	CAF2.StartingUp = true;
end
net.Receive("CAF_Start_true", CAF2.Start)

function CAF2.endStart(len, client)
	CAF2.StartingUp = false;
end
net.Receive("CAF_Start_false", CAF2.endStart)


--Menu's
CAF2.HTTP = {
	BUGS = "http://www.snakesvx.net",
	INTERNET = "http://www.snakesvx.net",
	VERSION = "http://www.snakesvx.net/versions/caf.txt"
};

CAF2.LATEST_VERSION = version;
if(not CAF2.HasInternet and CAF2.InternetEnabled) then
	http.Fetch(CAF2.HTTP.INTERNET,
		function(html,size)
			if(html) then
				MsgN(CAF.GetLangVar("CAF: Client has Internet. Enabled Online-Help"));
				CAF2.HasInternet = true;
			end
		end,
		function()
			CAF2.HasInternet = false;
		end
	);
end

local isuptodatecheck;
--Performs the CAF update check
local function IsUpToDate(callBackfn)
	if not CAF2.HasInternet then
		return
	end
	if isuptodatecheck ~= nil then
		callBackfn(isuptodatecheck);
		return
	end
	-- Do we have the latest version of CAF installed?
	http.Get(CAF2.HTTP.VERSION,"",
		function(html,size)
			local version = tonumber(html);
			if(version) then
				CAF2.LATEST_VERSION = version;
				if(CAF2.LATEST_VERSION > CAF2.version) then
					isuptodatecheck = false;
					callBackfn(false)
				else
					isuptodatecheck = true;
					callBackfn(true)
				end
			end
		end
	);
end

local displaypopups = {}
local popups = {}

--PopupSettings
local Font	= "GModCAFNotify"
--End popupsettings

local function DrawPopups()
	if GetConVarString('cl_hudversion') == "" then
		if displaypopups["top"] then
			local obj = displaypopups["top"]
			surface.SetFont( Font )
			local width, height = surface.GetTextSize(obj.message)
			if width == nil or height == nil then return end
			width = width + 16
			height = height + 16
			local left = (ScrW()/2)- (width/2);
			local top = 0;
			draw.RoundedBox( 4, left-1 , top, width+2, height+2, obj.color)
			draw.RoundedBox( 4, left , top+1, width, height, Color(0, 0, 0, 150))
			draw.DrawText(obj.message,	Font, left + 8, top + 9, obj.color, 0 )
		end
		if displaypopups["left"] then
			local obj = displaypopups["left"]
			surface.SetFont( Font )
			local width, height = surface.GetTextSize(obj.message)
			if width == nil or height == nil then return end
			width = width + 16
			height = height + 16
			local left = 0
			local top = ScrH() * 2/3;
			draw.RoundedBox( 4, left , top-1, width+2, height+2, obj.color)
			draw.RoundedBox( 4, left+1 , top, width, height, Color(0, 0, 0, 150))
			draw.DrawText(obj.message,	Font, left + 9, top + 8, obj.color, 0 )
		end
		if displaypopups["right"] then
			local obj = displaypopups["right"]
			surface.SetFont( Font )
			local width, height = surface.GetTextSize(obj.message)
			if width == nil or height == nil then return end
			width = width + 16
			height = height + 16
			local left = ScrW()- width;
			local top = ScrH() * 2/3;
			draw.RoundedBox( 4, left-1 , top-1, width + 2, height + 2, obj.color)
			draw.RoundedBox( 4, left , top, width, height, Color(0, 0, 0, 150))
			draw.DrawText(obj.message,	Font, left + 8, top + 8, obj.color, 0 )
		end
		if displaypopups["bottom"] then
			local obj = displaypopups["bottom"]
			surface.SetFont( Font )
			local width, height = surface.GetTextSize(obj.message)
			if width == nil or height == nil then return end
			width = width + 16
			height = height + 16
			local left = (ScrW()/2)- (width/2);
			local top = ScrH() - height
			draw.RoundedBox( 4, left-1 , top-2, width+2, height+2, obj.color)
			draw.RoundedBox( 4, left , top - 1, width, height, Color(0, 0, 0, 150))
			draw.DrawText(obj.message,	Font, left + 8, top + 7, obj.color, 0 )
		end
	end
end
hook.Add("HUDPaint", "CAF_Core_POPUPS", DrawPopups)

local function MessageOfTheDay()
	return "Welcome to CAF\nYou are using version "..CAF2.version;
end

--local function ShowNextTopMessage()
local function ShowNextPopupMessage()
	local ply = LocalPlayer();
	local locations = {"top", "left", "right", "bottom"};	
	for k, v in pairs(locations) do
		if displaypopups[v] == nil and popups[v] and table.Count(popups[v]) > 0 then
			local obj = popups[v][1];
			table.remove(popups[v], 1);
			if ply and ply.ChatPrint then
				ply:ChatPrint(obj.message.."\n")
			else
				Msg(obj.message.."\n")
			end
			displaypopups[v] = obj;
			timer.Simple(obj.time, function() ClearPopup(obj) end);
		end
	end
end

--function ClearTopTextMessage(obj)
function ClearPopup(obj)
	if obj then
		displaypopups[obj.location] = nil;
	end
	if table.Count(popups[obj.location]) > 0 then
		ShowNextPopupMessage();
	end
end

local MessageLog = {}

--function AddTopInfoMessage(message)
function AddPopup(message, location, color, displaytime)
	local obj = {}
	local allowedlocations = {"top", "left", "right", "bottom"};
	location = location or "top";
	if not table.HasValue(allowedlocations, location) then
		location = "top"
	end
	obj.message = message or "Corrupt Message";
	obj.location = location or "top"
	obj.time = displaytime or 1;
	obj.color = color or CAF2.colors.white;
	if not popups[location] then
		popups[location] = {}
	end
	table.insert(popups[location], obj);
	table.insert(MessageLog, obj);
	ShowNextPopupMessage();
end

local function GetHelpPanel(frame)
	local panel = vgui.Create("DPanel", frame)
	panel:StretchToParent( 6, 80, 6, 6 )
	
	local LeftTree = vgui.Create( "DTree", panel )
	LeftTree:SetSize( 200, panel:GetTall() - 2)
	LeftTree:SetPos(15, 1);

	local RightPanel = vgui.Create("DPanel", panel )
	RightPanel:SetSize(panel:GetWide() - 230, panel:GetTall() - 2);
	RightPanel:SetPos(220, 1);
	
	if not MainInfoMenuData then
		MainInfoMenuData = {}
		if table.Count(Addons) > 0 then
			for k, v in pairs(Addons) do
				local ok, err = pcall(v.GetMenu)
				if ok then
					if err then
						MainInfoMenuData[k] = err
					end
				end
			end
		end
	end
	LeftTree:Clear()
	--Fill the Tree
	if table.Count(MainInfoMenuData) > 0 then
		for k, v in pairs(MainInfoMenuData) do
			--Addon Info
			local title = k;
			local node = LeftTree:AddNode(title)
			--node.Icon:SetImage(devlist.icon)
			for l, w in pairs(v) do
				--Sub Menu's
				local Node = node:AddNode(l)
				function Node.DoClick(btn)
					if(w.hasmenu) then
						--To Implement
					elseif (CAF2.HasInternet and w.interneturl) then
						local HTMLTest = vgui.Create("HTML", RightPanel)   
						HTMLTest:StretchToParent( 10, 10, 10, 10 ) 
						HTMLTest:OpenURL(w.interneturl)  
					elseif(w.localurl) then
						local HTMLTest = vgui.Create("HTML", RightPanel)  
						HTMLTest:StretchToParent( 10, 10, 10, 10 ) 
						HTMLTest:SetHTML(file.Read(w.localurl)) 
					end
				end
				function Node.DoRightClick(btn)
					-- To Implement
				end
				for m, x in pairs(w) do
					--Links in submenu
					local cnode = Node:AddNode(m)
					function cnode.DoClick(btn)
						if(x.hasmenu) then
							--To Implement
						elseif (CAF2.HasInternet and x.interneturl) then
							RightPanel:Clear();
							local HTMLTest = vgui.Create("HTML", RightPanel)  
							HTMLTest:StretchToParent( 10, 10, 10, 10 ) 
							HTMLTest:OpenURL(x.interneturl)  
						elseif(x.localurl) then
							RightPanel:Clear();
							local HTMLTest = vgui.Create("HTML", RightPanel)  
							HTMLTest:StretchToParent( 10, 10, 10, 10 ) 
							HTMLTest:SetHTML(file.Read(x.localurl)) 
						end
					end
					function cnode.DoRightClick(btn)
						-- To Implement
					end
				end
			end
		end
	end
	return panel
end

function CAF2.Notice(message, title)
	if not message then return false end;
	if not title then title = "Notice" end
	local dfpopup = vgui.Create("DFrame")
	dfpopup:SetDeleteOnClose() 
	dfpopup:SetDraggable( false ) 
	dfpopup:SetTitle(title)
	
	local lbl = vgui.Create("DLabel", dfpopup)
	lbl:SetPos(10, 25);
	lbl:SetText(message);
	lbl:SizeToContents();
	
	dfpopup:SetSize(lbl:GetWide() + 4, lbl:GetTall() + 25);
	dfpopup:Center();
	dfpopup:MakePopup();
	return true;
end

local function GetClientMenu(contentpanel)
	--Create clientside menu here => Language settings, ...
	local panel = vgui.Create("DPanel", contentpanel)
	local x = 10;
	local y = 0;
	
	--Title
	local lblTitle = vgui.Create("DLabel", panel)
	lblTitle:SetText(CAF2.GetLangVar("Clientside CAF Options"));
	lblTitle:SizeToContents()
	lblTitle:SetPos(x, y);
	
	y = y + 20;
	-- Language Selection
	local lbl = vgui.Create("DLabel", panel)
	lbl:SetText(CAF2.GetLangVar("Language")..":");
	lbl:SizeToContents()
	lbl:SetPos(x, y);
	
	x = x + lbl:GetWide() + 2;
	
	--[[local selection = vgui.Create("DMultiChoice", panel)
	selection:SetPos(x, y);
	for k, v in pairs(CAF.LANGUAGE) do
		selection:AddChoice( k ) 
	end
	function selection:OnSelect( index, value, data ) 
		CAF2.currentlanguage = value;
		CAF2.SaveVar("CAF_LANGUAGE", value)
		CAF2.Notice(CAF2.GetLangVar("Some Language Changes will only Show after a map reload!"));
	end
	selection:SetWide( 150 )
	
	
	y = y + 15
	x = x - lbl:GetWide() - 5
	--Other options here]]
	
	panel:SetSize(contentpanel:GetWide(), y + 10);
	return panel;
end

local function AddCAFInfoToStatus(List)
	
	
	local descriptiontxt = nil
	if GetDescription then
		descriptiontxt = GetDescription()
	end
	
	local v = {}
	function v.GetVersion()
		return CAF2.version, "Core";
	end
	
	function v.GetStatus()
		return true;
	end
	
	function v.CanChangeStatus()
		return false
	end
	
	function v.GetDisplayImage()
		return "gui/silkicons/application"; --Change to something else later on?
	end
	
	local cat = vgui.Create("DCAFCollapsibleCategory") 
	cat:Setup("Custom Addon Framework", v);
	--cat:SetExtraButtonAction(function() frame:Close()  end)
	
	local contentpanel = vgui.Create("DPanelList", cat)
	contentpanel:SetWide(List:GetWide())
	local clientMenu = nil;
	if GetClientMenu then
		clientMenu = GetClientMenu(contentpanel);
	end
	local serverMenu = nil;
	if GetServerMenu then
		serverMenu = GetServerMenu(contentpanel);
	end
	
	--Start Add Custom Stuff
	local x = 0;
	local y = 0;
	local ply = LocalPlayer();
	--Version Check
	local versionupdatetext = vgui.Create("DLabel", contentpanel)
	versionupdatetext:SetPos(x + 10, y)
	versionupdatetext:SetText(CAF.GetLangVar("No Update Information Available"))
	versionupdatetext:SetTextColor( Color(200,200,0,200) )
	IsUpToDate(function(uptodate)
		if uptodate then
			versionupdatetext:SetText(CAF.GetLangVar("This Addon is up to date"))
			versionupdatetext:SetTextColor( Color(0,230,0,200) )
			
		else
			versionupdatetext:SetText(CAF.GetLangVar("This Addon is out of date"))
			versionupdatetext:SetTextColor( Color(230,0,0,200) )
		end
		versionupdatetext:SizeToContents()
	end);
	versionupdatetext:SizeToContents()
	
	y = y + 30;
	
	--ServerMenu
	if serverMenu then
		serverMenu:SetPos(x, y)
		y = y + serverMenu:GetTall() + 15;
	end
	--Clientside menu
	if clientMenu then
		clientMenu:SetPos(x, y)
		y = y + clientMenu:GetTall() + 15;
	end
	
	--Description
	if descriptiontxt ~= nil then
		local list = vgui.Create("DPanelList",contentpanel)
		list:SetPos(x, y);
		local size = 1;
		list:SetPadding(10)
		--Description Blank Line
		lab = vgui.Create("DLabel", list)
		lab:SetText(CAF.GetLangVar("Description")..":")
		lab:SizeToContents()
		list:AddItem(lab)
		size = size + 1;
		--Description
		for k, v in pairs(descriptiontxt) do
			lab = vgui.Create("DLabel", list)
			lab:SetText(v)
			lab:SizeToContents()
			list:AddItem(lab)
			size = size + 1;
		end
		list:SetSize(List:GetWide()-10, 15 * size)
		contentpanel:SizeToContents()
		y = y + (15 * size) + 15
	end
	contentpanel:SetTall(y);
	--End Add Custom Stuff
	cat:SetContents(contentpanel)
	cat:SizeToContents()
	cat:InvalidateLayout()
	cat:SetExpanded(true)
	List:AddItem(cat)
end

local function GetStatusPanel(frame)
	local panel = vgui.Create("DPanel", frame)
	panel:StretchToParent( 6, 36, 6, 6 )
	local List = vgui.Create("DPanelList", panel)
	List:EnableHorizontal(false)
	List:EnableVerticalScrollbar(true)
	List:SetPadding(5)
	List:SetSpacing(5)
	List:StretchToParent( 2, 2, 2, 2 )
	List:SetPos(2, 2)
	
	local iteration = 0 
	AddCAFInfoToStatus(List);
	
	iteration = iteration + 1;
	
	if table.Count(Addons) > 0 then
		for k,v in pairs( Addons ) do
			if v.IsVisible == nil or v.IsVisible() then
				iteration = iteration + 1;
				
				local descriptiontxt = nil
				if v.GetDescription then
					descriptiontxt = v.GetDescription()
				--else
				--	descriptiontxt = {CAF.GetLangVar("No Description")};
				end
				
				local cat = vgui.Create("DCAFCollapsibleCategory") 
				cat:Setup(k, v);
				--cat:SetExtraButtonAction(function() frame:Close()  end)
				
				local contentpanel = vgui.Create("DPanelList", cat)
				contentpanel:SetWide(List:GetWide())
				local clientMenu = nil;
				if v.GetClientMenu then
					clientMenu = v.GetClientMenu(contentpanel);
				end
				local serverMenu = nil;
				if v.GetServerMenu then
					serverMenu = v.GetServerMenu(contentpanel);
				end
				
				--Start Add Custom Stuff
				local x = 0;
				local y = 0;
				local ply = LocalPlayer();
				--Version Check
				local versionupdatetext = vgui.Create("DLabel", contentpanel)
				versionupdatetext:SetPos(x + 10, y)
				versionupdatetext:SetText(CAF.GetLangVar("No Update Information Available"))
				versionupdatetext:SetTextColor( Color(200,200,0,200) )
				if v.IsUpToDate and CAF2.HasInternet then
					v.IsUpToDate(function(uptodate)
						if uptodate then
							versionupdatetext:SetText(CAF.GetLangVar("This Addon is up to date"))
							versionupdatetext:SetTextColor( Color(0,230,0,200) )
						else
							versionupdatetext:SetText(CAF.GetLangVar("This Addon is out of date"))
							versionupdatetext:SetTextColor( Color(230,0,0,200) )
						end
						versionupdatetext:SizeToContents()
					end);
				end
				versionupdatetext:SizeToContents()
				
				y = y + 30;
				
				--ServerMenu
				if serverMenu then
					serverMenu:SetPos(x, y)
					y = y + serverMenu:GetTall() + 15;
				end
				--Clientside menu
				if clientMenu then
					clientMenu:SetPos(x, y)
					y = y + clientMenu:GetTall() + 15;
				end
				
				--Description
				if descriptiontxt ~= nil then
					local list = vgui.Create("DPanelList",contentpanel)
					list:SetPos(x, y);
					local size = 1;
					list:SetPadding(10)
					--Description Blank Line
					lab = vgui.Create("DLabel", list)
					lab:SetText(CAF.GetLangVar("Description")..":")
					lab:SizeToContents()
					list:AddItem(lab)
					size = size + 1;
					--Description
					for k, v in pairs(descriptiontxt) do
						lab = vgui.Create("DLabel", list)
						lab:SetText(v)
						lab:SizeToContents()
						list:AddItem(lab)
						size = size + 1;
					end
					list:SetSize(List:GetWide()-10, 15 * size)
					contentpanel:SizeToContents()
					y = y + (15 * size) + 15
				end
				contentpanel:SetTall(y);
				--End Add Custom Stuff
				cat:SetContents(contentpanel)
				cat:SizeToContents()
				cat:InvalidateLayout()
				--[[if iteration == 1 then
					cat:SetExpanded(true)
				else]]
					cat:SetExpanded(false)
				--end
				List:AddItem(cat)
			end
		end
	end
	return panel
end

function GetMessageLogPanel(frame)
	--TODO Create it
	local panel = vgui.Create("DPanel", frame)
	panel:StretchToParent( 6, 36, 6, 6 )
	local mylist = vgui.Create("DListView", panel)
	mylist:SetMultiSelect(false)
	mylist:SetPos(1,1)
	mylist:StretchToParent( 2, 2, 2, 2 ) --SetSize(panel:GetWide()- 2, panel:GetTall()-2)
	local colum =  mylist:AddColumn("Time")
	colum:SetFixedWidth(math.Round((mylist:GetWide() * (0.5/5))))
	colum =  mylist:AddColumn("Location")
	colum:SetFixedWidth(math.Round((mylist:GetWide() * (0.5/5))))
	colum =  mylist:AddColumn("Message")
	colum:SetFixedWidth(math.Round((mylist:GetWide() * (4/5))))
	for k, v in pairs(MessageLog) do
		local line = mylist:AddLine(CurTime(), v.location, v.message )
		line.Columns[3]:SetTextColor(v.color)  
	end
	return panel;
end

local function GetServerSettingsPanel(frame)
	local panel = vgui.Create("DPanel", frame)
	panel:StretchToParent( 6, 36, 6, 6 )
	return panel
end

local function GetAboutPanel(frame)
	local panel = vgui.Create("DPanel", frame)
	panel:StretchToParent( 6, 36, 6, 6 )
	--
	local mylist = vgui.Create("DListView", panel)
	mylist:SetMultiSelect(false)
	mylist:SetPos(1,1)
	mylist:SetSize(panel:GetWide()- 2, panel:GetTall()-2)
	local colum =  mylist:AddColumn( "")
	colum:SetFixedWidth(5)
	local colum1 =  mylist:AddColumn( "About")
	colum1:SetFixedWidth(mylist:GetWide() - 5)
	mylist.SortByColumn = function()
	end
	----------
	--Text--
	----------
	mylist:AddLine( "", "Custom Addon Framework" )
	mylist:AddLine( "", "More info to be added" )
	mylist:AddLine( "", "" )
	mylist:AddLine( "", "Made By SnakeSVx" )
	mylist:AddLine( "", "Official website: http://www.snakesvx.net" )
	--
	return panel
end

local MainFrame = nil;

function CAF2.CloseMainMenu()
	if MainFrame then MainFrame:Close() end
end

function CAF2.RefreshMainMenu()
	if MainFrame then
		 CAF2.OpenMainMenu()
	end
end

function CAF2.OpenMainMenu()
	CAF2.CloseMainMenu();
	MainFrame= vgui.Create("DFrame")
	MainFrame:SetDeleteOnClose() 
	MainFrame:SetDraggable( false ) 
	MainFrame:SetTitle("Custom Addon Framework Main Menu")
	MainFrame:SetSize(ScrW() * 0.8, ScrH() * 0.9)
	MainFrame:Center()
	local ContentPanel = vgui.Create( "DPropertySheet", MainFrame )
	ContentPanel:Dock(FILL)
	ContentPanel:AddSheet( CAF.GetLangVar("Installed Addons"), GetStatusPanel(ContentPanel), "gui/silkicons/application", true, true )
	ContentPanel:AddSheet( CAF.GetLangVar("Info and Help"), GetHelpPanel(ContentPanel), "gui/silkicons/box", true, true )
	if LocalPlayer():IsAdmin() then
		ContentPanel:AddSheet( CAF.GetLangVar("Server Settings"), GetServerSettingsPanel(ContentPanel), "gui/silkicons/wrench", true, true )
	end
	ContentPanel:AddSheet( CAF.GetLangVar("Message Log"), GetMessageLogPanel(ContentPanel), "gui/silkicons/wrench", true, true )
	ContentPanel:AddSheet( CAF.GetLangVar("About"), GetAboutPanel(ContentPanel), "gui/silkicons/group", true, true )
	MainFrame:MakePopup()
end
concommand.Add("Main_CAF_Menu", CAF2.OpenMainMenu)

--Panel
local function BuildMenu( Panel )
	Panel:ClearControls( )
	Panel:AddControl( "Header", { Text = "Custom Addon Framework", Description   = "Custom Addon Framework" }  )
	Panel:AddControl( "Button", {
		Label = "Open Menu",
		Text = "Custom Addon Framework",
		Command = "Main_CAF_Menu"
		} )
end

local function CreateMenu( )
	spawnmenu.AddToolMenuOption( "Custom Addon Framework", "Custom Addon Framework", "MainInfoMenu", "Main Info Menu", "", "", BuildMenu, { } )
end
hook.Add( "PopulateToolMenu", "Caf_OpenMenu_AddMenu", CreateMenu )

function CAF2.POPUP(msg, location, color, displaytime)
	if msg then
		AddPopup(msg, location, color, displaytime);
	end
end

local function ProccessMessage(len, client)
	local msg = net.ReadString()
	local location = net.ReadString()
	local r = net.ReadUInt( 8 )
	local g = net.ReadUInt( 8 )
	local b = net.ReadUInt( 8 )
	local a = net.ReadUInt( 8 )
	local displaytime = net.ReadUInt( 16 )
	local color = Color(r, g, b, a);
	CAF2.POPUP(msg, location, color, displaytime);
end
net.Receive("CAF_Addon_POPUP", ProccessMessage)

--CAF = CAF2

--Include clientside files

--Core

local Files = file.Find( "CAF/Core/client/*.lua" , "LUA")
for k, File in ipairs(Files) do
	Msg(CAF.GetLangVar("Loading")..": "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/Core/client/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Loaded: Successfully\n")
	end
end

Files = file.Find("CAF/LanguageVars/*.lua", "LUA")
for k, File in ipairs(Files) do
	Msg(CAF.GetLangVar("Loading")..": "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/LanguageVars/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Sent: Successfully\n")
	end
end

--Addons
local Files = file.Find( "CAF/Addons/client/*.lua" , "LUA")
for k, File in ipairs(Files) do
	Msg(CAF.GetLangVar("Loading")..": "..File.."...")
	local ErrorCheck, PCallError = pcall(include, "CAF/Addons/client/"..File)
	if(not ErrorCheck) then
		ErrorOffStuff(PCallError)
	else
		Msg("Loaded: Successfully\n")
	end
end
