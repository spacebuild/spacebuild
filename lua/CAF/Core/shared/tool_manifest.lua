

TOOL = nil


MsgN("Loading CAF Tools")

include( "tool_helpers.lua" )

local files = {
    "ls3_energysystems",
    "ls3_environmental_control",
    "ls3_other",
    "ls3_other_ligths",
    "ls3_receptacles",
    "pumps",
    "resourcenodes",
    "sb_dev_plants",
    "sb_terraformer",
    "valves"
}

for key, val in pairs(file.Find("CAF/Stools/*.lua", "LUA")) do
	local s_toolmode = string.sub(val, 0, -5)
	
	MsgN("\tloading stool: ",val)

	CAFToolSetup.open( s_toolmode )
	
	AddCSLuaFile( "CAF/Stools/"..val )
	include( "CAF/Stools/"..val )
	
	CAFToolSetup.BaseCCVars()
	CAFToolSetup.BaseLang()
	CAFToolSetup.MaxLimit()
	CAFToolSetup.RegEnts()
	CAFToolSetup.MakeFunc()
	CAFToolSetup.MakeCP()
	CAFToolSetup.close()
end

CAFToolSetup = nil
