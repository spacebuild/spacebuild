--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 21/12/12
-- Time: 13:51
-- To change this template use File | Settings | File Templates.
--



TOOL = nil


MsgN("Loading Legacy Tools [DEPRECATED]")

for key, val in pairs(file.Find("CAF/Stools/*.lua", "LUA")) do
    local s_toolmode = string.sub(val, 0, -5)

    MsgN("\t[DEPRECATED]loading stool: ",val)

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
