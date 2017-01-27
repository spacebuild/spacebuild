---
-- @description Library DListView
 module("DListView")

--- DListView:AddColumn
-- @usage client
-- Adds a column to the listview.
--
-- @param  column string  The name of the column to add.
-- @param  material string  The material to apply to the column.  Appears to only get applied if the listview is set to not be sortable.
-- @param  position number  Sets the ordering of this column compared to other columns.  Does not appear to be implemented.
-- @return Panel The newly created DListView_Column.
function AddColumn( column,  material,  position) end

--- DListView:AddLine
-- @usage client
-- Adds a line to the list view.
--
-- @param  text vararg  Values for a new row in the DListView, If several arguments are supplied, each argument will correspond to a respective column in the DListView.
-- @return Panel The newly created DListView_Line.
function AddLine( text) end

--- DListView:Clear
-- @usage client
-- Removes all lines that have been added to the DListView.
--
function Clear() end

--- DListView:ClearSelection
-- @usage client
-- Clears the current selection in the DListView.
--
function ClearSelection() end

--- DListView:ColumnWidth
-- @usage client
-- Gets the width of a column.
--
-- @param  column number  The column to get the width of.
-- @return number Width of the column.
function ColumnWidth( column) end

--- DListView:DataLayout
-- @usage client
-- Creates the lines and gets the height of the contents, in a DListView.
--
-- @return number The height of the contents
function DataLayout() end

--- DListView:DisableScrollbar
-- @usage client
-- Removes the scrollbar.
--
function DisableScrollbar() end

--- DListView:DoDoubleClick
-- @usage client
-- Called when a line in the DListView is double clicked.
--
-- @param  lineID number  The line number of the double clicked line.
-- @param  line Panel  The double clicked DListView_Line.
function DoDoubleClick( lineID,  line) end

--- DListView:FixColumnsLayout
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function FixColumnsLayout() end

--- DListView:GetCanvas
-- @usage client
-- Gets the canvas.
--
-- @return Panel The canvas.
function GetCanvas() end

--- DListView:GetDataHeight
-- @usage client
-- Returns the height of the data of the DListView.
--
-- @return number The height of the data of the DListView.
function GetDataHeight() end

--- DListView:GetDirty
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return boolean 
function GetDirty() end

--- DListView:GetHeaderHeight
-- @usage client
-- Returns the height of the header of the DListView.
--
-- @return number The height of the header of the DListView.
function GetHeaderHeight() end

--- DListView:GetHideHeaders
-- @usage client
-- Returns whether the header line should be visible on not.
--
-- @return boolean Whether the header line should be visible on not.
function GetHideHeaders() end

--- DListView:GetInnerTall
-- @usage client
-- Returns the height of DListView:GetCanvas.
--
-- @return number The height of DListView:GetCanvas.
function GetInnerTall() end

--- DListView:GetLine
-- @usage client
-- Gets the DListView_Line at the given index.
--
-- @param  id number  The index of the line to get.
-- @return Panel The DListView_Line at the given index.
function GetLine( id) end

--- DListView:GetLines
-- @usage client
-- Gets all of the lines added to the DListView.
--
-- @return table The lines added to the DListView.
function GetLines() end

--- DListView:GetMultiSelect
-- @usage client
-- Returns whether multiple lines can be selected or not.
--
-- @return boolean Whether multiple lines can be selected or not.
function GetMultiSelect() end

--- DListView:GetSelected
-- @usage client
-- Gets all of the DListViewLines that are currently selected.
--
-- @return table The selected lines.
function GetSelected() end

--- DListView:GetSelectedLine
-- @usage client
-- Gets the currently selected DListViewLine.
--
-- @return number The index of the currently selected line.
function GetSelectedLine() end

--- DListView:GetSortable
-- @usage client
-- Returns whether sorting of columns by clicking their headers is allowed or not.
--
-- @return boolean Whether sorting of columns by clicking their headers is allowed or not
function GetSortable() end

--- DListView:GetSortedID
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  lineId number  The DListView_Line:GetID of a line to look up
-- @return number 
function GetSortedID( lineId) end

--- DListView:OnClickLine
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--Use DListView:OnRowSelected instead!
-- @param  line Panel  The selected line.
-- @param  isSelected boolean  Boolean indicating whether the line is selected.
function OnClickLine( line,  isSelected) end

--- DListView:OnRequestResize
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  column Panel  The column which initialized the resize
-- @param  size number 
function OnRequestResize( column,  size) end

--- DListView:OnRowRightClick
-- @usage client
-- Called when a row is right-clicked
--
-- @param  lineID number  The line ID of the right clicked line
-- @param  line Panel  The line panel itself, a DListView_Line.
function OnRowRightClick( lineID,  line) end

--- DListView:OnRowSelected
-- @usage client
-- Called internally by DListView:OnClickLine when a line is selected. This is the function you should override to define the behavior when a line is selected.
--
-- @param  rowIndex number  The index of the row that the user clicked on.
-- @param  row Panel  The DListView_Line that the user clicked on.
function OnRowSelected( rowIndex,  row) end

--- DListView:RemoveLine
-- @usage client
-- Removes a line from the list view.
--
-- @param  line number  Removes the given row, by row id (same number as DListView:GetLine).
function RemoveLine( line) end

--- DListView:SelectFirstItem
-- @usage client
-- Selects the line at the first index of the DListView if one has been added.
--
function SelectFirstItem() end

--- DListView:SelectItem
-- @usage client
-- Selects a line in the listview.
--
-- @param  Line Panel  The line to select.
function SelectItem( Line) end

--- DListView:SetDataHeight
-- @usage client
-- Sets the height of all lines of the DListView except for the header line.
--
-- @param  height number  The new height to set. Default value is 17.
function SetDataHeight( height) end

--- DListView:SetDirty
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  isDirty boolean 
function SetDirty( isDirty) end

--- DListView:SetHeaderHeight
-- @usage client
-- Sets the height of the header line of the DListView.
--
-- @param  height number  The new height to set. Default value is 16.
function SetHeaderHeight( height) end

--- DListView:SetHideHeaders
-- @usage client
-- Sets whether the header line should be visible on not.
--
-- @param  hide boolean  Whether the header line should be visible on not.
function SetHideHeaders( hide) end

--- DListView:SetMultiSelect
-- @usage client
-- Sets whether multiple lines can be selected by the user by using the Ctrl or ⇧ Shift keys. When set to false, only one line can be selected.
--
-- @param  allowMultiSelect boolean  Whether multiple lines can be selected or not
function SetMultiSelect( allowMultiSelect) end

--- DListView:SetSortable
-- @usage client
-- Enables/disables the sorting of columns by clicking.
--
-- @param  isSortable boolean  Whether sorting columns with clicking is allowed or not.
function SetSortable( isSortable) end

--- DListView:SortByColumn
-- @usage client
-- Sorts the items in the specified column.
--
-- @param  columnIndex number  The index of the column that should be sorted.
-- @param  descending=false boolean  Whether the items should be sorted in descending order or not.
function SortByColumn( columnIndex,  descending) end

--- DListView:SortByColumns
-- @usage client
-- Sorts the list based on given columns.
--
-- @param  column1=nil number 
-- @param  descrending1=false boolean 
-- @param  column2=nil number 
-- @param  descrending2=false boolean 
-- @param  column3=nil number 
-- @param  descrending3=false boolean 
-- @param  column4=nil number 
-- @param  descrending4=false boolean 
function SortByColumns( column1,  descrending1,  column2,  descrending2,  column3,  descrending3,  column4,  descrending4) end
