--[[ 
		luaunit.lua

Description: A unit testing framework
Homepage: http://phil.freehackers.org/luaunit/
Initial author: Ryu, Gwang (http://www.gpgstudy.com/gpgiki/LuaUnit)
Lot of improvements by Philippe Fremy <phil@freehackers.org>
Version: 1.3  Custom
License: X11 License, see LICENSE.txt


Changes between 1.3 and 1.3 Custom
- Localised a lot of functions/variable for performance
- Made luaunit a proper module
- Removed the verbose settings
- Removed usage of io
- Removed USE_EXPECTED_ACTUAL_IN_ASSERT_EQUALS

Changes between 1.3 and 1.2a:
- port to lua 5.1
- use orderedPairs() to iterate over a table in the right order
- change the order of expected, actual in assertEquals() and the default value of
  USE_EXPECTED_ACTUAL_IN_ASSERT_EQUALS. This can be adjusted with
  USE_EXPECTED_ACTUAL_IN_ASSERT_EQUALS.

Changes between 1.2a and 1.2:
- fix: test classes were not run in the right order

Changes between 1.2 and 1.1:
- tests are now run in alphabetical order
- fix a bug that would prevent all tests from being run

Changes between 1.1 and 1.0:
- internal variables are not global anymore
- you can choose between assertEquals( actual, expected) or assertEquals(
  expected, actual )
- you can assert for an error: assertError( f, a, b ) will assert that calling
  the function f(a,b) generates an error
- display the calling stack when an error is spotted
- a dedicated class collects and displays the result, to provide easy
  customisation
- two verbosity level, like in python unittest
]] --



function assertError(f, ...)
	-- assert that calling f with the arguments will raise an error
	-- example: assertError( f, 1, 2 ) => f(1,2) should generate an error
	local has_error, error_msg = not pcall(f, ...)
	if has_error then return end
	error("No error generated", 2)
end

function assertEquals(actual, expected)
	-- assert that two values are equal and calls error else
	if actual ~= expected then
		local function wrapValue(v)
			if type(v) == 'string' then return "'" .. v .. "'" end
			return tostring(v)
		end

		local errorMsg
		if type(expected) == 'string' then
			errorMsg = "\nexpected: " .. wrapValue(expected) .. "\n" ..
					"actual  : " .. wrapValue(actual) .. "\n"
		else
			errorMsg = "expected: " .. wrapValue(expected) .. ", actual: " .. wrapValue(actual)
		end
		print(errorMsg)
		error(errorMsg, 2)
	end
end

function wrapFunctions(...)
	-- Use me to wrap a set of functions into a Runnable test class:
	-- TestToto = wrapFunctions( f1, f2, f3, f3, f5 )
	-- Now, TestToto will be picked up by LuaUnit:run()
	local testClass, testFunction
	testClass = {}
	local function storeAsMethod(idx, testName)
		testFunction = _G[testName]
		testClass[testName] = testFunction
	end

	table.foreachi({ ... }, storeAsMethod)
	return testClass
end





local string = string
local table = table
local error = error
local _G = _G
local pairs = pairs
local xpcall = xpcall
local loadstring = function(code) return CompileString(code, "luaunit") end
local debug = debug
local print = print
local type = type
local math = math
local unpack = unpack

module("luaunit")

local stack_list, strip_end, testClassList, key, testName, errorMsg
-------------------------------------------------------------------------------
local result = {
	-- class
	failureCount = 0,
	testCount = 0,
	errorList = {},
	currentClassName = "",
	currentTestName = "",
	testHasFailure = false,
}
function result:displayClassName()
	print('------ Class Name: ' .. self.currentClassName)
end

function result:displayTestName()
	print("--- Test: " .. self.currentTestName)
end

function result:displayFailure(errorMsg)
	print(errorMsg)
	print('Failed')
end

function result:displaySuccess()
	print("Ok")
end

function result:displayOneFailedTest(failure)
	testName, errorMsg = unpack(failure)
	print("--- Test: " .. testName .. " failed")
	print(errorMsg)
end

function result:displayFailedTests()
	if table.getn(self.errorList) == 0 then return end
	print("Failed tests:")
	print("-------------")
	table.foreachi(self.errorList, self.displayOneFailedTest)
	print()
end

function result:displayFinalResult()
	print("=========================================================")
	self:displayFailedTests()
	local failurePercent, successCount
	if self.testCount == 0 then
		failurePercent = 0
	else
		failurePercent = 100 * self.failureCount / self.testCount
	end
	successCount = self.testCount - self.failureCount
	print(string.format("Success : %d%% - %d / %d",
		100 - math.ceil(failurePercent), successCount, self.testCount))
	return self.failureCount
end

function result:startClass(className)
	self.currentClassName = className
	self:displayClassName()
end

function result:startTest(testName)
	self.currentTestName = testName
	self:displayTestName()
	self.testCount = self.testCount + 1
	self.testHasFailure = false
end

function result:addFailure(errorMsg)
	self.failureCount = self.failureCount + 1
	self.testHasFailure = true
	table.insert(self.errorList, { self.currentTestName, errorMsg })
	self:displayFailure(errorMsg)
end

function result:endTest()
	if not self.testHasFailure then
		self:displaySuccess()
	end
end

-- class UnitResult end



local function __genOrderedIndex(t)
	local orderedIndex = {}
	for key, _ in pairs(t) do
		table.insert(orderedIndex, key)
	end
	table.sort(orderedIndex)
	return orderedIndex
end

local function orderedNext(t, state)
	-- Equivalent of the next() function of table iteration, but returns the
	-- keys in the alphabetic order. We use a temporary ordered key table that
	-- is stored in the table being iterated.

	--print("orderedNext: state = "..tostring(state) )
	if state == nil then
		-- the first time, generate the index
		t.__orderedIndex = __genOrderedIndex(t)
		key = t.__orderedIndex[1]
		return key, t[key]
	end
	-- fetch the next value
	key = nil
	for i = 1, table.getn(t.__orderedIndex) do
		if t.__orderedIndex[i] == state then
			key = t.__orderedIndex[i + 1]
		end
	end

	if key then
		return key, t[key]
	end

	-- no more value to return, cleanup
	t.__orderedIndex = nil
	return
end

local function orderedPairs(t)
	-- Equivalent of the pairs() function on tables. Allows to iterate
	-- in order
	return orderedNext, t, nil
end


-- Split text into a list consisting of the strings in text,
-- separated by strings matching delimiter (which may be a pattern).
-- example: strsplit(",%s*", "Anna, Bob, Charlie,Dolores")
local function strsplit(delimiter, text)
	local list = {}
	local pos = 1
	if string.find("", delimiter, 1) then -- this would result in endless loops
		error("delimiter matches empty string!")
	end
	while 1 do
		local first, last = string.find(text, delimiter, pos)
		if first then -- found?
			table.insert(list, string.sub(text, pos, first - 1))
			pos = last + 1
		else
			table.insert(list, string.sub(text, pos))
			break
		end
	end
	return list
end

local function isFunction(aObject)
	return 'function' == type(aObject)
end

local function strip_luaunit_stack(stack_trace)
	stack_list = strsplit("\n", stack_trace)
	strip_end = nil
	for i = table.getn(stack_list), 1, -1 do
		-- a bit rude but it works !
		if string.find(stack_list[i], "[C]: in function `xpcall'", 0, true)
		then
			strip_end = i - 2
		end
	end
	if strip_end then
		table.setn(stack_list, strip_end)
	end
	stack_trace = table.concat(stack_list, "\n")
	return stack_trace
end

local function runTestMethod(aName, aClassInstance, aMethod)
	local ok, errorMsg
	-- example: runTestMethod( 'TestToto:test1', TestToto, TestToto.testToto(self) )
	result:startTest(aName)

	-- run setUp first(if any)
	if isFunction(aClassInstance.setUp) then
		aClassInstance:setUp()
	end

	local function err_handler(e)
		return e .. '\n' .. debug.traceback()
	end

	-- run testMethod()
	ok, errorMsg = xpcall(aMethod, err_handler)
	if not ok then
		errorMsg = strip_luaunit_stack(errorMsg)
		result:addFailure(errorMsg)
	end

	-- lastly, run tearDown(if any)
	if isFunction(aClassInstance.tearDown) then
		aClassInstance:tearDown()
	end

	result:endTest()
end

local function runTestMethodName(methodName, classInstance)
	-- example: runTestMethodName( 'TestToto:testToto', TestToto )
	local methodInstance = loadstring(methodName .. '()')
	runTestMethod(methodName, classInstance, methodInstance)
end

local function runTestClassByName(aClassName)
	-- example: runTestMethodName( 'TestToto' )
	local hasMethod, methodName, classInstance
	hasMethod = string.find(aClassName, ':')
	if hasMethod then
		methodName = string.sub(aClassName, hasMethod + 1)
		aClassName = string.sub(aClassName, 1, hasMethod - 1)
	end
	classInstance = _G[aClassName]
	if not classInstance then
		error("No such class: " .. aClassName)
	end

	result:startClass(aClassName)

	if hasMethod then
		if not classInstance[methodName] then
			error("No such method: " .. methodName)
		end
		runTestMethodName(aClassName .. ':' .. methodName, classInstance)
	else
		-- run all test methods of the class
		for methodName, method in orderedPairs(classInstance) do
			--for methodName, method in classInstance do
			if isFunction(method) and string.sub(methodName, 1, 4) == "test" then
				runTestMethodName(aClassName .. ':' .. methodName, classInstance)
			end
		end
	end
	print()
end

function run()

	testClassList = {}
	for key, val in pairs(_G) do
		if string.sub(key, 1, 4) == 'Test' then
			table.insert(testClassList, key)
		end
	end
	for i, val in orderedPairs(testClassList) do
		runTestClassByName(val)
	end
	return result:displayFinalResult()
end

-- class LuaUnit

