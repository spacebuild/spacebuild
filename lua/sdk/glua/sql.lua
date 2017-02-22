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
-- @description Library sql
 module("sql")

--- sql.Begin
-- @usage shared_m
-- Tells the engine a set of queries is coming. Will wait until sql.Commit is called to run them.
--This is most useful when you run more than 100+ queries.
--
function Begin() end

--- sql.Commit
-- @usage shared_m
-- Tells the engine to execute a series of queries queued for execution, must be preceded by sql.Begin
--
function Commit() end

--- sql.LastError
-- @usage shared_m
-- Returns the last error from a SQLite query.
--
-- @return string error
function LastError() end

--- sql.Query
-- @usage shared_m
-- Performs a query on the local SQLite database, returns a table as result set, nil if result is empty and false on error.
--
-- @param  query string  The query to execute.
-- @return table false is returned if there is an error, nil if the query returned no data.
function Query( query) end

--- sql.QueryRow
-- @usage shared_m
-- Performs the query like sql.Query, but returns the first row found.
--
-- @param  query string  The input query
-- @param  row=1 number  The row number. Say we receive back 5 rows, putting 3 as this argument will give us row #3.
-- @return table The returned row.
function QueryRow( query,  row) end

--- sql.QueryValue
-- @usage shared_m
-- Performs the query like sql.Query, but returns the first value found.
--
-- @param  query string  The input query.
-- @return any The returned value; the engine automatically converts numerical output to Lua numbers.
function QueryValue( query) end

--- sql.SQLStr
-- @usage shared_m
-- Escapes dangerous characters and symbols from user input used in an SQLite SQL Query.
--
-- @param  string string  The string to be escaped.
-- @param  bNoQuotes=false boolean  Set this as true, and the function will not wrap the input string in apostrophes.
-- @return string The escaped input.
function SQLStr( string,  bNoQuotes) end

--- sql.TableExists
-- @usage shared_m
-- Returns if the table with the specified name exists.
--
-- @param  tableName string  The name of the table to check.
-- @return boolean exists
function TableExists( tableName) end
