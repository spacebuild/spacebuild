--[[
		Addon: Custom Addon Framework
		Filename: includes/modules/cache.lua
		Version: 1.0
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net

		Licensed under the Apache License, Version 2.0 (the "License");
		you may not use this file except in compliance with the License.
		You may obtain a copy of the License at

			http://www.apache.org/licenses/LICENSE-2.0

		Unless required by applicable law or agreed to in writing, software
		distributed under the License is distributed on an "AS IS" BASIS,
		WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
		See the License for the specific language governing permissions and
		limitations under the License.
]]
--Simple cache mechanism using the LRU Strategy
local setmetatable = setmetatable
local CurTime = CurTime
local tonumber = tonumber
local pairs = pairs
local timer = timer
local tostring = tostring
module("cache")
local list = {}
list.__index = list
list.type = "cache"
local time

local function removeOldData(cache)
	time = CurTime()

	if cache.contents then
		for k, v in pairs(cache.contents) do
			if v.ttl < time then
				cache:remove(k)
			end
		end
	end
end

local rdata

function list:remove(key)
	if key ~= nil and self.contents[key] then
		rdata = self.contents[key]
		self.contents[key] = nil

		return rdata.data
	end

	return nil
end

--#max amount of elements in the cache table, Time to Live in seconds
function list:create(ttl, remove)
	self.ttl = ttl
	self.contents = {}
	self.should_remove = remove
end

function list:add(key, data)
	self.contents[key] = {
		ttl = CurTime() + self.ttl,
		data = data
	}

	return true
end

function list:update(key)
	self.contents[key].ttl = CurTime() + self.ttl
end

function list:get(key)
	local out_of_date = false

	if self.contents[key] then
		time = CurTime()

		if self.contents[key].ttl < time then
			if self.should_remove then
				self:remove(key)
			end

			out_of_date = true
		end
	end

	if self.contents[key] then return self.contents[key].data, out_of_date end

	return nil, true
end

local id = 0

function create(ttl, remove)
	if not ttl or tonumber(ttl) <= 0 then
		ttl = 1
	end

	local tmp = {}
	setmetatable(tmp, list)
	tmp:create(ttl, remove)

	timer.Create("caf_cache_timer_" .. tostring(id), ttl * 1000, 0, function()
		removeOldData(tmp)
	end)

	id = id + 1

	return tmp
end

function list:clear()
	self.contents = {}
end

--Debug
function list:getList()
	return self.contents
end