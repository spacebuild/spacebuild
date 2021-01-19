CAFToolSetup = {}

function CAFToolSetup.open(s_toolmode)
	if TOOL then
		WireToolSetup.close()
	end

	TOOL = ToolObj:Create()
	TOOL.Mode = s_toolmode
	TOOL.Command = nil
	TOOL.ConfigName = ""
	TOOL.LeftClick = CAFTool.LeftClick
	TOOL.RightClick = CAFTool.RightClick

	if not TOOL.NoRepair then
		TOOL.Reload = CAFTool.Reload
	end

	TOOL.UpdateGhost = CAFTool.UpdateGhost
	TOOL.Think = CAFTool.Think

	if (CLIENT and GetConVarNumber("CAF_UseTab") == 1) then
		TOOL.Tab = "Custom Addon Framework"
	end
end

function CAFToolSetup.close()
	if not TOOL then return end

	if TOOL.Model then
		util.PrecacheModel(TOOL.Model)
	end

	TOOL:CreateConVars()
	SWEP.Tool[TOOL.Mode] = TOOL
	TOOL = nil
end

function CAFToolSetup.BaseLang()
	if CLIENT and TOOL.DeviceName then
		TOOL.DeviceNamePlural = TOOL.DeviceNamePlural or TOOL.DeviceName
		language.Add("undone_" .. TOOL.Mode, "Undone " .. TOOL.DeviceName)
		language.Add("Cleanup_" .. TOOL.Mode, TOOL.DeviceNamePlural or TOOL.DeviceName)
		language.Add("Cleaned_" .. TOOL.Mode, "Cleaned Up " .. TOOL.DeviceNamePlural or TOOL.DeviceName)
	end

	cleanup.Register(TOOL.Mode)
end

function CAFToolSetup.SetLang(s_cname, s_cdesc, s_click)
	if SERVER then return end
	language.Add("tool." .. TOOL.Mode .. ".name", s_cname or TOOL.Name or "")
	language.Add("tool." .. TOOL.Mode .. ".desc", s_cdesc or "")
	language.Add("tool." .. TOOL.Mode .. ".0", s_click or "")
end

function CAFToolSetup.MaxLimit()
	if TOOL.Limited == true and TOOL.Limit >= 0 then
		TOOL.LimitName = TOOL.LimitName or TOOL.Mode
		local sbox = "sbox_max" .. TOOL.LimitName
		MsgN(sbox, " -> ", TOOL.Limit)

		if SERVER then
			CreateConVar(sbox, TOOL.Limit)
		elseif CLIENT and TOOL.DeviceNamePlural then
			language.Add("SBoxLimit_" .. TOOL.LimitName, "Maximum " .. TOOL.DeviceNamePlural .. " Reached")
		end
	end
end

function CAFToolSetup.RegEnts()
	if not TOOL.DevSelect then return end
	local t_devicefiles = file.Find("CAF/Stools/" .. TOOL.Mode .. "/*.lua", "LUA")

	if t_devicefiles then
		MsgN("CAF Tool: Loading device defs")
		TOOL.DevClasses = TOOL.DevClasses or {}
		TOOL.Devices = TOOL.Devices or {}
		local s_path = "CAF/Stools/" .. TOOL.Mode .. "/"

		for key, val in pairs(t_devicefiles) do
			local s_devtype = string.sub(val, 0, -5)
			MsgN("\tLoading dev type: ", s_devtype)
			DEVICEGROUP = {}
			--DEVICEGROUP.type		= s_devtype --entity class (can be defined differently in sub_types)
			--DEVICEGROUP.group_name	= s_devtype --name of this group, file can cange it if needed. should be the same as type in most cases
			AddCSLuaFile(s_path .. val)
			include(s_path .. val)

			if DEVICEGROUP.type then
				--gorup exists, add new devices only
				if TOOL.Devices[DEVICEGROUP.type] then
					for sub_type, dev in pairs(DEVICEGROUP.devices) do
						if not TOOL.Devices[DEVICEGROUP.type].devices[sub_type] then
							TOOL.Devices[DEVICEGROUP.type].devices[sub_type] = dev
						end
					end
				else
					TOOL.Devices[DEVICEGROUP.type] = DEVICEGROUP
				end
			end

			DEVICEGROUP = nil
		end
	end

	--[[
		Make sure our device list is sane
	]]
	for devtype, devlist in pairs(TOOL.Devices) do
		devlist.type = devlist.type or devtype
		devlist.class = devlist.class or devlist.type

		if not devlist.Name or devlist.Name == "" then
			TOOL.Devices[devtype] = nil
			CAF.WriteToDebugFile("caf_tool_error", "CAF: Bad device catagory definition, removing\n")
		else
			for sub_type, dev in pairs(devlist.devices) do
				if not dev.Name or dev.Name == "" or not dev.model or dev.model == "" then
					devlist.devices[sub_type] = nil
					CAF.WriteToDebugFile("caf_tool_error", "CAF: Bad device definition, removing\n")
				else
					dev.type = dev.type or devlist.type
					dev.class = dev.class or devlist.class

					if not table.HasValue(TOOL.DevClasses, dev.class) then
						table.insert(TOOL.DevClasses, dev.class)
					end

					dev.sub_type = sub_type
					dev.group = devlist
					dev.legacy = dev.legacy or devlist.legacy

					if dev.legacy then
						devlist.models = devlist.models or {}
						devlist.models[dev.model] = dev
					end
				end
			end
		end
	end
end

function CAFToolSetup.MakeFunc()
	if CLIENT then return end

	if TOOL.DevSelect and not TOOL.MakeFunc then
		local self = TOOL
		TOOL.MakeEnt = CAFEnts.MakeEnt

		TOOL.MakeFunc = function(ply, Ang, Pos, class, type, sub_type, model, Frozen, Extra_Data, Data)
			if not ply:CheckLimit(self.LimitName) then return end
			local ent = self:MakeEnt(ply, Ang, Pos, class, type, sub_type, model, Frozen, Extra_Data, Data)
			if not ent or not ent:IsValid() then return end
			ply:AddCount(self.LimitName, ent)
			ply:AddCleanup(self.Mode, ent)

			return ent
		end

		if TOOL.DevClasses then
			for _, class in pairs(TOOL.DevClasses) do
				CAFEnts.RegDupeFunction(class, TOOL.MakeFunc)
			end
		end

		if TOOL.Renamed and TOOL.Renamed.class then
			for class, _ in pairs(TOOL.Renamed.class) do
				CAFEnts.RegDupeFunction(class, TOOL.MakeFunc)
			end
		end
	end
end

local baseccvars = {
	AllowWorldWeld = 0,
	DontWeld = 0,
	Frozen = 0
}

function CAFToolSetup.BaseCCVars()
	TOOL.ClientConVar = TOOL.ClientConVar or {}
	table.Merge(TOOL.ClientConVar, baseccvars)

	if TOOL.DevSelect then
		TOOL.ClientConVar.type = TOOL.CCVar_type or ""
		TOOL.ClientConVar.sub_type = TOOL.CCVar_sub_type or ""
		TOOL.ClientConVar.model = TOOL.CCVar_model or ""
	end

	if TOOL.ExtraCCVars then
		table.Merge(TOOL.ClientConVar, TOOL.ExtraCCVars)
	end
end

function CAFToolSetup.MakeCP()
	if SERVER then return end
	local self = TOOL

	TOOL.BuildCPanel = function(panel)
		panel:CheckBox("Don't Weld", self.Mode .. "_DontWeld")
		panel:CheckBox("Allow welding to world", self.Mode .. "_AllowWorldWeld")
		panel:CheckBox("Make Frozen", self.Mode .. "_Frozen")

		--custom stuff
		if self.ExtraCCVarsCP then
			self:ExtraCCVarsCP(panel)
		end

		--Devices
		if self.DevSelect and self.Devices then
			local tree = vgui.Create("DTree")
			tree:SetTall(400)

			function tree:CAFSort(asc)
				if not self.RootNode or not self.RootNode:HasChildren() then return end

				if not asc then
					asc = false
				end

				table.sort(self.RootNode.ChildNodes:GetChildren(), function(a, b)
					if (asc) then
						local ta = a
						local tb = b
						a = tb
						b = ta
					end

					if (a == nil or a.caftext == nil) then return false end
					if (b == nil or b.caftext == nil) then return true end

					return a.caftext > b.caftext
				end)
			end

			panel:AddPanel(tree)
			local ccv_model = self.Mode .. "_model"
			local ccv_type = self.Mode .. "_type"
			local ccv_sub_type = self.Mode .. "_sub_type"
			local cur_model = GetConVarString(ccv_model)
			local cur_type = GetConVarString(ccv_type)
			local cur_sub_type = GetConVarString(ccv_sub_type)

			for _, devlist in pairs(self.Devices) do
				if not devlist.hide then
					local node = tree:AddNode(devlist.Name, devlist.icon)
					node.caftext = devlist.Name
					node.var_type = devlist.type

					function node:CAFSort(asc)
						if not self:HasChildren() then return end

						if not asc then
							asc = false
						end

						table.sort(self.ChildNodes:GetChildren(), function(a, b)
							if (asc) then
								local ta = a
								local tb = b
								a = tb
								b = ta
							end

							if (a == nil or a.caftext == nil) then return false end
							if (b == nil or b.caftext == nil) then return true end

							return a.caftext > b.caftext
						end)
					end

					for _, dev in pairs(devlist.devices) do
						if not dev.hide then
							local cnode = node:AddNode(dev.Name, dev.icon or "icon16/newspaper.png")
							cnode.caftext = dev.Name
							cnode.var_model = dev.model
							util.PrecacheModel(dev.model)
							cnode.var_type = dev.type
							cnode.var_sub_type = dev.sub_type

							if cur_model == dev.model and cur_type == dev.type and cur_sub_type == dev.sub_type then
								tree:SetSelectedItem(cnode)
							end

							function cnode.DoClick(btn)
								RunConsoleCommand(ccv_model, btn.var_model)
								RunConsoleCommand(ccv_type, btn.var_type)
								RunConsoleCommand(ccv_sub_type, btn.var_sub_type)
							end
						end
					end

					node:CAFSort(true)
					--node:ExpandRecurse(false)
				end
			end

			tree:CAFSort(true)
		end
	end
end

--[[
TOOL.*

--required vars
Name				string_sh	standard value
Category			string_sh	standard value

DeviceName		string_cl	Printable Name of device class made by this tool (these are used to made base lang.adds)
DeviceNamePlural	string_cl	Plural Prinable Name of above

ClassName			string_sh	name of class this tools makes (DevSelect=false only) 

DevSelect			bool_sh	false = tool makes one class, true = tool gets device seletion control and cconvars (requires Devices list to be usefull)
--toremove-- DevClasses			table_sv	list of classes made by this tool (for duplicator.RegisterEntityClass)
Devices			table_sh	table of devices (see ls tools for examples)

CCVar_type			string_sh	default clientconvar value for type (DevSelect=true only)
CCVar_sub_type		string_sh	ditto
CCVar_model		string_sh	ditto

Limited			bool_sh	if sbox limit convar should be made
LimitName			string_sh	name of sbox convar (less SBoxLimit_), in most cases this is the toolname (TOOL.Mode)
Limit				number_sv	default limit


NoLeftOnClass		bool_sh	true disallow left clicking if trace.Entity == ClassName (no ghosting too)
NoLeftClickOn		table_sh	list of entity classes that tool can not left click on (no ghosting too)
CanUpdateClassList	table_sv	list of ents the tool can update


ToolMakeEnt		func_sv	you won't need this

MakeFunc			func_sv	if you need to define your own makefunc. DevSelect=false gets ( ply, Ang, trace.HitPos, Frozen, Extra_Data ). DevSelect=true gets ( ply, Ang, trace.HitPos, type, model, Frozen, Extra_Data )

ExtraCCVars		table_sh	list of extra cconvars to add to ClientConVar
ExtraCCVarsCP		func_cl	is given cpanel when BuildCPanel is called (for added custom controls to control panel). gets past tool obj and panel, define as TOOL.ExtraCCVarsCP(tool,panel) or TOOL:ExtraCCVarsCP(panel)
GetExtraCCVars		func_sv	is called during left/right click, return 'Extra_Data' table that is pasted to ent:SetUp(Extra_Data) (if ent has that func). gets past self, define as TOOL:GetExtraCCVars()


Renamed			table_sv	list of classes,types,sub_types that were renamed
Renamed.class		table_sv	key: old class name. value: new class name
Renamed.type		table_sv	ditto
Renamed.sub_type	table_sv	ditto

]]
CAFTool = {}

local function NoLeftClickOn(self, trace)
	return self.NoLeftClickOn and table.HasValue(self.NoLeftClickOn, trace.Entity:GetClass())
end

local function NoHit(self, trace)
	if not trace.HitPos or trace.Entity:IsPlayer() or trace.Entity:IsNPC() then return true end
	if self.NoLeftOnClass and trace.HitNonWorld and trace.Entity:GetClass() == self.ClassName or NoLeftClickOn(self, trace) then return true end

	return false
end

function CAFTool.LeftClick(self, trace)
	if NoHit(self, trace) then return false end
	if CLIENT then return true end
	local ply = self:GetOwner()
	local AllowWorldWeld = self:GetClientNumber("AllowWorldWeld") == 1
	local DontWeld = self:GetClientNumber("DontWeld") == 1
	local Frozen = self:GetClientNumber("Frozen") == 1 or (not AllowWorldWeld and trace.Entity:IsWorld())
	local ent

	--like wire
	if self.ToolMakeEnt then
		ent = self:ToolMakeEnt(trace, ply)
		if ent == true then return true end
		if ent == nil or ent == false or not ent:IsValid() then return false end
	else
		local Extra_Data

		if self.GetExtraCCVars then
			Extra_Data = self:GetExtraCCVars() or {}
		end

		local Ang = trace.HitNormal:Angle()

		if self.GetGhostAngle then
			Ang = self:GetGhostAngle(Ang)
		elseif self.GhostAngle then
			Ang = Ang + self.GhostAngle
		end

		Ang.pitch = Ang.pitch + 90

		if self.DevSelect then
			local type = self:GetClientInfo("type")
			local sub_type = self:GetClientInfo("sub_type")

			if not type or type == "" then
				ErrorNoHalt("RD: GetClientInfo('type') is nil!\n")

				return false
			end

			ent = self.MakeFunc(ply, Ang, trace.HitPos, nil, type, sub_type, nil, Frozen, Extra_Data)
		elseif self.MakeFunc then
			MsgN("self.MakeFunc")
			ent = self.MakeFunc(ply, Ang, trace.HitPos, Frozen, Extra_Data)
		else
			MsgN("no MakeFunc")

			return false
		end

		if not ent or not ent:IsValid() then return false end
		local min = ent:OBBMins()

		if (self.GetGhostMin) then
			ent:SetPos(trace.HitPos - trace.HitNormal * self:GetGhostMin(min))
		elseif (self.GhostMin) then
			ent:SetPos(trace.HitPos - trace.HitNormal * min[self.GhostMin])
		elseif self.GetGhostOffset then
			ent:SetPos(self:GetGhostOffset(trace.HitPos, Ang))
		else
			ent:SetPos(trace.HitPos - trace.HitNormal * min.z)
		end
	end

	--[[Msg("GetPlayer: "..tostring(ent:GetPlayer()).."\n")
	Msg("Ply= "..tostring(ply).."\n")
	ent:SetPlayer(ply)]]
	--CAF.OnEntitySpawn(ent , "SENT" , ply) --Calls the CAF SentSpawn Hook
	local const

	if not DontWeld and (trace.Entity:IsValid() or AllowWorldWeld) then
		const = constraint.Weld(ent, trace.Entity, 0, trace.PhysicsBone, 0, true)
	end

	if Frozen and ent:GetPhysicsObject():IsValid() then
		local Phys = ent:GetPhysicsObject()
		Phys:EnableMotion(false)
		ply:AddFrozenPhysicsObject(ent, Phys)
	end

	undo.Create(self.Mode)
	undo.AddEntity(ent)
	undo.AddEntity(const)
	undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCleanup(self.Mode, ent)

	return true
end

function CAFTool.RightClick(self, trace)
	if trace.HitNonWorld and self.CanUpdateClassList and table.HasValue(self.CanUpdateClassList, trace.Entity:GetClass()) then return false end
	if CLIENT then return true end

	--Update trace.Entity
	if self.GetExtraCCVars then
		local Extra_Data = self:GetExtraCCVars() or {}

		if trace.Entity.Setup then
			trace.Entity:Setup(Extra_Data)
		end
	end

	return true
end

function CAFTool.Reload(self, trace)
	if not trace.Entity:IsValid() then return false end
	if CLIENT then return true end

	if trace.Entity.Repair == nil then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('Object cannot be repaired!', NOTIFY_GENERIC, 7); surface.PlaySound(\"ambient/water/drip" .. math.random(1, 4) .. ".wav\")")

		return
	end

	trace.Entity:Repair()

	return true
end

function CAFTool.UpdateGhost(self, ent)
	if (not ent or not ent:IsValid()) then return end
	local tr = util.GetPlayerTrace(self:GetOwner(), self:GetOwner():GetAimVector())
	local trace = util.TraceLine(tr)
	if (not trace.Hit) then return end

	if (not trace.Hit or trace.Entity:IsPlayer() or trace.Entity:IsNPC() or (self.NoLeftOnClass and trace.Entity:GetClass() == self.ClassName)) or NoLeftClickOn(self, trace) then
		ent:SetNoDraw(true)

		return
	end

	local Ang = trace.HitNormal:Angle()

	if self.GetGhostAngle then
		Ang = self:GetGhostAngle(Ang)
	elseif self.GhostAngle then
		Ang = Ang + self.GhostAngle
	end

	Ang.pitch = Ang.pitch + 90
	local min = ent:OBBMins()

	if (self.GetGhostMin) then
		ent:SetPos(trace.HitPos - trace.HitNormal * self:GetGhostMin(min))
	elseif (self.GhostMin) then
		ent:SetPos(trace.HitPos - trace.HitNormal * min[self.GhostMin])
	elseif self.GetGhostOffset then
		ent:SetPos(self:GetGhostOffset(trace.HitPos, Ang))
	else
		ent:SetPos(trace.HitPos - trace.HitNormal * min.z)
	end

	ent:SetAngles(Ang)
	ent:SetNoDraw(false)
end

function CAFTool.Think(self)
	local model = self.Model or self:GetClientInfo("model")
	if (not model) or (model == nil) or (model == "") or (not util.IsValidModel(model)) then return end

	if not IsValid(self.GhostEntity) or string.lower(model) ~= string.lower(self.GhostEntity:GetModel()) then
		if self.GetGhostAngle then
			self:MakeGhostEntity(model, Vector(0, 0, 0), self:GetGhostAngle(Angle(0, 0, 0)))
		else
			self:MakeGhostEntity(model, Vector(0, 0, 0), self.GhostAngle or Angle(0, 0, 0))
		end
	end

	self:UpdateGhost(self.GhostEntity)
end