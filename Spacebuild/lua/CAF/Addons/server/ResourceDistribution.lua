local RD = {}
local nettable = {};
local ent_table = {};
local resourcenames = {}
local resources = {}

local status = false

local rd_cache = cache.create(1, true) --Store data for 1 second

--Local functions/variables

--Precache some sounds for snapping
for i=1,3 do
	util.PrecacheSound( "physics/metal/metal_computer_impact_bullet"..i..".wav" )
end
util.PrecacheSound( "physics/metal/metal_box_impact_soft2.wav" )

local nextnetid = 1;

--These functions send all needed info the client

--nettable
--[[local function CreateEmptyNetwork(netid, ply)
	umsg.Start("RD_AddNet", ply)
		umsg.Short(netid)
	umsg.End()
end

local function SendResoureDataToNetwork(netid, resource, maxvalue, value, ply)
	umsg.Start("RD_AddResoureToNet", ply)
		umsg.Short(netid)
		umsg.String(resource)
		umsg.Long(maxvalue)
		umsg.Long(value)
	umsg.End()
end

--Needed?
local function AddConToNetwork(netid, conid, ply)
	umsg.Start("RD_AddConToNet", ply)
		umsg.Short(netid)
		umsg.Short(conid)
	umsg.End()
end

--Needed?
local function ClearCons(netid, ply)
	umsg.Start("RD_RemoveNetCons", ply)
		umsg.Short(netid)
	umsg.End()
end

local function RemoveNetWork(netid, ply)
	umsg.Start("RD_RemoveNet", ply)
		umsg.Short(netid)
	umsg.End()
end

	--ent_table

local function CreateEmptyEntity(entid, ply)
	umsg.Start("RD_AddEnt", ply)
		umsg.Short(entid)
	umsg.End()
end

local function SendResoureDataToEntity(entid, resource, maxvalue, value, ply)
	umsg.Start("RD_AddResoureToEnt", ply)
		umsg.Short(entid)
		umsg.String(resource)
		umsg.Long(maxvalue)
		umsg.Long(value)
	umsg.End()
end

local function ChangeNetWorkOnEntity(entid, netid, ply)
	umsg.Start("RD_ChangeNetOnEnt", ply)
		umsg.Short(entid)
		umsg.Short(netid)
	umsg.End()
end

local function RemoveEnt(entid, ply)
	umsg.Start("RD_RemoveEnt", ply)
		umsg.Short(entid)
	umsg.End()
end]]

-- End: These functions send all needed info the client

--[[local function UpdateNetworksAndEntities()
	--Sentd ent_table first
	if table.Count(ent_table) ~= 0 then
		for k, v in pairs(ent_table) do
			if v.clear then
				RemoveEnt(k)
				ent_table[k] = nil
			elseif v.new then
				CreateEmptyEntity(k)
				if v.network ~= 0 then
					ChangeNetWorkOnEntity(k, v.network)
				end
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						SendResoureDataToEntity(k, l, w.maxvalue, w.value)
					end
				end
				v.new = false
				v.haschanged = false
			elseif v.haschanged then
				ChangeNetWorkOnEntity(k, v.network)
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						if w.haschanged then
							SendResoureDataToEntity(k, l, w.maxvalue, w.value)
							w.haschanged = false
						end
					end
				end
				v.haschanged = false
			end
		end
	end
	--now lets send the nettable
	if table.Count(nettable) ~= 0 then
		for k, v in pairs(nettable) do
			if v.clear then
				RemoveNetWork(k)
				nettable[k] = nil
			elseif v.new then
				CreateEmptyNetwork(k)
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						SendResoureDataToNetwork(k, l, w.maxvalue, w.value)
						w.haschanged = false
					end
				end
				if table.Count(v.cons) > 0 then
					for l, w in pairs(v.cons) do
						AddConToNetwork(k, w)
					end
				end
				v.new = false
				v.haschanged = false
			elseif v.haschanged then
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						if w.haschanged then
							SendResoureDataToNetwork(k, l, w.maxvalue, w.value)
							w.haschanged = false
						end
					end
				end
				ClearCons(k)
				if table.Count(v.cons) > 0 then
					for l, w in pairs(v.cons) do
						AddConToNetwork(k, w)
					end
				end
				v.haschanged = false
			end
		end
	end
end

local function SendEntireNetWorkToClient(ply)
	--Sentd ent_table first
	if table.Count(ent_table) ~= 0 then
		for k, v in pairs(ent_table) do
			if not v.clear then
				CreateEmptyEntity(k, ply)
				if v.network ~= 0 then
					ChangeNetWorkOnEntity(k, v.network, ply)
				end
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						SendResoureDataToEntity(k, l, w.maxvalue, w.value, ply)
					end
				end
			end
		end
	end
	--now lets send the nettable
	if table.Count(nettable) ~= 0 then
		for k, v in pairs(nettable) do
			if not v.clear then
				CreateEmptyNetwork(k, ply)
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						SendResoureDataToNetwork(k, l, w.maxvalue, w.value, ply)
					end
				end
				if table.Count(v.cons) > 0 then
					for l, w in pairs(v.cons) do
						AddConToNetwork(k, w, ply)
					end
				end
			end
		end
	end
end]]

local function sendEntityData(ply, entid, rddata)
	umsg.Start("RD_Entity_Data", ply)
		umsg.Short(entid) --send key to update
		umsg.Bool(false) --Update
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
end

local function sendNetworkData(ply, netid, rddata)
	umsg.Start("RD_Network_Data", ply)
		umsg.Short(netid) --send key to update
		umsg.Bool(false) --Update
		
		local nr_of_resources = table.Count(rddata.resources);
		umsg.Short(nr_of_resources) --How many resources are going to be send?
		if nr_of_resources > 0 then
			for l, w in pairs(rddata.resources) do
				umsg.String(l)
				umsg.Long(w.maxvalue)
				umsg.Long(w.value)
			end
		end
		
		local nr_of_cons = #rddata.cons;
		umsg.Short(nr_of_cons) --How many connections are going to be send?
		if nr_of_cons > 0 then
			for l, w in pairs(rddata.cons) do
				umsg.Short(w)
			end
		end
		
	umsg.End()
end

/*
function RD.GetEntityTable(ent)
	local entid = ent:EntIndex( )
	return ent_table[entid] or {}
end

function RD.GetNetTable(netid)
	return nettable[netid] or {}
end

*/

local function RequestResourceData(ply, com, args)
	if not args then ply:ChatPrint("RD BUG: You forgot to provide arguments") return end
	if not args[1] then ply:ChatPrint("RD BUG: You forgot to enter the type") return end
	if not args[2] then ply:ChatPrint("RD BUG: You forgot to enter the entid/netid") return end
	local data, tmpdata
	
	if args[1] == "ENT" then
		data = rd_cache:get("entity_"..args[2]);
		if not data then
			tmpdata = ent_table[tonumber(args[2])] 
			if not tmpdata then ply:ChatPrint("RD BUG: INVALID ENTID") return end
			data = {}
			data.network = tmpdata.network
			data.resources = {}
			for k, v in pairs(tmpdata.resources) do
				data.resources[k] = {value = RD.GetResourceAmount(tmpdata.ent, k), maxvalue = RD.GetNetworkCapacity(tmpdata.ent, k)}
			end
			rd_cache:add("entity_"..args[2], data)
		end
		sendEntityData(ply, tonumber(args[2]), data)
	elseif args[1] == "NET" then	
		data = rd_cache:get("network_"..args[2]);
		if not data then
			tmpdata = nettable[tonumber(args[2])] 
			if not tmpdata then ply:ChatPrint("RD BUG: INVALID NETID") return end
			data = {}
			data.resources = {}
			for k, v in pairs(tmpdata.resources) do
				data.resources[k] = {value = RD.GetNetResourceAmount(tonumber(args[2]), k), maxvalue = RD.GetNetNetworkCapacity(tonumber(args[2]), k)}
			end
			data.cons = {}
			for k, v in pairs(tmpdata.cons) do
				table.insert(data.cons, v)
			end
			rd_cache:add("network_"..args[2], data)
		end
		sendNetworkData(ply, tonumber(args[2]), data)
	else
		ply:ChatPrint("RD BUG: INVALID TYPE")
	end
end
concommand.Add( "RD_REQUEST_RESOURCE_DATA", RequestResourceData ) 





--Remove All Entities that are registered by RD, without RD they won't work anyways!
local function ClearEntities()
	if table.Count(ent_table) ~= 0 then
		for k, v in pairs(ent_table) do
			local ent = ents.GetByIndex( k );
			if ent and ValidEntity(ent) and ent ~= NULL then
				ent:Remove()
			end
		end
	end
end

local function ClearNets()
	umsg.Start("RD_ClearNets")
	umsg.End()
end

local function RD_Initial_Spawn( ply )
	--SendEntireNetWorkToClient(ply)
end

--End local functions

/**
	The Constructor for this Custom Addon Class
*/
function RD.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	nextnetid = 1
	ClearNets()
	ClearEntities()
	nettable = {};
	ent_table = {};
	CAF.AddHook("think3", UpdateNetworksAndEntities)
	hook.Add( "PlayerInitialSpawn", "RD_Initial_Spawn", RD_Initial_Spawn )
	for k, ply in pairs(player.GetAll( )) do
		SendEntireNetWorkToClient(ply)
	end
	CAF.AddServerTag("RD")
	status = true
	return true
end

/**
	The Destructor for this Custom Addon Class
*/
function RD.__Destruct()
	if not status then return false , CAF.GetLangVar("This Addon is already disabled!") end
	nextnetid = 1
	ClearNets()
	ClearEntities()
	nettable = {};
	ent_table = {};
	CAF.RemoveHook("think3", UpdateNetworksAndEntities)
	hook.Remove( "PlayerInitialSpawn", "RD_Initial_Spawn")
	CAF.RemoveServerTag("RD")
	status = false
	return true
end

/**
	Get the required Addons for this Addon Class
*/
function RD.GetRequiredAddons()
	return {}
end

/**
	Get the Boolean Status from this Addon Class
*/
function RD.GetStatus()
	return status
end

/**
	Get the Version of this Custom Addon Class
*/
function RD.GetVersion()
	return 3.1, "Alpha"
end

/**
	Get any custom options this Custom Addon Class might have
*/
function RD.GetExtraOptions()
	return {}
end

/**
	Get the Custom String Status from this Addon Class
*/
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
	if not ent or not ValidEntity(ent) then return end
	if ent.IsNode then
		--RemoveNetWork(ent.netid)
		--nettable[ent.netid].clear = true
		nettable[ent.netid] = nil;
	elseif ent_table[ent:EntIndex()] then
		--RemoveEnt(ent:EntIndex())
		--ent_table[ent:EntIndex()].clear = true
		ent_table[ent:EntIndex()] = nil
	end
end

--[[
	RegisterNonStorageDevice( entity)
	
		Used to register non-storage Device ( devices that have a max of 0 for all resources)
		Add the to-display resources to the "list.Set( "LSEntOverlayText" , "generator_energy_fusion", {HasOOO = true, num = 2, resnames = {"nitrogen","heavy water"}} )" call specific for your Sent

]]
function RD.RegisterNonStorageDevice(ent)
	if not ValidEntity( ent ) then return false, "Not a valid entity" end
	if not ent_table[ent:EntIndex( )] then
		ent_table[ent:EntIndex()] = {}
		local index = ent_table[ent:EntIndex( )];
		index.resources = {}
		index.network = 0;
		index.clear = false
		index.haschanged = false;
		index.new = true;
		index.ent = ent
	elseif ent_table[ent:EntIndex( )].ent ~= ent then
		ent_table[ent:EntIndex()] = {}
		local index = ent_table[ent:EntIndex( )];
		index.resources = {}
		index.network = 0;
		index.clear = false
		index.haschanged = false;
		index.new = true;
		index.ent = ent
	end
end

--[[
	AddResource(entity, resource, maximum amount, default value)
		
		Add a resource to the Entity, you can use this for any amount, but it's recomended to only call this if your entity can store resources (max amount > 0 )
			Even if it requires multiple resources, registering the ones that can store resources is enough.
			
			Note: If your device doesn't store anything just use RegisterNonStorageDevice instead of this, it's more optimized for it
]]
function RD.AddResource(ent, resource, maxamount, defaultvalue)
	if not ValidEntity( ent ) then return false, "Not a valid entity" end
	if not resource then return false, "No resource given" end
	if not defaultvalue then defaultvalue = 0 end
	if not maxamount then maxamount = 0 end
	if not table.HasValue(resources, resource) then
		table.insert(resources, resource)
	end
	if ent_table[ent:EntIndex( )] and ent_table[ent:EntIndex( )].ent == ent then
		local index = ent_table[ent:EntIndex( )];
		if index.resources[resource] then
			if index.network ~= 0 then
				nettable[index.network].resources[resource].maxvalue = nettable[index.network].resources[resource].maxvalue - index.resources[resource].maxvalue;
				if nettable[index.network].resources[resource].value > nettable[index.network].resources[resource].maxvalue then
					nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].maxvalue;
				end
			end
		else
			index.resources[resource] = {}
		end
		index.resources[resource].maxvalue = maxamount
		index.resources[resource].value = defaultvalue
		index.resources[resource].haschanged = true
		if index.network ~= 0 then
			nettable[index.network].resources[resource].maxvalue = nettable[index.network].resources[resource].maxvalue + maxamount;
			nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].value + defaultvalue;
			if nettable[index.network].resources[resource].value > nettable[index.network].resources[resource].maxvalue then
				nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].maxvalue;
				nettable[index.network].resources[resource].haschanged = true
			end
		end
		index.haschanged = true;
	else
		 ent_table[ent:EntIndex()] = {}
		 local index = ent_table[ent:EntIndex( )];
		 index.resources = {}
		 index.resources[resource] = {}
		 index.resources[resource].maxvalue = maxamount;
		 index.resources[resource].value = defaultvalue;
		 index.network = 0;
		 index.clear = false
		 index.haschanged = false;
		 index.new = true;
		 index.ent = ent
	end
	return true
end

--[[
	AddNetResource(Netid, resource, maximum amount, default value)
		
		Add a resource to the network with the specified Netid, you can use this for any amount, but it's recomended to only call this if your entity can store resources (max amount > 0 )
			Even if it requires multiple resources, registering the ones that can store resources is enough.
			
			Note: If your device doesn't store anything just use RegisterNonStorageDevice instead of this, it's more optimized for it
]]
function RD.AddNetResource(netid, resource, maxamount, defaultvalue)
	if not netid or not nettable[netid] then return false, "Not a valid Network ID" end
	if not resource then return false, "No resource given" end
	if not defaultvalue then defaultvalue = 0 end
	if not maxamount then maxamount = 0 end
	if maxamount < defaultvalue then defaultvalue = maxamount end
	if not table.HasValue(resources, resource) then
		table.insert(resources, resource)
	end
	local index = nettable[netid]
	if not index.resources[resource] then
		index.resources[resource] = {}
		index.resources[resource].maxvalue = maxamount
		index.resources[resource].value = defaultvalue
		index.resources[resource].haschanged = true
		index.haschanged = true
	else
		index.resources[resource].maxvalue = index.resources[resource].maxvalue + maxamount
		index.resources[resource].value = index.resources[resource].value + defaultvalue
		if index.resources[resource].value > index.resources[resource].maxvalue then
			index.resources[resource].value = index.resources[resource].maxvalue
		end
		index.resources[resource].haschanged = true
		index.haschanged = true
	end
	return true
end

--[[
	ConsumeNetResource( netid, resource, amount)
	
		Only use this if you got a special sent (like the Resource Pumps) which don't have direct netinfo stored
		
		This means not Registered using RegisterNonStorageDevice() or Addresource(), one you used those you definetly don't need to use this one (except for special cases)
		
		Returns the actual amount consumed!!

]]
function RD.ConsumeNetResource(netid, resource, amount)
	if not nettable[netid] then return 0, "Not a valid network" end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	local origamount = amount
	local consumed = 0;
	local index = {}
	index.network = netid
	if nettable[index.network] and nettable[index.network].resources and nettable[index.network].resources[resource]  then
		if nettable[index.network].resources[resource].maxvalue > 0 then
			if nettable[index.network].resources[resource].value >= amount then
				nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].value - amount
				nettable[index.network].resources[resource].haschanged = true
				nettable[index.network].haschanged = true
			elseif nettable[index.network].resources[resource].value > 0 then
				amount = nettable[index.network].resources[resource].value
				nettable[index.network].resources[resource].value = 0
				nettable[index.network].resources[resource].haschanged = true
				nettable[index.network].haschanged = true
			else
				amount = 0
			end
			consumed = amount
		end
	end
	if consumed ~= origamount then
		if table.Count(nettable[index.network].cons) > 0 then
			for k, v in pairs(RD.getConnectedNets(index.network)) do
				amount = origamount - consumed
				if v ~= index.network then
					if nettable[v] and nettable[v].resources and nettable[v].resources[resource]  then
						if nettable[v].resources[resource].maxvalue > 0 then
							if nettable[v].resources[resource].value >= amount then
								nettable[v].resources[resource].value = nettable[v].resources[resource].value - amount
								nettable[v].resources[resource].haschanged = true
								nettable[v].haschanged = true
							elseif nettable[v].resources[resource].value > 0 then
								amount = nettable[v].resources[resource].value
								nettable[v].resources[resource].value = 0
								nettable[v].resources[resource].haschanged = true
								nettable[v].haschanged = true
							else
								amount = 0
							end
							consumed = consumed + amount
							if (consumed >= origamount) then
								break;
							end
						end
					end
				end
			end
		end
	end
	return consumed
end

--[[
	ConsumeResource(entity, resource , amount)
	
		Use this to consume resource (if you call this from inside the entity use self where the entity needs to be)
		
		It will return the amount of resources actually consumed!!
]]

function RD.ConsumeResource(ent, resource, amount)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	if not amount then return 0, "No amount given" end
	local origamount = amount
	local consumed = 0;
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )];
		if index.network == 0 then
			if index.resources[resource] then
				if index.resources[resource].maxvalue > 0 then
					if index.resources[resource].value >= amount then
						index.resources[resource].value = index.resources[resource].value - amount
						index.resources[resource].haschanged = true
						index.haschanged = true
					elseif index.resources[resource].value > 0 then
						amount = index.resources[resource].value
						index.resources[resource].value = 0
						index.resources[resource].haschanged = true
						index.haschanged = true
					end
					consumed = amount;
				end
			end
		else
			consumed = RD.ConsumeNetResource(index.network, resource, amount)
		end
	end
	return consumed;
end

--[[
	SupplyNetResource(netid, resource, amount)
	
		Only use this if you got a special sent (like the Resource Pumps) which don't have direct netinfo stored
		
		This means not Registered using RegisterNonStorageDevice() or Addresource(), one you used those you definetly don't need to use this one (except for special cases)
	
		Returns the amount of resources it couldn't supply to the network (lack of storage fe)
	
]]
function RD.SupplyNetResource(netid, resource, amount)
	if not amount then return 0, "No amount given" end
	if not nettable[netid] then return amount, "Not a valid network" end
	if not resource then return amount, "No resource given" end
	local index = {}
	local left = amount
	index.network = netid
	if nettable[index.network] and nettable[index.network].resources and nettable[index.network].resources[resource]  then
		if nettable[index.network].resources[resource].maxvalue > nettable[index.network].resources[resource].value + amount then
			nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].value + amount
			amount = 0;
			nettable[index.network].haschanged = true
			nettable[index.network].resources[resource].haschanged = true
		elseif nettable[index.network].resources[resource].maxvalue > nettable[index.network].resources[resource].value then
			amount = nettable[index.network].resources[resource].maxvalue - nettable[index.network].resources[resource].value
			nettable[index.network].resources[resource].value = nettable[index.network].resources[resource].maxvalue
			nettable[index.network].haschanged = true
			nettable[index.network].resources[resource].haschanged = true
		end
		left = amount
	end
	if left > 0 then
		if table.Count(nettable[index.network].cons) > 0 then
			for k, v in pairs(RD.getConnectedNets(index.network)) do
				amount = left
				if v ~= index.network then
					if nettable[v] and nettable[v].resources and nettable[v].resources[resource]  then
						if nettable[v].resources[resource].maxvalue > nettable[v].resources[resource].value + amount then
							nettable[v].resources[resource].value = nettable[v].resources[resource].value + amount
							amount = 0;
							nettable[v].haschanged = true
							nettable[v].resources[resource].haschanged = true
						elseif nettable[v].resources[resource].maxvalue > nettable[v].resources[resource].value then
							amount = nettable[v].resources[resource].maxvalue - nettable[v].resources[resource].value
							nettable[v].resources[resource].value = nettable[v].resources[resource].maxvalue
							nettable[v].haschanged = true
							nettable[v].resources[resource].haschanged = true
						end
						left = amount
						if left <= 0 then
							break
						end
					end
				end
			end
		end
	end
	return left
end

--[[
	SupplyResource(entity, resource, amount)
		
		Supplies the network connected to the specific Entity (mostly self) the specific amount of resources
		
		Returns the amount of resources it couldn't store

]]
function RD.SupplyResource(ent, resource, amount)
	if not amount then return 0, "No amount given" end
	if not ValidEntity( ent ) then return amount, "Not a valid entity" end
	if not resource then return amount, "No resource given" end
	local left = 0;
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )];
		if index.network == 0 then
			if index.resources[resource] then
				if index.resources[resource].maxvalue > index.resources[resource].value + amount then
					index.resources[resource].value = index.resources[resource].value + amount
					index.haschanged = true
					index.resources[resource].haschanged = true
					amount = 0
				elseif index.resources[resource].maxvalue > index.resources[resource].value then
					amount = index.resources[resource].maxvalue - index.resources[resource].value
					index.resources[resource].value = index.resources[resource].maxvalue
					index.resources[resource].haschanged = true
					index.haschanged = true
				end
				left = amount;
			end
		else
			left = RD.SupplyNetResource(index.network, resource, amount)
		end
	end
	return left;
end

--[[
	Link(entity, netid)
	
		This function connects the specific (valid) entity to the specific (valid) network
		
		This is called by the Link tool(s)

]]
function RD.Link(ent, netid)
	RD.Unlink(ent) --Just to be sure
	if ent_table[ent:EntIndex( )] then
		if nettable[netid] then
			local index = ent_table[ent:EntIndex( )]
			local netindex = nettable[netid]
			for k, v in pairs(index.resources) do
				local resindex = netindex.resources[k]
				if not resindex then
					netindex.resources[k] = {}
					resindex = netindex.resources[k]
					resindex.maxvalue = 0
					resindex.value = 0
				end
				if index.resources[k].maxvalue > 0 then
					resindex.maxvalue = resindex.maxvalue + index.resources[k].maxvalue
					resindex.value = resindex.value + index.resources[k].value
				end
				resindex.haschanged = true
			end
			table.insert(netindex.entities, ent)
			index.network = netid
			index.haschanged = true
			netindex.haschanged = true
		end
	end
end

--[[
	Unlink(entity)
	
		This function unlinks the device from it's network
		
		This is called by the Link tool(s)

]]
function RD.Unlink(ent)
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )]
		if index.network ~= 0 then
			if nettable[index.network] then
				for k, v in pairs(index.resources) do
					if index.resources[k].maxvalue > 0 then
						local resindex = nettable[index.network].resources[k]
						local percent = resindex.value / resindex.maxvalue
						index.resources[k].value = index.resources[k].maxvalue * percent
						resindex.maxvalue = resindex.maxvalue - index.resources[k].maxvalue
						resindex.value = resindex.value - index.resources[k].value
						index.resources[k].haschanged = true
						resindex.haschanged = true
					end
				end
				index.haschanged = true
				nettable[index.network].haschanged = true
				for k, v in pairs(nettable[index.network].entities) do
					if v == ent then
						table.remove(nettable[index.network].entities, k)

						--remove beams
						RD.Beam_clear( ent )
						break
					end
				end
			end
			index.network = 0
		end
	end
end

--[[
	UnlinkAllFromNode( netid)
	
		This function disconnects all devices and network connection from the network with that specific netid
		
		This is called by the Link tool(s)

]]
function RD.UnlinkAllFromNode(netid)
	if nettable[netid] then
		for k, v in pairs(nettable[netid].cons) do
			/*for l, w in pairs(nettable[v].cons) do
				if w == netid then
					table.remove(nettable[v].cons, l)
					break
				end
			end
			table.remove(nettable[netid].cons, k)*/
			RD.UnlinkNodes(netid, v)
		end
		for l, w in pairs(nettable[netid].entities) do
			RD.Unlink(w)
			--table.remove(nettable[netid].entities, l)
		end
		/*for l, w in pairs(nettable[netid].resources) do
			w.value = 0
			w.maxvalue = 0
			w.haschanged = true
		end*/
		nettable[netid].haschanged = true
		return true
	end
	return false
end

--[[
	UnLinkNodes(netid, netid2)
	
		This function will break the link between these 2 networks
		
		This is called by the Link tool(s)

]]
function RD.UnlinkNodes(netid, netid2)
	if nettable[netid] and nettable[netid2] then
		for k, v in pairs(nettable[netid].cons) do
			if v == netid2 then
				table.remove(nettable[netid].cons, k)
			end
		end
		for k, v in pairs(nettable[netid2].cons) do
			if v == netid then
				table.remove(nettable[netid2].cons, k)
			end
		end
		nettable[netid].haschanged = true
		nettable[netid2].haschanged = true
		return true
	end
	return false
end

--[[
	linkNodes(netid, netid2)
	
		This function will create a link between these 2 networks
		
		This is called by the Link tool(s)

]]
function RD.linkNodes(netid, netid2)
	if netid and netid2 and netid == netid2 then return end
	if nettable[netid] and nettable[netid2] then
		if not table.HasValue(nettable[netid].cons, netid2) then
			table.insert(nettable[netid].cons, netid2)
			table.insert(nettable[netid2].cons, netid)
			nettable[netid].haschanged = true
			nettable[netid2].haschanged = true
			return true
		end
	end
	return false
end
--[[
nettable[netid] = {}
	nettable[netid].resources = {}
	nettable[netid].resources[resource] = {}
	nettable[netid].resources[resource] .value = value
	nettable[netid].resources[resource] .maxvalue = value
	nettable[netid].resources[resource].haschanged = true/false
	nettable[netid].entities = {}
	nettable[netid].haschanged = true/false
	nettable[netid].clear = true/false
	nettable[netid].new = true/false

]]

--[[
	CreateNetwork(entity)
	
		Used to register a Resource Node with the system
		
			Returns the id of the network
]]
function RD.CreateNetwork(ent)
	local nextid = nextnetid
	nextnetid = nextnetid + 1
	nettable[nextid] = {}
	local index = nettable[nextid]
	index.resources = {}
	index.entities = {}
	index.cons = {}
	index.haschanged = false
	index.clear = false
	index.new = true
	index.nodeent = ent
	return nextid
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
				duplicator.StoreEntityModifier( ent, "RDPumpDupeInfo", info )
			end
		end
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
			if nettab and table.Count(nettab) > 0 and nettab.nodeent and ValidEntity(nettab.nodeent) then
				table.insert(cons, nettab.nodeent:EntIndex())
			end
		end
	end
	info.entities = entids
	info.cons = cons
	if info.entities then
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
	end

	--restore any beams
	RD.Beam_dup_build( ent, CreatedEntities )
end



--[[ Shared stuff ]]


function RD.getConnectedNets(netid)
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
end


function RD.GetNetResourceAmount(netid, resource)
	if not nettable[netid] then return 0, "Not a valid network" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	local index = {}
	index.network = netid
	if table.Count(nettable[index.network].cons) > 0 then
		for k, v in pairs(RD.getConnectedNets(index.network)) do
			if nettable[v] and nettable[v].resources and nettable[v].resources[resource]  then
				amount = amount + nettable[v].resources[resource].value
			end
		end
	else
		if nettable[index.network].resources[resource] then
			amount = nettable[index.network].resources[resource].value
		end
	end
	return amount
end

function RD.GetResourceAmount(ent, resource)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )];
		if index.network == 0 then
			if index.resources[resource] then
				amount = index.resources[resource].value
			end
		else
			amount = RD.GetNetResourceAmount(index.network, resource)
		end
	end
	return amount
end

function RD.GetUnitCapacity(ent, resource)
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
end

function RD.GetNetNetworkCapacity(netid, resource)
	if not nettable[netid] then return 0, "Not a valid Network" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	local index = {}
	index.network = netid
	if table.Count(nettable[index.network].cons) > 0 then
		for k, v in pairs(RD.getConnectedNets(index.network)) do
			if nettable[v] and nettable[v].resources and nettable[v].resources[resource]  then
				amount = amount + nettable[v].resources[resource].maxvalue
			end
		end
	else
		if nettable[index.network].resources[resource] then
			amount = nettable[index.network].resources[resource].maxvalue
		end
	end
	return amount
end

function RD.GetNetworkCapacity(ent, resource)
	if not ValidEntity( ent ) then return 0, "Not a valid entity" end
	if not resource then return 0, "No resource given" end
	local amount = 0
	if ent_table[ent:EntIndex( )] then
		local index = ent_table[ent:EntIndex( )];
		if index.network == 0 then
			if index.resources[resource] then
				amount = index.resources[resource].maxvalue
			end
		else
			amount = RD.GetNetNetworkCapacity(index.network, resource)
		end
	end
	return amount
end

function RD.GetEntityTable(ent)
	local entid = ent:EntIndex( )
	return ent_table[entid] or {}
end

function RD.GetNetTable(netid)
	return nettable[netid] or {}
end

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
function RD.GetNetworkIDs()
	local ids = {}
	if table.Count(nettable) > 0 then
		for k, v in pairs(nettable) do
			if not v.clear then
				table.insert(ids, k)
			end
		end
	end
	return ids
end

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
	local beamR, beamG, beamB, beamA = beamColor.R or 255, beamColor.G or 255, beamColor.B or 255, beamColor.A or 255

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

	--amount of beams to draw
	beamTable.Beams = ent:GetNWInt( "Beams" )

	--if we have beams, then create them
	if beamTable.Beams & beamTable.Beams ~= 0 then
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
	if !ent.EntityMods or !ent.EntityMods.RDBeamDupeInfo then return end

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
	ply.useaction = !ply.useaction
end 
concommand.Add("RD_swap_use_key", SwapUsage)