-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

TOOL.Category = "Spawner"
TOOL.Name = "#Part Spawner"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.Tab = "Main"

local SmallBridgeModels = list.Get("SB4_ModelParts")

if CLIENT then
	language.Add("Tool.sbep_part_spawner.name", "SB4 Part Spawner")
	language.Add("Tool.sbep_part_spawner.desc", "Spawn SB4 props.")
	language.Add("Tool.sbep_part_spawner.0", "Left click to spawn a prop.")
	language.Add("undone_SB4 Part", "Undone SB4 Part")
end

TOOL.ClientConVar["model"] = "models/SmallBridge/Hulls_SW/sbhulle1.mdl"
TOOL.ClientConVar["skin"] = 0
TOOL.ClientConVar["glass"] = 0
TOOL.ClientConVar["hab_mod"] = 0

function TOOL:LeftClick(trace)

	if CLIENT then return end

	local model = self:GetClientInfo("model")
	local hab = self:GetClientNumber("hab_mod")
	local skin = self:GetClientNumber("skin")
	local glass = self:GetClientNumber("glass")
	local pos = trace.HitPos

	local SMBProp = nil

	if hab == 1 then
		SMBProp = ents.Create("base_livable_module")
	else
		SMBProp = ents.Create("prop_physics")
	end

	SMBProp:SetModel(model)

	local skincount = SMBProp:SkinCount()
	local skinnum = nil
	if skincount > 5 then
		skinnum = skin * 2 + glass
	else
		skinnum = skin
	end
	SMBProp:SetSkin(skinnum)

	SMBProp:SetPos(pos - Vector(0, 0, SMBProp:OBBMins().z))

	SMBProp:Spawn()
	SMBProp:Activate()

	undo.Create("SB4 Part")
	undo.AddEntity(SMBProp)
	undo.SetPlayer(self:GetOwner())
	undo.Finish()

	return true
end

function TOOL:RightClick(trace)
	CC_GMOD_Tool(self:GetOwner(), "", { "sbep_part_assembler" })
end

function TOOL:Reload(trace)
end

function TOOL.BuildCPanel(panel)

	panel:SetSpacing(10)
	panel:SetName("SB4 Part Spawner")

	local SkinTable =
	{
		"Advanced",
		"SlyBridge",
		"MedBridge2",
		"Jaanus",
		"Scrappers"
	}

	local SkinSelector = vgui.Create( "DComboBox", panel )
	SkinSelector:Dock(TOP)
	SkinSelector:DockMargin( 2,2,2,2 )
	SkinSelector:SetValue( SkinTable[GetConVar("sb4_partspawner_skin"):GetInt()] or SkinTable[1] )
	SkinSelector.OnSelect = function( index, value, data )
		RunConsoleCommand( "sb4_partspawner_skin", value )
	end
	for k,v in pairs( SkinTable ) do
		SkinSelector:AddChoice( v )
	end

	local GlassButton = vgui.Create( "DCheckBoxLabel", panel )
	GlassButton:Dock(TOP)
	GlassButton:DockMargin(2,2,2,2)
	GlassButton:SetValue( GetConVar( "sb4_partspawner_glass" ):GetBool() )
	GlassButton:SetText( "Glass:" )
	GlassButton:SetConVar( "sb4_partspawner_glass" )

	for Tab,v  in pairs( SmallBridgeModels ) do
		for Category, models in pairs( v ) do
			local catPanel = vgui.Create( "DCollapsibleCategory", panel )
			catPanel:Dock( TOP )
			catPanel:DockMargin(2,2,2,2)
			catPanel:SetText(Category)
			catPanel:SetLabel(Category)

			local grid = vgui.Create( "DGrid", catPanel )
			grid:Dock( TOP )
			--grid:SetCols( 3 )
			local width,_ = catPanel:GetSize()
			grid:SetColWide( 64 )
			grid:SetRowHeight( 64 )

			for key, modelpath in pairs( models ) do
				local icon = vgui.Create( "SpawnIcon", panel )
				--icon:Dock( TOP )
				icon:SetModel( modelpath )
				icon:SetToolTip( modelpath )
				icon.DoClick = function( panel )

					RunConsoleCommand( "sb4_partspawner_model", modelpath )
				end
				--icon:SetIconSize( width )
				grid:AddItem( icon )

			end
			catPanel:SetExpanded( 0 )
		end
	end
end
