--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 17/01/2017
-- Time: 20:41
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local lang = SB.lang
local languages = {}
local defaultLanguage = "en"
local selectedLanguage = GetConVar("gmod_language"):GetString() or defaultLanguage

lang.add = function(language, code, message)
    if not languages[language] then languages[language] = {} end
    languages[language][code] = message
end

lang.get = function(code, default)
    return (languages[selectedLanguage] and languages[selectedLanguage][code]) or languages[defaultLanguage][code] or default or code
end

lang.register = function(code, default)
    language.Add( code, lang.get(code, default) )
end

include("spacebuild/languages/include.lua")

