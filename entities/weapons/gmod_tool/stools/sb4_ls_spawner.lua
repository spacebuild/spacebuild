--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]] --
-- Created by IntelliJ IDEA.
-- User: Sam
-- Date: 26/12/12
-- Time: 1:24 PM
-- To change this template use File | Settings | File Templates.
--

TOOL.Category = "Spawners" --TODO: Change for Sb4
TOOL.Name = "#Generator Spawner"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.Tab = "Spacebuild"

local generators = {}
--[[generators.energy = {} -- Doesnt have to be energy just the name of the cagory you want.
generators.energy[1]= {} -- Set this as a unique name
generators.energy[1].Name = "My First Energy Generator"
generators.energy[1].Model = "models/props_borealis/bluebarrel001.mdl" --Your entity's model
generators.energy[1].EntityClass = "resource_generator_energy"
generators.energy[1].EntityDescription = "An energy generator."

generators.oxygen = {}
generators.oxygen[1] = {}
generators.oxygen[1].Name = "My First Oxygen Generator"
generators.oxygen[1].Model = "models/props_borealis/mooring_cleat01.mdl"
generators.oxygen[1].EntityClass = "resource_generator_oxygen"
generators.oxygen[1].EntityDescription = "The First created oxygen generator."]]


--TODO: Fix undo

if CLIENT then
	language.Add("Tool.sb4_ls_spawner.name", "Spacebuild Generator Spawner")
	language.Add("Tool.sb4_ls_spawner.desc", "Spawn Spacebuild Generators.")
	language.Add("Tool.sb4_ls_spawner.0", "Left click to spawn a generator.")
	language.Add("Undone_Undo Generators", "Undone Generator")
end

TOOL.ClientConVar["model"] = "models/SmallBridge/Hulls_SW/sbhulle1.mdl"
TOOL.ClientConVar["class"] = ""
TOOL.ClientConVar["description"] = ""
TOOL.ClientConVar["weld"] = 0
TOOL.ClientConVar["freeze"] = 0
TOOL.ClientConVar["world"] = 0

--Sample entTable for devs to see how to add.
--[[
entTables = {}
entTables[1] = {
	Name = "Name Here",
	Model = "",
	EntityClass = "Class",
	EntityDescription = "A sample ent for developers"
}

]]


function TOOL:AddRDEntities(entTables, type)
	if not generators[type] then
		generators[type] = {}
	end
	highest = 0
	for k, v in pairs(generators[type]) do
		--Let's get the highest number:
		print(v) -- 1,2,3)
		if (k > highest) then
			highest = k
		end
	end
	highest = highest + 1
	for k, v in pairs(entTables) do
		generators[type][highest] = {
			Name = v.Name,
			Model = v.Model,
			EntityClass = v.EntityClass,
			EntityDescription = v.EntityDescription
		}
		highest = highest + 1
	end
	--PrintTable(generators)
end

function TOOL:LeftClick(trace)
	--Spawn in the selected Generator

	if CLIENT then return end

	local model = self:GetClientInfo("model")
	local class = self:GetClientInfo("class")
	local desc = self:GetClientInfo("description")
	local weld = self:GetClientInfo("weld")
	local world = self:GetClientInfo("world")
	local freeze = self:GetClientInfo("freeze")
	local pos = trace.HitPos
	local ply = self:GetOwner()
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	MsgN("Freeze: " .. freeze)
	MsgN("Weld: " .. weld)
	MsgN("WorldWeld" .. world)

	local ent = ents.Create(class)
	ent:SetModel(model)
	ent:SetPos(trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	--ent:Spawn()
	ent:Spawn()
	--ent:SetModel(model) --Don't set the model again, it messes up physics
	--ent:PhysWake()
	local phys = ent:GetPhysicsObject()
	MsgN("IsValid: " .. tostring(trace.Entity:IsValid()))
	if (tonumber(weld) == 1) then
		if (tonumber(world) == 1) then
			local const = constraint.Weld(ent, trace.Entity, 0, trace.PhysicsBone, 0, true)
			--Weld to props and World
		elseif (trace.Entity:IsValid() == true) then
			MsgN("IsValid: " .. tostring(trace.Entity:IsValid()))
			MsgN("Welding to Props Not world")
			local const = constraint.Weld(ent, trace.Entity, 0, trace.PhysicsBone, 0, true)
			--Weld to props but not to world
		end
	end
	MsgN("Freeze " .. freeze)

	if (tonumber(freeze) == 1) then
		MsgN("Freezing")
		phys:EnableMotion(false)
	end

	undo.Create("Undo Generators")
	undo.AddEntity(ent)
	--undo.AddEntity( const )
	undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCleanup("Generators", ent)

	return true
end


function TOOL:RightClick(trace)
	--Select Model
	--[[
if (  not trace.Entity:IsValid() or trace.Entity:IsPlayer() ) then return false end

RunConsoleCommand( "sb4_ls_spawner_model", trace.Entity:GetModel())
]] --

	local ent = trace.Entity
end

function TOOL:Reload(trace)
	if (not trace.Entity:IsValid() or trace.Entity:IsPlayer()) then return false end
	if (CLIENT) then return true end

	constraint.RemoveConstraints(trace.Entity, "Weld")
	self:ClearObjects()

	return true
	-- Don't know.
	-- Maybe upgrade the generator making it bigger.
	--self.rdobject.network() Returns the network stuff.
end

function TOOL.BuildCPanel(panel)



	--generators[CO2] = {}
	panel:SetSpacing(10)
	panel:SetName("SBEP Part Spawner")


	--Add the categories
	local counter = 1
	local categories = {}

	--Create CheckBoxes for Welding, Freezing
	local WeldButton = vgui.Create("DCheckBoxLabel", panel)
	WeldButton:Dock(TOP)
	WeldButton:DockMargin(5, 10, 2, 2)
	WeldButton:SetValue(GetConVar("sb4_ls_spawner_weld"):GetBool())
	WeldButton:SetText("Weld:")
	WeldButton:SetConVar("sb4_ls_spawner_weld")

	local FreezeButton = vgui.Create("DCheckBoxLabel", panel)
	FreezeButton:Dock(TOP)
	FreezeButton:DockMargin(5, 10, 2, 2)
	FreezeButton:SetValue(GetConVar("sb4_ls_spawner_freeze"):GetBool())
	FreezeButton:SetText("Freeze:")
	FreezeButton:SetConVar("sb4_ls_spawner_freeze")

	local AllowWorld = vgui.Create("DCheckBoxLabel", panel)
	AllowWorld:Dock(TOP)
	AllowWorld:DockMargin(5, 10, 2, 2)
	AllowWorld:SetValue(GetConVar("sb4_ls_spawner_world"):GetBool())
	AllowWorld:SetText("Allow World Welding:")
	AllowWorld:SetConVar("sb4_ls_spawner_world")


	local InfoFrame = vgui.Create("DPanel")

	local BigIcon = vgui.Create("SpawnIcon", InfoFrame)
	--BigIcon:Dock( LEFT )
	BigIcon:SetPos(2, 2)
	BigIcon:SetSize(128, 128)
	BigIcon:SetModel("")

	local Title = vgui.Create("DLabel", InfoFrame)
	Title:SetPos(132, 2)
	Title:SetText("Please Select")
	Title:SetSize(100, 0) -- YES I KNOW
	Title:SetColor(Color(0, 0, 0, 255))
	Title:SetFont("WorkshopLarge")
	Title:SizeToContents()


	local Info = vgui.Create("DLabel")
	Info:SetText("Waiting for Selection")
	Info:SetParent(InfoFrame)
	Info:SetPos(132, 16)
	Info:SetWrap(true)
	Info:SetSize(175, 128)
	Info:SetColor(Color(255, 0, 0, 255))
	Info:SetFont("ToolInfo")




	for k, v in pairs(generators) do
		if (counter == 1) then
			categories[counter] = vgui.Create("DCollapsibleCategory", panel)
			categories[counter]:Dock(TOP)
			categories[counter]:DockMargin(2, 20, 2, 2)
			local s = tostring(k)
			categories[counter]:SetLabel(s:sub(1, 1):upper() .. s:sub(2))

			local grid = vgui.Create("DGrid", categories[counter])
			grid:Dock(TOP)
			--grid:SetCols( 3 )
			local width, _ = categories[counter]:GetSize()
			grid:SetColWide(64)
			grid:SetRowHeight(64)
			PrintTable(v)
			for i, j in pairs(generators[k]) do
				MsgN(j.Model)
				local icon = vgui.Create("SpawnIcon", panel)
				icon:SetModel(j.Model)
				icon:SetToolTip(j.EntityDescription)
				local model = j.Model
				local class = j.EntityClass
				local desc = j.EntityDescription
				icon.DoClick = function(model, class, desc)
				--TODO: Fill this out.
					RunConsoleCommand("sb4_ls_spawner_model", j.Model)
					RunConsoleCommand("sb4_ls_spawner_class", j.EntityClass)
					MsgN("SpawnIcon Pressed")
					RunConsoleCommand("sb4_ls_spawner_description", j.EntityDescription)
					BigIcon:SetModel(j.Model)
					Title:SetFont("WorkshopLarge")
					Title:SetText(j.Name)
					Title:SetFont("WorkshopLarge")
					Title:SizeToContents()
					Info:SetText(j.EntityDescription)
					Info:SetWrap(true)
					Info:SizeToContents()
				end
				--icon:SetIconSize( width )
				grid:AddItem(icon)
			end
			counter = counter + 1
		else
			categories[counter] = vgui.Create("DCollapsibleCategory", panel)
			categories[counter]:Dock(TOP)
			categories[counter]:DockMargin(2, 2, 2, 2)
			local s = tostring(k)
			categories[counter]:SetLabel(s:sub(1, 1):upper() .. s:sub(2))
			local grid = vgui.Create("DGrid", categories[counter])
			grid:Dock(TOP)
			--grid:SetCols( 3 )
			local width, _ = categories[counter]:GetSize()
			grid:SetColWide(64)
			grid:SetRowHeight(64)
			for i, j in pairs(generators[k]) do
				MsgN(j.Model)
				local icon = vgui.Create("SpawnIcon", panel)
				icon:SetModel(j.Model)
				icon:SetToolTip(j.EntityDescription)
				local model = j.Model
				local class = j.EntityClass
				local desc = j.EntityDescription
				icon.DoClick = function(model, class, desc)
				--TODO: Fill this out.
					RunConsoleCommand("sb4_ls_spawner_model", j.Model)
					RunConsoleCommand("sb4_ls_spawner_class", j.EntityClass)
					MsgN("SpawnIcon Pressed")
					RunConsoleCommand("sb4_ls_spawner_description", j.EntityDescription)
					BigIcon:SetModel(j.Model)
					Title:SetText(j.Name)
					Title:SizeToContents()
					Info:SetText(j.EntityDescription)
					Info:SetWrap(true)
					Info:SizeToContents()
				end
				--icon:SetIconSize( width )
				grid:AddItem(icon)
			end
			counter = counter + 1
		end
	end


	InfoFrame:SetParent(panel)
	InfoFrame:SetSize(panel:GetWide() - 10, 400)
	MsgN("Width: " .. panel:GetWide() - 10)
	InfoFrame:DockMargin(10, 2, 10, 2)
	InfoFrame:Dock(TOP)


	--[[

--Example to show how to set up
local generators = {}
generators.energy = {} -- Doesnt have to be energy just the name of the cagory you want.
generators.energy.YourEntityName = {} -- Set this as a unique name
generators.energy.YourEntityName.Model = "Your entity's model"
generators.energy.YourEntityName.EntityClass = "Your Entity's Class"
generators.energy.YourEntityName.EntityDescription = "A test entity that isn't real and won't do anything"


]] --
end
hook.Call("OnToolCreated", GAMEMODE,"sb4_generators", TOOL)


