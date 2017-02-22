--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

-- REQUIRES Von by Vercas!
-- https://github.com/wiremod/wire/blob/master/lua/autorun/von.lua

local function addToTableIgnoreMeta(tab, name, thetype, value)
	if thetype == "string" and string.sub(name,1,2) == "_" then return end
	table.insert(tab, {name = name, type=thetype, value=value})
end

local function getDermaControls()
	local controls = {}
	for _, ctrl in pairs(derma.GetControlList()) do
		addToTableIgnoreMeta(controls, ctrl.ClassName,"function",ctrl)
	end

	return controls
end

local ignoreLibraries = {
	_G = true,
	GAMEMODE = true,
	SPACEBUILD = true,
	GateActions = true,
	AdvDupe = true,
	GPULib = true,
	wire_expression2_funcs = true,
	CAF = true,
	BeamNetVars = true,
	WireDermaExts = true,
	CAFTool = true,
	wire_expression2_constant = true,
	wire_expression_types2 = true,
	CPUTable = true,
	E2Helper = true,
	Wire_Keyboard_Remap = true,
	e2lib_replace_function = true,
	wire_expression_callbacks = true,
	AdvDupeClient = true,
	wire_expression2_funclist = true,
	WireToolSetup = true,
	AdvDupe2 = true,
	WireGPU_Monitors = true,
	WireToolHelpers = true,
	wire_expression2_funclist_lowercase = true,
	EGP = true,
	WireToolObj = true,
	WireTextEditor = true,
	HCOMP = true,
	ArrayList = true,
	CAFEnts = true,
	RESOURCES = true,
	E2Lib = true,
	wire_expression_callbacks = true,
	WireLib = true,
	von = true}

local function getLibraries()
	local libraries = {}

	for k,v in pairs(_G) do
		if type(v) ~= "table" or ignoreLibraries[k] then continue end -- If it's not a table, then it's not a library by definition

			-- the "library" is actually the metatable of a panel, don't put it in the libraries list
			-- SpawniconGenFunctions are also bad news
			if CLIENT and vgui.GetControlTable(k) or k == "SpawniconGenFunctions" then
				continue
				end

				for name, value in pairs(v) do -- All libraries have functions. Some have other members
					libraries[k] = libraries[k] or {}
					addToTableIgnoreMeta(libraries[k], name, type(value),value)
				end
			end

			return libraries
		end

		local function getGlobalFunctions()
			local functions = {}
			for k,v in pairs(_G) do
				if type(v) == "function" then
					addToTableIgnoreMeta(functions, k,"function", v)
				end
			end

			return functions
		end

		local function getEnumerations()
			local enumerations = {}

			for k, v in next, _G do
				if(type(v) == "number" and type(k) == "string" and k:upper() == k) then
					addToTableIgnoreMeta(enumerations, k, type(v), v)
				end
			end

			return enumerations
		end

		local function getMetaMethods()
			local objects = {} -- All the classes that exist, with their respective methods

			local panelFunctionsSeen = {} -- Panels have a different case
			for k,v in pairs(debug.getregistry()) do
				-- All metamethods are in non-empty tables in _R. These tables always have a string as name
				if type(v) != "table" or type(k) ~= "string" then continue end


					for name, func in pairs(v) do
						objects[k] = objects[k] or {}
						addToTableIgnoreMeta(objects[k], name, type(func), func)

						if k == "Panel" then panelFunctionsSeen[name] = true end
					end
				end

				if not CLIENT then return objects end

				-- Several panel objects have their own meta functions. Put them all under Panel to highlight them anyway
				objects["Panel"] = objects["Panel"] or {}
				for k,v in pairs(_G) do
					if not vgui.GetControlTable(k) or not istable(v) then continue end

						for name, func in pairs(v) do
							if not isfunction(func) or panelFunctionsSeen[name] then continue end

								panelFunctionsSeen[name] = true
								addToTableIgnoreMeta(objects["Panel"], name, type(func), func)
							end
						end

						return objects
					end

					local function hooksFromTable(tbl, othertable)
						local found = othertable or {} -- Build upon previously made table

						for k, v in pairs(tbl) do
							if type(v) ~= "table" and not table.HasValue(found, k) then
								addToTableIgnoreMeta(found, k, type(v), v)
							end
						end
						return found
					end

					local function getHooks()
						local hooks = {}

						hooks["SWEP"] = hooksFromTable(weapons.Get("weapon_base")) -- All the weapon hooks
						hooks["TOOL"] = hooksFromTable(weapons.Get("gmod_tool")) -- All the tool hooks
						hooks["GAMEMODE"] = table.Merge(hooksFromTable(GAMEMODE.BaseClass), {"ShowHelp", "ShowSpare1", "ShowSpare2"})  -- All the gamemode hooks, some added manually
						hooks["EFFECT"] = {"Init", "Think", "Render"} -- Effects. Hard coded until a method is found to generate them

						-- Entities
						hooks["ENT"] = hooksFromTable(scripted_ents.Get("base_anim"))
						hooks["ENT"] = hooksFromTable(scripted_ents.Get("base_ai"), hooks["ENT"])
						hooks["ENT"] = hooksFromTable(scripted_ents.Get("widget_base"), hooks["ENT"])
						table.insert(hooks["ENT"], "Category")
						--hooks["ENT"] = hooksFromTable(scripted_ents.Get("base_vehicle"), hooks["ENT"]) -- Gone in gmod 13?

						if SERVER then -- The server only entity types
							hooks["ENT"] = hooksFromTable(scripted_ents.Get("base_point"), hooks["ENT"])
							hooks["ENT"] = hooksFromTable(scripted_ents.Get("base_brush"), hooks["ENT"])
						end

						-- Panels.
						-- Hard coded until a method is found to generate them
						hooks["PANEL"] = {"ActionSignal", "ApplySchemeSettings", "DoClick", "Init", "OnCursorEntered", "OnCursorExited", "OnCursorMoved", "OnKeyCodePressed", "OnKeyCodeReleased", "OnKeyCodeTyped", "OnMousePressed", "OnMouseReleased", "OnMouseWheeled", "Paint", "PaintOver", "PerformLayout", "Think"}

						return hooks
					end

					local function isValidKey(key)
						return key and type(key) == "string"  and not string.find(key, "$", 1, true)  and not string.find(key, "-", 1, true)  and not string.find(key, "/", 1, true) and not string.find(key, " ", 1, true) and not string.find(key, "(", 1, true) and not string.find(key, ")", 1, true) and not string.find(key, ".", 1, true)  and key ~= "package" and key ~= "_G"
					end

					local function processTable(str, tab, inTable, sub)
						for k, v in pairs(tab) do
							local key, thetype, value
							if type(v) == "table" then
								key = v.name
								thetype = v.type
								value = v.value
							elseif sub then
								key = k
								thetype = type(v)
								value = v
							else
								key = v
								thetype = "function"
							end
							if isValidKey(key) then
								if thetype == "function" then
									str = str .. key.." = function() end"
								elseif thetype == "table" then
									str = str .. key.." = {\n"
									str = processTable(str, value, true, true)
									str = str .. "}\n"
								elseif thetype == "number" then
									str = str .. key.." = "..tostring(value)
								else
									str = str .. key.." = \""..tostring(value).."\""
								end

								if inTable then
									str = str .. ","
								end
								str = str.."\n"
							end
						end
						if inTable then
							return str.."nil\n"
						end
						return str
					end


					local function writeTable(fileName, tab, isFlat)
						MsgN("Writing table "..fileName)
						local var = "";
						if isFlat then
							var = processTable(var, tab)
						else
							for k, v in pairs(tab) do
								if isValidKey(k) then
									var = var .. k.."= {\n"
									var = processTable(var, v,true)
									var = var .."}\n"
								end
							end
						end
						file.Write(fileName, var)
					end

					local function generateXSideFiles()
						local side = SERVER and "sv" or "cl"

						writeTable("enums_"..side..".txt", getEnumerations(), true)
						writeTable("libraries_"..side..".txt", getLibraries())
						writeTable("globalfunctions_"..side..".txt", getGlobalFunctions(), true)
						writeTable("metamethods_"..side..".txt", getMetaMethods())
						writeTable("hooks_"..side..".txt",getHooks())

						if CLIENT then
							writeTable("DermaControls_cl.txt", getDermaControls(), true)
						end
					end
					if SERVER then
						concommand.Add("sublime_generate_sv", generateXSideFiles)
					else
						concommand.Add("sublime_generate_cl", generateXSideFiles)
					end
