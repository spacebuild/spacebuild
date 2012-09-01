local RD = {}
--local nettable = {};
--local ent_table = {};
local resourcenames = {}
local resources = {}
local status = false

local rd_cache = cache.create(1, false) --Store data for 1 second
--[[

]]

--local functions

RD_OverLay_Distance = CreateClientConVar("rd_overlay_distance", "512", false, false)
RD_OverLay_Mode = CreateClientConVar("rd_overlay_mode", "-1", false, false)
local client_chosen_number = CreateClientConVar("number_to_send", "1", false, false)
local client_chosen_hold = CreateClientConVar("number_to_hold", "0", false, false)

----------NetTable functions

local function CreateNetTable(netid)
	nettable[netid] = {}
	local index = nettable[netid]
	index.resources = {}
	index.cons = {}
end
--[[
umsg.Start("RD_AddNet")
		umsg.Short(netid)
	umsg.End()
]]
--[[local function AddNet( um )
	local netid = um:ReadShort()
	if netid > 0 then
		CreateNetTable(netid)
	end
end
usermessage.Hook("RD_AddNet", AddNet)]]

--[[
umsg.Start("RD_AddResoureToNet")
		umsg.Short(netid)
		umsg.String(resource)
		umsg.Long(maxvalue)
		umsg.Long(value)
	umsg.End()
]]

--[[local function AddResoureToNet( um )
	local netid = um:ReadShort()
	local resource = um:ReadString()
	local maxvalue = um:ReadLong()
	local value = um:ReadLong()
	if not table.HasValue(resources, resource) then
		table.insert(resources, resource)
	end
	if netid > 0 then
		if not nettable[netid] then
			CreateNetTable(netid)
		end
		nettable[netid].resources[resource] = {}
		nettable[netid].resources[resource].maxvalue = maxvalue
		nettable[netid].resources[resource].value = value
	end
end
usermessage.Hook("RD_AddResoureToNet", AddResoureToNet)]]

--[[

--Needed?
umsg.Start("RD_AddConToNet")
		umsg.Short(netid)
		umsg.Short(entid)
	umsg.End()
]]

--[[local function AddConToNet(um)
	local netid = um:ReadShort()
	local conid = um:ReadShort()
	if netid > 0 then
		if not nettable[netid] then
			CreateNetTable(netid)
		end
		table.insert(nettable[netid].cons, conid)
	end
end
usermessage.Hook("RD_AddConToNet", AddConToNet)]]

--[[
umsg.Start("RD_RemoveNetCons")
		umsg.Short(netid)
	umsg.End()
]]

--[[local function RemoveConsFromNet( um)
	local netid = um:ReadShort()
	if netid > 0 then
		if not nettable[netid] then
			CreateNetTable(netid)
		end
		nettable[netid].cons = {}
	end
end
usermessage.Hook("RD_RemoveNetCons", RemoveConsFromNet)]]
--[[
umsg.Start("RD_RemoveNet")
		umsg.Short(netid)
	umsg.End()
]]

--[[local function RemoveNet( um)
	local netid = um:ReadShort()
	if netid > 0 then
		nettable[netid] = nil
	end
end
usermessage.Hook("RD_RemoveNet", RemoveNet)]]

---------ent_table functions
--[[
umsg.Start("RD_AddEnt")
		umsg.Short(entid)
	umsg.End()
]]

--[[local function CreateEntTable(entid)
	ent_table[entid] = {}
	ent_table[entid].network = 0
	ent_table[entid].resources = {}
end

local function AddEnt( um )
	local entid = um:ReadShort()
	CreateEntTable(entid)
end
usermessage.Hook("RD_AddEnt", AddEnt)]]


--[[
umsg.Start("RD_AddResoureToEnt")
		umsg.Short(entid)
		umsg.String(resource)
		umsg.Long(maxvalue)
		umsg.Long(value)
	umsg.End()
]]

--[[local function AddResourceToEnt( um )
	local entid = um:ReadShort()
	local resource = um:ReadString()
	local maxvalue = um:ReadLong()
	local value = um:ReadLong()
	if not ent_table[entid] then
		CreateEntTable(entid)
	end
	ent_table[entid].resources[resource] = {}
	ent_table[entid].resources[resource].maxvalue = maxvalue
	ent_table[entid].resources[resource].value = value
end
usermessage.Hook("RD_AddResoureToEnt", AddResourceToEnt)]]

--[[
umsg.Start("RD_ChangeNetOnEnt")
		umsg.Short(entid)
		umsg.Short(netid)
	umsg.End()
]]
--[[local function ChangeNetOnEnt( um )
	local entid = um:ReadShort()
	local netid = um:ReadShort()
	if not ent_table[entid] then
		CreateEntTable(entid)
	end
	ent_table[entid].network = netid
end
usermessage.Hook("RD_ChangeNetOnEnt", ChangeNetOnEnt)]]

--[[
umsg.Start("RD_RemoveEnt")
		umsg.Short(entid)
	umsg.End()
]]
--[[local function RemoveEnt( um )
	local entid = um:ReadShort()
	ent_table[entid] = nil
end
usermessage.Hook("RD_RemoveEnt", RemoveEnt)]]

------ nettable and ent_table
--[[
umsg.Start("RD_ClearNets")
	umsg.End()
]]
local function ClearNets( um )
	--nettable = {}
	--ent_table = {}
	rd_cache:clear();
end
usermessage.Hook("RD_ClearNets", ClearNets)

--[[
umsg.Start("RD_Entity_Data", ply)
	umsg.Short(entid) --send key to update
	umsg.Short(rddata.network) --send network used in entity
	
	local nr_of_resources = table.Count(rddata.resources);
	umsg.Short(nr_of_resources) --How many resources are going to be send?
	if nr_of_resources > 0 then
		for l, w in pairs(rddata.resources) do
			umsg.String(l)
			umsg.Long(w.maxvalue)
			umsg.Long(w.value)
		end
	end
	
umsg.End()
]]

local function AddEntityToCache( um )
	local data = {}

	data.entid = um:ReadShort() --Key
	local up_to_date = um:ReadBool();
	if up_to_date then
		rd_cache:update("entity_"..tostring(data.entid))
	end
	data.network = um:ReadShort() --network key
	
	data.resources = {}
	local i = 0;
	local nr_of_resources = um:ReadShort();
	if (nr_of_resources > 0) then
		--print("nr_of_sources", nr_of_resources)
		local resource 
		local maxvalue 
		local value
		for i = 1, nr_of_resources do
			--print(i)
			resource = um:ReadString()
			maxvalue = um:ReadLong()
			value = um:ReadLong()
			
			data.resources[resource] = {value = value, maxvalue = maxvalue}
		end
	end
	
	rd_cache:add("entity_"..tostring(data.entid), data)
end
usermessage.Hook("RD_Entity_Data", AddEntityToCache)

--[[
umsg.Start("RD_Network_Data", ply)
		umsg.Short(netid) --send key to update
		
		local nr_of_resources = table.Count(rddata.resources);
		umsg.Short(nr_of_resources) --How many resources are going to be send?
		if nr_of_resources > 0 then
			for l, w in pairs(rddata.resources) do
				umsg.String(l)
				umsg.Long(w.maxvalue)
				umsg.Long(w.value)
			end
		end
		
		local nr_of_cons = table.Count(rddata.cons);
		umsg.Short(nr_of_cons) --How many connections are going to be send?
		if nr_of_cons > 0 then
			for l, w in pairs(rddata.cons) do
				umsg.Short(w)
			end
		end
		
	umsg.End()

]]

local function AddNetworkToCache( um )
	local data = {}
	
	data.netid = um:ReadShort() --network key
	local up_to_date = um:ReadBool();
	if up_to_date then
		rd_cache:update("network_"..tostring(data.netid))
	end
	
	data.resources = {}
	local i = 0;
	local nr_of_resources = um:ReadShort();
	if (nr_of_resources > 0) then
		--print("nr_of_sources", nr_of_resources)
		local resource 
		local maxvalue 
		local value
		for i = 1, nr_of_resources do
			--print(i)
			resource = um:ReadString()
			maxvalue = um:ReadLong()
			value = um:ReadLong()
			
			data.resources[resource] = {value = value, maxvalue = maxvalue}
		end
	end
	
	data.cons = {}
	local nr_of_cons = um:ReadShort();
	if (nr_of_cons > 0) then
		--print("nr_of_cons", nr_of_cons)
		for i = 1, nr_of_cons do
			--print(i)
			con = um:ReadShort()
			table.insert(data.cons, con);
		end
	end
	
	rd_cache:add("network_"..tostring(data.netid), data)
end
usermessage.Hook("RD_Network_Data", AddNetworkToCache)

--end local functions

--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function RD.__Construct()
	status = true
	return true
	--return false , "No Implementation yet"
end

--[[
	The Destructor for this Custom Addon Class
]]
function RD.__Destruct()
	status = false
	return true
	--return false , "No Implementation yet"
end

--[[
	Get the required Addons for this Addon Class
]]
function RD.GetRequiredAddons()
	return {}
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
	return 3.1, "Alpha"
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
	--[[http.Get("http://www.snakesvx.net/versions/rd.txt","",
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
	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function RD.GetCustomStatus()
	return ; --CAF.GetLangVar("Not Implemented Yet")
end

--[[
	Returns a table containing the Description of this addon
]]
function RD.GetDescription()
	return {
				"Resource Distribution",
				"",
				""
			}
end
CAF.RegisterAddon("Resource Distribution", RD, "1")

--[[ Shared stuff ]]

--TODO UPDATE FROM HERE

--RD.GetEntityTable(ent)
--RD.GetNetTable(netid)

--[[function RD.getConnectedNets(netid) -- NEEDED ANYWHERE?
	local contable = {}
	local tmpcons = { netid}
	while(table.Count(tmpcons) > 0) do
		for k, v in pairs(tmpcons) do
			if not table.HasValue(contable, v) then
				table.insert(contable, v)
				if nettable[v] and nettable[v].cons then
					if table.Count(nettable[v].cons) > 0 then
						for l, w in pairs(nettable[v].cons) do
							table.insert(tmpcons, w)
						end
					end
				end
			end
			table.remove(tmpcons, k)
		end
	end
	return contable
end]]

function RD.GetNetResourceAmount(netid, resource)
	if not resource then return 0, "No resource given" end
	local data = GetNetTable(netid);
	if not data then return 0, "Not a valid network" end
	
	local amount = 0;
	if data.resources[resource] then
		amount = data.resources[resource].value
	end
	return amount
end

function RD.GetResourceAmount(ent, resource)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	
	local index=RD.GetEntityTable(ent)
	if table.Count(index)>0 then
		if index.resources[resource] then
			amount = index.resources[resource].value
		end
	end
	return amount
end

--[[function RD.GetUnitCapacity(ent, resource)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )];
		if index.resources[resource] then
			amount = index.resources[resource].maxvalue
		end
	end
	return amount
end]]

function RD.GetNetNetworkCapacity(netid, resource)
	if not resource then return 0, "No resource given" end
	local data = GetNetTable(netid);
	if not data then return 0, "Not a valid network" end
	
	local amount = 0;
	if data.resources[resource] then
		amount = data.resources[resource].maxvalue
	end
	return amount
end

function RD.GetNetworkCapacity(ent, resource)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	local index=RD.GetEntityTable(ent)
	if table.Count(index) then
		if index.resources[resource] then
			amount = index.resources[resource].maxvalue
		end
	end
	return amount
end

local requests = {}
local ttl = 0.2; --Wait 0.2 second before doing a new request

function RD.GetEntityTable(ent)
	local entid = ent:EntIndex( )
	local id = "entity_"..tostring(entid)
	local data, needs_update = rd_cache:get(id);
	if not data or needs_update then
		if not requests[id] or requests[id] < CurTime() then
			--Do (new) request
			requests[id] = CurTime() + ttl;
			RunConsoleCommand("RD_REQUEST_RESOURCE_DATA", "ENT", entid, needs_update and "UPDATE");
		end
	end
	--PrintTable(data)
	return data or {}
end

function RD.GetNetTable(netid)
	local id = "network_"..tostring(netid)
	local data, needs_update = rd_cache:get(id);
	if not data or needs_update then
		if not requests[id] or requests[id] < CurTime() then
			--Do (new) request
			requests[id] = CurTime() + ttl;
			RunConsoleCommand("RD_REQUEST_RESOURCE_DATA", "NET", netid, needs_update and "UPDATE");
		end
	end
	return data or {}
end

--TODO UPDATE TO HERE

function RD.AddProperResourceName(resource, name)
	if not resource or not name then return end
	if not table.HasValue(resources, resource) then
		table.insert(resources, resource)
	end
	resourcenames[resource] = name
end

function RD.GetProperResourceName(resource)
	if not resource then return "" end
	if resourcenames[resource] then
		return resourcenames[resource]
	end
	return resource
end

function RD.GetAllRegisteredResources()
	if not resourcenames or table.Count(resourcenames) < 0 then
		return {}
	end
	return table.Copy(resourcenames)
end

function RD.GetRegisteredResources()
	return table.Copy(resources)
end

--[[function RD.GetNetworkIDs() --NEEDED FOR SOMEONE?
	local ids = {}
	if table.Count(nettable) > 0 then
		for k, v in pairs(nettable) do
			if not v.clear then
				table.insert(ids, k)
			end
		end
	end
	return ids
end]]

function RD.PrintDebug(ent)
	if ent then
		if ent.IsNode then
			local nettable = RD.GetNetTable(ent.netid)
			PrintTable(nettable)
		elseif ent.IsValve then
			--
		elseif ent.IsPump then
			--
		else
			local enttable = RD.GetEntityTable(ent)
			PrintTable(enttable)
		end
	end
end

list.Add( "BeamMaterials", "cable/rope_icon" )
list.Add( "BeamMaterials", "cable/cable2" )
list.Add( "BeamMaterials", "cable/xbeam" )
list.Add( "BeamMaterials", "cable/redlaser" )
list.Add( "BeamMaterials", "cable/blue_elec" )
list.Add( "BeamMaterials", "cable/physbeam" )
list.Add( "BeamMaterials", "cable/hydra" )

--holds the materials
beamMat = {}

for _,mat in pairs(list.Get( "BeamMaterials" )) do
	beamMat[mat] = Material(mat)
end

-----------------------------------------
--START BEAMS BY MADDOG
-----------------------------------------

-- Desc: draws beams on ents
function RD.Beam_Render( ent )

	--get the number of beams to use
	local intBeams = ent:GetNWInt( "Beams" )

	--if we have beams, then create them
	if intBeams & intBeams ~= 0 then
		--make some vars we are about to use
		local i, start, scroll = 1, ent:GetNWVector( "Beam1" ), CurTime() * 0.5

		--get beam info and explode into a table
		local beamInfo = string.Explode(";", ent:GetNWString("BeamInfo"))

		--get beam info from table (1: beamMaterial 2: beamSize 3: beamR 4: beamG 5: beamB 6: beamAlpha)
		local beamMaterial, beamSize, color = (beamMat[beamInfo[1]] or Material("cable/xbeam")), (beamInfo[2] or 2), Color( beamInfo[3], beamInfo[4], beamInfo[5], beamInfo[6] )

		-- set material
		render.SetMaterial( beamMaterial )
		render.StartBeam( intBeams )	--how many links (points) the beam has

		--loop through all beams
		for i=1,intBeams do
			--get beam data
			local beam, ent = ent:GetNWVector( "Beam" .. tostring(i) ), ent:GetNWEntity( "BeamEnt" .. tostring(i) )

			--if no beam break for statement
			if not beam or  not ent or not ent:IsValid() then
				ent:SetNWInt( "Beams", 0 )
				break
			end

			--get beam world vector
			local pos = ent:LocalToWorld(beam)

			--update scroll
			scroll = scroll - (pos-start):Length()/10

			-- add point
			render.AddBeam(pos, beamSize, scroll, color)

			--reset start postion
			start = pos
		end

		--beam done
		render.EndBeam()
	end
end
-----------------------------------------
--END BEAMS BY MADDOG
-----------------------------------------

--Alternate Use Code--

function GenUseMenu(ent)
	local SmallFrame = vgui.Create("DFrame")
	SmallFrame:SetPos( (ScrW()/2)-110,(ScrH()/2)-100)
	SmallFrame:SetSize( 220, (#ent.Inputs*40)+90 )
	SmallFrame:SetTitle( ent.PrintName )
	
	local ypos = 30
	
	local HoldSlider = vgui.Create( "DNumSlider", SmallFrame )
		HoldSlider:SetPos( 10,ypos )
		HoldSlider:SetSize( 200, 30 )
		HoldSlider:SetText( "Time to Hold:" )
		HoldSlider:SetMin( 0 )
		HoldSlider:SetMax( 10 )
		HoldSlider:SetDecimals( 1 )
		HoldSlider:SetConVar( "number_to_hold" )
		
		ypos = ypos + 40
	for k,v in pairs(ent.Inputs) do
		local NumSliderThingy = vgui.Create( "DNumSlider", SmallFrame )
		NumSliderThingy:SetPos( 10,ypos )
		NumSliderThingy:SetSize( 120, 30 )
		NumSliderThingy:SetText( v.." :" )
		NumSliderThingy:SetMin( 0 )
		NumSliderThingy:SetMax( 10 )
		NumSliderThingy:SetDecimals( 0 )
		NumSliderThingy:SetConVar( "number_to_send" )
		
		local SendButton = vgui.Create( "DButton", SmallFrame )
		SendButton:SetPos(140,ypos)
		SendButton:SetText("Send Command")
		SendButton:SizeToContents()
		SendButton.DoClick = function()
			RunConsoleCommand("send_input_selection_to_server",ent.serverindex,v,client_chosen_number:GetInt(),client_chosen_hold:GetFloat())
		end
		
		ypos = ypos + 40
	end
	
	SmallFrame:MakePopup()
end 

function RecieveInputs(um)
	local last = um:ReadBool()
	local input = um:ReadString()
	local index = um:ReadShort()
	local ent = ents.GetByIndex(index)
	ent.serverindex = index
	if not ent.Inputs then ent.Inputs = {} end
	if not table.HasValue(ent.Inputs,input) then table.insert(ent.Inputs,input) end
	if last and last == true then
		GenUseMenu(ent)
	end
end
usermessage.Hook("RD_AddInputToMenu", RecieveInputs)
