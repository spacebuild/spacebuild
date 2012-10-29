AddCSLuaFile( "autorun/RDBeam_NetVars.lua" )

--[[--------------------------------------------------
--	===BeamVars===										--
--	==Client Side Beams Library==						--
--	Custom Networked Vars and Beams Module				--
--	Designed for use with								--
--	Resource Distribution and Wire mod					--
--	By: TAD2020											--
----------------------------------------------------]]

--[[
NOTES:
	BeamVars replaces the seperate BeamNetVars and RDbeamlib modules
	It combines their functions in to one send stack
	All seperate BeamNetVars and RDbeamlib modules need to not load
	This file is in need of clean up and re-org, part of that is under way in another branch
		-TAD2020
]]

--RD header for multi distro-ablity
local ThisBeamVarsVersion = 1.1
local ThisBeamNetVarsVersion = 0.82 --to make existing standalone versions not load
local ThisRDBeamLibVersion = 0.72 --to make existing standalone versions not load


if (BeamVars and BeamVars.Version and BeamVars.Version > ThisBeamVarsVersion) then
		Msg("======== A Newer Version of BeamVars Detected ========\n"..
			"======== This ver: "..ThisBeamVarsVersion.." or  Detected ver: "..BeamVars.Version.." or  Skipped Loading\n")
	return
elseif (BeamVars and BeamVars.Version and BeamVars.Version == ThisBeamVarsVersion) then
		Msg("======== The Same Version of BeamVars Detected or  Skipped Loading ========\n")
		return
elseif (BeamVars and BeamVars.Version) then
	Msg("======== Am Older Version of BeamVars Detected ========\n")
end


-- Stuff for BeamNetVars
BeamNetVars = {}
BeamNetVars.Version = ThisBeamNetVarsVersion
--	settings
local FLOATACCURACY = 1000 --sets accuracy of floats sent for use at text to 1/1000
local SHORTADJUST = 32769 --for making the umsg.shorts 1 to 65536
--	internal stuff
local Vector_Default 	= Vector(0,0,0)
local Angle_Default		= Angle(0,0,0)
local NetworkVars 			= {}
local NetworkFunction 	= {}
local DelayedUpdates 	= {}
local DelayedUpdatesNum = 0
local ExtraDelayedUpdates = {}
local NextCleanup = CurTime()


--	Stuff for RDbeamlib
RDbeamlib = {}
RDbeamlib.Version = ThisRDBeamLibVersion
--	All beam data is stored here
--Format is BeamData[ source_ent ][ dest_ent ]
local BeamData = {}
--Format is WireBeams[ wire_dev ].Inputs[ iname ].Nodes[ node_num ]
local WireBeams = {}



if (SERVER) then
	--we want this
	--sv_usermessage_maxsize = 1024
	game.ConsoleCommand( "sv_usermessage_maxsize 1024\n" )
end


local meta = FindMetaTable( "Entity" )
-- Return if there's nothing to add on to
if (!meta) then return end




local function AttemptToSwitchTables( Ent, EntIndex )
	if ( NetworkVars[ EntIndex ] == nil ) then return end
	-- We have an old entindex based entry! Move it over!
	NetworkVars[ Ent ] = NetworkVars[ EntIndex ]
	NetworkVars[ EntIndex ] = nil
end

local function GetNetworkTable( ent, name )
	if (type(ent) == "number" and ent < 0) then
		NetworkVars[ ent ] = NetworkVars[ ent ] or {}
		NetworkVars[ ent ][ name ] = NetworkVars[ ent ][ name ] or {}
		return NetworkVars[ ent ][ name ]
	end
	if ( CLIENT ) then
		if ( NextCleanup < CurTime() ) then
			NextCleanup	= CurTime() + 30
			for k, v in pairs( NetworkVars ) do
				if ( type( k ) ~= "number" and type( k ) ~= "string" ) then
					if ( !k:IsValid() ) then
						NetworkVars[ k ] = nil
					end
				end
			end
		end
	end
	if ( !NetworkVars[ ent ] ) then
		NetworkVars[ ent ] = {}
		-- This is the first time this entity has been created.
		-- Check whether we previously had an entindex based table
		if ( CLIENT and type( ent ) ~= "number" and type( ent ) ~= "string" ) then
			AttemptToSwitchTables( ent, ent:EntIndex() )
		end
	end
	NetworkVars[ ent ][ name ] = NetworkVars[ ent ][ name ] or {}
	--Msg("NetworkVars ent= "..tostring(ent).." name= "..tostring(name).." n= "..tostring(NetworkVars[ ent ][ name ]).."\n")
	return NetworkVars[ ent ][ name ]
end



--
--	checks if the source_ent and dest_ent are valid and will clear data as needed
--
local function SourceAndDestEntValid( source_ent, dest_ent )
	if (BeamData[ dest_ent ]) and (BeamData[ dest_ent ][ source_ent ]) then
		RDbeamlib.ClearBeam( dest_ent, source_ent )
	end
	if (source_ent) and (source_ent:IsValid()) then
		if (dest_ent) and (dest_ent:IsValid()) then
			return true
		elseif (BeamData[ source_ent ]) and (BeamData[ source_ent ][ dest_ent ]) then
			RDbeamlib.ClearBeam( source_ent, dest_ent )
		end
	elseif (BeamData[ source_ent ]) then
		RDbeamlib.ClearAllBeamsOnEnt( source_ent )
	end
	return false
end



local function SendNetworkUpdate( VarType, Index, Key, Value, Player )
	if(Player and not (Player:IsValid() and Player:IsPlayer())) then return end -- Be sure, Player is not a NULL-Entity, or the server will crash!
	
	if (!VarType or !Index or !Key or !Value) then return end
	
	--
	--Beams
	--
	if (VarType == "simple") then
		if (!SourceAndDestEntValid( Key.source_ent, Key.dest_ent )) then return end
		
		umsg.Start( "RcvRDBeamSimple", Player )
			--umsg.Entity(	Key.source_ent )
			--umsg.Entity(	Key.dest_ent )
			umsg.Short(	Key.source_ent:EntIndex() )
			umsg.Short(	Key.dest_ent:EntIndex() )
			umsg.Vector(	Value.start_pos or Vector(0,0,0) )
			umsg.Vector(	Value.dest_pos or Vector(0,0,0) )
			umsg.String(	Value.material )
			--umsg.Vector(	Value.colv )
			umsg.Short(		Value.color.r )
			umsg.Short(		Value.color.g )
			umsg.Short(		Value.color.b )
			umsg.Float(		Value.width )
		umsg.End()
		
	elseif (VarType == "clearbeam") then
		if (!SourceAndDestEntValid( Key.source_ent, Key.dest_ent )) then return end
		
		umsg.Start( "RcvRDClearBeam", Player )
			--umsg.Entity( Key.source_ent )
			--umsg.Entity( Key.dest_ent )
			umsg.Short( Key.source_ent:EntIndex() )
			umsg.Short( Key.dest_ent:EntIndex() )
		umsg.End()
		
	elseif (VarType == "clearallentbeams") then
		if (!Key.source_ent or !Key.source_ent:IsValid()) then return end
		
		umsg.Start( "RcvRDClearAllBeamsOnEnt", Player )
			--umsg.Entity( Key.source_ent )
			umsg.Short( Key.source_ent:EntIndex() )
		umsg.End()
		
	elseif (VarType == "wirestart") then
		--if (!info.wire_dev) or (!info.wire_dev:IsValid()) then return end
		
		umsg.Start( "RcvRDWireBeamStart", Player )
			--umsg.Entity(	Key.wire_dev )
			umsg.Short(		Key.wire_devIdx )
			--umsg.Entity(	info.Drawer )
			umsg.Short(		Key.iname )
			umsg.Vector(	Value.pos or Vector(0,0,0) )
			umsg.String(	Value.material or "" )
			umsg.Short(		Value.color.r )
			umsg.Short(		Value.color.g )
			umsg.Short(		Value.color.b )
			umsg.Float(		Value.width )
		umsg.End()
		
	elseif (VarType == "wirenode") then
		/*if (!info.wire_dev) or (!info.wire_dev:IsValid())
		or (!info.Drawer) or (!info.Drawer:IsValid())
		or (!beam_data.nodes[info.nodenum].ent) or (!beam_data.nodes[info.nodenum].ent:IsValid()) then return end*/
		
		umsg.Start( "RcvRDWireBeamNode", Player )
			--umsg.Entity(	Key.wire_dev )
			umsg.Short(		Key.wire_devIdx )
			--umsg.Entity(	info.Drawer )
			umsg.Short(		Key.iname )
			umsg.Short(		Key.nodenum )
			--umsg.Entity(	beam_data.nodes[Key.nodenum].ent )
			umsg.Short(		Key.node_entIdx )
			umsg.Vector(	Value.pos )
		umsg.End()
		
	elseif (VarType == "clearwirebeam") then
		
		umsg.Start( "RcvRDWireBeamClear", Player )
			--umsg.Entity( Key.wire_dev )
			umsg.Short( Key.wire_dev:EntIndex() )
			umsg.Short( Key.iname )
		umsg.End()
		
	elseif (VarType == "clearallwirebeam") then
		
		umsg.Start( "RcvRDWireBeamClearAll", Player )
			--umsg.Entity( Key.wire_dev )
			umsg.Short( Key.wire_dev:EntIndex() )
		umsg.End()
	
	--
	--RD2
	--
	elseif ( VarType == "OOO" ) then
		umsg.Start( "RcvEntityVarBeam_OOO", Player )
			umsg.Short( Index )
			umsg.Short( Value )
		umsg.End()
	
	elseif ( VarType == "NetInfo" ) then
		umsg.Start( "RcvEntityVarBeam_NetInfo", Player )
			umsg.Short( Key )
			umsg.Long( Value )
		umsg.End()
	
	elseif (VarType == "ResNames") then
		
		umsg.Start( "RcvEntityVarBeam_ResNames", Player )
			umsg.Short( Key )
			umsg.String( Value.name )
			umsg.String( Value.unit )
		umsg.End()
		
	elseif (VarType == "ResourceNetID") then
		
		umsg.Start( "RcvEntityVarBeam_ResourceNetID", Player )
			umsg.Short( Index )
			umsg.Short( Key )
			umsg.Short( Value )
		umsg.End()
	
	--
	--SB2
	--
	elseif (VarType == "StarInfo") then
		
		umsg.Start( "AddStar", Player )
			umsg.Short( Index ) --star.num
			umsg.Vector( Value.pos ) --star.pos
			umsg.Float( Value.radius ) --star.radius
		umsg.End()
		
	elseif (VarType == "PlanetInfo") then
		
		-- add to the planet list on the client.
		umsg.Start( "AddPlanet", Player )
			umsg.Vector( Value.pos )
			umsg.Float( Value.radius )
			umsg.Short( Key ) --planet.num
			if Value.Color == nil then
				umsg.Bool (false)
			else
				umsg.Bool( true )
				umsg.Short( Value.Color.AddColor_r )
				umsg.Short( Value.Color.AddColor_g )
				umsg.Short( Value.Color.AddColor_b )
				umsg.Short( Value.Color.MulColor_r )
				umsg.Short( Value.Color.MulColor_g )
				umsg.Short( Value.Color.MulColor_b )
				umsg.Float( Value.Color.Brightness )
				umsg.Float( Value.Color.Contrast )
				umsg.Float( Value.Color.Color )	
			end
			if Value.Bloom == nil then
				umsg.Bool(false)
			else
				umsg.Bool(true)
				umsg.Short( Value.Bloom.Col_r )
				umsg.Short( Value.Bloom.Col_g )
				umsg.Short( Value.Bloom.Col_b )
				umsg.Float( Value.Bloom.SizeX )
				umsg.Float( Value.Bloom.SizeY )
				umsg.Float( Value.Bloom.Passes )
				umsg.Float( Value.Bloom.Darken )
				umsg.Float( Value.Bloom.Multiply )
				umsg.Float( Value.Bloom.Color )	
			end
		umsg.End()
	
	--
	--BeamNetVars
	--
	else
		umsg.Start( "RcvEntityVarBeam_"..VarType, Player )
			umsg.Short( Index )
			umsg.String( Key )
			umsg[ NetworkFunction[VarType].SetFunction ]( Value )
		umsg.End()
	end
end





local function AddDelayedNetworkUpdate( VarType, Ent, Key, Value )
	if (Ent) and (VarType) then
		DelayedUpdates[Ent]					= DelayedUpdates[Ent] or {}
		DelayedUpdates[Ent][ VarType ]		= DelayedUpdates[Ent][ VarType ] or {}
		DelayedUpdates[Ent][ VarType ][Key]	= Value
		DelayedUpdatesNum					= DelayedUpdatesNum + 1
		
		if (ExtraDelayedUpdates[Ent])
		and (ExtraDelayedUpdates[Ent][VarType])
		and (ExtraDelayedUpdates[Ent][VarType][Key]) then
			ExtraDelayedUpdates[Ent][VarType][Key] = nil
		end
	end
end

local function AddExtraDelayedNetworkUpdate( VarType, Ent, Key, Value, Player )
	if (Ent) and (VarType) and (Key) then
		ExtraDelayedUpdates[Ent]						= ExtraDelayedUpdates[Ent] or {}
		ExtraDelayedUpdates[Ent][VarType]				= ExtraDelayedUpdates[Ent][VarType] or {}
		ExtraDelayedUpdates[Ent][VarType][Key]			= ExtraDelayedUpdates[Ent][VarType][Key] or {}
		ExtraDelayedUpdates[Ent][VarType][Key].Value	= Value
		ExtraDelayedUpdates[Ent][VarType][Key].Player	= Player
		--ExtraDelayedUpdatesNum = ExtraDelayedUpdatesNum + 1
	end
end



--
-- make all the ent.Get/SetNetworkedBeamVarCrap
--
local function AddNetworkFunctions( name, SetFunction, GetFunction, Default )

	NetworkFunction[ name ] = {}
	NetworkFunction[ name ].SetFunction = SetFunction
	NetworkFunction[ name ].GetFunction = GetFunction
	
	-- SetNetworkedBlah
	meta[ "SetNetworkedBeam" .. name ] = function ( self, key, value, urgent )
		
		key = tostring(key)
		
		-- The same - don't waste our time.
		if ( value == GetNetworkTable( self, name )[ key ] ) then return end
		
		-- Clients can set this too, but they should only really be setting it
		-- when they expect the exact same result coming over the wire (ie prediction)
		GetNetworkTable( self, name )[key] = value
			
		if ( SERVER ) then
			
			local Index = self:EntIndex()
			if (Index <= 0) then return end
		
			if ( urgent ) then
				SendNetworkUpdate( name, Index, key, value )
			else
				AddDelayedNetworkUpdate( name, Index, key, value )
			end
			
		end
		
	end
	
	meta[ "SetNWB" .. name ] = meta[ "SetNetworkedBeam" .. name ]
	
	-- GetNetworkedBlah
	meta[ "GetNetworkedBeam" .. name ] = function ( self, key, default )
	
		key = tostring(key)
		
		local out = GetNetworkTable( self, name )[ key ]
		if ( out ~= nil ) then return out end
		if ( default == nil ) then return Default end
		--default = default or Default

		return default
		
	end
	
	meta[ "GetNWB" .. name ] = meta[ "GetNetworkedBeam" .. name ]
	
	
	-- SetGlobalBlah
	_G[ "SetGlobalBeam"..name ] = function ( key, value, urgent ) 

		key = tostring(key)
	
		if ( value == GetNetworkTable( "G", name )[key] ) then return end
		GetNetworkTable( "G", name )[key] = value
			
		if ( SERVER ) then
			if ( urgent ) then
				SendNetworkUpdate( name, -1, key, value )
			else
				AddDelayedNetworkUpdate( name, -1, key, value )
			end
		end
		
	end
	
	
	-- GetGlobalBlah
	_G[ "GetGlobalBeam"..name ] = function ( key ) 

		key = tostring(key)
	
		local out = GetNetworkTable( "G", name )[key]
		if ( out ~= nil ) then return out end
		
		return Default
		
	end
	
	-- GetGlobalBlah
	_G[ "GetGlobalBeam"..name ] = function ( key ) 

		key = tostring(key)
	
		local out = GetNetworkTable( "G", name )[key]
		if ( out ~= nil ) then return out end
		
		return Default
		
	end
	
	if ( SERVER ) then
		-- Pool the name of the function.
		-- Makes it send a number representing the string rather than the string itself.
		-- Only do this with strings that you send quite a bit and always stay the same.
		umsg.PoolString( "RcvEntityBeamVar_"..name )
	end
	
	-- Client Receive Function
	if ( CLIENT ) then
		
		local function RecvFunc( m )
			local EntIndex 	= m:ReadShort()
			local Key		= m:ReadString()
			local Value		= m[GetFunction]( m )
			
			local IndexKey
			if ( EntIndex <= 0 ) then 
				IndexKey = "G"
			else
				IndexKey = Entity( EntIndex )
				-- No entity yet - store using entindex
				if ( IndexKey == NULL ) then IndexKey = EntIndex end
			end
			GetNetworkTable( IndexKey, name )[Key] = Value
			
			if (type(IndexKey) ~= "number") and (IndexKey.RecvBeamNetVar) and (IndexKey:IsValid()) then
				IndexKey:RecvBeamNetVar( name, Key, Value )
			end
			
		end
		usermessage.Hook( "RcvEntityVarBeam_"..name, RecvFunc )
		
	end
	
end

AddNetworkFunctions( "Vector", 	"Vector", 	"ReadVector", 	Vector_Default )
AddNetworkFunctions( "Angle", 	"Angle", 	"ReadAngle", 	Angle_Default )
AddNetworkFunctions( "Float", 	"Float", 	"ReadFloat", 	0 )
AddNetworkFunctions( "Int", 	"Short", 	"ReadShort", 	0 )
AddNetworkFunctions( "Entity", 	"Entity", 	"ReadEntity", 	NULL )
AddNetworkFunctions( "Bool", 	"Bool", 	"ReadBool", 	false )
AddNetworkFunctions( "String", 	"String", 	"ReadString", 	"" )


--stuff will be changed and moved later from here down

--	SetOOO (3 cap o's)
-- sets off/on/overdrive
meta[ "SetOOO" ] = meta.SetOOO or function ( self, value )
	if ( value == GetNetworkTable( self, "OOO" )[1] ) then return end
	
	GetNetworkTable( self, "OOO" )[1] = value
	
	if ( SERVER ) then
		local Index = self:EntIndex()
		SendNetworkUpdate( "OOO", Index, 1, value )
	end
	
end

meta[ "GetOOO" ] = meta.GetOOO or function ( self, default )
	local out = GetNetworkTable( self, "OOO" )[ 1 ]
	if ( out ~= nil ) then return out end
	return default or {}
end

if ( CLIENT ) then
local function RecvFunc( m )
	local EntIndex 	= m:ReadShort()
	local Value		= m:ReadShort()
	
	local IndexKey = Entity( EntIndex )
	if ( IndexKey == NULL ) then IndexKey = EntIndex end
	
	GetNetworkTable( IndexKey, "OOO" )[1] = Value
	
	if (type(IndexKey) ~= "number") and (IndexKey.RecvOOO) and (IndexKey:IsValid()) then
		IndexKey:RecvOOO(Value)
	end
	
end
usermessage.Hook( "RcvEntityVarBeam_OOO", RecvFunc )
end


--
-- SetNetworked NetInfo
--
if (SERVER) then
function BeamNetVars.SetNetAmount( net, value, priority )
	value = math.floor( value )
	if ( value == GetNetworkTable( -2, "NetInfo" )[ net ] ) then return end
	
	GetNetworkTable( -2, "NetInfo" )[ net ] = value
	
	if ( priority ) and ( priority > 0 ) then
		SendNetworkUpdate( "NetInfo", -2, net, value )
	elseif ( priority ) and ( priority < 0 ) then
		AddExtraDelayedNetworkUpdate( "NetInfo", -2, net, value )
	else
		AddDelayedNetworkUpdate( "NetInfo", -2, net, value )
	end
end
--
function BeamNetVars.ClearNetAmount( net )
	GetNetworkTable( -2, "NetInfo" )[ net ] = nil
end
end
-- GetNetworked ShortFloat
function BeamNetVars.GetNetAmount( net )
	if (!net or net == 0) then return 0 end
	return GetNetworkTable( -2, "NetInfo" )[ net ] or 0
end

--	Recvs ShortFloat
if ( CLIENT ) then
local function RecvFunc( m )
	local net 	= m:ReadShort()
	local Value	= m:ReadLong()
	
	GetNetworkTable( -2, "NetInfo" )[ net ] = Value
end
usermessage.Hook( "RcvEntityVarBeam_NetInfo", RecvFunc )
end


--list of resources keyed by name
local resnames = {}
local ResNamesPrint = {}
local ResNamesPrintByName = {}
local ResUnitsPrint = {}

if ( SERVER ) then
--
meta[ "SetResourceNetID" ] = function ( self, res, ID, urgent )
	--Msg("sv==SetResourceNetID "..tostring(self).." res= "..tostring(res).." id= "..tostring(ID).."\n")
	if ( ID == GetNetworkTable( self, "ResourceNetID" )[ res ] ) then return end
	GetNetworkTable( self, "ResourceNetID" )[res] = ID
	local Index = self:EntIndex()
	if ( urgent ) then
		SendNetworkUpdate( "ResourceNetID", Index, res, ID )
	else
		AddDelayedNetworkUpdate( "ResourceNetID", Index, res, ID )
	end
end
end
-- give a resouce id or name and get the ent's net's index
meta[ "GetResourceNetID" ] = function ( self, res )
	if (type(res) ~= "number") then res = resnames[res] end
	if (!res) then return 0 end
	local out = GetNetworkTable( self, "ResourceNetID" )[ res ]
	return out or 0
end
-- give a resouce id or name and get amount on that net
meta[ "GetResourceAmount" ] = function ( self, res )
	--Msg("res = "..tostring(res).."\n")
	if (type(res) ~= "number") then res = resnames[res] end
	--Msg("GetResourceAmount "..tostring(self).." res= "..tostring(res).."\n")
	if (!res) then return 0 end
	
	local nn = GetNetworkTable( self, "ResourceNetID" )[ res ]
	--local nn = self:GetNetworkedBeamInt( res.."net" )
	
	return BeamNetVars.GetNetAmount( nn )
end
-- give a resouce id or name and get amount on that net with units attached
meta[ "GetResourceAmountText" ] = function ( self, res )
	if (type(res) ~= "number") then res = resnames[res] end
	if (!res) then return 0 end
	local nn = GetNetworkTable( self, "ResourceNetID" )[ res ]
	return BeamNetVars.GetNetAmount( nn )..ResUnitsPrint[res]
end
meta[ "GetResourceAmountTextPrint" ] = function ( self, res )
	if (type(res) ~= "number") then res = resnames[res] end
	if (!res) then return "" end
	return ResNamesPrint[res]..self:GetResourceAmountText( self, res )
end
-- get all the ent's net's indexes keyed with the resource IDs
meta[ "GetResourceNetIDAll" ] = function ( self )
	return GetNetworkTable( self, "ResourceNetID" )
end
--  get all the ent's net's indexes keyed with the resource names
meta[ "GetResourceNetIDAllNamed" ] = function ( self )
	local rez = BeamNetVars.GetResourceNames() 
	local out = {}
	for k,v in pairs (GetNetworkTable( self, "ResourceNetID" )) do
		out[ rez[k].name ] = v
	end
	return out
end
-- get all amount of resouces on this ents nets key with resource names
meta[ "GetAllResourcesAmounts" ] = function ( self )
	local rez = BeamNetVars.GetResourceNames() 
	local amounts, units = {}, {}
	for k,v in pairs (GetNetworkTable( self, "ResourceNetID" )) do
		amounts[ rez[k].name ] = BeamNetVars.GetNetAmount( v )
		units[ rez[k].name ] =  rez[k].unit
	end
	return amounts, units
end
-- get all amount of resouces on this ents nets ready for overlay text readout
meta[ "GetAllResourcesAmountsText" ] = function ( self, GreaterThanOneOnly )
	local out = {}
	for k,v in pairs (GetNetworkTable( self, "ResourceNetID" )) do
		--Msg("k= "..k.." ("..type(k)..") v= "..v.."ResNamesPrint[k]= "..tostring(ResNamesPrint[k]).." BeamNetVars.GetNetAmount(v)= "..tostring(BeamNetVars.GetNetAmount(v)).."\n")
		local amount = BeamNetVars.GetNetAmount(v)
		if (!GreaterThanOneOnly) or (amount > 0) then
			table.insert( out, (ResNamesPrint[k] or "")..(amount or 0)..ResUnitsPrint[k] )
		end
	end
	local txt = table.concat(out, "\n")
	if txt == "" then txt = "-None-" end
	return txt
end
meta[ "GetNumOfResources" ] = function ( self, GreaterThanOneOnly )
	return table.Count(GetNetworkTable( self, "ResourceNetID" ))
end
if ( CLIENT ) then
local function RecvFunc( m )
	--Msg("RecvFunc\n")
	local EntIndex 	= m:ReadShort()
	local res		= m:ReadShort()
	local ID		= m:ReadShort()
	local IndexKey = Entity( EntIndex )
	if ( IndexKey == NULL ) then IndexKey = EntIndex end
	--Msg("cl==ResourceNetID "..tostring(IndexKey).." res= "..tostring(res).." id= "..tostring(ID).."\n")
	GetNetworkTable( IndexKey, "ResourceNetID" )[res] = ID	
end
usermessage.Hook( "RcvEntityVarBeam_ResourceNetID", RecvFunc )
end




function BeamNetVars.SetResourcePrintName( resname, printname )
	ResNamesPrintByName[ resname ] = printname
end
if ( SERVER ) then
-- Tell clients the names of resources and their IDs
function BeamNetVars.SetResourceNames( id, name, unit, urgent ) 
	local tab = {}
	tab.name = name
	tab.unit = unit
	GetNetworkTable( -4, "ResNames" )[id] = tab
	resnames[name] = id
	ResNamesPrint[id] = string.upper(string.sub(name,1,1)) .. string.sub(name,2) .. ": " --makes "air" in to "Air: " for overlaytext
	if ( unit and unit ~= "") then
		ResUnitsPrint[id] = " "..unit
	else
		ResUnitsPrint[id] = ""
	end
	if ( urgent ) then
		SendNetworkUpdate( "ResNames", -4, id, tab )
	else
		AddDelayedNetworkUpdate( "ResNames", -4, id, tab )
	end
end
end
-- returns the name from given id
function BeamNetVars.GetResourceName( id ) 
	local out = GetNetworkTable( -4, "ResNames" )[id]
	if ( out ~= nil ) then return out.name, out.unit end
	return "", ""
end
-- returns table of all name indexed by id
function BeamNetVars.GetResourceNames() 
	return GetNetworkTable( -4, "ResNames" ) or {}
end
if ( CLIENT ) then
local function RecvFunc( m )
	local id		= m:ReadShort()
	local name		= m:ReadString()
	local unit		= m:ReadString()
	local tab = {}
	tab.name = name
	tab.unit = unit
	GetNetworkTable( -4, "ResNames" )[id] = tab
	resnames[name] = id
	if not (ResNamesPrintByName[name] == nil) then
		ResNamesPrint[id] = ResNamesPrintByName[name]
	else
		ResNamesPrint[id] = string.upper(string.sub(name,1,1)) .. string.sub(name,2) .. ": " --makes "air" in to "Air: " for overlaytext
	end
	if ( unit and unit ~= "") then
		ResUnitsPrint[id] = " "..unit
	else
		ResUnitsPrint[id] = ""
	end
	Msg("resID= "..id.." name= "..name.." printname= "..ResNamesPrint[id].." 0 "..unit.."\n")
end
usermessage.Hook( "RcvEntityVarBeam_ResNames", RecvFunc )
end


if ( SERVER ) then
--
-- Updated SB2 planet info
--
function BeamNetVars.SB2UpdatePlanet( planet )
	--TODO: Check for change
	/*local currentvalue = GetNetworkTable( -11, "PlanetInfo" )[planet.num] or {}
	
	local nochange = true
	for k,v in pairs(planet) do
		if ( planet[k] ~= currentvalue[k] ) then
			nochange = false
		end
	end
	if ( nochange ) then return end*/
	
	GetNetworkTable( -11, "PlanetInfo" )[planet.num] = planet
	
	SendNetworkUpdate( "PlanetInfo", -11, planet.num, planet )
end
--
-- Updated SB2 star info
--
function BeamNetVars.SB2UpdateStar( star )
	--TODO: Check for change
	/*local currentvalue = GetNetworkTable( -11, "StarInfo" )[star.num] or {}
	
	local nochange = true
	for k,v in pairs(star) do
		if ( star[k] ~= currentvalue[k] ) then
			nochange = false
		end
	end
	if ( nochange ) then return end*/
	
	GetNetworkTable( -11, "StarInfo" )[star.num] = star
	
	SendNetworkUpdate( "StarInfo", -11, star.num, star )
end
end





----------------------------/
--	Server Side Functions
----------------------------/
if (SERVER) then
--
-- send the netvars queried in the stack
--
local NextBeamVarsDelayedSendTime = 0
local NormalOpMode = true
local function NetworkVarsSend()
	if (CurTime() >= NextBeamVarsDelayedSendTime) then
		
		if (NormalOpMode) and (DelayedUpdatesNum > 200) then
			Msg("========BeamVars leaving NormalOpMode | "..DelayedUpdatesNum.."\n")
			NormalOpMode = false
		elseif (!NormalOpMode) and (DelayedUpdatesNum < 150)  then
			Msg("========BeamVars returning NormalOpMode | "..DelayedUpdatesNum.."\n")
			NormalOpMode = true
		end
		
		
		if (DelayedUpdatesNum > 0) then
			for Index, a in pairs(DelayedUpdates) do
				for VarType, b in pairs(a) do
					for Key, Value in pairs(b) do
						--SendNetworkUpdate( VarType, Index, Key, Value )
						local NoFail, Result = pcall( SendNetworkUpdate, VarType, Index, Key, Value )
						if ( !NoFail ) then
							Error("BeamNetVars: SendNetworkUpdate send failed: "..tostring(Result).."\n")
						end
					end
				end
			end
			DelayedUpdatesNum = 0
			DelayedUpdates = {}
		end
		
		--we send one entity's ExtraDelayedUpdates each tick
		local i = 0
		for Index, a in pairs(ExtraDelayedUpdates) do
			for VarType, b in pairs(a) do
				for Key, data in pairs(b) do
					--SendNetworkUpdate( VarType, Index, Key, data.Value, data.Player )
					local NoFail, Result = pcall( SendNetworkUpdate, VarType, Index, Key, data.Value, data.Player )
					if ( !NoFail ) then
						Error("BeamNetVars: ExtraDelayedUpdates send failed: "..tostring(Result).."\n")
					end
				end
			end
			ExtraDelayedUpdates[Index] = nil
			i = i + 1
			if (i >= 2) then
				break
			end
		end
		
		if (!NormalOpMode) then
			NextBeamVarsDelayedSendTime = CurTime() +  .2
		else
			NextBeamVarsDelayedSendTime = CurTime() +  .1
		end
		
	end
end
hook.Add("Think", "NetBeamLib_Think", NetworkVarsSend)



----------------------------/
--	Player join stuff
----------------------------/
-- Sends all net vars to player
local function FullUpdateEntityNetworkVars( ply )
	Msg("==sending netbeamvar var data to "..tostring(ply).."\n")
	--Msg("\n===Size: "..table.Count(NetworkVars).."\n")
	for Ent, EntTable in pairs(NetworkVars) do
		for Type, TypeTable in pairs(EntTable) do
			for Key, Value in pairs(TypeTable) do
				local Index = Ent
				if ( type(Ent) ~= "string" and type(Ent) ~= "number") then
					Index = Ent:EntIndex()
				end
				--SendNetworkUpdate( Type, Index , Key, Value, ply )
				AddExtraDelayedNetworkUpdate( Type, Index , Key, Value, ply )
			end
		end
	end
end
-- Sends all beams to player
local function SendAllBeams( ply )
	Msg("==sending Beam data to "..tostring(ply).." ==\n")
	for source_ent, source_ent_table in pairs(BeamData) do
		for dest_ent, beam_data in pairs(source_ent_table) do
			
			local info			= {}
			info.type			= "simple"
			info.source_ent		= source_ent
			info.dest_ent		= dest_ent
			
			AddExtraDelayedNetworkUpdate( "simple", -3 , info, beam_data, ply )
		end
	end
	for wire_dev, wire_dev_table in pairs(WireBeams) do
		local Drawer = wire_dev_table.Drawer
		Msg("=====  "..tostring(wire_dev).."  =======\n")
		for iname, beam_data in pairs(wire_dev_table.Inputs) do
			
			local info			= {}
			info.type			= "wirestart"
			info.wire_dev		= wire_dev
			info.wire_devIdx	= wire_dev:EntIndex()
			info.iname			= beam_data.Idx
			
			AddExtraDelayedNetworkUpdate( "wirestart", -3 , info, beam_data, ply )
			
			for node_num, node_data in pairs(beam_data.nodes) do
				local info			= {}
				info.type			= "wirenode"
				info.wire_dev		= wire_dev
				info.wire_devIdx	= wire_dev:EntIndex()
				info.iname			= beam_data.Idx
				info.node_entIdx	= node_data.ent:EntIndex()
				info.nodenum		= node_num
				
				AddExtraDelayedNetworkUpdate( "wirenode", -3 , info, node_data, ply )
			end
			
		end
	end
end
-- Offset the sending of data a little after the player has join
local function DelayedFullUpdateEntityNetworkVars( ply )
	--Msg("==starting timer for sending var data to "..tostring(ply).."\n")
	/*timer.Simple(4, FullUpdateEntityNetworkVars, ply) // Broken since GMod 13 beta
	timer.Simple(7, SendAllBeams, ply)*/
	
	timer.Simple(4, function()
		FullUpdateEntityNetworkVars(ply)
	end)
	timer.Simple(7, function()
		SendAllBeams(ply)
	end)
	
	hook.Add("Think", "NetBeamLib_Think", NetworkVarsSend)
end
hook.Add( "PlayerInitialSpawn", "FullUpdateEntityNetworkBeamVars", DelayedFullUpdateEntityNetworkVars )
-- Allow players to resend them the data to themselves
concommand.Add( "networkbeamvars_SendAllNow", FullUpdateEntityNetworkVars )
concommand.Add( "RDBeamLib_SendAllEntityBeamVars",  SendAllBeams)



--
-- Listen out for dead entities so we can remove their vars
--
local function NetworkVarsCleanup( ent )
	NetworkVars[ ent ] = nil
end
hook.Add( "EntityRemoved", "NetworkBeamVarsCleanup", NetworkVarsCleanup )





----------------------------/
--	Save/Load hooks
----------------------------/
-- Save net vars to file
local function Save( save )
	-- Remove baggage
	for k, v in pairs(NetworkVars) do
		if ( k == NULL ) then
			NetworkVars[k] = nil
		end
	end
	saverestore.WriteTable( NetworkVars, save )
end
local function Restore( restore )
	NetworkVars = saverestore.ReadTable( restore )
	--PrintTable(NetworkVars)
end
saverestore.AddSaveHook( "EntityNetworkedBeamVars", Save )
saverestore.AddRestoreHook( "EntityNetworkedBeamVars", Restore )
--	includes the local BeamData in the save file
local function RDSave( save )
	-- Remove baggage
	for k, v in pairs(BeamData) do
		if ( k == NULL ) then
			BeamData[k] = nil
		else
			for k2, v2 in pairs(v) do
				if ( k2 == NULL ) then
					BeamData[k][k2] = nil
				end
			end
		end
	end
	saverestore.WriteTable( BeamData, save )
end
local function RDRestore( restore )
	BeamData = saverestore.ReadTable( restore )
end
local function WireSave( save )
	-- Remove baggage
	for k, v in pairs(WireBeams) do
		if ( k == NULL ) then
			WireBeams[k] = nil
		end
	end
	saverestore.WriteTable( WireBeams, save )
end
local function WireRestore( restore )
	WireBeams = saverestore.ReadTable( restore )
end
saverestore.AddSaveHook( "EntityRDBeamVars", RDSave )
saverestore.AddRestoreHook( "EntityRDBeamVars", RDRestore )
saverestore.AddSaveHook( "EntityRDWireBeamVars", WireSave )
saverestore.AddRestoreHook( "EntityRDWireBeamVars", WireRestore )




----------------------------/
--	RDbeamlib Server Side Stuff
----------------------------/

--	checks the links' lengths and breaks if they're too long
--		TODO: this should make some kinda snapping noise when the link is borken
for i=1,3 do
	util.PrecacheSound( "physics/metal/metal_computer_impact_bullet"..i..".wav" )
end
util.PrecacheSound( "physics/metal/metal_box_impact_soft2.wav" )
function RDbeamlib.CheckLength( source_ent )
	if ( BeamData[ source_ent ] ) then
		for dest_ent, beam_data in pairs( BeamData[ source_ent ] ) do
			if (dest_ent:IsValid()) then
				local length = ( dest_ent:GetPos() - source_ent:GetPos() ):Length()
				if  ( length > (beam_data.Length or RD_MAX_LINK_LENGTH or 2048) ) then
					if ( (beam_data.LengthOver or 0) > 4 )
					or ( length > (RD_MAX_LINK_LENGTH or 2048) )
					or ( length > (beam_data.Length or RD_MAX_LINK_LENGTH or 2048) + ((RD_EXTRA_LINK_LENGTH or 64) * 1.5) ) then
						source_ent:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500) 
						dest_ent:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500)
						Dev_Unlink(source_ent, dest_ent)
					else
						beam_data.LengthOver = (beam_data.LengthOver or 0) + 1
						local vol = 30 * beam_data.LengthOver
						source_ent:EmitSound("physics/metal/metal_box_impact_soft2.wav", vol) 
						dest_ent:EmitSound("physics/metal/metal_box_impact_soft2.wav", vol)
					end
				elseif ( beam_data.LengthOver ) and ( beam_data.LengthOver > 0 ) then
					beam_data.LengthOver = 0
				end
			else
				RDbeamlib.ClearBeam( source_ent, dest_ent )
			end
		end
	end
end


--
--	for duplicating
--
function RDbeamlib.GetBeamTable( source_ent )
	return BeamData[ source_ent ] or {}
end


--
--	function to spam all the BeamData the server has
--
local function spamBeamData()
	Msg("\n\n================= BeamData ======================\n\n")
	/*	PrintTable(BeamData)
	Msg("\n=============== end BeamData ==================\n")*/
	Msg("===BeamData Size: "..table.Count(BeamData).."\n")
	Msg("\n\n================= WireBeams ======================\n\n")
	/*	PrintTable(WireBeams)
	Msg("\n=============== end WireBeams ==================\n")*/
	
	for wire_dev,beam_data in pairs(WireBeams) do
		Msg("wire_dev= "..tostring(wire_dev).."\n")
		for iname,beam in pairs(beam_data.Inputs) do
			Msg("\tiname= "..iname.."\tnodesize= "..table.Count(beam.Nodes or {}).."\n")
		end
	end
	
	Msg("===WireBeams Size: "..table.Count(WireBeams).."\n")
end
concommand.Add( "RDBeamLib_PrintBeamData", spamBeamData )




--just in case the duplicator gets a hold of a drawer
duplicator.RegisterEntityClass("Beam_Drawer", function() return end, "pl" )


end --end SERVER olny






--
--	Get the beam drawer or make one if none
--
local function GetDrawer( source_ent, NoCheckLength )
	if (SERVER) and ( !source_ent.RDbeamlibDrawer ) then
		Drawer = ents.Create( "Beam_Drawer2b" )
		Drawer:SetPos( source_ent:GetPos() )
		Drawer:SetAngles( source_ent:GetAngles() )
		Drawer:SetParent( source_ent )
		Drawer:Spawn()
		Drawer:Activate()
		source_ent:DeleteOnRemove( Drawer )
		Drawer:SetEnt( source_ent, not NoCheckLength )
		source_ent.RDbeamlibDrawer = Drawer
		source_ent.Entity:SetNetworkedEntity( "RDbeamlibDrawer", Drawer )
	end
	return source_ent.RDbeamlibDrawer
end
--	Set up the drawer for ent to ent beams
--	reuse the an existing drawer or make one
--	either ent can have the drawer, it doesn't matter
local function SetUpDrawer( source_ent, start_pos, dest_ent, dest_pos, NoCheckLength )
	/*local Drawer
	if (SERVER) and ( !source_ent.RDbeamlibDrawer ) and ( !dest_ent.RDbeamlibDrawer ) then
		Drawer = GetDrawer( source_ent, NoCheckLength )*/
	if (SERVER) and ( !source_ent.RDbeamlibDrawer ) and ( dest_ent.RDbeamlibDrawer ) then
		/*local ent = source_ent
		local pos = start_pos
		source_ent = dest_ent
		start_pos = dest_pos
		dest_ent = ent
		dest_pos = pos
		Drawer = dest_ent.RDbeamlibDrawer*/
		return dest_ent, dest_pos, source_ent, start_pos, dest_ent.RDbeamlibDrawer
	elseif (SERVER) then
		return source_ent, start_pos, dest_ent, dest_pos, GetDrawer( source_ent, NoCheckLength )
	end
	
end



----------------------------/
--	RD Beams: ent to ent only
----------------------------/
--	makes a simple beam from a source ent to dest ent
function RDbeamlib.MakeSimpleBeam(source_ent, start_pos, dest_ent, dest_pos, material, color, width, NoCheckLength)
	if (SERVER) then
		if (!SourceAndDestEntValid( source_ent, dest_ent )) then return end
		source_ent, start_pos, dest_ent, dest_pos = SetUpDrawer( source_ent, start_pos, dest_ent, dest_pos, NoCheckLength )
	end
	
	BeamData[ source_ent ]							= BeamData[ source_ent ] or {}
	BeamData[ source_ent ][ dest_ent ]				= {}
	BeamData[ source_ent ][ dest_ent ].start_pos	= start_pos
	BeamData[ source_ent ][ dest_ent ].dest_pos		= dest_pos
	BeamData[ source_ent ][ dest_ent ].material		= material
	BeamData[ source_ent ][ dest_ent ].width		= width
	BeamData[ source_ent ][ dest_ent ].color		= color
	
	if (CLIENT) then
		RDbeamlib.UpdateRenderBounds(source_ent)
		RDbeamlib.UpdateRenderBounds(dest_ent)
	end
	
	if (SERVER) then
		--BeamData[ source_ent ][ dest_ent ].colv = Vector(color.r, color.g, color.b)
		BeamData[ source_ent ][ dest_ent ].Length = ( dest_ent:GetPos() - source_ent:GetPos() ):Length() + (RD_EXTRA_LINK_LENGTH or 64)
		
		local info			= {}
		info.type			= "simple"
		info.source_ent		= source_ent
		info.dest_ent		= dest_ent
		
		AddDelayedNetworkUpdate( "simple", -3, info, BeamData[ source_ent ][ dest_ent ] )
		--AddDelaySendBeamData( info, BeamData[ source_ent ][ dest_ent ], nil )
	end
	
end

--
--	Clears the beam between two ents
function RDbeamlib.ClearBeam( source_ent, dest_ent )
	if (BeamData[ source_ent ]) then
		BeamData[ source_ent ][ dest_ent ] = nil
	end
	if (BeamData[ dest_ent ]) then
		BeamData[ dest_ent ][ source_ent ] = nil
	end
	if (CLIENT) then
		RDbeamlib.UpdateRenderBounds(source_ent)
		RDbeamlib.UpdateRenderBounds(dest_ent)
	end
	if (SERVER) then
		--TODO: fir to use ExtraDelayedUpdates
		/*for _, data in pairs (ExtraDelaySendBeamData) do
			if (data.type == "simple") and (data.source_ent == source_ent) and (data.dest_ent == dest_ent) then
				data = nil
			end
		end*/
		
		local info			= {}
		info.type			= "clearbeam"
		info.source_ent		= source_ent
		info.dest_ent		= dest_ent
		
		AddDelayedNetworkUpdate( "clearbeam", -3, info, {} )
		--AddDelaySendBeamData( info, {}, nil )
	end
end

--
--	Clears all beams from/to ent
function RDbeamlib.ClearAllBeamsOnEnt( source_ent, DontUpdateCl )
	if (BeamData[ source_ent ]) then
		BeamData[ source_ent ] = nil
	end
	for ent, beamstable in pairs(BeamData) do
		if (BeamData[ent][ source_ent ]) then
			BeamData[ent][ source_ent ] = nil
		end
		if ent == NULL then BeamData[ent] = nil end
	end
	if (CLIENT) then
		RDbeamlib.UpdateRenderBounds(source_ent)
	end
	if (SERVER and !DontUpdateCl) then
		--TODO: fir to use ExtraDelayedUpdates
		/*for _, data in pairs (ExtraDelaySendBeamData) do
			if (data.type == "simple") and ((data.source_ent == source_ent) or (data.dest_ent == source_ent)) then
				data = nil
			end
		end*/
		
		local info			= {}
		info.type			= "clearallentbeams"
		info.source_ent		= source_ent
		
		AddDelayedNetworkUpdate( "clearallentbeams", -3, info, {} )
		--AddDelaySendBeamData( info, {}, nil )
	end
end



----------------------------/
--	Wire Beams: ent to ent with mid point nodes
----------------------------/
--
--	Start a wire beam
function RDbeamlib.StartWireBeam( wire_dev, iname, pos, material, color, width )
	if (!wire_dev or wire_dev == NULL) then return end
	
	WireBeams[wire_dev]							= WireBeams[wire_dev] or {}
	WireBeams[wire_dev].Inputs					= WireBeams[wire_dev].Inputs or {}
	
	if ( SERVER ) then
		Drawer = GetDrawer( wire_dev )
		
		--clients don't actually need to know the name of the input, use a index number instead
		local Idx
		if ( WireBeams[wire_dev].Inputs[iname] and WireBeams[wire_dev].Inputs[iname].Idx) then
			Idx = WireBeams[wire_dev].Inputs[iname].Idx --reuse the same index
		else
			WireBeams[wire_dev].inameIdx		= (WireBeams[wire_dev].inameIdx or 0) + 1
			Idx									= WireBeams[wire_dev].inameIdx
		end
		
		--clear current data (i'm the server, i know what i'm doing)
		WireBeams[wire_dev].Inputs[iname]		= {}
		WireBeams[wire_dev].Inputs[iname].nodes	= {}
		WireBeams[wire_dev].Inputs[iname].Idx	= Idx --set index for this iname
	else
		--client may not get the start data first, so don't clear it
		WireBeams[wire_dev].Inputs[iname]		= WireBeams[wire_dev].Inputs[iname] or {}
		WireBeams[wire_dev].Inputs[iname].nodes	= WireBeams[wire_dev].Inputs[iname].nodes or {}
	end
	
	WireBeams[wire_dev].Inputs[iname].pos		= pos
	WireBeams[wire_dev].Inputs[iname].material	= material
	WireBeams[wire_dev].Inputs[iname].color		= color or Color(0, 0, 0, 255)
	WireBeams[wire_dev].Inputs[iname].width		= width
	
	if ( CLIENT ) then
		WireBeams[wire_dev].Inputs[iname].nodenum = table.Count( WireBeams[wire_dev].Inputs[iname].nodes )
	end
	
	if ( SERVER ) then
		WireBeams[wire_dev].Inputs[iname].nodenum = 0
		
		local info			= {}
		info.type			= "wirestart"
		info.wire_dev		= wire_dev
		info.wire_devIdx	= wire_dev:EntIndex()
		--info.Drawer			= Drawer
		info.iname			= WireBeams[wire_dev].Inputs[iname].Idx
		if (#DelayedUpdates < 550) then
			AddDelayedNetworkUpdate( "wirestart", -3, info, WireBeams[wire_dev].Inputs[iname] )
			--AddDelaySendBeamData( info, WireBeams[wire_dev].Inputs[iname], nil )
		else --being flooded (dupe paste), delay these some
			AddExtraDelayedNetworkUpdate( "wirestart", -3, info, WireBeams[wire_dev].Inputs[iname] )
			--AddExtraDelaySendBeamData( info, WireBeams[wire_dev].Inputs[iname], nil )
		end
		
	end
	
end

--
--	Add a node to a wire beam
function RDbeamlib.AddWireBeamNode( wire_dev, iname, node_ent, pos, nodenum )
	if (!wire_dev or wire_dev == NULL) or (!node_ent or node_ent == NULL) then return end
	
	if ( SERVER ) then
		Drawer = GetDrawer( wire_dev )
		nodenum = WireBeams[wire_dev].Inputs[iname].nodenum + 1
	end
	
	WireBeams[wire_dev]										= WireBeams[wire_dev] or {}
	WireBeams[wire_dev].Inputs								= WireBeams[wire_dev].Inputs or {}
	WireBeams[wire_dev].Inputs[iname]						= WireBeams[wire_dev].Inputs[iname] or {}
	WireBeams[wire_dev].Inputs[iname].nodes					= WireBeams[wire_dev].Inputs[iname].nodes or {}
	WireBeams[wire_dev].Inputs[iname].nodes[nodenum]		= {}
	WireBeams[wire_dev].Inputs[iname].nodes[nodenum].pos	= pos
	
	if (type(node_ent) == "number") then
		WireBeams[wire_dev].Inputs[iname].nodes[nodenum].entIdx = node_ent
	else
		WireBeams[wire_dev].Inputs[iname].nodes[nodenum].ent = node_ent
	end
	
	if ( CLIENT ) then
		WireBeams[wire_dev].Inputs[iname].nodenum = table.Count( WireBeams[wire_dev].Inputs[iname].nodes )
	end
	
	if ( SERVER ) then
		WireBeams[wire_dev].Inputs[iname].nodenum = nodenum
		
		local info			= {}
		info.type			= "wirenode"
		info.wire_dev		= wire_dev
		info.wire_devIdx	= wire_dev:EntIndex()
		--info.Drawer			= Drawer
		info.iname			= WireBeams[wire_dev].Inputs[iname].Idx
		info.node_entIdx	= node_ent:EntIndex()
		info.nodenum		= nodenum
		
		if (#DelayedUpdates < 500) then
			AddDelayedNetworkUpdate( "wirenode", -3, info, WireBeams[wire_dev].Inputs[iname] )
			--AddDelaySendBeamData( info, WireBeams[wire_dev].Inputs[iname], nil )
		else --being flooded (dupe paste), delay these some
			AddExtraDelayedNetworkUpdate( "wirenode", -3, info, WireBeams[wire_dev].Inputs[iname] )
			--AddExtraDelaySendBeamData( info, WireBeams[wire_dev].Inputs[iname], nil )
		end
	end
	
end

--
--	Clears a wire beam
function RDbeamlib.ClearWireBeam( wire_dev, iname )
	if (!wire_dev or !iname or !WireBeams[wire_dev] or !WireBeams[wire_dev].Inputs or !WireBeams[wire_dev].Inputs[iname] or !wire_dev:IsValid()) then return end
	
	if (SERVER) then
		--TODO: fir to use ExtraDelayedUpdates
		/*for _, data in pairs (ExtraDelaySendBeamData) do
			if ( (data.type == "wirestart") and (data.wire_dev == wire_dev) and (data.iname == iname) )
			and ( (data.type == "wirenode") and (data.wire_dev == wire_dev) and (data.iname == iname) ) then
				data = nil
			end
		end*/
		
		local info		= {}
		info.type		= "clearwirebeam"
		info.wire_dev	= wire_dev
		info.iname		= WireBeams[wire_dev].Inputs[iname].Idx
		
		AddDelayedNetworkUpdate( "clearwirebeam", -3, info, {} )
		--AddDelaySendBeamData( info, {}, nil )
	end
	
	if (WireBeams[wire_dev]) and (WireBeams[wire_dev].Inputs) then
		WireBeams[wire_dev].Inputs[iname] = nil
	end
	
	if (CLIENT) and (wire_dev:IsValid()) then
		RDbeamlib.UpdateRenderBounds(wire_dev)
	end
end

--
--	Clears a wire beam
function RDbeamlib.ClearAllWireBeam( wire_dev )
	if (!wire_dev) then return end 
	
	WireBeams[wire_dev] = nil
	
	if (CLIENT) and (wire_dev:IsValid()) then
		RDbeamlib.UpdateRenderBounds(wire_dev)
	end
	
	if (SERVER) then
		--TODO: fir to use ExtraDelayedUpdates
		/*for _, data in pairs (ExtraDelaySendBeamData) do
			if ( (data.type == "wirestart") and (data.wire_dev == wire_dev) )
			and ( (data.type == "wirenode") and (data.wire_dev == wire_dev) ) then
				data = nil
			end
		end*/
		
		local info		= {}
		info.type		= "clearallwirebeam"
		info.wire_dev	= wire_dev
		
		AddDelayedNetworkUpdate( "clearallwirebeam", -3, info, {} )
		--AddDelaySendBeamData( info, {}, nil )
	end
end




----------------------------/
--	Client Side Functions
----------------------------/
if (CLIENT) then

--
--	check for any beam date for NULL ents and removes it
--
local function CleanupBeams()
	--Msg("Running BeamVarsCleanup\n")
	for source_ent, source_ent_table in pairs(BeamData) do
		if ( source_ent == NULL ) then
			BeamData[ source_ent ] = nil
		/*else	
			for dest_ent, beam_data in pairs(source_ent_table) do
				if (dest_ent == NULL) then
					BeamData[source_ent][dest_ent] = nil
				end
			end*/
		end
	end
	for wire_dev, beam_data in pairs(WireBeams) do
		if ( wire_dev == NULL ) then
			WireBeams[ wire_dev ] = nil
		end --TODO: check nodes too
	end
end
timer.Create( "RDBeamVarsCleanUp", 35, 0, CleanupBeams )


local mats = {}
local function getmat( mat )
	if mats[mat] == nil then 
		mats[mat] = Material(mat)
	end
	return mats[mat]
end

local BEAM_SCROLL_SPEED = 0.5
local DisableBeamRender = 0

--
--	renders all the beams on the source_ent
--
function RDbeamlib.BeamRender( source_ent )
    if ( !source_ent or !source_ent:IsValid() ) then return end
	if (DisableBeamRender > 0) then return end
	
	if ( BeamData[ source_ent ] ) then
		
		for dest_ent, beam_data in pairs( BeamData[ source_ent ] ) do
		    
			if ( type(dest_ent) == "number" ) then
				local dest_entIdx = dest_ent
				dest_ent = ents.GetByIndex(dest_entIdx)
				BeamData[ source_ent ][ dest_ent ] = BeamData[ source_ent ][ dest_entIdx ]
				BeamData[ source_ent ][ dest_entIdx ] = nil
			else
				
				if (beam_data.width or 0 > 0) and (dest_ent:IsValid()) then
					local startpos	= source_ent:LocalToWorld(beam_data.start_pos)
					local endpos	= dest_ent:LocalToWorld(beam_data.dest_pos)
					local width	= beam_data.width
					local color = beam_data.color
					local scroll = CurTime() * BEAM_SCROLL_SPEED
					
					render.SetMaterial( getmat(beam_data.material) )
					render.DrawBeam(startpos, endpos, width, scroll, scroll+(endpos-startpos):Length()/10, color)
				else
					beam_data = nil
				end
				
			end
		end
		
	elseif (BeamData[ source_ent:EntIndex() ]) then
		BeamData[ source_ent ] = BeamData[ source_ent:EntIndex() ]
		BeamData[ source_ent:EntIndex() ] = nil
	end
	
	if ( WireBeams[ source_ent ] ) then
		
		for iname, beam_data in pairs(WireBeams[ source_ent ].Inputs) do
			if ( beam_data.pos ) then
				
				local scroll = CurTime() * BEAM_SCROLL_SPEED
				local pos		= beam_data.pos
				local material	= beam_data.material
				local color		= beam_data.color
				local width		= beam_data.width
				local nodenum	= beam_data.nodenum
				local start		= source_ent:LocalToWorld(pos)
				
				--TODO: clean up when node becomes invalid
				if (nodenum == 1) then
					local node_ent	= beam_data.nodes[1].ent
					local node_pos	= beam_data.nodes[1].pos
					
					if (!node_ent and beam_data.nodes[1].entIdx) then
						beam_data.nodes[1].ent = ents.GetByIndex(beam_data.nodes[1].entIdx)
						node_ent = beam_data.nodes[1].ent
					end
					
					if (node_ent:IsValid()) then 
						local endpos = node_ent:LocalToWorld(node_pos)
						render.SetMaterial( getmat(material) )
						render.DrawBeam( start, endpos, width, scroll, scroll+(endpos-start):Length()/10, color )
					end
				else
					render.SetMaterial( getmat(material) )
					render.StartBeam( nodenum + 1 )
					render.AddBeam( start, width, scroll, color )
					
					for node_num, node_data in pairs(beam_data.nodes) do
						local node_ent	= node_data.ent
						local node_pos	= node_data.pos
						
						if (!node_ent and node_data.entIdx) then
							node_data.ent = ents.GetByIndex(node_data.entIdx)
							node_ent = node_data.ent
						end
						
						if (node_ent:IsValid()) then
							local endpos = node_ent:LocalToWorld(node_pos)
							
							scroll = scroll+(endpos-start):Length()/10
							
							render.AddBeam( endpos, width, scroll, color )
							
							start = endpos
						end
						
					end
					
					render.EndBeam()
				end
			else
				--Msg("no beam_data.pos for "..iname.."\n")
			end
		end
		
	elseif (WireBeams[ source_ent:EntIndex() ]) then
		WireBeams[ source_ent ] = WireBeams[ source_ent:EntIndex() ]
		WireBeams[ source_ent:EntIndex() ] = nil
	end
	
end


--
--	updates the render bounds on source_ent
--		TODO: this should be run by the source_ent once in a while
function RDbeamlib.UpdateRenderBounds(source_ent)
	if (!source_ent) or (type(source_ent) == "number") or (!source_ent:IsValid()) then return end
	
	local Drawer = source_ent.Entity:GetNetworkedEntity( "RDbeamlibDrawer" )
	if ( !Drawer:IsValid() ) then return end
	
	local bbmin = Vector(16,16,16)
	local bbmax = Vector(-16,-16,-16)
	
	if (BeamData[ source_ent ]) then
		
		for dest_ent, beam_data in pairs( BeamData[ source_ent ] ) do
			if (dest_ent:IsValid()) then
				if (beam_data.start_pos.x < bbmin.x) then bbmin.x = beam_data.start_pos.x end
				if (beam_data.start_pos.y < bbmin.y) then bbmin.y = beam_data.start_pos.y end
				if (beam_data.start_pos.z < bbmin.z) then bbmin.z = beam_data.start_pos.z end
				if (beam_data.start_pos.x > bbmax.x) then bbmax.x = beam_data.start_pos.x end
				if (beam_data.start_pos.y > bbmax.y) then bbmax.y = beam_data.start_pos.y end
				if (beam_data.start_pos.z > bbmax.z) then bbmax.z = beam_data.start_pos.z end
				
				local endpos = source_ent:WorldToLocal( dest_ent:LocalToWorld( beam_data.dest_pos ) )
				if (endpos.x < bbmin.x) then bbmin.x = endpos.x end
				if (endpos.y < bbmin.y) then bbmin.y = endpos.y end
				if (endpos.z < bbmin.z) then bbmin.z = endpos.z end
				if (endpos.x > bbmax.x) then bbmax.x = endpos.x end
				if (endpos.y > bbmax.y) then bbmax.y = endpos.y end
				if (endpos.z > bbmax.z) then bbmax.z = endpos.z end
			end
		end
		
	end
	
	if ( WireBeams[ source_ent ] ) then
		
		for iname, beam_data in pairs(WireBeams[ source_ent ].Inputs) do
			if ( beam_data.pos ) then
				
				local start_pos	= source_ent:LocalToWorld(beam_data.pos)
				if (start_pos.x < bbmin.x) then bbmin.x = start_pos.x end
				if (start_pos.y < bbmin.y) then bbmin.y = start_pos.y end
				if (start_pos.z < bbmin.z) then bbmin.z = start_pos.z end
				if (start_pos.x > bbmax.x) then bbmax.x = start_pos.x end
				if (start_pos.y > bbmax.y) then bbmax.y = start_pos.y end
				if (start_pos.z > bbmax.z) then bbmax.z = start_pos.z end
				
				for node_num, node_data in pairs(beam_data.nodes) do --TODO: clean up when node becomes invalid
					local node_ent	= node_data.ent
					local node_pos	= node_data.pos
					if (node_ent and node_ent:IsValid()) then
						local endpos = source_ent:WorldToLocal( node_ent:LocalToWorld( node_pos ) )
						if (endpos.x < bbmin.x) then bbmin.x = endpos.x end
						if (endpos.y < bbmin.y) then bbmin.y = endpos.y end
						if (endpos.z < bbmin.z) then bbmin.z = endpos.z end
						if (endpos.x > bbmax.x) then bbmax.x = endpos.x end
						if (endpos.y > bbmax.y) then bbmax.y = endpos.y end
						if (endpos.z > bbmax.z) then bbmax.z = endpos.z end
					end
				end
				
			end
		end
		
	end
	
	Drawer:SetRenderBounds( bbmin, bbmax )
	
end


--
--	turns off beam rendering
--
local function BeamRenderDisable(pl, cmd, args)
	if not args[1] then return end
	DisableBeamRender = tonumber(args[1])
end
concommand.Add( "RDBeamLib_DisableRender", BeamRenderDisable )


--
--	umsg Recv'r functions
--
local function RecvBeamSimple( m )
	
	--local source_ent	= m:ReadEntity()
	local source_entIdx	= m:ReadShort()
	--local dest_ent		= m:ReadEntity()
	local dest_entIdx	= m:ReadShort()
	local start_pos		= m:ReadVector()
	local dest_pos		= m:ReadVector()
	local material		= m:ReadString()
	--local colv			= m:ReadVector()
	--local color			= Color(colv.x, colv.y, colv.z, 255)
	local color			= Color( m:ReadShort(), m:ReadShort(), m:ReadShort(), 255)
	local width			= m:ReadFloat()
	
	local source_ent = ents.GetByIndex( source_entIdx )
	if (source_ent == NULL) then source_ent = source_entIdx end
	local dest_ent = ents.GetByIndex( dest_entIdx )
	if (dest_ent == NULL) then dest_ent = dest_entIdx end
	
	RDbeamlib.MakeSimpleBeam(source_ent, start_pos, dest_ent, dest_pos, material, color, width)
	
end
usermessage.Hook( "RcvRDBeamSimple", RecvBeamSimple )

local function RecvClearBeam( m )
	--local source_ent	= m:ReadEntity()
	--local dest_ent		= m:ReadEntity()
	
	local source_entIdx	= m:ReadShort()
	local dest_entIdx	= m:ReadShort()
	
	local source_ent = ents.GetByIndex( source_entIdx )
	if (source_ent == NULL) then source_ent = source_entIdx end
	local dest_ent = ents.GetByIndex( dest_entIdx )
	if (dest_ent == NULL) then dest_ent = dest_entIdx end
	
	RDbeamlib.ClearBeam( source_ent, dest_ent )
end
usermessage.Hook( "RcvRDClearBeam", RecvClearBeam )

local function RecvClearAllBeamsOnEnt( m )
	--local source_ent	= m:ReadEntity()
	local source_entIdx	= m:ReadShort()
	local source_ent	= Entity( source_entIdx )
	if (source_ent == NULL) then source_ent = source_entIdx end
	
	RDbeamlib.ClearAllBeamsOnEnt( source_ent )
end
usermessage.Hook( "RcvRDClearAllBeamsOnEnt", RecvClearAllBeamsOnEnt )


local function RecvWireBeamStart( m )
	
	--local wire_dev		= m:ReadEntity()
	local wire_devIdx	= m:ReadShort()
	local iname			= m:ReadShort()
	local pos			= m:ReadVector()
	local material		= m:ReadString()
	local color			= Color( m:ReadShort(), m:ReadShort(), m:ReadShort(), 255)
	local width			= m:ReadFloat()
	
	local wire_dev = ents.GetByIndex( wire_devIdx )
	if (wire_dev == NULL) then wire_dev = wire_devIdx end
	
	RDbeamlib.StartWireBeam( wire_dev, iname, pos, material, color, width )
	
end
usermessage.Hook( "RcvRDWireBeamStart", RecvWireBeamStart )

local function RecvWireBeamNode( m )
	
	--local wire_dev		= m:ReadEntity()
	local wire_devIdx	= m:ReadShort()
	local iname			= m:ReadShort()
	local nodenum		= m:ReadShort()
	--local node_ent		= m:ReadEntity()
	local node_entIdx	= m:ReadShort()
	local pos			= m:ReadVector()
	
	local wire_dev = ents.GetByIndex( wire_devIdx )
	if (wire_dev == NULL) then wire_dev = wire_devIdx end
	local node_ent = ents.GetByIndex( node_entIdx )
	if (node_ent == NULL) then node_ent = node_entIdx end
	
	RDbeamlib.AddWireBeamNode( wire_dev, iname, node_ent, pos, nodenum )
	
end
usermessage.Hook( "RcvRDWireBeamNode", RecvWireBeamNode )

local function RecvClearWireBeam( m )
	local wire_dev = ents.GetByIndex( m:ReadShort() )
	RDbeamlib.ClearWireBeam( wire_dev, m:ReadShort() )
	--RDbeamlib.ClearWireBeam( m:ReadEntity(), m:ReadShort() )
end
usermessage.Hook( "RcvRDWireBeamClear", RecvClearWireBeam )

local function RecvClearAllWireBeam( m )
	local wire_dev = ents.GetByIndex( m:ReadShort() )
	RDbeamlib.ClearAllWireBeam( wire_dev )
	--RDbeamlib.ClearAllWireBeam( m:ReadEntity() )
end
usermessage.Hook( "RcvRDWireBeamClearAll", RecvClearAllWireBeam )



--
--	test function to clear BeamData, for testing FullUpdate function
--
local function ClearBeamData()
	BeamData = {}
	WireBeams = {}
end
concommand.Add( "RDBeamLib_ClearBeamData", ClearBeamData )


--
--	function to spam all the BeamData the client has
--
local function spamCLBeamData()
	CleanupBeams()
	/*Msg("\n\n================= CLBeamData ======================\n\n")
		PrintTable(BeamData)
	Msg("\n=============== end CLBeamData ==================\n\n")*/
	Msg("===BeamData Size: "..table.Count(BeamData).."\n")
	Msg("\n\n================= CLWireBeams ======================\n\n")
		PrintTable(WireBeams)
	Msg("\n=============== end CLWireBeams ==================\n")
	
	for wire_dev,beam_data in pairs(WireBeams) do
		Msg("wire_dev= "..tostring(wire_dev).."\n")
		for iname,beam in pairs(beam_data.Inputs) do
			Msg("\tiname= "..iname.." pos= "..tostring(beam.pos).."\n")
			Msg("\t\tnodesize= "..table.Count(beam.Nodes).."\n")
		end
	end
	
	Msg("===WireBeams Size: "..table.Count(WireBeams).."\n")
end
concommand.Add( "RDBeamLib_PrintCLBeamData", spamCLBeamData )


-- Net vars dump
local function Dump()
	Msg("Networked Beam Vars...\n")
	PrintTable( NetworkVars )
end
concommand.Add( "networkbeamvars_dump", Dump )

end

Msg("=======================================================\n"..
"======== Beam NetVars Lib v"..BeamNetVars.Version.." Installed ========\n"..
"======== BeamLib v"..RDbeamlib.Version.." Installed ========\n"..
"=======================================================\n")
