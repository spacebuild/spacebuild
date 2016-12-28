local SPACEBUILD = SPACEBUILD
local RD = {}
local nettable = {};
local ent_table = {};
local resourcenames = {}
local resources = {}

local status = false

--Local functions/variables

--Precache some sounds for snapping
for i=1,3 do
	util.PrecacheSound( "physics/metal/metal_computer_impact_bullet"..i..".wav" )
end
util.PrecacheSound( "physics/metal/metal_box_impact_soft2.wav" )

--[[
	The Constructor for this Custom Addon Class
]]
function RD.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	status = true
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function RD.__Destruct()
	if not status then return false , CAF.GetLangVar("This Addon is already disabled!") end
	status = false
	return false, "Can't disable"
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
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function RD.GetExtraOptions()
	return {}
end

--[[
	Get the Custom String Status from this Addon Class
]]
function RD.GetCustomStatus()
	return "Not Implemented Yet"
end

function RD.AddResourcesToSend()

end
CAF.RegisterAddon("Resource Distribution", RD, "1")

--[[
	RemoveRDEntity( entity)
		Call this when you want to remove the registered RD entity from the RD3 syncing (happens in the base_rd_entity/init.lua: OnRemove Function, if you override this function, don't forget to add this call!!)

]]
function RD.RemoveRDEntity(ent)
	SPACEBUILD:removeDevice(ent)
end

--[[
	RegisterNonStorageDevice( entity)
	
		Used to register non-storage Device ( devices that have a max of 0 for all resources)
		Add the to-display resources to the "list.Set( "LSEntOverlayText" , "generator_energy_fusion", {HasOOO = true, num = 2, resnames = {"nitrogen","heavy water"}} )" call specific for your Sent

]]
function RD.RegisterNonStorageDevice(ent)
	if not IsValid( ent ) then return false, "Not a valid entity" end
	if not ent.rdobject then
		SPACEBUILD:registerDevice(ent, SPACEBUILD.RDTYPES.GENERATOR)
	else
		error("this entity has already been registered before.")
	end
end

--[[
	AddResource(entity, resource, maximum amount, default value)
		
		Add a resource to the Entity, you can use this for any amount, but it's recomended to only call this if your entity can store resources (max amount > 0 )
			Even if it requires multiple resources, registering the ones that can store resources is enough.
			
			Note: If your device doesn't store anything just use RegisterNonStorageDevice instead of this, it's more optimized for it
]]
function RD.AddResource(ent, resource, maxamount, defaultvalue)
	if not IsValid( ent ) then return false, "Not a valid entity" end
	if not ent.rdobject then return false, "this entity has not been registered before." end
	if not defaultvalue then defaultvalue = 0 end
	if not maxamount then maxamount = 0 end
	if maxamount < defaultvalue then defaultvalue = maxamount end
	ent.rbobject:addResource(resource, maxamount, defaultvalue)
	return true
end

--[[
	AddNetResource(Netid, resource, maximum amount, default value)
		
		Add a resource to the network with the specified Netid, you can use this for any amount, but it's recomended to only call this if your entity can store resources (max amount > 0 )
			Even if it requires multiple resources, registering the ones that can store resources is enough.
			
			Note: If your device doesn't store anything just use RegisterNonStorageDevice instead of this, it's more optimized for it
]]
function RD.AddNetResource(netid, resource, maxamount, defaultvalue)
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if ent then return false, "Not a valid Network ID" end
	if not resource then return false, "No resource given" end
	if not defaultvalue then defaultvalue = 0 end
	if not maxamount then maxamount = 0 end
	if maxamount < defaultvalue then defaultvalue = maxamount end
	ent:addResource(resource, maxamount, defaultvalue)
	return true
end

--[[
	ConsumeNetResource( netid, resource, amount)
	
		Only use this if you got a special sent (like the Resource Pumps) which don't have direct netinfo stored
		
		This means not Registered using RegisterNonStorageDevice() or Addresource(), one you used those you definetly don't need to use this one (except for special cases)
		
		Returns the actual amount consumed!!

]]
function RD.ConsumeNetResource(netid, resource, amount)
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if ent then return false, "Not a valid Network ID" end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	return ent:consumeResource(resource, amount)
end

--[[
	ConsumeResource(entity, resource , amount)
	
		Use this to consume resource (if you call this from inside the entity use self where the entity needs to be)
		
		It will return the amount of resources actually consumed!!
]]

function RD.ConsumeResource(ent, resource, amount)
	if not IsValid( ent ) then return 0, "Not a valid entity" end
	if not ent.rdobject then return false, "this entity has not been registered before." end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	return ent.rbobject:consumeResource(resource, amount)
end

--[[
	SupplyNetResource(netid, resource, amount)
	
		Only use this if you got a special sent (like the Resource Pumps) which don't have direct netinfo stored
		
		This means not Registered using RegisterNonStorageDevice() or Addresource(), one you used those you definetly don't need to use this one (except for special cases)
	
		Returns the amount of resources it couldn't supply to the network (lack of storage fe)
	
]]
function RD.SupplyNetResource(netid, resource, amount)
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if ent then return false, "Not a valid Network ID" end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	return ent:supplyResource(resource, amount)
end

--[[
	SupplyResource(entity, resource, amount)
		
		Supplies the network connected to the specific Entity (mostly self) the specific amount of resources
		
		Returns the amount of resources it couldn't store

]]
function RD.SupplyResource(ent, resource, amount)
	if not IsValid( ent ) then return 0, "Not a valid entity" end
	if not ent.rdobject then return false, "this entity has not been registered before." end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	return ent.rbobject:supplyResource(resource, amount)
end

--[[
	Link(entity, netid)
	
		This function connects the specific (valid) entity to the specific (valid) network
		
		This is called by the Link tool(s)

]]
function RD.Link(ent, netid)
	if not IsValid( ent ) then return 0, "Not a valid entity" end
	if not ent.rdobject then return false, "this entity has not been registered before." end
	local network = SPACEBUILD:getDeviceInfo(netid)
	if network then return false, "Not a valid Network ID" end
	network:link(ent.rdobject)
end

--[[
	Unlink(entity)
	
		This function unlinks the device from it's network
		
		This is called by the Link tool(s)

]]
function RD.Unlink(ent)
	if not IsValid( ent ) then return 0, "Not a valid entity" end
	if not ent.rdobject then return false, "this entity has not been registered before." end
	ent.rdobject:unlink()
end

--[[
	UnlinkAllFromNode( netid)
	
		This function disconnects all devices and network connection from the network with that specific netid
		
		This is called by the Link tool(s)

]]
function RD.UnlinkAllFromNode(netid)
	local network = SPACEBUILD:getDeviceInfo(netid)
	if network then return false, "Not a valid Network ID" end
	network:unlink()
	return true
end

--[[
	UnLinkNodes(netid, netid2)
	
		This function will break the link between these 2 networks
		
		This is called by the Link tool(s)

]]
function RD.UnlinkNodes(netid, netid2)
	local network = SPACEBUILD:getDeviceInfo(netid)
	if network then return false, "Not a valid Network ID" end
	local network2 = SPACEBUILD:getDeviceInfo(netid2)
	if network2 then return false, "Not a valid Network ID 2" end
	network:unlink(network2)
	return false
end

--[[
	linkNodes(netid, netid2)
	
		This function will create a link between these 2 networks
		
		This is called by the Link tool(s)

]]
function RD.linkNodes(netid, netid2)
	local network = SPACEBUILD:getDeviceInfo(netid)
	if network then return false, "Not a valid Network ID" end
	local network2 = SPACEBUILD:getDeviceInfo(netid2)
	if network2 then return false, "Not a valid Network ID 2" end
	network:link(network2)
	return false
end

--[[
	CreateNetwork(entity)
	
		Used to register a Resource Node with the system
		
			Returns the id of the network
]]
function RD.CreateNetwork(ent)
	local device = SPACEBUILD:registerDevice(ent, SPACEBUILD.RDTYPES.NETWORK)
	return device:getID()
end

-- [[ Save Stuff  - Testing]]

local function MySaveFunction( save )
	print("Calling RD Save method")
	local data = {
		net = nettable,
		ents = ent_table,
		res_names = resourcenames,
		res = resources
	}
	saverestore.WriteTable( data, save )
end

local function MyRestoreFunction( restore )
	print("Calling RD Restore method");
	local data = saverestore.ReadTable( restore )
	PrintTable(data)
	nettable = data.net;
	ent_table = data.ents;
	for k, v in pairs(nettable) do -- needed?
		v.haschanged = true;
		v.new = true;
	end
	for k, v in pairs(ent_table) do -- needed?
		v.haschanged = true;
		v.new = true;
	end
	resourcenames = data.res_names;
	resources = data.res;
end
saverestore.AddSaveHook( "caf_rd_save", MySaveFunction )
saverestore.AddRestoreHook( "caf_rd_save", MyRestoreFunction )

--[[ Dupe Stuff]]

function RD.BuildDupeInfo( ent )
	--save any beams
	RD.Beam_dup_save( ent )
	
	if ent.IsPump then
		if ent.netid ~= 0 then
			local nettable = RD.GetNetTable(ent.netid)
			if nettable.nodeent then
				local info = {}
				info.node = nettable.nodeent:EntIndex()
				duplicator.ClearEntityModifier( ent, "RDPumpDupeInfo" )
				duplicator.StoreEntityModifier( ent, "RDPumpDupeInfo", info )
			end
		end
		return
	end

	if ent.IsValve or ent.IsEntityValve then
		local info = {}
		--store active state
		info.active = ent.Active
				
		--store node1 info
		if ent.connected.node1 and ent.connected.node1.netid ~= 0 then
			local nettable1 = RD.GetNetTable(ent.connected.node1.netid)
			if nettable1.nodeent then
				info.node1 = nettable1.nodeent:EntIndex()
			end
		end
		
		--store node2 info
		if ent.connected.node2 and ent.connected.node2.netid ~= 0 then
			local nettable2 = RD.GetNetTable(ent.connected.node2.netid)
			if nettable2.nodeent then
				info.node2 = nettable2.nodeent:EntIndex()
			end
		end
		
		--store node info
		if ent.connected.node and ent.connected.node.netid ~= 0 then
			local nettable = RD.GetNetTable(ent.connected.node.netid)
			if nettable.nodeent then
				info.node = nettable.nodeent:EntIndex()
			end
		end
		
		--store ent info
		if ent.connected.ent then
			info.ent = ent.connected.ent:EntIndex()
		end

		duplicator.ClearEntityModifier( ent, "RDValveDupeInfo")
		duplicator.StoreEntityModifier( ent, "RDValveDupeInfo", info )
		return
	end
	
	if not ent.IsNode then return end
	local nettable = RD.GetNetTable(ent.netid)
	local info = {}
	--info.resources = table.Copy(nettable.resources)
	local entids = {}
	if table.Count(nettable.entities) > 0 then
		for k, v in pairs(nettable.entities) do
			table.insert(entids, v:EntIndex())
		end
	end
	local cons = {}
	if table.Count(nettable.cons) > 0 then
		for k, v in pairs(nettable.cons) do
			local nettab = RD.GetNetTable(v)
			if nettab and table.Count(nettab) > 0 and nettab.nodeent and IsValid(nettab.nodeent) then
				table.insert(cons, nettab.nodeent:EntIndex())
			end
		end
	end
	info.entities = entids
	info.cons = cons
	if info.entities then
		duplicator.ClearEntityModifier( ent, "RDDupeInfo" )
		duplicator.StoreEntityModifier( ent, "RDDupeInfo", info )
	end
end

--apply the DupeInfo
function RD.ApplyDupeInfo( ent, CreatedEntities )
	if (ent.EntityMods) and (ent.EntityMods.RDDupeInfo) and (ent.EntityMods.RDDupeInfo.entities) then
		local RDDupeInfo = ent.EntityMods.RDDupeInfo
		if RDDupeInfo.entities and table.Count(RDDupeInfo.entities) > 0 then
			for _,ent2ID in pairs(RDDupeInfo.entities) do
				local ent2 = CreatedEntities[ ent2ID ]
				if ent2 and ent2:IsValid() then
					RD.Link(ent2, ent.netid)
				end
			end
		end
		if RDDupeInfo.cons and table.Count(RDDupeInfo.cons) > 0 then
			for _,ent2ID in pairs(RDDupeInfo.cons) do
				local ent2 = CreatedEntities[ ent2ID ]
				if ent2 and ent2:IsValid() then
					RD.linkNodes(ent.netid, ent2.netid)
				end
			end
		end
		ent.EntityMods.RDDupeInfo = nil --trash this info, we'll never need it again
	elseif ent.EntityMods and ent.EntityMods.RDPumpDupeInfo and ent.EntityMods.RDPumpDupeInfo.node then
		--This entity is a pump and has a network to connect to 
		local ent2 = CreatedEntities[ ent.EntityMods.RDPumpDupeInfo.node ] --Get the new node entity
		if ent2 then
			ent:SetNetwork(ent2.netid)
			ent:SetResourceNode(ent2)
		end
	elseif ent.EntityMods and ent.EntityMods.RDValveDupeInfo and (ent.EntityMods.RDValveDupeInfo.node1 or ent.EntityMods.RDValveDupeInfo.node2 or ent.EntityMods.RDValveDupeInfo.node or ent.EntityMods.RDValveDupeInfo.ent) then
		--This entity is a valve and has networks to connect to
		
		--restore node1 connection
		if ent.EntityMods.RDValveDupeInfo.node1 then
			local ent2 = CreatedEntities[ ent.EntityMods.RDValveDupeInfo.node1 ]
			if ent2 then
				ent:SetNode1(ent2)
			end
		end
		
		--restore node2 connection
		if ent.EntityMods.RDValveDupeInfo.node2 then
			local ent3 = CreatedEntities[ ent.EntityMods.RDValveDupeInfo.node2 ] --Get the new node2 entity
			if ent3 then
				ent:SetNode2(ent3)
			end
		end
		
		--restore node connection
		if ent.EntityMods.RDValveDupeInfo.node then
			local ent2 = CreatedEntities[ ent.EntityMods.RDValveDupeInfo.node ]
			if ent2 then
				ent:SetNode(ent2)
			end
		end
		
		--restore ent
		if ent.EntityMods.RDValveDupeInfo.ent then
			local ent3 = CreatedEntities[ ent.EntityMods.RDValveDupeInfo.ent ] --Get the new entity
			if ent3 then
				ent:SetRDEntity(ent3)
			end
		end		
		
		--restore active state
		if ent.EntityMods.RDValveDupeInfo.active and ent.EntityMods.RDValveDupeInfo.active == 1 then
			ent:TurnOn()
		else
			ent:TurnOff()
		end
	end

	--restore any beams
	RD.Beam_dup_build( ent, CreatedEntities )
end



function RD.GetNetResourceAmount(netid, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getResourceAmount(resource)
end

function RD.GetResourceAmount(ent, resource)
	if not resource then return 0, "No resource given" end
	if not ent.rdobject then return 0, "Not a valid resource container" end
	return ent.rdobject:getResourceAmount(resource)
end

function RD.GetNetNetworkCapacity(netid, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getMaxResourceAmount(resource)
end

function RD.GetNetworkCapacity(ent, resource)
	if not resource then return 0, "No resource given" end
	local ent = SPACEBUILD:getDeviceInfo(netid)
	if not ent or not ent:isA("ResourceNetwork") then return 0, "Not a valid network" end
	return ent:getMaxResourceAmount(resource)
end

function RD.AddProperResourceName(resource, name)
	local registry = SPACEBUILD:getResourceRegistry()
	if not resource or not name then return end
	local resObj = registry:getResourceInfoFromName(resource)
	if not resObj then error("Use SPACEBUILD:getResourceRegistry():registerResourceInfo(UNIQUE_ID, resource , name, ATTRIBUTES) instead.") end
end

function RD.GetProperResourceName(resource)
	local registry = SPACEBUILD:getResourceRegistry()
	if not resource then return end
	local resObj = registry:getResourceInfoFromName(resource)
	return resObj:getDisplayName()
end


-----------------------------------------
--START BEAMS BY MADDOG
-----------------------------------------

--Name: RD.Beam_settings
--Desc: Sends beam info to the clientside.
--Args:
--	beamMaterial -  the material to use (defualt cable/cable2)
--	beamSize - the size of the beam, design 2
--	beamColor - the beam color (default: Color(255, 255, 255, 255)
function RD.Beam_settings( ent, beamMaterial, beamSize, beamColor )
	--get beam color
	local beamR, beamG, beamB, beamA = beamColor.r or 255, beamColor.g or 255, beamColor.b or 255, beamColor.a or 255

	--send beam info to ent/clientside
	ent:SetNWString( "BeamInfo", ((beamMaterial or "cable/cable2") .. ";" .. tostring(beamSize or 2) .. ";" .. tostring(beamR or 255) .. ";" .. tostring(beamG or 255) .. ";" .. tostring(beamB or 255) .. ";" .. tostring(beamA or 255)) )
end

--Name: RD.Beam_add
--Desc: Add a beam to a ent
--Args:
--	sEnt: The ent to save the beam to
--	eEnt: The entity to base the vector off
--	beamVec: The local vector (based on eEnt) to place the beam
function RD.Beam_add(sEnt, eEnt, beamVec)
	--get how many beams there currently are
	local iBeam = (sEnt:GetNWInt( "Beams" ) or 0) + 1

	--send beam data
	--clicked entity
	sEnt:SetNWEntity( "BeamEnt" .. tostring(iBeam), eEnt )
	--clicked local vector
	sEnt:SetNWVector( "Beam" .. tostring(iBeam), beamVec or Vector(0, 0, 0) )
	--how many beams (points)
	sEnt:SetNWInt( "Beams", iBeam )
end

--Name: RD.Beam_switch
--Desc: Switches the beam settings from one ent to another.
--Args:
--	Ent1: The ent to get the current beams from
--	Ent2: Where to send the beam settings to
function RD.Beam_switch( Ent1, Ent2 )
	--transfer beam data
	Ent2:SetNWString( "BeamInfo", Ent1:GetNWString( "BeamInfo" ))

	--loop through all beams
	for i=1, Ent1:GetNWInt( "Beams" ) do
		--transfer beam data
		Ent2:SetNWVector("Beam"..tostring(i), Ent1:GetNWVector( "Beam"..tostring(i) ))
		Ent2:SetNWEntity("BeamEnt"..tostring(i), Ent1:GetNWEntity( "BeamEnt" .. tostring(i) ))
	end

	--how many beam points
	Ent2:SetNWInt( "Beams", Ent1:GetNWInt( "Beams" ) )

	--set beams to zero
	Ent1:SetNWInt( "Beams", 0 )
end

--Name: RD.Beam_clear
--Desc: Sets beams to zero to stop from them rendering
--Args:
--	ent - the ent to clean the beams from
function RD.Beam_clear( ent )
	ent:SetNWInt( "Beams", 0 )
end

--Name: Rd.Beam_get_table
--Desc: Used to return a table of beam info for adv dup support
--Args:
--	ent - the ent to get the beam info from
function RD.Beam_dup_save( ent )
	--the table to return
	local beamTable = {}
	duplicator.ClearEntityModifier( ent, "RDBeamDupeInfo")

	--amount of beams to draw
	beamTable.Beams = ent:GetNWInt( "Beams" )

	--if we have beams, then create them
	if beamTable.Beams and beamTable.Beams ~= 0 then
		--store beam info
		beamTable.BeamInfo = ent:GetNWString("BeamInfo")

		--loop through all beams
		for i=1,beamTable.Beams do
			--store beam vector
			beamTable["Beam" .. tostring(i)] = ent:GetNWVector( "Beam" .. tostring(i) )
			--store beam entity
			beamTable["BeamEnt" .. tostring(i)] = ent:GetNWEntity( "BeamEnt" .. tostring(i) ):EntIndex()
		end
	else
		return	--no beams to save
	end

	--store beam table into duplicator
	duplicator.StoreEntityModifier( ent, "RDBeamDupeInfo", beamTable )
end

--Name: Rd.Beam_set_table
--Desc: Sets beams from a table
--Args:
--	ent - the ent to get the beam info from
function RD.Beam_dup_build( ent, CreatedEntities )
	--exit if no beam dup info
	if not ent.EntityMods or not ent.EntityMods.RDBeamDupeInfo then return end

	--get the beam info table
	local beamTable = ent.EntityMods.RDBeamDupeInfo

	--transfer beam data
	ent:SetNWString( "BeamInfo", beamTable.BeamInfo)

	--loop through all beams
	for i=1, beamTable.Beams do
		--transfer beam data
		ent:SetNWVector("Beam"..tostring(i), beamTable["Beam"..tostring(i) ])
		ent:SetNWEntity("BeamEnt"..tostring(i), CreatedEntities[ beamTable[ "BeamEnt" .. tostring(i) ] ])
	end

	--how many beam points
	ent:SetNWInt( "Beams", beamTable.Beams )
end

-----------------------------------------
--END BEAMS BY MADDOG
-----------------------------------------

--Alternate use code--
local hookcount = 0
function InputFromClientMenu(ply, cmd, args) --This is essentially a controlled ent_fire...I probably overcomplicated it a fuckton right there just too add in that 4th argument. T_T
	local ent = ents.GetByIndex(args[1])
	if not ent or (ent:GetPos():Distance(ply:GetPos()) > 750) then ply:ChatPrint("You cannot perform that action.") return end
	if not ent.InputsBeingTriggered then ent.InputsBeingTriggered = {} end
	local input = args[2]
	if not ent.InputsBeingTriggered[input] then ent.InputsBeingTriggered[input] = {} end
	local valuez = args[3]
	if args[4] and ent.InputsBeingTriggered[input].bool and ent.InputsBeingTriggered[input].bool == true and ent.InputsBeingTriggered[input].value and ent.InputsBeingTriggered[input].value == valuez and ent.InputsBeingTriggered[input].EndTime and ent.InputsBeingTriggered[input].EndTime == CurTime() + args[4]	then return end
	if ent.InputsBeingTriggered[input].hooknum then hook.Remove("Think","ButtonHoldThinkNumber"..ent.InputsBeingTriggered[input].hooknum) end
	if not args[4] or (args[4] and tonumber(args[4]) == 0) then
		ent:TriggerInput(input,tonumber(valuez))
	elseif tonumber(args[4]) == -1 then
		hook.Add("Think","ButtonHoldThinkNumber"..hookcount,function() if ent and ent:IsValid() then ent:TriggerInput(input,tonumber(valuez)) end end)
		ent.InputsBeingTriggered[input].bool = true
		ent.InputsBeingTriggered[input].value=valuez
		ent.InputsBeingTriggered[input].hooknum = hookcount
		ent.InputsBeingTriggered[input].EndTime = 0
		hookcount = hookcount + 1
	else
		hook.Add("Think","ButtonHoldThinkNumber"..hookcount,function() if ent and ent:IsValid() then ent:TriggerInput(input,tonumber(valuez)) end end)
		ent.InputsBeingTriggered[input].bool = true
		ent.InputsBeingTriggered[input].value=valuez
		ent.InputsBeingTriggered[input].hooknum = hookcount
		ent.InputsBeingTriggered[input].EndTime = CurTime()+args[4]
		timer.Simple(tonumber(args[4]),function() hook.Remove("Think","ButtonHoldThinkNumber"..hookcount) ent.InputsBeingTriggered[input].bool = false end)
		hookcount = hookcount + 1
	end
end
concommand.Add("send_input_selection_to_server", InputFromClientMenu)

function SwapUsage(ply,cmd,args)
	if not ply.useaction then ply.useaction = false end
	ply.useaction = not ply.useaction
end 
concommand.Add("RD_swap_use_key", SwapUsage)