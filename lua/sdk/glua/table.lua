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

---
-- @description Library table
 module("table")

--- table.Add
-- @usage shared_m
-- Adds the contents from one table into another.
--
-- @param  target table  The table to insert the new values into.
-- @param  source table  The table to retrieve the values from.
-- @return table The table the values were appended to.
function Add( target,  source) end

--- table.ClearKeys
-- @usage shared_m
-- Changes all keys to sequential integers. This creates a new table object and does not affect the original.
--
-- @param  table table  The original table to modify.
-- @param  saveKeys=false boolean  Save the keys within each member table. This will insert a new field __key into each value, and should not be used if the table contains non-table values.
-- @return table Table with integer keys.
function ClearKeys( table,  saveKeys) end

--- table.CollapseKeyValue
-- @usage shared_m
-- Collapses a table with keyvalue structure
--
-- @param  input table  Input table
-- @return table Output table
function CollapseKeyValue( input) end

--- table.concat
-- @usage shared_m
-- Concatenates the contents of a table to a string.
--
-- @param  tbl table  The table to concatenate.
-- @param  concatenator="" string  A seperator to insert between strings
-- @param  startPos=1 number  The key to start at
-- @param  endPos=#tbl number  The key to end at
-- @return string Concatenated values
function concat( tbl,  concatenator,  startPos,  endPos) end

--- table.Copy
-- @usage shared_m
-- Creates a deep copy and returns that copy.
--
-- @param  originalTable table  The table to be copied.
-- @return table A deep copy of the original table
function Copy( originalTable) end

--- table.CopyFromTo
-- @usage shared_m
-- Empties the target table, and merges all values from the source table into it.
--
-- @param  source table  The table to copy from.
-- @param  target table  The table to write to.
function CopyFromTo( source,  target) end

--- table.Count
-- @usage shared_m
-- Counts the amount of keys in a table. This should only be used when a table is not numerically and sequentially indexed. For those tables, consider the length operator.
--
-- @param  tbl table  The table to count the keys of.
-- @return number The number of keyvalue pairs. This includes non-numeric and non-sequential keys, unlike the length (#) operator.
function Count( tbl) end

--- table.DeSanitise
-- @usage shared_m
-- Converts a table that has been sanitised with table.Sanitise back to its original form
--
-- @param  tbl table  Table to be de-sanitised
-- @return table De-sanitised table
function DeSanitise( tbl) end

--- table.Empty
-- @usage shared_m
-- Removes all values from a table.
--
-- @param  tbl table  The table to empty.
function Empty( tbl) end

--- table.FindNext
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Instead, iterate the table using ipairs or increment from the previous index. Non-numerically indexed tables are not ordered.
-- @param  tbl table  Table to search
-- @param  value any  Value to return element after
-- @return any Found element
function FindNext( tbl,  value) end

--- table.FindPrev
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Instead, iterate your table with ipairs, storing the previous value and checking for the target. Non-numerically indexed tables are not ordered.
-- @param  tbl table  Table to search
-- @param  value any  Value to return element before
-- @return any Found element
function FindPrev( tbl,  value) end

--- table.ForceInsert
-- @usage shared_m
-- Inserts a value in to the given table even if the table is non-existent
--
-- @param  tab={} table  Table to insert value in to
-- @param  value any  Value to insert
-- @return table The supplied or created table
function ForceInsert( tab,  value) end

--- table.foreach
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This was deprecated in Lua 5.1 and removed in 5.2. You should use pairs() instead.
-- @param  tbl table  The table to iterate over.
-- @param  callback function  The function to run for each key and value.
function foreach( tbl,  callback) end

--- table.ForEach
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use pairs() instead.
-- @param  tab table  Table to iterate over.
-- @param  callback function  Function to call for every key-value pair. Arguments passed are:   any key  any value
function ForEach( tab,  callback) end

--- table.foreachi
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This was deprecated in Lua 5.1 and removed in 5.2. You should use ipairs() instead.
-- @param  table table  The table to iterate over.
-- @param  func function  The function to run for each index.
function foreachi( table,  func) end

--- table.GetFirstKey
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--Instead, expect the first key to be 1.
--
--Non-numerically indexed tables are not ordered and do not have a first key.
-- @param  tab table  Table to retrieve key from
-- @return any Key
function GetFirstKey( tab) end

--- table.GetFirstValue
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--Instead, index the table with a key of 1.
--
--Non-numerically indexed tables are not ordered and do not have a first key.
-- @param  tab table  Table to retrieve value from
-- @return any Value
function GetFirstValue( tab) end

--- table.GetKeys
-- @usage shared_m
-- Returns all keys of a table.
--
-- @param  tabl table  The table to get keys of
-- @return table Table of keys
function GetKeys( tabl) end

--- table.GetLastKey
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Instead, use the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.
-- @param  tab table  Table to retrieve key from
-- @return any Key
function GetLastKey( tab) end

--- table.GetLastValue
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Instead, index the table with the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.
-- @param  tab table  Table to retrieve value from
-- @return any Value
function GetLastValue( tab) end

--- table.getn
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This function was deprecated in Lua 5.1 and is removed in 5.2. Use the length (#) operator instead.
-- @param  tbl table  The table to check.
-- @return number Sequential length.
function getn( tbl) end

--- table.GetWinningKey
-- @usage shared_m
-- Returns a key of the supplied table with the highest number value.
--
-- @param  inputTable table  The table to search in.
-- @return any winningKey
function GetWinningKey( inputTable) end

--- table.HasValue
-- @usage shared_m
-- Checks if a table has a value.
--
-- @param  tbl table  Table to check
-- @param  value any  Value to search for
-- @return boolean Returns true if the table has that value, false otherwise
function HasValue( tbl,  value) end

--- table.Inherit
-- @usage shared_m
-- Copies any missing data from base to target, and sets the target's BaseClass member to the base table's pointer.
--
-- @param  target table  Table to copy data to
-- @param  base table  Table to copy data from
-- @return table Target
function Inherit( target,  base) end

--- table.insert
-- @usage shared_m
-- Inserts a value into a table at the end of the table or at the given position.
--
-- @param  tbl table  The table to insert the variable into.
-- @param  position=nil number  The position in the table to insert the variable.
-- @param  value any  The variable to insert into the table.
-- @return number The index the object was placed at.
function insert( tbl,  position,  value) end

--- table.IsSequential
-- @usage shared_m
-- Returns whether or not the table's keys are sequential
--
-- @param  tab table  Table to check
-- @return boolean Is sequential
function IsSequential( tab) end

--- table.KeyFromValue
-- @usage shared_m
-- Returns the first key found to be containing the supplied value
--
-- @param  tab table  Table to search
-- @param  value any  Value to search for
-- @return any Key
function KeyFromValue( tab,  value) end

--- table.KeysFromValue
-- @usage shared_m
-- Returns a table of keys containing the supplied value
--
-- @param  tab table  Table to search
-- @param  value any  Value to search for
-- @return table Keys
function KeysFromValue( tab,  value) end

--- table.LowerKeyNames
-- @usage shared_m
-- Returns a copy of the input table with all string keys converted to be lowercase recursively
--
-- @param  tbl table  Table to convert
-- @return table New table
function LowerKeyNames( tbl) end

--- table.maxn
-- @usage shared_m
-- Returns the highest numerical key.
--
-- @param  tbl table  The table to search.
-- @return number The highest numerical key.
function maxn( tbl) end

--- table.Merge
-- @usage shared_m
-- Merges the content of the second table with the content in the first one
--
-- @param  destination table  The table you want the source table to merge with
-- @param  source table  The table you want to merge with the destination table
function Merge( destination,  source) end

--- table.Random
-- @usage shared_m
-- Returns a random value from the supplied table.
--
-- @param  haystack table  The table to choose from.
-- @return any A random value from the table.
-- @return any The key associated with the random value.
function Random( haystack) end

--- table.remove
-- @usage shared_m
-- Removes a value from a table and shifts any other values down to fill the gap.
--
-- @param  tbl table  The table to remove the value from.
-- @param  index=#tbl number  The index of the value to remove.
-- @return any The value that was removed.
function remove( tbl,  index) end

--- table.RemoveByValue
-- @usage shared_m
-- Removes the first instance of a given value from the specified table with table.remove, then returns the key that the value was found at.
--
-- @param  tbl table  The table that will be searched.
-- @param  val any  The value to find within the table.
-- @return any The key at which the value was found, or false if the value was not found.
function RemoveByValue( tbl,  val) end

--- table.Reverse
-- @usage shared_m
-- Returns a reversed copy of a sequential table. Any non-sequential and non-numeric keyvalue pairs will not be copied.
--
-- @param  tbl table  Table to reverse.
-- @return table A reversed copy of the table.
function Reverse( tbl) end

--- table.Sanitise
-- @usage shared_m
-- Converts Vectors, Angles and booleans to be able to be converted to and from key-values. table.DeSanitise does the opposite
--
-- @param  tab table  Table to sanitise
-- @return table Sanitised table
function Sanitise( tab) end

--- table.sort
-- @usage shared_m
-- Sorts a table either ascending or by the given sort function.
--
-- @param  tbl table  The table to sort.
-- @param  sorter function  If specified, the function will be called with 2 parameters each.
function sort( tbl,  sorter) end

--- table.SortByKey
-- @usage shared_m
-- Returns a list of keys sorted based on values of those keys.
--
-- @param  tab table  Table to sort. All values of this table must be of same type.
-- @param  descending=false boolean  Should the order be descending?
-- @return table A table of keys sorted by values from supplied table.
function SortByKey( tab,  descending) end

--- table.SortByMember
-- @usage shared_m
-- Sorts a table by a named member
--
-- @param  tab table  Table to sort
-- @param  memberKey any  The key used to identify the member
-- @param  ascending=false boolean  Whether or not the order should be ascending
function SortByMember( tab,  memberKey,  ascending) end

--- table.SortDesc
-- @usage shared_m
-- Sorts a table in reverse order from table.sort
--
-- @param  tbl table  The table to sort in descending order.
-- @return table sorted
function SortDesc( tbl) end

--- table.ToString
-- @usage shared_m
-- Converts a table into a string
--
-- @param  tbl table  The table to iterate over.
-- @param  displayName string  Optional. A name for the table.
-- @param  niceFormatting boolean  Adds new lines and tabs to the string.
-- @return string The table formatted as a string.
function ToString( tbl,  displayName,  niceFormatting) end
