TOOL.Category			= "Resource Distribution"
TOOL.Name				= "#ResourceNodes"

TOOL.DeviceName			= "Resource Node"
TOOL.DeviceNamePlural	= "Resource Nodes"
TOOL.ClassName			= "resourcenodes"

TOOL.DevSelect			= true
TOOL.CCVar_type			= "resource_node"
TOOL.CCVar_sub_type		= "small_node"
TOOL.CCVar_model		= "models/SnakeSVx/small_res_node.mdl"

TOOL.Limited			= true
TOOL.LimitName			= "resourcenodes"
TOOL.Limit				= 30

CAFToolSetup.SetLang("RD Resource Nodes","Create Resource Nodes attached to any surface.","Left-Click: Spawn a Device.  Reload: Repair Device.")


TOOL.ExtraCCVars = {
	auto_link = 0,
}

function TOOL.ExtraCCVarsCP( tool, panel )
	panel:CheckBox( "Auto Link", "resourcenodes_auto_link" )
	panel:TextEntry( "Custom Name", "resourcenodes_custom")
end

function TOOL:GetExtraCCVars()
	local Extra_Data = {}
	Extra_Data.auto_link = self:GetClientNumber("auto_link") == 1
	Extra_Data.custom_name = self:GetClientInfo("custom")
	return Extra_Data
end

local function link_in_range(ent, range)
	if ent ~= NULL and IsValid(ent) then
		for k, v in pairs(ents.FindInSphere( ent:GetPos(), range)) do
			local enttable = CAF.GetAddon("Resource Distribution").GetEntityTable(v)
			if table.Count(enttable) > 0 and enttable.network == 0 and ent:GetPlayerName() == v:GetPlayerName() then
				CAF.GetAddon("Resource Distribution").Link(v, ent.netid)
			end
		end
	end
end

local function resource_node_func(ent,type,sub_type,devinfo,Extra_Data,ent_extras)
	MsgAll("Trying to Spawn Resource Node: "..tostring(type).."\n");
	local volume_mul = 1 --Change to be 0 by default later on
	local base_volume = 2958
	local base_mass = 20
	local base_health = 300
	local phys = ent:GetPhysicsObject()
	if phys:IsValid() and phys.GetVolume then
		local vol = phys:GetVolume()
		vol = math.Round(vol)
		volume_mul = vol/base_volume
	end
	local range = 128
	if sub_type == "small_node" then
		range = 512
	elseif sub_type == "medium_node" then
		range = 1024
	elseif sub_type == "large_node" then
		range = 2048
	elseif string.find(ent:GetModel(),"128") then
		range = 128
	elseif string.find(ent:GetModel(),"256") then
		range = 256
	elseif string.find(ent:GetModel(),"512") then
		range = 512
	elseif string.find(ent:GetModel(),"1024") then
		range = 1024
	elseif string.find(ent:GetModel(),"2048") then
		range = 2048
	end
	ent:SetRange(range)
	if Extra_Data and Extra_Data.custom_name then
		Msg("Set name: "..tostring(Extra_Data.custom_name).."\n")
		ent:SetCustomNodeName(Extra_Data.custom_name)
	end
	if Extra_Data and Extra_Data.auto_link then
		 timer.Simple(0.1, function() link_in_range(ent, range * 2) end)
	end
	local mass = math.Round(base_mass * volume_mul)
	local maxhealth = math.Round(base_health * volume_mul)
	return mass, maxhealth
end

TOOL.Devices = {
	resource_node = {
		Name	= "Resource Node",
		type	= "resource_node",
		class	= "resource_node",
		func	= resource_node_func,
		devices = {
			s_small_node = {
				Name	= "Tiny node 128",
				model	= "models/SnakeSVx/s_small_res_node_128.mdl",	
			},
			s_small_node2 = {
				Name	= "Tiny node 256",
				model	= "models/SnakeSVx/s_small_res_node_256.mdl",	
			},
			small_node = {
				Name	= "Small node 512",
				model	= "models/SnakeSVx/small_res_node.mdl",
			},
			medium_node = {
				Name	= "Medium Node 1024",
				model	= "models/SnakeSVx/medium_res_node.mdl",
			},
			large_node = {
				Name	= "Large Node 2048",
				model	= "models/SnakeSVx/large_res_node.mdl",
			},
			small_pipe_straight_128 = {
				Name	= "Small Test pipe 128",
				model	= "models/SnakeSVx/small_res_pipe_straight_128.mdl",
			},
			small_pipe_straight_256 = {
				Name	= "Small Test pipe 256",
				model	= "models/SnakeSVx/small_res_pipe_straight_256.mdl",
			},
			small_pipe_straight_512 = {
				Name	= "Small Test pipe 512",
				model	= "models/SnakeSVx/small_res_pipe_straight_512.mdl",
			},
			small_pipe_straight_1024 = {
				Name	= "Small Test pipe 1024",
				model	= "models/SnakeSVx/small_res_pipe_straight_1024.mdl",
			},
			small_pipe_curve1_128 = {
				Name	= "Small Test pipe curve1 128",
				model	= "models/SnakeSVx/small_res_pipe_curve1_128.mdl",
			},
			small_pipe_curve2_128 = {
				Name	= "Small Test pipe curve2 128",
				model	= "models/SnakeSVx/small_res_pipe_curve2_128.mdl",
			},
			small_pipe_curve3_128 = {
				Name	= "Small Test pipe curve3 128",
				model	= "models/SnakeSVx/small_res_pipe_curve3_128.mdl",
			},
			small_pipe_curve4_128 = {
				Name	= "Small Test pipe curve4 128",
				model	= "models/SnakeSVx/small_res_pipe_curve4_128.mdl",
			},
			small_pipe_T_128 = {
				Name	= "Small Test pipe T 128",
				model	= "models/SnakeSVx/small_res_pipe_T_128.mdl",
			},
			small_pipe_T2_128 = {
				Name	= "Small Test pipe T2 128",
				model	= "models/SnakeSVx/small_res_pipe_T2_128.mdl",
			},
			CS_small_pipe_128 = {
				Name	= "CS Small straight pipe 128",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_128.mdl",
			},
			CS_small_pipe_256 = {
				Name	= "CS Small straight pipe 256",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_256.mdl",
			},
			CS_small_pipe_512 = {
				Name	= "CS Small straight pipe 512",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_512.mdl",
			},
			CS_small_pipe_1024 = {
				Name	= "CS Small straight pipe 1024",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_1024.mdl",
			},
			CS_small_pipe_curve_1 = {
				Name	= "CS Small Curve 1 pipe 128",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve1_128.mdl",
			},
			CS_small_pipe_curve_2= {
				Name	= "CS Small Curve 2 pipe 128",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve1_128.mdl",
			},
			CS_small_pipe_curve_3 = {
				Name	= "CS Small Curve 3 pipe 128",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve3_128.mdl",
			},
			CS_small_pipe_curve_4= {
				Name	= "CS Small Curve 4 pipe 128",
				model	= "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve4_128.mdl",
			},
		},
	},
}


	
	
	
