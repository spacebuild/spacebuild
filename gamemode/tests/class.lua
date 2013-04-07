--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]

AddCSLuaFile()


local print = print
local class = GM.class

TestClasses = {} --class
function TestClasses:setUp()
	-- this function is run before each test, so that multiple
	-- tests can share initialisations
end

function TestClasses:tearDown()
	-- this function is executed after each test
	-- here, we have nothing to do so we could have avoid
	-- declaring it
end

function TestClasses:testClasses()
	local obj = class.new("Resource", "resource_name")
	assert(obj)
	assertEquals(obj:getName(), "resource_name")

	local network1 = class.new("ResourceNetwork", 1)
	local network2 = class.new("ResourceNetwork", 2)
	local network3 = class.new("ResourceNetwork", 3)
	local ent1 = class.new("ResourceEntity", 10)
	local ent2 = class.new("ResourceEntity", 11)
	local ent3 = class.new("ResourceEntity", 12)
	local ent4 = class.new("ResourceEntity", 13)
	local ent5 = class.new("ResourceEntity", 14)
	local ent6 = class.new("ResourceEntity", 15)

	--Test entity 1
	ent1:addResource("energy", 10000)
	ent1:addResource("water", 8000, 1000)
	ent1:addResource("oxygen", 1000)

	assertEquals(ent1:getMaxResourceAmount("energy"), 10000)
	assertEquals(ent1:getResourceAmount("energy"), 0)
	assertEquals(ent1:getMaxResourceAmount("water"), 8000)
	assertEquals(ent1:getResourceAmount("water"), 1000)
	assertEquals(ent1:getMaxResourceAmount("oxygen"), 1000)
	assertEquals(ent1:getResourceAmount("oxygen"), 0)

	-- Test network 1
	assertEquals(network1:getMaxResourceAmount("energy"), 0)
	assertEquals(network1:getResourceAmount("energy"), 0)
	assertEquals(network1:getMaxResourceAmount("water"), 0)
	assertEquals(network1:getResourceAmount("water"), 0)
	assertEquals(network1:getMaxResourceAmount("oxygen"), 0)
	assertEquals(network1:getResourceAmount("oxygen"), 0)

	-- Connect ent1 to network 1

	network1:link(ent1)
	assertEquals(network1:getMaxResourceAmount("energy"), 10000)
	assertEquals(network1:getResourceAmount("energy"), 0)
	assertEquals(network1:getMaxResourceAmount("water"), 8000)
	assertEquals(network1:getResourceAmount("water"), 1000)
	assertEquals(network1:getMaxResourceAmount("oxygen"), 1000)
	assertEquals(network1:getResourceAmount("oxygen"), 0)

	-- Store more energy in ent1

	ent1:addResource("energy", 10000, 2000)
	assertEquals(ent1:getMaxResourceAmount("energy"), 20000)
	assertEquals(ent1:getResourceAmount("energy"), 2000)
	assertEquals(network1:getMaxResourceAmount("energy"), 20000)
	assertEquals(network1:getResourceAmount("energy"), 2000)

	-- Connect entity 3 and 4 to network 1

	network1:link(ent3)
	network1:link(ent4)

	assertEquals(ent3:getMaxResourceAmount("energy"), 20000)
	assertEquals(ent3:getResourceAmount("energy"), 2000)
	assertEquals(ent4:getMaxResourceAmount("energy"), 20000)
	assertEquals(ent4:getResourceAmount("energy"), 2000)

	--Test entity 2 and network2
	ent2:addResource("energy", 10000)
	ent2:addResource("water", 8000, 1000)
	ent2:addResource("oxygen", 1000)

	assertEquals(ent2:getMaxResourceAmount("energy"), 10000)
	assertEquals(ent2:getResourceAmount("energy"), 0)
	assertEquals(ent2:getMaxResourceAmount("water"), 8000)
	assertEquals(ent2:getResourceAmount("water"), 1000)
	assertEquals(ent2:getMaxResourceAmount("oxygen"), 1000)
	assertEquals(ent2:getResourceAmount("oxygen"), 0)

	network2:link(ent2)
	network2:link(ent5)

	assertEquals(network2:getMaxResourceAmount("energy"), 10000)
	assertEquals(network2:getResourceAmount("energy"), 0)
	assertEquals(ent5:getMaxResourceAmount("energy"), 10000)
	assertEquals(ent5:getResourceAmount("energy"), 0)

	-- Connect network 1 and 2
	-- Connect network 2 and 3

	network1:link(network2)
	network2:link(network3)
	network3:link(ent6)

	assertEquals(network1:getMaxResourceAmount("energy"), 30000)
	assertEquals(network1:getResourceAmount("energy"), 2000)

	assertEquals(network2:getMaxResourceAmount("energy"), 30000)
	assertEquals(network2:getResourceAmount("energy"), 2000)

	assertEquals(network2:getMaxResourceAmount("energy"), 30000)
	assertEquals(network2:getResourceAmount("energy"), 2000)

	assertEquals(ent6:getMaxResourceAmount("energy"), 30000)
	assertEquals(ent5:getResourceAmount("energy"), 2000)

	-- Remove some resources

	ent1:removeResource("energy", 5000)

	assertEquals(network1:getMaxResourceAmount("energy"), 25000)
	assertEquals(network1:getResourceAmount("energy"), 2000)

	assertEquals(network2:getMaxResourceAmount("energy"), 25000)
	assertEquals(network2:getResourceAmount("energy"), 2000)

	assertEquals(network2:getMaxResourceAmount("energy"), 25000)
	assertEquals(network2:getResourceAmount("energy"), 2000)

	assertEquals(ent1:getMaxResourceAmount("energy"), 25000)
	assertEquals(ent1:getResourceAmount("energy"), 2000)
end