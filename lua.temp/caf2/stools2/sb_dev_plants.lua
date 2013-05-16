TOOL.Category = "Life Support"
TOOL.Name = CAF.GetLangVar("#Dev Plants")

TOOL.DeviceName = "Dev Plant"
TOOL.DeviceNamePlural = "Dev Plants"
TOOL.ClassName = "sb_dev_plants"

TOOL.DevSelect = true
TOOL.CCVar_type = "nature_dev_tree"
TOOL.CCVar_sub_type = "default"
TOOL.CCVar_model = "models/chipstiks_ls3_models/OxygenCompressor/oxygencompressor.mdl"

TOOL.Limited = true
TOOL.LimitName = "sb_dev_plants"
TOOL.Limit = 30
TOOL.AdminOnly = true

CAFToolSetup.SetLang(CAF.GetLangVar("sb_dev_plants_title"), CAF.GetLangVar("sb_dev_plants_desc"), CAF.GetLangVar("sb_dev_plants_desc2"))

function TOOL.EnableFunc()
    local SB = CAF.GetAddon("Spacebuild")
    if not SB or not SB.GetStatus() then
        return false;
    end
    return true;
end

TOOL.ExtraCCVars = {
    rate = 0,
}

function TOOL.ExtraCCVarsCP(tool, panel)
    panel:NumSlider(CAF.GetLangVar("O2 Refresh Rate"), "sb_dev_plants_rate", 0, 10000, 0)
end

function TOOL:GetExtraCCVars()
    local Extra_Data = {}
    Extra_Data.rate = self:GetClientNumber("rate")
    return Extra_Data
end

local function gas_generator_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 200
    local base_health = 600
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    ent:SetRate(Extra_Data.rate)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

TOOL.Devices = {
    nature_dev_tree = {
        Name = CAF.GetLangVar("Dev Plants (Auto O2 Refresher)"),
        type = "nature_dev_tree",
        class = "nature_dev_tree",
        func = gas_generator_func,
        devices = {
            default = {
                Name = "Block Plant",
                model = "models/ce_ls3additional/plants/plantfull.mdl",
            },
        },
    },
}


	
	
	
