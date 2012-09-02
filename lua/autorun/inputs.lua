--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 25/03/12
-- Time: 11:04
-- To change this template use File | Settings | File Templates.
--

local version = 1;
local WireAddon = WireAddon

if not inputs or not inputs.version or inputs.version < version then
    inputs = {}
    local types = {
        NONE = 0,
        STRING = 1,
        NUMBER = 2,
        VECTOR = 3,
        ENTITY = 4;
        CUSTOM = 255,
    }
    inputs.types = types;
    local convert = {
        tostring,
        tonumber,
        function(vector_string) return {} end, --TODO
        function(ent_id) return Entity(tonumer(entid)) end
    }

    local inpts = inputs;
    inpts.version = version;

    local function capitalize(str)
        return str:gsub("^%l", string.upper)
    end

    local function generateMutatorNames(str)
        str = capitalize(str);
        return "get" .. str, "set" .. str;
    end

    local function convertValue(data, value)
        if data then
            if (data.type ~= types.NONE) then
                if (data.type == types.CUSTOM) then
                    if data.convert then
                        value = data.convert(value)
                    end
                else
                    if (convert[data.type]) then
                        value = convert[data.type](value)
                    end
                end
            end
        end
        return value
    end

    local tmp, tmp2, tmp3;

    function inpts.register(ent, input_data, output_data, shared_data)
        ent.inputenabled = true;

        --convert tables to correct input
        if table.IsSequential(input_data) then
            tmp = input_data;
            input_data = {}
            for _, v in pairs(tmp) do
                input_data[v] = { name = v, type = types.STRING }
            end
        end
        if table.IsSequential(output_data) then
            tmp = output_data;
            output_data = {}
            for _, v in pairs(tmp) do
                output_data[v] = { name = v, type = types.STRING }
            end
        end
        if table.IsSequential(shared_data) then
            tmp = shared_data;
            shared_data = {}
            for _, v in pairs(tmp) do
                shared_data[v] = { name = v, type = types.STRING }
            end
        end

        if SERVER then
            for k, v in pairs(shared_data) do
                input_data[k] = v;
                output_data[k] = v;
            end
            shared_data = nil
        else
            ent.menu_inputs = input_data;
            ent.menu_shared = shared_data;
            ent.menu_outputs = output_data;
        end

        --Enable setter function
        local oldTriggerInput = ent.TriggerInput;

        function ent:TriggerInput(iname, value)
            local get, set = generateMutatorNames(iname);
            if ent[set] then
                ent[set](convertValue(input_data[iname], value))
            elseif oldTriggerInput then
                oldTriggerInput(iname, value);
            end
        end

        --Enable getter function
        function ent:getValue(iname)
            local get, set = generateMutatorNames(iname);
            if ent[get] then
                return ent[get]()
            end
            return ent[iname]
        end

        function ent:setValue(iname, value)
            self:TriggerInput(iname, value)
        end


        -- first we add support for wire inputs
        if SERVER and WireAddon then
            local input_keys = {}
            local output_keys = {}

            for k, _ in pairs(input_data) do
                table.insert(input_keys, k);
            end
            for k, _ in pairs(output_data) do
                table.insert(output_keys, k);
            end

            ent.WireDebugName = ent.PrintName
            ent.Inputs = Wire_CreateInputs(ent, input_keys)
            ent.Outputs = Wire_CreateOutputs(ent, output_keys)
        end
    end

    local function drawMenu(ent)
    end


    properties.Add("inputmenu",
        {
            MenuLabel = "Open Input Menu",
            Order = 1000,
            Filter = function(self, ent)
                if not IsValid(ent) then return false end
                if ent:IsPlayer() then return false end
                return ent.inputenabled
            end,
            Action = function(self, ent)
                drawMenu(ent)
            end
        });

    if SERVER then
        local function setvalue(player, command, arguments)
            local ent = arguments[1];
            ent = Entity(ent);
            if ent and ent.setValue then
                ent.setValue(arguments[2], arguments[3])
            end
        end

        concommand.Add("input_set_value", setvalue)

        local function getvalue(player, command, arguments)
            local ent = arguments[1];
            ent = Entity(ent);
            if ent and ent.getValue then
                local value = ent.getValue(arguments[2])
                -- TODO send it back to the client
            end
        end

        concommand.Add("input_get_value", getvalue)
    end
end