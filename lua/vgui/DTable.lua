--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DListView
	
	Columned list view
	
	
	TheList = vgui.Create( "DTable" )
	
	local Col1 = TheList:AddColumn( "Address" )
	local Col2 = TheList:AddColumn( "Port" )
	
	Col2:SetMinWidth( 30 )
	Col2:SetMaxWidth( 30 )
	
	TheList:AddLine( "192.168.0.1", "80" )
	TheList:AddLine( "192.168.0.2", "80" )
	
	etc
	
--]]
	
local PANEL = {}

AccessorFunc( PANEL, "m_bDirty", 				"Dirty", 				FORCE_BOOL )

AccessorFunc( PANEL, "m_bHideHeaders", 			"HideHeaders",			FORCE_BOOL )

Derma_Hook( PANEL, "Paint", "Paint", "ListView" )


--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetMouseInputEnabled( true )
	self:SetHideHeaders( false )

	self:SetDrawBackground( true )
	
	self.Columns = {}
	
	self.Lines = {}
	self.Sorted = {}
	
	self:SetDirty( true )
	
	self.pnlCanvas 	= vgui.Create( "Panel", self )
	
	self.VBar 		= vgui.Create( "DVScrollBar", self )
	self.VBar:SetZPos( 20 )

end

--[[---------------------------------------------------------
   Name: DisableScrollbar
-----------------------------------------------------------]]
function PANEL:DisableScrollbar()

	if ( IsValid( self.VBar ) ) then
		self.VBar:Remove()
	end
	
	self.VBar = nil

end

--[[---------------------------------------------------------
   Name: GetLines
-----------------------------------------------------------]]
function PANEL:GetLines()
	return self.Lines
end



--[[---------------------------------------------------------
   Name: GetInnerTall
-----------------------------------------------------------]]
function PANEL:GetInnerTall()
	return self:GetCanvas():GetTall()
end

--[[---------------------------------------------------------
   Name: GetCanvas
-----------------------------------------------------------]]
function PANEL:GetCanvas()
	return self.pnlCanvas
end

--[[---------------------------------------------------------
   Name: AddColumn
-----------------------------------------------------------]]
function PANEL:AddColumn( strName, strMaterial )

	local pColumn = vgui.Create( "DTable_Column", self )
	pColumn:SetName( strName )
	pColumn:SetMaterial( strMaterial )
	pColumn:SetZPos( 10 )

	
	local ID = table.insert( self.Columns, pColumn )
	pColumn:SetColumnID( ID )

	self:InvalidateLayout()
	
	return pColumn
	
end

--[[---------------------------------------------------------
   Name: RemoveLine
-----------------------------------------------------------]]
function PANEL:RemoveLine( LineID )

	local Line = self:GetLine( LineID )
	local SelectedID = self:GetSortedID( LineID )
	
	self.Lines[ LineID ] = nil
	table.remove( self.Sorted, SelectedID )

	self:SetDirty( true )
	self:InvalidateLayout()
	
	Line:Remove()

end

--[[---------------------------------------------------------
   Name: ColumnWidth
-----------------------------------------------------------]]
function PANEL:ColumnWidth( i )

	local ctrl = self.Columns[ i ]
	if (not ctrl) then return 0 end
	
	return ctrl:GetWide()

end

--[[---------------------------------------------------------
   Name: FixColumnsLayout
-----------------------------------------------------------]]
function PANEL:FixColumnsLayout()

	local NumColumns = #self.Columns
	if ( NumColumns == 0 ) then return end

	local AllWidth = 0
	for k, Column in pairs( self.Columns ) do
		AllWidth = AllWidth + Column:GetWide()
	end
	
	local ChangeRequired = self.pnlCanvas:GetWide() - AllWidth
	local ChangePerColumn = math.floor( ChangeRequired / NumColumns )
	local Remainder = ChangeRequired - (ChangePerColumn * NumColumns)
	
	for k, Column in pairs( self.Columns ) do

		local TargetWidth = Column:GetWide() + ChangePerColumn
		Remainder = Remainder + ( TargetWidth - Column:SetWidth( TargetWidth ) )
	
	end
	
	-- If there's a remainder, try to palm it off on the other panels, equally
	while ( Remainder ~= 0 ) do

		local PerPanel = math.floor( Remainder / NumColumns )
		
		for k, Column in pairs( self.Columns ) do
	
			Remainder = math.Approach( Remainder, 0, PerPanel )
			
			local TargetWidth = Column:GetWide() + PerPanel
			Remainder = Remainder + (TargetWidth - Column:SetWidth( TargetWidth ))
			
			if ( Remainder == 0 ) then break end
		
		end
		
		Remainder = math.Approach( Remainder, 0, 1 )
	
	end
		
	-- Set the positions of the resized columns
	local x = 0
	for k, Column in pairs( self.Columns ) do
	
		Column.x = x
		x = x + Column:GetWide()
		
		Column:SetTall( self:GetHeaderHeight() )
		Column:SetVisible( not self:GetHideHeaders() )
	
	end

end

--[[---------------------------------------------------------
   Name: Paint
-----------------------------------------------------------]]
function PANEL:PerformLayout()
	
	-- Do Scrollbar
	local Wide = self:GetWide()
	local YPos = 0
	
	if ( IsValid( self.VBar ) ) then
	
		self.VBar:SetPos( self:GetWide() - 16, 0 )
		self.VBar:SetSize( 16, self:GetTall() )
		self.VBar:SetUp( self.VBar:GetTall() - self:GetHeaderHeight(), self.pnlCanvas:GetTall() )
		YPos = self.VBar:GetOffset()

		if ( self.VBar.Enabled ) then Wide = Wide - 16 end
	
	end
	
	if ( self.m_bHideHeaders ) then
		self.pnlCanvas:SetPos( 0, YPos )
	else
		self.pnlCanvas:SetPos( 0, YPos + self:GetHeaderHeight() )
	end

	self.pnlCanvas:SetSize( Wide, self.pnlCanvas:GetTall() )
	
	self:FixColumnsLayout()
	
	--
	-- If the data is dirty, re-layout
	--
	if ( self:GetDirty( true ) ) then
	
		self:SetDirty( false )
		local y = self:DataLayout()
		self.pnlCanvas:SetTall( y )
		
		-- Layout again, since stuff has changed..
		self:InvalidateLayout( true )
	
	end
	


end



--[[---------------------------------------------------------
   Name: OnScrollbarAppear
-----------------------------------------------------------]]
function PANEL:OnScrollbarAppear()

	self:SetDirty( true )
	self:InvalidateLayout()

end

--[[---------------------------------------------------------
   Name: OnRequestResize
-----------------------------------------------------------]]
function PANEL:OnRequestResize( SizingColumn, iSize )
	
	-- Find the column to the right of this one
	local Passed = false
	local RightColumn = nil
	for k, Column in ipairs( self.Columns ) do
	
		if ( Passed ) then
			RightColumn = Column
			break
		end
	
		if ( SizingColumn == Column ) then Passed = true end
	
	end
	
	-- Alter the size of the column on the right too, slightly
	if ( RightColumn ) then
	
		local SizeChange = SizingColumn:GetWide() - iSize
		RightColumn:SetWide( RightColumn:GetWide() + SizeChange )
		
	end
	
	SizingColumn:SetWide( iSize )
	self:SetDirty( true )
	
	-- Invalidating will munge all the columns about and make it right
	self:InvalidateLayout()

end

--[[---------------------------------------------------------
   Name: DataLayout
-----------------------------------------------------------]]
function PANEL:DataLayout()

	local y = 0
	local h = self.m_iDataHeight
	
	for k, Line in ipairs( self.Sorted ) do
	
		Line:SetPos( 1, y )
		Line:SetSize( self:GetWide()-2, h )
		Line:DataLayout( self ) 
		
		Line:SetAltLine( k % 2 == 1 )
		
		y = y + Line:GetTall()
	
	end
	
	return y

end

--[[---------------------------------------------------------
   Name: AddLine - returns the line number.
-----------------------------------------------------------]]
function PANEL:AddLine( ... )

	self:SetDirty( true )
	self:InvalidateLayout()

	local Line = vgui.Create( "DListView_Line", self.pnlCanvas )
	local ID = table.insert( self.Lines, Line )
	
	Line:SetListView( self ) 
	Line:SetID( ID )

	for k, v in pairs( {...} ) do
		Line:SetColumnText( k, v )
	end
	
	-- Make appear at the bottom of the sorted list
	local SortID = table.insert( self.Sorted, Line )
	
	if ( SortID % 2 == 1 ) then
		Line:SetAltLine( true )
	end

	return Line
	
end

--[[---------------------------------------------------------
   Name: OnMouseWheeled
-----------------------------------------------------------]]
function PANEL:OnMouseWheeled( dlta )

	if ( not IsValid( self.VBar ) ) then return end
	
	return self.VBar:OnMouseWheeled( dlta )
	
end

--[[---------------------------------------------------------
   Name: OnMouseWheeled
-----------------------------------------------------------]]
function PANEL:ClearSelection( dlta )

	for k, Line in pairs( self.Lines ) do
		Line:SetSelected( false )
	end
	
end

--[[---------------------------------------------------------
   Name: GetSelectedLine
-----------------------------------------------------------]]
function PANEL:GetSelectedLine()

	for k, Line in pairs( self.Lines ) do
		if ( Line:IsSelected() ) then return k end
	end
	
end

--[[---------------------------------------------------------
   Name: GetLine
-----------------------------------------------------------]]
function PANEL:GetLine( id )

	return self.Lines[ id ]
	
end

--[[---------------------------------------------------------
   Name: GetSortedID
-----------------------------------------------------------]]
function PANEL:GetSortedID( line )

	for k, v in pairs( self.Sorted ) do
	
		if ( v:GetID() == line ) then return k end
	
	end
	
end

--[[---------------------------------------------------------
   Name: OnClickLine
-----------------------------------------------------------]]
function PANEL:OnClickLine( Line, bClear )

	local bMultiSelect = self.m_bMultiSelect
	if ( not bMultiSelect and not bClear ) then return end
	
	--
	-- Control, multi select
	--
	if ( bMultiSelect and input.IsKeyDown( KEY_LCONTROL ) ) then
		bClear = false
	end
	
	--
	-- Shift block select
	--
	if ( bMultiSelect and input.IsKeyDown( KEY_LSHIFT ) ) then
	
		local Selected = self:GetSortedID( self:GetSelectedLine() )
		if ( Selected ) then
		
			if ( bClear ) then self:ClearSelection() end
			
			local LineID = self:GetSortedID( Line:GetID() )
		
			local First = math.min( Selected, LineID )
			local Last = math.max( Selected, LineID )
			
			for id = First, Last do
			
				local line = self.Sorted[ id ]
				line:SetSelected( true )
			
			end
		
			return
		
		end
		
	end
	
	--
	-- Check for double click
	--
	if ( Line:IsSelected() and Line.m_fClickTime and (not bMultiSelect or bClear) ) then
	
		local fTimeDistance = SysTime() - Line.m_fClickTime

		if ( fTimeDistance < 0.3 ) then
			self:DoDoubleClick( Line:GetID(), Line )
			return
		end
	
	end

	--
	-- If it's a new mouse click, or this isn't 
	--  multiselect we clear the selection
	--
	if ( not bMultiSelect or bClear ) then
		self:ClearSelection()
	end
	
	if ( Line:IsSelected() ) then return end

	Line:SetSelected( true )
	Line.m_fClickTime = SysTime()
	
	self:OnRowSelected( Line:GetID(), Line )
	
end

--[[---------------------------------------------------------
   Name: SortByColumn
-----------------------------------------------------------]]
function PANEL:SortByColumn( ColumnID, Desc )

	table.Copy( self.Sorted, self.Lines )
	
	table.sort( self.Sorted, function( a, b ) 

									if ( Desc ) then
										a, b = b, a
									end
			
									return a:GetColumnText( ColumnID ) < b:GetColumnText( ColumnID )
							
						end )

	self:SetDirty( true )
	self:InvalidateLayout()
	

end

--[[---------------------------------------------------------
   Name: SelectFirstItem
   Selects the first item based on sort..
-----------------------------------------------------------]]
function PANEL:SelectItem( Item )

	if ( not Item ) then return end
	
	Item:SetSelected( true )
	self:OnRowSelected( Item:GetID(), Item )

end

--[[---------------------------------------------------------
   Name: SelectFirstItem
   Selects the first item based on sort..
-----------------------------------------------------------]]
function PANEL:SelectFirstItem()

	self:ClearSelection()
	self:SelectItem( self.Sorted[ 1 ] )

end

--[[---------------------------------------------------------
   Name: DoDoubleClick
-----------------------------------------------------------]]
function PANEL:DoDoubleClick( LineID, Line )

	-- For Override

end

--[[---------------------------------------------------------
   Name: OnRowSelected
-----------------------------------------------------------]]
function PANEL:OnRowSelected( LineID, Line )

	-- For Override

end

--[[---------------------------------------------------------
   Name: OnRowRightClick
-----------------------------------------------------------]]
function PANEL:OnRowRightClick( LineID, Line )

	-- For Override

end

--[[---------------------------------------------------------
   Name: Clear
-----------------------------------------------------------]]
function PANEL:Clear()

	for k, v in pairs( self.Lines ) do
		v:Remove()
	end
	
	self.Lines = {}
	self.Sorted = {}
	
	self:SetDirty( true )

end

--[[---------------------------------------------------------
   Name: GetSelected
-----------------------------------------------------------]]
function PANEL:GetSelected()

	local ret = {}
	
	for k, v in pairs( self.Lines ) do
		if ( v:IsLineSelected() ) then
			table.insert( ret, v )
		end
	end

	return ret

end


--[[---------------------------------------------------------
   Name: SizeToContents
-----------------------------------------------------------]]
function PANEL:SizeToContents( )

	self:SetHeight( self.pnlCanvas:GetTall() + self:GetHeaderHeight() )
	

end


--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		
		local Col1 = ctrl:AddColumn( "Address" )
		local Col2 = ctrl:AddColumn( "Port" )
	
		Col2:SetMinWidth( 30 )
		Col2:SetMaxWidth( 30 )
	
		for i=1, 128 do
			ctrl:AddLine( "192.168.0."..i, "80" )
		end
		
		ctrl:SetSize( 300, 200 )
		
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end


derma.DefineControl( "DListView", "Data View", PANEL, "DPanel" )
