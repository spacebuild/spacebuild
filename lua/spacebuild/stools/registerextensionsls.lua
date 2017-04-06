--[[============================================================================
  Project spacebuild extensions                                                =
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

local SB = SPACEBUILD

local function initEnergyStorageTools(SB)
    local category = "Storage"
    SB:registerDeviceInfo(
        category,
        "CE Small Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_small.mdl",
        function(ent)
            ent:addResource("energy", 1500)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CE Medium Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_medium.mdl",
        function(ent)
            ent:addResource("energy", 9000)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CE Large Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_large.mdl",
        function(ent)
            ent:addResource("energy", 27000)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CE Mini Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_mini.mdl",
        function(ent)
            ent:addResource("energy", 50)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CE Huge Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_huge.mdl",
        function(ent)
            ent:addResource("energy", 54000)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CE Giant Energy Storage",
        "base_resource_entity",
        "models/ce_ls3additional/energy_cells/energy_cell_giant.mdl",
        function(ent)
            ent:addResource("energy", 108000)
        end
    )
end

local function initResourceNodes(SB)
    local category = "Network"
    SB:registerDeviceInfo(
        category,
        "Tiny node 128",
        "base_resource_network",
        "models/SnakeSVx/s_small_res_node_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Tiny node 256",
        "base_resource_network",
        "models/SnakeSVx/s_small_res_node_256.mdl",
        function(ent)
            ent.range = 256
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small node 512",
        "base_resource_network",
        "models/SnakeSVx/small_res_node.mdl",
        function(ent)
            ent.range = 512
        end
    )
    SB:registerDeviceInfo(
        category,
        "Medium Node 1024",
        "base_resource_network",
        "models/SnakeSVx/medium_res_node.mdl",
        function(ent)
            ent.range = 1024
        end
    )
    SB:registerDeviceInfo(
        category,
        "Large Node 2048",
        "base_resource_network",
        "models/SnakeSVx/large_res_node.mdl",
        function(ent)
            ent.range = 2048
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_straight_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe 256",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_straight_256.mdl",
        function(ent)
            ent.range = 256
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe 512",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_straight_512.mdl",
        function(ent)
            ent.range = 512
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe 1024",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_straight_1024.mdl",
        function(ent)
            ent.range = 1024
        end
    )

    SB:registerDeviceInfo(
        category,
        "Small Test pipe curve1 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_curve1_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe curve2 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_curve2_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe curve3 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_curve3_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe curve4 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_curve4_128.mdl",
        function(ent)
            ent.range = 128
        end
    )

    SB:registerDeviceInfo(
        category,
        "Small Test pipe T 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_T_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "Small Test pipe T2 128",
        "base_resource_network",
        "models/SnakeSVx/small_res_pipe_T2_128.mdl",
        function(ent)
            ent.range = 128
        end
    )

    SB:registerDeviceInfo(
        category,
        "CS Small straight pipe 128",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small straight pipe 256",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_256.mdl",
        function(ent)
            ent.range = 256
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small straight pipe 512",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_512.mdl",
        function(ent)
            ent.range = 512
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small straight pipe 1024",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_straight_1024.mdl",
        function(ent)
            ent.range = 1024
        end
    )

    SB:registerDeviceInfo(
        category,
        "CS Small Curve 1 pipe 128",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve1_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small Curve 2 pipe 128",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve2_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small Curve 3 pipe 128",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve3_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Small Curve 4 pipe 128",
        "base_resource_network",
        "models/chipstiks_ls3_models/Pipes/small_res_pipe_curve4_128.mdl",
        function(ent)
            ent.range = 128
        end
    )
end

local function initWaterPumps(SB)
    local category = "Storage"
    SB:registerDeviceInfo(
        category,
        "CE Medium Water Pump",
        "resource_generator_water_pump",
        "models/ce_ls3additional/water_pump/water_pump.mdl",
        function(ent)
            ent.rdobject:generatesResource("water", 300, 0)
            ent.rdobject:requiresResource("energy", 15, 5)
            SB.util.wire.registerDefaultOutputs(ent, true, {"WaterRate", "EnergyRate"})
            SB.util.wire.registerDefaultInputs(ent, true)
        end
    )
    SB:registerDeviceInfo(
        category,
        "CS Large Water Pump",
        "resource_generator_water_pump",
        "models/chipstiks_ls3_models/LargeH2OPump/largeh2opump.mdl",
        function(ent)
            ent.rdobject:generatesResource("water", 500, 0)
            ent.rdobject:requiresResource("energy", 30, 10)
            SB.util.wire.registerDefaultOutputs(ent, true, {"WaterRate", "EnergyRate"})
            SB.util.wire.registerDefaultInputs(ent, true)
        end
    )
end

function SB:registerExtensionsLS()
    initEnergyStorageTools(self)
    initResourceNodes(self)
    initWaterPumps(self)
end

