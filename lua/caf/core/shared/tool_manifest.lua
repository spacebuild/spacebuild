TOOL = nil
MsgN("Loading CAF Tools")
include("tool_helpers.lua")

for key, val in pairs(file.Find("CAF/Stools/*.lua", "LUA")) do
	local s_toolmode = string.sub(val, 0, -5)
	MsgN("\tloading stool: ", val)
	CAFToolSetup.open(s_toolmode)
	AddCSLuaFile("caf/stools/" .. val)
	include("caf/stools/" .. val)
	CAFToolSetup.BaseCCVars()
	CAFToolSetup.BaseLang()
	CAFToolSetup.MaxLimit()
	CAFToolSetup.RegEnts()
	CAFToolSetup.MakeFunc()
	CAFToolSetup.MakeCP()
	CAFToolSetup.close()
end

CAFToolSetup = nil