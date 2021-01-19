local RD = {}
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

local function ClearNets()
	rd_cache:clear()
end

net.Receive("RD_ClearNets", ClearNets)

local function ReadBool()
	return net.ReadBit() == 1
end

local function ReadShort()
	return net.ReadInt(16)
end

local function ReadLong()
	return net.ReadInt(32)
end

local dev = GetConVar("developer")

local function AddEntityToCache(nrofbytes)
	if dev:GetBool() then
		print("RD_Entity_Data #", nrofbytes, " bytes received")
	end

	local data = {}
	data.entid = ReadShort() --Key
	local up_to_date = ReadBool()

	if up_to_date then
		rd_cache:update("entity_" .. tostring(data.entid))
	end

	data.network = ReadShort() --network key
	data.resources = {}
	local nr_of_resources = ReadShort()

	if (nr_of_resources > 0) then
		--print("nr_of_sources", nr_of_resources)
		local resource
		local maxvalue
		local value

		for i = 1, nr_of_resources do
			--print(i)
			resource = net.ReadString()
			maxvalue = ReadLong()
			value = ReadLong()

			data.resources[resource] = {
				value = value,
				maxvalue = maxvalue
			}
		end
	end

	rd_cache:add("entity_" .. tostring(data.entid), data)
end

net.Receive("RD_Entity_Data", AddEntityToCache)

local function AddNetworkToCache(nrofbytes)
	if dev:GetBool() then
		print("RD_Network_Data #", nrofbytes, " bytes received")
	end

	local data = {}
	data.netid = ReadShort() --network key
	local up_to_date = ReadBool()

	if up_to_date then
		rd_cache:update("network_" .. tostring(data.netid))
	end

	data.resources = {}
	local nr_of_resources = ReadShort()

	if (nr_of_resources > 0) then
		--print("nr_of_sources", nr_of_resources)
		local resource
		local maxvalue
		local value
		local localmaxvalue
		local localvalue

		for _ = 1, nr_of_resources do
			--print(i)
			resource = net.ReadString()
			maxvalue = ReadLong()
			value = ReadLong()
			localmaxvalue = ReadLong()
			localvalue = ReadLong()

			data.resources[resource] = {
				value = value,
				maxvalue = maxvalue,
				localvalue = localvalue,
				localmaxvalue = localmaxvalue
			}
		end
	end

	data.cons = {}
	local nr_of_cons = ReadShort()

	if (nr_of_cons > 0) then
		--print("nr_of_cons", nr_of_cons)
		for i = 1, nr_of_cons do
			--print(i)
			con = ReadShort()
			table.insert(data.cons, con)
		end
	end

	rd_cache:add("network_" .. tostring(data.netid), data)
end

net.Receive("RD_Network_Data", AddNetworkToCache)

--end local functions
--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function RD.__Construct()
	status = true
	--return false , "No Implementation yet"

	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function RD.__Destruct()
	status = false
	--return false , "No Implementation yet"

	return true
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

local isuptodatecheck

--[[
	Update check
]]
function RD.IsUpToDate(callBackfn)
	if not CAF.HasInternet then return end

	if isuptodatecheck ~= nil then
		callBackfn(isuptodatecheck)

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
--Name is nil for main menu, String for others
function RD.GetMenu(menutype, menuname)
	local data = {}

	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function RD.GetCustomStatus()
	--CAF.GetLangVar("Not Implemented Yet")
	return
end

--[[
	Returns a table containing the Description of this addon
]]
function RD.GetDescription()
	return {"Resource Distribution", "", ""}
end

CAF.RegisterAddon("Resource Distribution", RD, "1")

function RD.GetNetResourceAmount(netid, resource)
	if not resource then return 0, "No resource given" end
	local data = RD.GetNetTable(netid)
	if not data then return 0, "Not a valid network" end
	if not data.resources or (data.resources and table.Count(data.resources) == 0) then return 0, "No resources available" end
	if not data.resources[resource] then return 0, "Resource not available" end
	local amount = 0
	amount = data.resources[resource].value

	return amount
end

function RD.GetResourceAmount(ent, resource)
	if not IsValid(ent) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local data = RD.GetEntityTable(ent)
	if not data.resources or (data.resources and table.Count(data.resources) == 0) then return 0, "No resources available" end
	if not data.resources[resource] then return 0, "Resource not available" end
	local amount = 0
	amount = data.resources[resource].value

	return amount
end

--[[function RD.GetUnitCapacity(ent, resource)
	if not IsValid( ent ) then return 0, "Not a valid entity" end
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
	local data = RD.GetNetTable(netid)
	if not data then return 0, "Not a valid network" end
	if not data.resources or (data.resources and table.Count(data.resources) == 0) then return 0, "No resources available" end
	if not data.resources[resource] then return 0, "Resource not available" end
	local amount = 0
	amount = data.resources[resource].maxvalue

	return amount
end

function RD.GetNetworkCapacity(ent, resource)
	if not IsValid(ent) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local data = RD.GetEntityTable(ent)
	if not data then return 0, "Not a valid network" end
	if not data.resources or (data.resources and table.Count(data.resources) == 0) then return 0, "No resources available" end
	if not data.resources[resource] then return 0, "Resource not available" end
	local amount = 0

	if data.resources[resource] then
		amount = data.resources[resource].maxvalue
	end

	return amount
end

local requests = {}
local ttl = 0.2 --Wait 0.2 second before doing a new request

function RD.GetEntityTable(ent)
	local entid = ent:EntIndex()
	local id = "entity_" .. tostring(entid)
	local data, needs_update = rd_cache:get(id)

	if not data or needs_update then
		if not requests[id] or requests[id] < CurTime() then
			--Do (new) request
			requests[id] = CurTime() + ttl
			RunConsoleCommand("RD_REQUEST_RESOURCE_DATA", "ENT", entid, needs_update and "UPDATE")
		end
	end
	--PrintTable(data)

	return data or {}
end

function RD.GetNetTable(netid)
	local id = "network_" .. tostring(netid)
	local data, needs_update = rd_cache:get(id)

	if not data or needs_update then
		if not requests[id] or requests[id] < CurTime() then
			--Do (new) request
			requests[id] = CurTime() + ttl
			RunConsoleCommand("RD_REQUEST_RESOURCE_DATA", "NET", netid, needs_update and "UPDATE")
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
	if resourcenames[resource] then return resourcenames[resource] end

	return resource
end

function RD.GetAllRegisteredResources()
	if not resourcenames or table.Count(resourcenames) < 0 then return {} end

	return table.Copy(resourcenames)
end

function RD.GetRegisteredResources()
	return table.Copy(resources)
end


function RD.PrintDebug(ent)
	if ent then
		if ent.IsNode then
			PrintTable(RD.GetNetTable(ent.netid))
		else -- --
			local enttable = RD.GetEntityTable(ent)
			PrintTable(enttable)
		end
	end
end

list.Add("BeamMaterials", "cable/rope_icon")
list.Add("BeamMaterials", "cable/cable2")
list.Add("BeamMaterials", "cable/xbeam")
list.Add("BeamMaterials", "cable/redlaser")
list.Add("BeamMaterials", "cable/blue_elec")
list.Add("BeamMaterials", "cable/physbeam")
list.Add("BeamMaterials", "cable/hydra")
--holds the materials
beamMat = {}

for _, mat in pairs(list.Get("BeamMaterials")) do
	beamMat[mat] = Material(mat)
end

-----------------------------------------
--START BEAMS BY MADDOG
-----------------------------------------
local xbeam = Material("cable/xbeam")

-- Desc: draws beams on ents
function RD.Beam_Render(ent)
	--get the number of beams to use
	local intBeams = ent:GetNWInt("Beams")

	--if we have beams, then create them
	if intBeams and intBeams ~= 0 then
		--make some vars we are about to use
		local start, scroll = ent:GetNWVector("Beam1"), CurTime() * 0.5
		--get beam info and explode into a table
		local beamInfo = string.Explode(";", ent:GetNWString("BeamInfo"))
		--get beam info from table (1: beamMaterial 2: beamSize 3: beamR 4: beamG 5: beamB 6: beamAlpha)
		local beamMaterial, beamSize, color = (beamMat[beamInfo[1]] or xbeam), (beamInfo[2] or 2), Color(beamInfo[3] or 255, beamInfo[4] or 255, beamInfo[5] or 255, beamInfo[6] or 255)
		-- set material
		render.SetMaterial(beamMaterial)
		render.StartBeam(intBeams) --how many links (points) the beam has

		--loop through all beams
		for i = 1, intBeams do
			--get beam data
			local beam, ent = ent:GetNWVector("Beam" .. tostring(i)), ent:GetNWEntity("BeamEnt" .. tostring(i))

			--if no beam break for statement
			if not beam or not ent or not ent:IsValid() then
				ent:SetNWInt("Beams", 0)
				break
			end

			--get beam world vector
			local pos = ent:LocalToWorld(beam)
			--update scroll
			scroll = scroll - (pos - start):Length() / 10
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
local function GenUseMenu(ent)
	local SmallFrame = vgui.Create("DFrame")
	SmallFrame:SetPos((ScrW() / 2) - 110, (ScrH() / 2) - 100)
	SmallFrame:SetSize(220, (#ent.Inputs * 40) + 90)
	SmallFrame:SetTitle(ent.PrintName)
	local ypos = 30
	local HoldSlider = vgui.Create("DNumSlider", SmallFrame)
	HoldSlider:SetPos(10, ypos)
	HoldSlider:SetSize(200, 30)
	HoldSlider:SetText("Time to Hold:")
	HoldSlider:SetMin(0)
	HoldSlider:SetMax(10)
	HoldSlider:SetDecimals(1)
	HoldSlider:SetConVar("number_to_hold")
	ypos = ypos + 40

	for k, v in pairs(ent.Inputs) do
		local NumSliderThingy = vgui.Create("DNumSlider", SmallFrame)
		NumSliderThingy:SetPos(10, ypos)
		NumSliderThingy:SetSize(120, 30)
		NumSliderThingy:SetText(v .. " :")
		NumSliderThingy:SetMin(0)
		NumSliderThingy:SetMax(10)
		NumSliderThingy:SetDecimals(0)
		NumSliderThingy:SetConVar("number_to_send")
		local SendButton = vgui.Create("DButton", SmallFrame)
		SendButton:SetPos(140, ypos)
		SendButton:SetText("Send Command")
		SendButton:SizeToContents()

		SendButton.DoClick = function()
			RunConsoleCommand("send_input_selection_to_server", ent:EntIndex(), v, client_chosen_number:GetInt(), client_chosen_hold:GetFloat())
		end

		ypos = ypos + 40
	end

	SmallFrame:MakePopup()
end

local function RecieveInputs()
	local last = net.ReadBool()
	local input = net.ReadString()
	local ent = net.ReadEntity()

	if not ent.Inputs then
		ent.Inputs = {}
	end

	if not table.HasValue(ent.Inputs, input) then
		table.insert(ent.Inputs, input)
	end

	if last and last == true then
		GenUseMenu(ent)
	end
end

net.Receive("RD_AddInputToMenu", RecieveInputs)