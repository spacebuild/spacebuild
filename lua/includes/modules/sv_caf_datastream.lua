--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 0.1
--
--
--
--=============================================================================--


local table = table
local string = string
local umsg = umsg
local concommand = concommand
local util = util
local hook = hook
local math = math
local type = type
local pairs = pairs
local tostring = tostring
local tonumber = tonumber
local pcall = pcall
local error = error
local glon = glon
local rawget = rawget
local rawset = rawset
local setmetatable = setmetatable
local _R = _R
local print = print
local ErrorNoHalt = ErrorNoHalt
local CurTime = CurTime
local maxretries = CreateConVar( "caf_datastream_maxretries", "3", { FCVAR_ARCHIVE } )

module( "sv_caf_datastream" )

local _out = {}
local _in = {}
local _hooks = {}
local _bytesin = 0;
local _bytesout = 0;

local nextid = 0;

function Hook(hookname,func)
	local hk = {}
	hk.command = hookname
	hk.func = func
	_hooks[hookname] = hk
end

function GetTotalBytesIn()
	return _bytesin;
end

function GetTotalBytesOut()
	return _bytesout;
end

function ReceivingData() 
	return #_in > 0 
end

function GetProgress(id)
	if _out[id] then return _out[id].sent/_out[id].totalpackets end
	return 1, "ID Not Found";
end

local function CallStreamHook(ply, command , id, glondata, data)
	if not _hooks[command] then
		ErrorNoHalt(("Caf DataStreamServer: Unhandled stream %q!"):format(command))
		--LOG TO CAF
		return false;
	end
	if hook.Call("CompletedIncomingCafStream", GAMEMODE , ply , command ,id, glondata, data) == false then
		--LOG TO CAF
		return 
	end
	_hooks[command].func(ply, command , id, glondata, data)
end

local function AcceptStream()
	return true
end
hook.Add("AcceptCafStream", "AcceptCafStream", AcceptStream)

function StreamToClients( recipients, hookname, data, callback )
	local senddata = {}
	--Players
	local rt = type(recipients)
	if rt == "table" then
		senddata.recipients = recipients;
	elseif rt == "Player" then
		senddata.recipient = rt;
	else
		local err = ("Invalid type %q given to sv_caf_datastream.StreamToClients for recipients!"):format(type(rcp));
		if callback then
			callback(hookname, data, false, err, 0, 0);
		end
		return false, err;
	end
	--Data
	senddata.data = data;
	senddata.command = hookname;
	local succ,err = pcall(glon.encode, data)
	if succ then
		local nrPackets = 0;
		senddata.glondata = err;
		senddata.packets =  {};
		local packets = string.split(err,128)
		for k, v in pairs(packets) do
			nrPackets = nrPackets + 1;
			local pack = {}
			if senddata.recipient then
				pack.recipient = senddata.recipient;
			else
				pack.recipients = {}
				for k, v in pairs(senddata.recipients) do
					table.insert(pack.recipients, v);
				end
			end
			pack.id = k;
			pack.tries = 0;
			pack.lasttry = 0;
			pack.data = v;
			pack.size = v:len();
			senddata.packets[k] = pack;
		end
		senddata.totalpackets = nrPackets;
	else 
		if callback then
			callback(hookname, data, false, err);
		end
		return false, err;
	end
	senddata.id = nextid;
	nextid = nextid + 1;
	senddata.callback = callback;
	senddata.bytesout = 0;
	senddata.bytesin = 0;
	senddata.tries = 0;
	senddata.lasttry = 0;
	senddata.commandreceived = false;
	_out[senddata.id] = senddata;
	return true, senddata.id;
end

umsg.PoolString "caf_ds_start"
umsg.PoolString "caf_ds_packet"
umsg.PoolString "caf_ds_clear"
umsg.PoolString "caf_ds_confirm_packet"

local function StreamTick()
	for id, send in pairs(_out) do
		--Send Command
		if not send.commandreceived and send.lasttry + 0.05 < CurTime() then
			send.tries = send.tries + 1;
			send.lasttry = CurTime();
			if send.tries > maxretries:GetInt() then
				if send.callback then
					send.callback(send.command, send.data, false, "Max Retries have passed", send.bytesout, send.bytesin);
				end
				--LOG TO CAF
				umsg.Start("caf_ds_clear", send.recipients or send.recipient)
					umsg.Short(2);
					umsg.Long(send.id);
				umsg.End()
				_out[send.id] = nil;
				break
			end
			umsg.Start("caf_ds_start", send.recipients or send.recipient)
				umsg.Short(0);
				umsg.Long(send.id);
				umsg.Short(send.totalpackets);
				umsg.String(send.command)
			umsg.End()
		end
		--Send Packets
		for k, v in pairs(send.packets) do
			if v.lasttry + 0.05 < CurTime() then --ADJUST TIME??
				v.tries = v.tries + 1;
				v.lasttry = CurTime();
				if v.tries > maxretries:GetInt() then
					if send.callback then
						send.callback(send.command, send.data, false, "Max Retries have passed", send.bytesout, send.bytesin);
					end
					--LOG TO CAF
					umsg.Start("caf_ds_clear", v.recipients or v.recipient)
						umsg.Short(2);
						umsg.Long(send.id);
					umsg.End()
					_out[send.id] = nil;
					break
				end
				umsg.Start("caf_ds_packet", v.recipients or v.recipient)
					umsg.Short(1);
					umsg.Long(send.id);
					umsg.Short(v.id);
					umsg.String(v.data);
				umsg.End()
			end
		end
	end
end
hook.Add("Tick", "CAF_DatastreamTick", StreamTick)

local function DSConfirmation(ply,cmd,args)
	if tonumber(args[1]) ~= 4 then return end
	local id = tonumber(args[3])
	if not _out[id] then return end
	local code = tonumber(args[2])
	local packetid = tonumber(args[4]);
	if code == 0 then
		if _out[id].totalpackets == tonumber(packetid) then
			if _out[id].recipients then
				if #_out[id].recipients <= 1 then
					_out[id].commandreceived = true;
				else
					for k, v in pairs(_out[id].recipients) do
						if v == ply then
							table.remove(_out[id].recipients, k);
						end
					end
				end
			else
				_out[id].commandreceived = true;
			end
		end
	elseif code == 1 then
		local p = _out[id].packets[packetid];
		if p.recipients then
			if #p.recipients <= 1 then
				_out[id].packets[packetid] = nil;
			else
				for k, v in pairs(p.recipients) do
					if v == ply then
						table.remove(p.recipients, k);
					end
				end
			end
		else
			_out[id].packets[packetid] = nil;
		end
	end
	if _out[id].commandreceived and table.Count(_out.packets) == 0 then
		if send.callback then
			send.callback(_out[id].command, _out[id].data, true, "Succesfully Send all Data", _out[id].bytesout, _out[id].bytesin);
		end
	end
end
concommand.Add("__caf_ds_rec",DSConfirmation)


--ADD Receive code from client here









