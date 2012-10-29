--[[=================================
	Resource Distribution 2
	Rewritten by TAD2020
	Backcompat w/ Shanjaq's RD1
=================================]]

--global setting for links
RD_MAX_LINK_LENGTH = 2048
RD_EXTRA_LINK_LENGTH = 64

--	== Network Tables Structures ==
--	==== A New Method (TAD2020) ====
-- on ents:
--	ent.resources2links[]	-- list of ents this ent is linked to, indexed with ent_IDs
--	ent.resources2[]	-- table of resources infos on this ent, indexed with resID
--		.capacity	-- capacity for this res on this ent
--		.res_name	-- name of res
--		.resID		-- the resID again
--		.net			-- netID for network this ent is on. ID < 0 are local nets when ent is make and not linked to anything, used to cache any info for this ent while unlinked
--	Networks[]		-- local table of network info, indexed by netID
--		,ID			-- netID for this net
--		.amount		-- amount of this resource on this net
--		.max			-- capacity of this net
--		.res_name	-- name of the resource stored
--		.resID		-- resource ID
--		.ents		-- list of ents on this net, indexed by ent_IDs

local Resource_Types = { }
local Resource_Types_By_Name = { }
local RD2 = {} --local util functions
local next_resID = 1
local next_netID = 1
local Networks = {} --list of networks, nil didcarded ones and BeamNetVars.ClearNetAmount(  netID ) on the ID to remove it from net updates

--	==notes==
--BeamNetVars.SetNetAmount( net.ID, net.amount ) -- this updates client side of the ammount of res on this net
--ent.Entity:SetResourceNetID( net1.resID, net1.ID, true ) -- this tells the client side of the ent what net it is on


--
--	Save/Load local data tabels
--
local function RD2Save( save )
	local savetab					= {}
	savetab.Resource_Types			= Resource_Types
	savetab.Resource_Types_By_Name	= Resource_Types_By_Name
	savetab.next_resID				= next_resID
	savetab.next_netID				= next_netID
	savetab.Networks				= Networks
	saverestore.WriteTable( savetab, save )
end
local function RD2Restore( restore )
	local restoretab = saverestore.ReadTable( restore )
	Resource_Types			= restoretab.Resource_Types
	Resource_Types_By_Name	= restoretab.Resource_Types_By_Name
	next_resID				= restoretab.next_resID
	next_netID				= restoretab.next_netID
	Networks				= restoretab.Networks
end
saverestore.AddSaveHook( "RD2Save", RD2Save )
saverestore.AddRestoreHook( "RD2Save", RD2Restore )


--makes a new empty network. give entID as netID to make a new local net
function RD2.NewNet( resID, netID )
	local net = table.Copy(Resource_Types[ resID ])
	if (netID) then
		net.ID = -1 * ((netID * 100) + resID) -- make local netID -entID..resID (only allows for 99 resIDs, but that should be enough)
	else
		net.ID = next_netID
		next_netID = next_netID + 1
	end
	Networks[ net.ID ] = net
	BeamNetVars.SetNetAmount( net.ID, net.amount )
	return net
end

function RD2.GetNet( ent, resID )
	local restab = RD2.GetRes( ent, resID )
	if (restab and restab.net) then
		local net = Networks[ restab.net ]
		if net then return net end
	end
	return nil
end

function RD2.GetFactor( amount, max )
	local factor = 0
	if (max > 0) then --no zero division, no oh shi-
		factor = math.Clamp( (amount / max), 0, 1 ) --we can't be more than full or less than empty, lol
	end
	return factor
end

function RD2.GetNetFactor( net ) --factor of res on this net, used to refill new net
	return RD2.GetFactor( net.amount, net.max )
end

function RD2.RemoveNet( netID ) --deletes a net
	Networks[ netID ] = nil
	BeamNetVars.ClearNetAmount( netID ) --clears the net table to clients won't be sent this on join
end

function RD2.GetRes( ent, resID )
	if (not ent.resources2) then
		if ent:IsVehicle() then
			RD2.SetUpPod( ent )
		else
			Error("RD2: this ent "..tostring(ent).." does not have any resources!\n")
			return
		end
	end
	return ent.resources2[resID] --returns are restab, you get nil if it doesn't have that res
end

function RD2.MoveEntToNet( ent, net1, net2 ) --move ent from net2 to net1
	local restab = RD2.GetRes( ent, net1.resID )
	if (ent.is_valve) then --ent is a valve
		restab.nets[ net2.ID ] = nil
		restab.nets[ net1.ID ] = net1.ID
	else
		restab.net = net1.ID
		ent.Entity:SetResourceNetID( net1.resID, net1.ID, true )
	end
	net2.ents[ ent:EntIndex() ] = nil --remove ent from net2
	net1.ents[ ent:EntIndex() ] = ent --put ent on net1
end

function RD2.MoveNet( net1, net2 ) --moves res on net2 on to net1 then removes net2
	net1.max = net1.max + net2.max
	net1.amount = net1.amount + net2.amount
	RD2.RemoveNet( net2.ID )
	BeamNetVars.SetNetAmount( net1.ID, net1.amount )
end

function RD2.CombineNets( net1, net2 ) --puts everything on net2 on to net1 then removes net2
	for idx, ent in pairs(net2.ents) do
		RD2.MoveEntToNet( ent, net1, net2 )
	end
	RD2.MoveNet( net1, net2 )
end

function RD2.PutEntOnNet( ent, net1, net2 ) --like combine, but faster, puts one ent from a local net2 on to a normal net1
	RD2.MoveEntToNet( ent, net1, net2 )
	if (not ent.is_valve) then RD2.MoveNet( net1, net2 ) end --ent is not a valve
end

function RD2.PutEntsOnNewNet( resID, ent1, net1, ent2, net2 ) --puts two ents from their local nets on a normal net
	local net = RD2.NewNet(resID)
	RD2.MoveEntToNet( ent1, net, net1 )
	RD2.MoveEntToNet( ent2, net, net2 )
	if (not ent1.is_valve) then RD2.MoveNet( net, net1 ) end
	if (not ent2.is_valve) then RD2.MoveNet( net, net2 ) end
end

function RD2.RebuildNet( net, resID, ent, restab, list )
	list[ ent:EntIndex() ] = ent1
	
	if (ent.is_valve) then --ent is a valve
		restab.nets[ net.ID ] = net.ID
		net.ents[ ent:EntIndex() ] = ent
		return --links on the valve don't actually connect nets
	end
	
	net.max = net.max + restab.capacity
	net.ents[ ent:EntIndex() ] = ent
	restab.net = net.ID
	ent.Entity:SetResourceNetID( net.resID, net.ID, true )
	
	for _,ent2 in pairs(restab.links) do
		if (not net.ents[ ent2:EntIndex() ]) then --is this ent alread on this net?
			local restab2 = RD2.GetRes( ent2, resID )
			if (restab2) then --just to be sure that is does has this res still
				RD2.RebuildNet( net, resID, ent2, restab2, list ) --recurse
			end
		end
	end
end

function RD2.RebuildNets( resID, ents, factor ) --ents is list of entities to rebuild out from
	local out = {} --list of nets new made
	local list = {} --list of all ents linked, used to prevent inf. loop
	for _,ent in pairs(ents) do
		if (not list[ ent:EntIndex() ]) then --was this ent linked via another ent in a previous loop?
			local restab = RD2.GetRes( ent, resID )
			if (restab) then --this ent has this res
				local net = RD2.NewNet( resID )
				RD2.RebuildNet( net, resID, ent, restab, list )
				net.amount = math.Round(net.max * factor)
				BeamNetVars.SetNetAmount( net.ID, net.amount )
				out[ net.ID ] = net
			end
		end
	end
	return out
end

function RD2.ModifyNetAmount( net, amount )
	if (not net) then return 0 end
	
	local oldamount = net.amount
	net.amount = math.Clamp( (net.amount + amount), 0, net.max )
	BeamNetVars.SetNetAmount( net.ID, net.amount )
	
	return net.amount - oldamount
end

function RD2.GetJuncRes( ent1, class, ent2, recurse_res )
	if ((class == "res_pump") or (class == "res_valve") or (class == "res_junction")) then
		for resID,restab in pairs( ent2.resources2 ) do
			RD_AddResource(ent1, restab.res_name, 0)
			--Msg( "Adding " .. restab.res_name .. "\n" )
			recurse_res[resID] = restab.res_name
		end
	end
end

--Makes all linked pumps, valves and junctions connected together all share the same resources (TAD2020)
--This is a costly funciton when lots of junctions are linked
function RD2.RecurseJunc( ent, recurse_res, done )
	done = done or {}
	for ent1ID,ent1 in pairs(ent.resources2links) do
		if (not done[ent1]) then
			if (not ent1:IsValid()) then
				ent.resources2links[ent1ID] = nil
			else
				done[ent1] = ent1
				local ent1_class = ent1.Entity:GetClass()
				if ((ent1_class == "res_pump") or (ent1_class == "res_valve") or (ent1_class == "res_junction")) then
					for _, res in pairs( recurse_res ) do
						RD_AddResource(ent1, res, 0)
					end
					RD2.RecurseJunc(ent1, recurse_res, done)
				end
			end
		end
	end
end

function RD2.SetJuncRes( ent, class, recurse_res )
	if ((class == "res_pump") or (class == "res_valve") or (class == "res_junction")) then
		RD2.RecurseJunc( ent, recurse_res )
	end
end

function RD2.CheckEntsOnLink( ent1, ent2 )
	local Ent1_class = ent1:GetClass()
	local Ent2_class = ent2:GetClass()
	
	local recurse_res = {}
	RD2.GetJuncRes( ent1, Ent1_class, ent2, recurse_res )
	RD2.GetJuncRes( ent2, Ent2_class, ent1, recurse_res )
	RD2.SetJuncRes( ent1, Ent1_class, recurse_res )
	RD2.SetJuncRes( ent2, Ent2_class, recurse_res )
end

function RD2.GetCommonRes( ent1, ent2 )
	local commonres = {}
	for resID, restab in pairs( ent1.resources2 ) do
		if (ent2.resources2[resID]) then table.insert( commonres, resID ) end
	end
	return commonres
end


function RD2.SetUpPod( ent )
	if (LIFESUPPORT and LIFESUPPORT == 2) then
		Msg("pod registered: "..tostring(ent).."\n")
		LS_RegisterEnt(ent, "Pod")
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
	end
end


local function PrintTable2(t,tabs,dt,tn)
	tabs = tabs or 0
	dt = dt or {}
	tn = tn or 1
	dt[tostring(t)] = tn
	tn = tn + 1
	for k,v in pairs(t) do
		if type(v) == "table" then
			if not dt[tostring(v)] then
				Msg(string.rep("\t",tabs)..k.."\t=\t"..tostring(v).." t: "..tn.."\n")
				tn = PrintTable2(v,tabs+1,dt,tn)
			else
				Msg(string.rep("\t",tabs)..k.."\t=\t"..tostring(v).." t: "..dt[tostring(v)].."\n")
			end
		else
			Msg(string.rep("\t",tabs)..k.."\t=\t"..tostring(v).."\n")
		end
	end
	return tn
end

local function PrintTable1(t)
	Msg(tostring(t).." t: 1\n")
	return PrintTable2(t,1)
end

function RD_PrintResources(ent)
	if (not ent.resources2) then Msg("ent has no resources\n") return end
	Msg("=== ent.resources2 on "..tostring(ent).." ===\n")
	local tn = PrintTable1( ent.resources2 )
	Msg("num tables: "..tn.."\n=== networks ===\n")
	for resID, restab in pairs( ent.resources2 ) do
		if (ent.is_valve) then
			for netID,_  in pairs( restab.nets ) do
				Msg("=== net "..Networks[ netID ].res_name.." "..netID.." ===\n")
				local tn = PrintTable1(  Networks[ netID ] or {} )
				Msg("=== num tables: "..tn.." ===\n")
			end
		else
			Msg("=== net "..Networks[ restab.net ].res_name.." "..restab.net.." ===\n")
			local tn = PrintTable1( Networks[ restab.net ] or {} )
			Msg("=== num tables: "..tn.." ===\n")
		end
	end
	Msg("=========================\n")
end


--define a resource, it's anem and a unit name. going to add something later for special resource nets (like presure or something)
function RD2_DefineResource( resname, unit )
	if (Resource_Types_By_Name[resname]) then return Resource_Types_By_Name[resname] end
	
	local net = { }
	net.resID		= next_resID
	next_resID		= next_resID + 1
	net.res_name	= resname
	net.res_unit	= unit
	net.ID			= 0
	net.amount		= 0
	net.max			= 0
	net.ents		= {}
	Resource_Types[ net.resID ]		= net
	Resource_Types_By_Name[ resname ]	= net.resID
	
	BeamNetVars.SetResourceNames( net.resID, resname, unit, true )
	--Use these client side to get names
	--BeamNetVars.GetResourceName( id ) --from id
	--BeamNetVars.GetResourceNames() --gets whole table
	
	return net.resID
end

function EnumResource( resname ) --just a front for the above function
	return RD2_DefineResource( resname, "" )
end

--Adds a named resource with the specified storage capacity to the ent
function RD_AddResource( ent, resname, capacity )
	local resID				= EnumResource(resname)
	ent.resources2			= ent.resources2 or {}
	ent.resources2[resID]	= ent.resources2[resID] or {}
	ent.resources2links		= ent.resources2links or {}
	local restab			= RD2.GetRes( ent, resID )
	restab.links			= restab.links or {}
	local net				= RD2.GetNet( ent, resID )
	if (net) then
		local oldcapacity	= restab.capacity
		local diff			= capacity - oldcapacity
		net.max				= net.max + diff
		if (diff < 0) then	net.amount = math.Clamp( net.amount, 0, net.max ) end
	else
		local net			= RD2.NewNet(resID, ent:EntIndex())
		net.max				= capacity
		net.ents[ ent:EntIndex() ] = ent
		restab.net			= net.ID
	end
	restab.capacity			= capacity
	restab.resID			= resID
	restab.res_name			= resname
	if (ent.is_valve) then restab.nets = restab.nets or {} end
	
	ent.Entity:SetResourceNetID( resID, restab.net, true )
end

--Consumes a named resource from the entity
function RD_ConsumeResource( ent, res, amount )
	if not (ent and res and amount) then return end
	local resID = EnumResource(res)
	local net = RD2.GetNet( ent, resID )
	return (-1 * RD2.ModifyNetAmount( net, (-1 * amount) ))
end

--Replenishes a named resource on the entity by a specified amount
function RD_SupplyResource( ent, res, amount )
	if not (ent and res and amount) then return end
	local resID = EnumResource(res)
	local net = RD2.GetNet( ent, resID )
	return RD2.ModifyNetAmount( net, amount )
end


local PUMP_NONE = 0 --no pump installed
local PUMP_NO_POWER = 1 --pump has no power
local PUMP_READY = 2 --pump ready for connection
local PUMP_ACTIVE = 3 --pump on
local PUMP_RECEIVING = 4 --not used
local Pump_Energy_Increment = 5

-- RD_PumpResource: move a resource from one net to another one
-- pump (bool): true = res moves from net1 to net2. false = equlize both net to within a precent
-- rate: for pumps, how much of the resource is moved per tick
-- pump true and rate 0 make a one way check valve
-- returns amount moved from net1 to net2
function RD2_PumpResource( net1, net2, pump, rate, ispump )
	if (net1.ID == net2.ID) then return 0 end --dummy, we can't pump to our own net
	if (net1.max == net1.amount and net2.max == net2.amount) or (net1.amount == 0 and net2.amount == 0) then return 0 end --nothing to do
	
	--TODO: fix this code to work :V
	--[[local pullnet, pushnet = net1, net2
	if (pump and rate < 0) then pullnet, pushnet = net2, net1 end
	--local pullnetfactor = net1.amount / net1.max
	--local pushnetfactor = net2.amount / net2.max
	local pullnetfactor = RD2.GetNetFactor( net1 )
	local pushnetfactor = RD2.GetNetFactor( net1 )
	local pressure = pushnetfactor - pullnetfactor
	local take = math.min( (pushnet.max - pushnet.amount),  math.min( pullnet.amount, math.abs(rate) )) --how much we're going to move
	local energyused = 0
	
	if (pump and pressure < 0 and ispump) then --LS2 is installed and we has a pump
		if (LIFESUPPORT and LIFESUPPORT == 2) then
			local energyneeded = math.abs(math.floor(math.max(take, 50) / 100 * Pump_Energy_Increment))
			if (energyneeded >= 0) then --going to need energy to do this
				if (pullnet.res_name == "energy" and RD_GetResourceAmount(self, "energy") >= energyneeded + take)
				 or (pullnet.res_name ~= "energy" and RD_GetResourceAmount(self, "energy") >= energyneeded) then
					energyused = RD_ConsumeResource( self, "energy", energyneeded )
				else --not enough energy!!!
					return 0
				end
			end
		end
	elseif (not pump and pressure < 0) then --are we crazy, we can't pump that if we can't pump!
		return 0
	elseif (pressure > 0) then
		--local pullnetfactorafter = (net1.amount - take) / net1.max
		--local pushnetfactorafter = (net2.amount + take) / net2.max
		local pullnetfactorafter = RD2.GetFactor( (net1.amount - take), net1.max )
		local pushnetfactorafter = RD2.GetFactor( (net2.amount + take), net2.max )
		local pressureafter = pushnetfactorafter - pullnetfactorafter
		if (pressureafter < 0) then --shit, we can pump all of this
			if (pump and ispump) then
				if (LIFESUPPORT and LIFESUPPORT == 2) then --LS2 is installed and we has a pump
					local energyneeded = math.abs(math.floor(math.max(take * (pressureafter - pressure), 50) / 100 * Pump_Energy_Increment))
					if (energyneeded >= 0) then --going to need energy to do this
						if (pullnet.res_name == "energy" and RD_GetResourceAmount(self, "energy") >= energyneeded + take)
						 or (pullnet.res_name ~= "energy" and RD_GetResourceAmount(self, "energy") >= energyneeded) then
							energyused = RD_ConsumeResource( self, "energy", energyneeded )
						else --not enought energy!!!
							take = take * (pressure - pressureafter)
						end
					end
				end
			else
				take = take * (pressure - pressureafter)
			end
		end
	end
	
	
	local result = RD2.SupplyResource( pushnet, RD2.ConsumeResource( pullnet, take ) ) --pump
	
	if (rate > 0) then return result else return -1 * result end]]
	
	--TODO: fuckit, this will work for now
	if (pump and rate ~= 0) then
		local pullnet, pushnet = net1, net2
		if (rate < 0) then pullnet, pushnet = net2, net1 end
		if (pullnet.amount <= 0 or pushnet.amount >= pushnet.max) then return 0 end --net1 must have soemthing and net2 must have some room
		
		local take = math.min( (pushnet.max - pushnet.amount),  math.min( pullnet.amount, math.abs(rate) )) --how much we can take
		if (take <= 0) then return 0 end
		local result = RD2.ModifyNetAmount( pushnet, (-1 * RD2.ModifyNetAmount( pullnet, (-1 * take) )) ) --pump
		if (rate > 0) then return result else return -1 * result end
	else --equalize nets
		--local factor1 = net1.amount / net1.max
		--local factor2 = net2.amount / net2.max
		local factor1 = RD2.GetNetFactor( net1 )
		local factor2 = RD2.GetNetFactor( net1 )
		
		if (pump and rate == 0 and factor1  > factor2) or (not pump) then --one way or equalize
			local oldamount = net1.amount
			local factor = (net1.amount + net2.amount) / (net1.max + net2.max) --average factor
			net1.amount = math.Round(net1.max * factor)
			net2.amount = math.Round(net2.max * factor)
			BeamNetVars.SetNetAmount( net1.ID, net1.amount )
			BeamNetVars.SetNetAmount( net2.ID, net2.amount )
			return oldamount - net1.amount --change from net1 to net2
		end
	end
	return 0
end

function RD2_Pump( Socket, OtherSocket )
	if (Socket and OtherSocket) then
		local pump, rate = false, 100
		if (Socket.pump_active == 1) then
			local SocketStatus, SocketRate = Socket.pump_status, Socket.pump_rate
			if (SocketStatus <= PUMP_NO_POWER) then SocketRate = 0 end --don't pump if there's no power
			local OtherSocketStatus, OtherSocketRate = OtherSocket.pump_status, OtherSocket.pump_rate
			if (OtherSocketStatus <= PUMP_NO_POWER) then OtherSocketRate = 0 end --don't pump if there's no power
			rate = SocketRate - OtherSocketRate
			pump = (SocketStatus == PUMP_ACTIVE or SocketStatus == PUMP_NO_POWER or OtherSocketStatus == PUMP_ACTIVE or OtherSocketStatus == PUMP_NO_POWER)
		end
		
		--Msg("rate= "..rate.." pump= "..tostring(pump).."\n")
		local pusshed = 0 --this is the ammount we had to push past equilibrium
		for resID1, restab1 in pairs( Socket.resources2 ) do
			for resID2, restab2 in pairs( OtherSocket.resources2 ) do
				if ( resID1 == resID2 ) then 
					local net1 = RD2.GetNet( Socket, resID1 )
					local net2 = RD2.GetNet( OtherSocket, resID1 )
					
					--Msg("SocketStatus= "..SocketStatus.." OtherSocketStatus= "..OtherSocketStatus.."  "..tostring(pump).." rate= "..rate.." net1= "..net1.ID.." net2= "..net2.ID.."\n")
					
					pusshed = pusshed + RD2_PumpResource( net1, net2, pump, rate, (Socket.pump_active == 1) )
					
				end
			end
		end
		return pusshed
	end
	return 0
end


function RD2_EqualizeNets( ent )
	for resID,restab  in pairs( ent.resources2 ) do
		local amount, max = 0,0
		for _,netID in pairs( restab.nets ) do
			local net = Networks[ netID ]
			if (net == nil) then
				restab.nets[netID] = nil
			else
				amount = amount + net.amount
				max = max + net.max
			end
		end
		--if (max > 0) then factor = amount / max end
		local factor = RD2.GetFactor( amount, max )
		--Msg("amount= "..amount.." max= "..max.." factor= "..factor.."\n")
		for _,netID in pairs( restab.nets ) do
			local net = Networks[ netID ]
			--Msg("netID: "..netID.." net.max= "..net.max.." net.amount= "..net.amount)
			net.amount = math.Round(net.max * factor)
			BeamNetVars.SetNetAmount( net.ID, net.amount )
			--Msg(" after= "..net.amount.."\n")
		end
	end
end


--Returns true if device uses resource
function RD_CheckResource( ent, res )
	local resID = EnumResource(res)
	local check = RD2.GetRes( ent, resID )
	if (check) then return 1 end
	return 0
end

--Returns the amount of a named resource accessable to the entity
function RD_GetResourceAmount( ent, res )
	local resID = EnumResource(res)
	local net = RD2.GetNet( ent, resID )
	if (net) then return net.amount end
	return 0
end

--Returns the maximum storage capacity of a specified entity, disregarding the network size(for named resource only)
function RD_GetUnitCapacity( ent, res )
	local resID = EnumResource(res)
	local check = RD2.GetRes( ent, resID )
	if (check) then return check.capacity end
	return 0
end

--Returns the maximum storage capacity of an entire network accessable to the entity(for named resource only)
function RD_GetNetworkCapacity( ent, res )
	local resID = EnumResource(res)
	local net = RD2.GetNet( ent, resID )
	if (net) then return net.max end
	return 0
end

--Disables or Enables the passage of all resources through this device(0 = closed, 1 = open)
function RD_ValveState( ent, toggle )
	if (ent.is_valve) then
		if not (toggle == 0) then toggle = 1 end --open
		ent.valve_state = toggle
	end
end


function Dev_Link( ent1, ent2, LPos1, LPos2, material, color, width )
	
	if (ent1:IsVehicle()) then RD2.SetUpPod( ent1 ) end
	if (ent2:IsVehicle()) then RD2.SetUpPod( ent2 ) end
	
	if (not ent1 or not ent1.resources2) or (not ent2 or not ent2.resources2) then
		Error("Dev_link: One or both entities are not valid!\n")
		return
	end
	if (ent1.is_valve) and (ent2.is_valve) then
		Error("Dev_link: Valves cannot be linked to each other!\n")
		return
	end
	
	--only make beam if parameters call for it
	if (LPos1 and LPos2 and material and color and width) then
		RDbeamlib.MakeSimpleBeam( ent1, LPos1, ent2, LPos2, material, color, width )
	end
	
	ent1.resources2links = ent1.resources2links or {}
	ent2.resources2links = ent2.resources2links or {}
	
	RD2.CheckEntsOnLink( ent1, ent2 )
	
	--links to other ents on top level for dupe'n
	ent1.resources2links[ ent2:EntIndex() ] = ent2
	ent2.resources2links[ ent1:EntIndex() ] = ent1
	
	for _,resID in pairs( RD2.GetCommonRes( ent1, ent2 ) ) do
		local restab1 = RD2.GetRes( ent1, resID )
		local restab2 = RD2.GetRes( ent2, resID )
		--Msg("linking resID "..resID.."  net1= "..restab1.net.."  net2= "..restab2.net.."\n")
		
		restab1.links[ ent2:EntIndex() ] = ent2
		restab2.links[ ent1:EntIndex() ] = ent1
		
		local net1 = Networks[ restab1.net ]
		local net2 = Networks[ restab2.net ]
		
		local ent1localnet = false
		local ent2localnet = false
		if (net1.ID < 0) then ent1localnet = true end
		if (net2.ID < 0) then ent2localnet = true end
		
		if (ent1localnet and ent2localnet) then --both are on local nets, make net net and put both on
			--Msg("RD2 Link: making new net\n")
			RD2.PutEntsOnNewNet( resID, ent1, net1, ent2, net2 )
		elseif (not ent1localnet and ent2localnet) then --ent2 on local net, put it on ent1's net
			--Msg("RD2 Link: joining ent to net\n")
			RD2.PutEntOnNet( ent2, net1, net2 )
		elseif (ent1localnet and not ent2localnet) then --ent1 on local net, put it on ent2's net
			--Msg("RD2 Link: joining ent to net\n")
			RD2.PutEntOnNet( ent1, net2, net1 )
		elseif (not ent1localnet and not ent2localnet and net1.ID ~= net2.ID) then --both have own net, put net2 on net1 and remove net2
			--Msg("RD2 Link: combining 2 nets\n")
			RD2.CombineNets( net1, net2 )
		elseif (net1.ID == net2.ID) then --both are on the same net already, don't do anything more.
			--Msg("RD2 Link: redundant link made\n")
		end
	end
	
end


function Dev_Unlink_All( ent1 )
	RDbeamlib.ClearAllBeamsOnEnt( ent1 )
	
	if (not ent1 or not ent1.resources2) then
		Error("Dev_Unlink_All: Entity is not valid!\n")
		return
	end
	
	local ent1ID = ent1:EntIndex()
	
	for ent2ID,ent2 in pairs( ent1.resources2links or {} ) do
		ent2.resources2links[ ent1ID ] = nil
	end
	ent1.resources2links = {}
	
	for resID, restab1 in pairs( ent1.resources2 ) do
		local ents = restab1.links
		
		--remove this ent from links on other ents
		for _,ent2 in pairs(restab1.links) do
			local restab2 = RD2.GetRes( ent2, resID )
			restab2.links[ ent1ID ] = nil --remove ent1 from links
		end
		
		--remove links to other ents from this ent
		restab1.links = {}
		
		if (ent1.is_valve) then --ent is a valve
			restab1.nets = {}
		else
			local oldnet = RD2.GetNet( ent1, resID )
			local factor = RD2.GetNetFactor( oldnet )
			
			--kill our old net, we'll be making new ones
			RD2.RemoveNet( oldnet.ID )
			
			--put this ent back on it's own net
			local net = RD2.NewNet(resID, ent1:EntIndex())
			net.max = restab1.capacity
			net.amount = math.Round(net.max * factor)
			net.ents[ ent1ID ] = ent1
			restab1.net = net.ID
			BeamNetVars.SetNetAmount( net.ID, net.amount )
			ent1.Entity:SetResourceNetID( resID, net.ID, true )
			
			--build new nets for all connected ents
			local newnets = RD2.RebuildNets( resID, ents, factor )
			
			--[[Msg("=== new nets ===\n")
			PrintTable1(newnets)
			Msg("=== = ===\n")]]
		end
	end

end


function Dev_Unlink( ent1, ent2 )
	RDbeamlib.ClearBeam( ent1, ent2 )
	
	if (not ent1 or not ent1.resources2) or (not ent2 or not ent2.resources2) then
		Error("Dev_Unlink: One or both entities are not valid!\n")
		return
	end
	
	local ent1ID = ent1:EntIndex()
	local ent2ID = ent2:EntIndex()
	
	ent1.resources2links[ ent2ID ] = nil
	ent2.resources2links[ ent1ID ] = nil
	
	for resID, restab1 in pairs( ent1.resources2 ) do
		local restab2 = RD2.GetRes( ent2, resID )
		if (restab2) then
			local oldnet = RD2.GetNet( ent1, resID )
			local oldnet2 = RD2.GetNet( ent2, resID )
			
			if (ent1.is_valve) then --ent is a valve
				oldnet = oldnet2
				restab1.nets[ oldnet2.ID ] = nil
			elseif (ent2.is_valve) then --ent is a valve
				oldnet2 = oldnet
				restab2.nets[ oldnet.ID ] = nil
			end
			
			if (oldnet.ID ~= oldnet2.ID) then Error("Dev_Unlink: nets missmatch!!!\n") return end
			local factor = RD2.GetNetFactor( oldnet )
			
			--kill our old net, we'll be making new ones
			RD2.RemoveNet( oldnet.ID )
			
			--make list of all ents connected to these two
			local ents = {}
			for _,ent3 in pairs(restab1.links) do
				ents[ ent3:EntIndex() ] = ent3
			end
			for _,ent3 in pairs(restab2.links) do
				ents[ ent3:EntIndex() ] = ent3
			end
			
			--remove ents from eachothers links
			restab1.links[ ent2ID ] = nil
			restab2.links[ ent1ID ] = nil
			
			--build new nets for all connected ents
			local newnets = RD2.RebuildNets( resID, ents, factor )
			
			--[[Msg("=== new nets ===\n")
			PrintTable1(newnets)
			Msg("=== = ===\n")]]
		end
	end
	
end


--TAD2020: duplicator support
--build the DupeInfo table and save it as an entity mod
function RD_BuildDupeInfo( ent )
	if (not ent.resources2) then return end
	
	local info = {}
	info.devices = {}
	
	local beamtable = RDbeamlib.GetBeamTable( ent )
	info.beams = {}
	
	for ent2ID, ent2 in pairs( ent.resources2links ) do
		if ( ent2 and ent2:IsValid() ) then 
			table.insert(info.devices, ent2ID)
			
			if beamtable[ent2] then
				info.beams[ent2ID] = beamtable[ent2]
			end
		end
	end
	
	if info.devices then
		duplicator.StoreEntityModifier( ent, "RDDupeInfo", info )
	end
	
end

--apply the DupeInfo
function RD_ApplyDupeInfo( ent, CreatedEntities )
	if (ent.EntityMods) and (ent.EntityMods.RDDupeInfo) and (ent.EntityMods.RDDupeInfo.devices) then
		
		local RDDupeInfo = ent.EntityMods.RDDupeInfo
		
		for _,ent2ID in pairs(RDDupeInfo.devices) do
			local ent2 = CreatedEntities[ ent2ID ]
			
			if ent2 and ent2:IsValid() then
				
				if (RDDupeInfo.beams) and (RDDupeInfo.beams[ ent2ID ]) then
					Dev_Link(
						ent, ent2, 
						RDDupeInfo.beams[ ent2ID ].start_pos, 
						RDDupeInfo.beams[ ent2ID ].dest_pos, 
						RDDupeInfo.beams[ ent2ID ].material, 
						RDDupeInfo.beams[ ent2ID ].color, 
						RDDupeInfo.beams[ ent2ID ].width
					)
				else
					Dev_Link(ent, ent2)
				end
			end
		end
		
		ent.EntityMods.RDDupeInfo = nil --trash this info, we'll never need it again
		
	end
end	

function RD_AfterPasteMods(ply, Ent, DupeInfo)
	--doesn't need to do anything for now
end
--TAD2020: end duplicator support
