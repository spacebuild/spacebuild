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
local RunConsoleCommand = RunConsoleCommand
local usermessage = usermessage
local CurTime = CurTime
local ErrorNoHalt = ErrorNoHalt
local maxretries = CreateConVar( "caf_datastream_maxretries", "3", { FCVAR_ARCHIVE } )

module( "cl_caf_datastream" )

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

local function CallStreamHook(command , id, glondata, data, bytesin, bytesout)
	if not _hooks[command] then
		ErrorNoHalt(("Caf DataStreamServer: Unhandled stream %q!"):format(command))
		--LOG TO CAF
		return false;
	end
	if hook.Call("CompletedIncomingCafStream", GAMEMODE , ply , command ,id, glondata, data) == false then
		--LOG TO CAF
		return 
	end
	_hooks[command].func(command , id, glondata, data, bytesin, bytesout)
end

local function AcceptStream()
	return true
end
hook.Add("AcceptCafStream", "AcceptCafStream", AcceptStream)

local function FinishServerStream(id)
	ErrorNoHalt("Finishing ServerStream");
	local rec = _in[id];
	local glondata = "";
	for k, v in pairs(rec.packets) do
		glondata = glondata..v.data;
	end
	local data = nil;
	local b,err = pcall(glon.decode,glondata)
	if b then 
		data = err 
	else 
		ErrorNoHalt("CAF DataStreamClient Decoding Error: "..err.." (operation "..id..")\n") 
		return 
	end
	CallStreamHook(rec.command, id, glondata, data, rec.bytesin, rec.bytesout)
	_in[id] = nil
end

-- Usermessages from the server
local function DSStart(data)
	ErrorNoHalt("DSSTART\n");
	local code = data:ReadShort();
	if code ~= 0 then
		_bytesin = _bytesin + 2 --short
		ErrorNoHalt("Error in DSStart: Faulty Code"..code);
		return;
	end
	local id = data:ReadLong()
	local nrPackets = data:ReadShort();
	local command = data:ReadString()
	local rec = _in[id] or {} 
	rec.id = id;
	rec.command = command;
	rec.packets = rec.packets or {};
	rec.nrPackets = nrPackets;
	rec.bytesin = rec.bytesin or 0;
	rec.bytesout = rec.bytesout or 0
	RunConsoleCommand("__caf_ds_rec", 4, code , id, nrPackets)
	
	local totalbytesrec = 2 + 4 + 2 + command:len() + 2; --short + long + short + stringsize + extra of 2 bytes for string
	rec.bytesin = rec.bytesin + totalbytesrec
	_bytesin = _bytesin + totalbytesrec
	
	local totalbytessend = 2 + 2 + tostring(id):len() + tostring(nrPackets):len() + 2 + 2; --short (1 char long), code (1 char long) + id (# chars long) + NrPackets(#chars long) + Extra bytes for string + extra bytes for string
	rec.bytesout = rec.bytesout + totalbytessend;
	_bytesout = _bytesout + totalbytessend;
	
	_in[id] = rec
	if table.Count(rec.packets) == rec.nrPackets then
		FinishServerStream(id)
	end
end
usermessage.Hook("caf_ds_start", DSStart)

local function DSPacket(data)
	ErrorNoHalt("DSPACKET\n");
	local code = data:ReadShort();
	if code ~= 1 then
		_bytesin = _bytesin + 2 --short
		ErrorNoHalt("Error in DSPacket: Faulty Code"..code);
		return;
	end
	local id = data:ReadLong()
	local packetid = data:ReadShort();
	local datastr = data:ReadString()
	local ob =  {}
	ob.id = id;
	ob.command = "X2X2X2";
	ob.packets = {}
	ob.nrPackets = 0;
	ob.bytesin = 0;
	ob.bytesout = 0
	local rec = _in[id] or ob;
	local obj = {}
	obj.id = packetid;
	obj.data = datastr;
	rec.packets[packetid] = rec.packets[packetid] or obj;
	RunConsoleCommand("__caf_ds_rec", 4, code , id, packetid)
	
	local totalbytesrec = 2 + 4 + 2 + datastr:len() + 2; --short + long + short + stringsize + extra of 2 bytes for string
	rec.bytesin = rec.bytesin + totalbytesrec
	_bytesin = _bytesin + totalbytesrec
	
	local totalbytessend = 2 + 2 + tostring(id):len() + tostring(packetid):len() + 2 + 2; --short (1 char long), code (1 char long) + id (# chars long) + packetid(#chars long)  + Extra bytes for string + extra bytes for string
	rec.bytesout = rec.bytesout + totalbytessend;
	_bytesout = _bytesout + totalbytessend;
	
	_in[id] = rec
	if rec.nrPackets > 0 then
		if table.Count(rec.packets) == rec.nrPackets then
			FinishServerStream(id)
		end
	end	
end
usermessage.Hook("caf_ds_packet",DSPacket)

local function DSClear(data)
	ErrorNoHalt("DSCLEAR\n");
	local code = data:ReadShort();
	if code ~= 2 then
		_bytesin = _bytesin + 2 --short
		ErrorNoHalt("Error in DSClear: Faulty Code..code");
		return;
	end
	local id = data:ReadLong()
	_bytesin = _bytesin + 2 + 4 --short + long
	_in[id] = nil;
end
usermessage.Hook("caf_ds_clear", DSClear)



