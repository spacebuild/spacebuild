AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

util.PrecacheSound( "Buttons.snd17" )

include('shared.lua')

--
local screens = {}

--[[
	--SetResourceAmount
	--PumpTurnOn
	--PumpTurnOff
]]
local function TurnOnScreen(ply, com, args)
	local id = args[1]
	if not id then return end
	local ent = ents.GetByIndex( id )
	if not ent then return end
	if ent.IsScreen and ent.TurnOn then
		ent:TurnOn()
	end
end
concommand.Add( "LSScreenTurnOn", TurnOnScreen )  

local function TurnOffScreen(ply, com, args)
	local id = args[1]
	if not id then return end
	local ent = ents.GetByIndex( id )
	if not ent then return end
	if ent.IsScreen and ent.TurnOff then
		ent:TurnOff()
	end
end
concommand.Add( "LSScreenTurnOff", TurnOffScreen )  

local function AddResource(ply, com, args)
	local id = args[1]
	if not id or not args[2] then return end
	local ent = ents.GetByIndex( id )
	if not ent then return end
	if ent.IsScreen and ent.resources then
		if not table.HasValue(ent.resources, args[2]) then
			table.insert(ent.resources, args[2])
			umsg.Start("LS_Add_ScreenResource")
				umsg.Entity(ent)
				umsg.String(args[2])
			umsg.End()
		end
	end
end
concommand.Add( "AddLSSCreenResource", AddResource )

local function RemoveResource(ply, com, args)
	local id = args[1]
	if not id or not args[2] then return end
	local ent = ents.GetByIndex( id )
	if not ent then return end
	if ent.IsScreen and ent.resources then
		if table.HasValue(ent.resources, args[2]) then
			for k, v in pairs(ent.resources) do
				if v == args[2] then
					table.remove(ent.resources, k)
					break
				end
			end
			umsg.Start("LS_Remove_ScreenResource")
				umsg.Entity(ent)
				umsg.String(args[2])
			umsg.End()
		end
	end
end
concommand.Add( "RemoveLSSCreenResource", RemoveResource )

local function UserConnect(ply)
	if table.Count(screens) > 0 then
		for k, v in pairs(screens) do
			if IsValid(v) then
				if table.Count(v.resources) > 0 then
					for l, w in pairs(v.resources) do
						umsg.Start("LS_Add_ScreenResource", ply)
							umsg.Entity(v)
							umsg.String(w)
						umsg.End()
					end
				end
			end
		end
	end
end
hook.Add("PlayerInitialSpawn", "LS_Screen_info_Update", UserConnect)
--

local Energy_Increment = 4

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.resources = {}
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "On" })
		self.Outputs = Wire_CreateOutputs(self, { "On" })
	else
		self.Inputs = {{Name="On"},{Name="Overdrive"}}
	end
	table.insert(screens, self)
end

function ENT:TurnOn()
	if self.Active == 0 then
		self:EmitSound( "Buttons.snd17" )
		self.Active = 1
		self:SetOOO(1)
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", 1) end
	end
end

function ENT:TurnOff(warn)
	if self.Active == 1 then
		if (!warn) then self:EmitSound( "Buttons.snd17" ) end
		self.Active = 0
		self:SetOOO(0)
		if not (WireAddon == nil) then
			Wire_TriggerOutput(self, "On", 0)
		end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		if value == 0 then
			self:TurnOff()
		elseif value == 1 then
			self:TurnOn()
		end
	end
end

--use this to set self.active
--put a self:TurnOn and self:TurnOff() in your ent
--give value as nil to toggle
--override to do overdrive
--AcceptInput (use action) calls this function with value = nil
function ENT:SetActive( value, caller )
	umsg.Start("LS_Open_Screen_Menu", caller)
		umsg.Entity(self)
	umsg.End()
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
	self.BaseClass.Repair(self)
	self:SetColor(Color(255, 255, 255, 255))
	self.damaged = 0
end

function ENT:Destruct()
	if CAF and CAF.GetAddon("Life Support") then
		CAF.GetAddon("Life Support").Destruct( self, true )
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.Active == 1) then
		if (self:GetResourceAmount("energy") < math.Round(Energy_Increment * self:GetMultiplier())) then
			self:EmitSound( "common/warning.wav" )
			self:TurnOff(true)
		else
			self:ConsumeResource("energy", math.Round(Energy_Increment * self:GetMultiplier()))
		end
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

