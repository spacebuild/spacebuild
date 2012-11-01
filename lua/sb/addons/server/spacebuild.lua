include("sb/addons/spacebuild.lua");

local A = ADDON
local sb = sb;
local environment_data = {}
local environment_classes = { "env_sun", "logic_case" }
local engines = {}
local DEFAULT_ENGINE = "legacy"
local engine = nil
require("sbhelper")


local oldConstruct = A.construct
function A:construct(config)
    oldConstruct(self, config)
    self.config = self:checkConfig(sbhelper.loadConfig(self.name))
end

function A:checkConfig(config)
    local modified = false;
    if not config.version then --Create new config
        modified = true
        config.version = 1
        config.engine = "legacy"
        config.usedrag = true
        config.infiniteresources = false
        config.allownoclip = false
        config.allownocliponplanets = true
        config.allowadminnoclip = true
        config.engine = DEFAULT_ENGINE
    else -- check if config needs updates
    end
    if modified then
        sbhelper.saveConfig(self.name, config)
    end
    return config;
end

function A:addEnvironmentClass(class)
    table.insert(environment_classes, class)
end

function A:registerEngine(name, engine)
    engines[name] = engine
end

function A:initEngine()
    if not engine then
        if not engines[self.config.engine] then
            self.config.engine = DEFAULT_ENGINE
        end
        engine = engines[self.config.engine]
    end
end

function A:start()
    self:initEngine();
    engine:init(environment_data, self)
    self.active = true
end

function A:stop()
    self:initEngine();
    engine:stop(self)
    self.active = false
end

function A:getPlanets()
    self:initEngine();
    engine:getPlanets()
end

function A:getStars()
    self:initEngine();
    engine:getStars()
end

function A:getCustomEnvironments()
    self:initEngine();
    engine:getCustomEnvironments()
end

function A:getAllEnvironments()
    self:initEngine();
    engine:getAllEnvironments()
end

local function getKey(key)
    if key == "Case01" then
        return 1
    elseif key == "Case02" then
        return 2
    elseif key == "Case03" then
        return 3
    elseif key == "Case04" then
        return 4
    elseif key == "Case05" then
        return 5
    elseif key == "Case06" then
        return 6
    elseif key == "Case07" then
        return 7
    elseif key == "Case08" then
        return 8
    elseif key == "Case09" then
        return 9
    elseif key == "Case10" then
        return 10
    elseif key == "Case11" then
        return 11
    elseif key == "Case12" then
        return 12
    elseif key == "Case13" then
        return 13
    elseif key == "Case14" then
        return 14
    elseif key == "Case15" then
        return 15
    elseif key == "Case16" then
        return 16
    else
        return key
    end
end

local function Register_Environments_Data()
    print("Registering environment info\n")
    --Load the planets/stars/bloom/color/... data. The actual creation of the environments will be handled by the "engine"
    local entities;
    local data
    local values
    for k, v in pairs(environment_classes) do
        entities = ents.FindByClass(v)
        for _, ent in ipairs(entities) do
            data = {}
            data["_environment_class"] = v;
            values = ent:GetKeyValues()
            for key, value in pairs(values) do
                data[getKey(key)] = value
            end
            table.insert(environment_data, data)
        end
    end
end

hook.Add("InitPostEntity", "sb4_load_data", Register_Environments_Data)

