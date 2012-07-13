

TOOL = nil


MsgN("Loading CAF Tools")

include( "tool_helpers.lua" )

for key, val in pairs(file.FindInLua("CAF/Stools/*.lua")) do
	local _,_,s_toolmode = string.find( val, "([%w_]*)\.lua" )
	
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
