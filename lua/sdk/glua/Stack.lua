---
-- @description Library Stack
 module("Stack")

--- Stack:Pop
-- @usage shared
-- Pop an item from the stack
--
-- @param  amount=1 number  Amount of items you want to pop.
function Pop( amount) end

--- Stack:Push
-- @usage shared
-- Push an item onto the stack
--
-- @param  object any  The item you want to push
function Push( object) end

--- Stack:Size
-- @usage shared
-- Returns the size of the stack
--
-- @return number The size of the stack
function Size() end

--- Stack:Top
-- @usage shared
-- Get the item at the top of the stack
--
-- @return any The item at the top of the stack
function Top() end
