AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("RD/pump/beep-4.wav")
util.PrecacheSound("RD/pump/beep-3.wav")
util.PrecacheSound("RD/pump/beep-5.wav")
include("shared.lua")
local pumps = {}
util.AddNetworkString("RD_Add_ResourceRate_to_Pump")
util.AddNetworkString("RD_Open_Pump_Menu")

--[[
	--SetResourceAmount
	--PumpTurnOn
	--PumpTurnOff
]]
local function TurnOnPump(ply, com, args)
	local id = args[1]
	if not id then return end
	local ent = ents.GetByIndex(id)
	if not ent then return end

	if ent.IsPump and ent.TurnOn then
		ent:TurnOn()
	end
end

concommand.Add("PumpTurnOn", TurnOnPump)

local function TurnOffPump(ply, com, args)
	local id = args[1]
	if not id then return end
	local ent = ents.GetByIndex(id)
	if not ent then return end

	if ent.IsPump and ent.TurnOff then
		ent:TurnOff()
	end
end

concommand.Add("PumpTurnOff", TurnOffPump)

local function SetResourceAmount(ply, com, args)
	local id = args[1]
	if not id or not args[2] or not args[3] then return end
	local ent = ents.GetByIndex(id)
	if not ent then return end

	if ent.IsPump and ent.ResourcesToSend then
		local amount = tonumber(args[3])

		if amount < 0 then
			amount = 0
		end

		ent.ResourcesToSend[args[2]] = amount
		net.Start("RD_Add_ResourceRate_to_Pump")
		net.WriteEntity(ent)
		net.WriteString(args[2])
		net.WriteUInt(amount, 32)
		net.Broadcast()
	end
end

concommand.Add("SetResourceAmount", SetResourceAmount)

local function LinkToPump(ply, com, args)
	local id = args[1]
	local id2 = args[2]
	if not id or not id2 then return end
	id = tonumber(id)
	id2 = tonumber(id2)
	local ent = ents.GetByIndex(id)
	local ent2 = ents.GetByIndex(id2)
	if not ent or not ent2 then return end

	if ent.IsPump and ent2.IsPump then
		if ent2.otherpump then
			ent:EmitSound("RD/pump/beep-5.wav", 256)
			ply:ChatPrint("This Pump is already connected to another pump!")
		elseif ent2:GetPos():Distance(ent:GetPos()) > 512 then
			ent:EmitSound("RD/pump/beep-5.wav", 256)
			ply:ChatPrint("There can only be a distance of 512 units between 2 pumps!")
		else
			ent:Connect(ent2)
		end
	end
end

concommand.Add("LinkToPump", LinkToPump)

local function SetPumpName(ply, com, args)
	local id = args[1]
	local name = args[2]
	if not id or not name then return end
	id = tonumber(id)
	name = tostring(name)
	local ent = ents.GetByIndex(id)
	if not ent or not ent.IsPump then return end
	local oldname = ent:GetPumpName()
	ent:SetPumpName(name)
	ply:ChatPrint("Changed name for pump <" .. tostring(oldname) .. "> to <" .. name .. ">")
end

concommand.Add("SetPumpName", SetPumpName)

local function UnlinkPump(ply, com, args)
	local id = args[1]
	if not id then return end
	local ent = ents.GetByIndex(id)
	if not ent then return end

	if ent.IsPump then
		ent:Disconnect()
	end
end

concommand.Add("UnlinkPump", UnlinkPump)

local function UserConnect(ply)
	for k, v in pairs(pumps) do
		if IsValid(v) then
			for l, w in pairs(v.ResourcesToSend) do
				net.Start("RD_Add_ResourceRate_to_Pump")
				net.WriteEntity(v)
				net.WriteString(l)
				net.WriteUInt(w, 32)
				net.Send(ply)
			end
		end
	end
end

hook.Add("PlayerFullLoad", "RD_Pump_info_Update", UserConnect)

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNWInt("overlaymode", 1)
	self:SetNWInt("OOO", 0)
	self.Active = 0
	self.ResourcesToSend = {}
	self.netid = 0
	self:SetNWInt("netid", self.netid)
	self.otherpump = nil
	self.WireConnectPump = -1
	table.insert(pumps, self)

	if WireAddon ~= nil then
		self.WireDebugName = self.PrintName

		self.Inputs = Wire_CreateInputs(self, {"On", "Disconnect", "ConnectID", "Connect"})

		self.Outputs = Wire_CreateOutputs(self, {"On", "PumpID", "ConnectedPumpID"})

		Wire_TriggerOutput(self, "PumpID", self:EntIndex())
		Wire_TriggerOutput(self, "ConnectedPumpID", -1)
	else
		self.Inputs = {
			{
				Name = "On"
			},
			{
				Name = "Disconnect"
			},
			{
				Name = "ConnectID"
			},
			{
				Name = "Connect"
			}
		}
	end

	self:SetNWString("name", "test")
	self:SetPumpName("Pump_" .. tostring(self:EntIndex()))
end

function ENT:GetPumpName()
	return self:GetNWString("name")
end

function ENT:SetPumpName(name)
	self:SetNWString("name", name)
end

function ENT:SetNetwork(netid)
	if not netid then return end
	self.netid = netid
	self:SetNWInt("netid", self.netid)
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		self:SetOOO(1)

		if WireAddon ~= nil then
			Wire_TriggerOutput(self, "On", self.Active)
		end
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		self:SetOOO(0)

		if WireAddon ~= nil then
			Wire_TriggerOutput(self, "On", self.Active)
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
	elseif (iname == "Disconnect") then
		if value == 1 then
			self:Disconnect()
		end
	elseif (iname == "ConnectID") then
		if value > -1 then
			self.WireConnectPump = value
		end
	elseif (iname == "Connect") then
		if value ~= 0 and self.WireConnectPump >= 0 then
			local ent2 = ents.GetByIndex(self.WireConnectPump)
			if not ent2 then return end

			if ent2.IsPump then
				if ent2.otherpump then
					-- Can't connect to the other pump, because it already is connected to a pump
					self:EmitSound("RD/pump/beep-5.wav", 256)
				elseif ent2:GetPos():Distance(self:GetPos()) > 512 then
					-- Can't connect to the other pump, because it is out of range
					self:EmitSound("RD/pump/beep-5.wav", 256)
				else
					self:Connect(ent2)
				end
			end
		end
	end
end

--use this to set self.active
--put a self:TurnOn and self:TurnOff() in your ent
--give value as nil to toggle
--override to do overdrive
--AcceptInput (use action) calls this function with value = nil
function ENT:SetActive(value, caller)
	net.Start("RD_Open_Pump_Menu")
	net.WriteEntity(self)
	net.Send(caller)
end

function ENT:SetResourceNode(node)
	if not node then return end
	self.node = node
end

function ENT:SetOOO(value)
	self:SetNWInt("OOO", value)
end

AccessorFunc(ENT, "LSMULTIPLIER", "Multiplier", FORCE_NUMBER)

function ENT:GetMultiplier()
	return self.LSMULTIPLIER or 1
end

function ENT:Repair()
	self:SetHealth(self:GetMaxHealth())
end

function ENT:AcceptInput(name, activator, caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:SetActive(nil, caller)
	end
end

--should make the damage go to the shield if the shield is installed(CDS)
function ENT:OnTakeDamage(DmgInfo)
	if self.Shield then
		self.Shield:ShieldDamage(DmgInfo:GetDamage())
		CDS_ShieldImpact(self:GetPos())

		return
	end

	if CAF and CAF.GetAddon("Life Support") then
		CAF.GetAddon("Life Support").DamageLS(self, DmgInfo:GetDamage())
	end
end

function ENT:Think()
	local RD = CAF.GetAddon("Resource Distribution")

	if self.otherpump and self.otherpump:GetPos():Distance(self:GetPos()) > 768 then
		self:Disconnect()
	end

	--if not self.otherpump then Wire_TriggerOutput(self, "ConnectedPumpID", -1) end --Suggested wireoutput fix, needed??
	if self.node and (not IsValid(self.node) or self.node:GetPos():Distance(self:GetPos()) > self.node.range) then
		RD.Beam_clear(self)

		if IsValid(self.node) then
			self:EmitSound("physics/metal/metal_computer_impact_bullet" .. math.random(1, 3) .. ".wav", 500)
			self.node:EmitSound("physics/metal/metal_computer_impact_bullet" .. math.random(1, 3) .. ".wav", 500)
		end

		self.node = nil
		self:SetNetwork(0)
		self.netid = 0
	elseif not self.node and self.netid ~= 0 then
		self:SetNetwork(0)
		self.netid = 0
	end

	if self.Active == 1 then
		if not self.otherpump then
			self:TurnOff()
		else
			if self.ResourcesToSend then
				for k, v in pairs(self.ResourcesToSend) do
					if RD.GetNetResourceAmount(self.netid, k) > 0 then
						if RD.GetNetResourceAmount(self.netid, k) > v then
							self:Send(k, v)
						else
							self:Send(k, RD.GetNetResourceAmount(self.netid, k))
						end
					end
				end
			end
		end
	end

	self:NextThink(CurTime() + 1)

	return true
end

function ENT:Send(resource, amount)
	if not self.otherpump then return end
	local left = self.otherpump:Receive(resource, amount)
	local RD = CAF.GetAddon("Resource Distribution")
	RD.ConsumeNetResource(self.netid, resource, amount - left)
end

function ENT:Receive(resource, amount)
	if not self.otherpump then return end
	local RD = CAF.GetAddon("Resource Distribution")

	return RD.SupplyNetResource(self.netid, resource, amount)
end

function ENT:Connect(ent)
	if ent and ent.IsPump then
		self:SetNWInt("connectedpump", ent:EntIndex())
		self.otherpump = ent
		ent:SetNWInt("connectedpump", self:EntIndex())
		ent.otherpump = self
		Wire_TriggerOutput(self, "ConnectedPumpID", ent:EntIndex())
		Wire_TriggerOutput(ent, "ConnectedPumpID", self:EntIndex())
		self:EmitSound("RD/pump/beep-3.wav", 256)
		self.otherpump:EmitSound("RD/pump/beep-3.wav", 256)
	end
end

function ENT:Disconnect()
	if self.otherpump then
		self:EmitSound("RD/pump/beep-4.wav", 256)
		self.otherpump:EmitSound("RD/pump/beep-4.wav", 256)
		self.otherpump:SetNWInt("connectedpump", 0)
		self.otherpump.otherpump = nil
		Wire_TriggerOutput(self, "ConnectedPumpID", -1)
		Wire_TriggerOutput(self.otherpump, "ConnectedPumpID", -1)
		self:SetNWInt("connectedpump", 0)
		self.otherpump = nil
	end
end

function ENT:OnRemove()
	self:Disconnect()
	CAF.GetAddon("Resource Distribution").Unlink(self)
	CAF.GetAddon("Resource Distribution").RemoveRDEntity(self)

	if WireAddon ~= nil then
		Wire_Remove(self)
	end
end

function ENT:OnRestore()
	if WireAddon ~= nil then
		Wire_Restored(self)
	end
end

function ENT:PreEntityCopy()
	local RD = CAF.GetAddon("Resource Distribution")
	RD.BuildDupeInfo(self)

	if WireAddon ~= nil then
		local DupeInfo = WireLib.BuildDupeInfo(self)

		if DupeInfo then
			duplicator.StoreEntityModifier(self, "WireDupeInfo", DupeInfo)
		end
	end
end

function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
	local RD = CAF.GetAddon("Resource Distribution")
	RD.ApplyDupeInfo(Ent, CreatedEntities)

	if WireAddon ~= nil and (Ent.EntityMods) and (Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end
end