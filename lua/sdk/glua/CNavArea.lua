---
-- @description Library CNavArea
 module("CNavArea")

--- CNavArea:AddToClosedList
-- @usage server
-- Adds this CNavArea to the list of positions that have been checked by NextBot's A* search algorithm.
--
function AddToClosedList() end

--- CNavArea:AddToOpenList
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function AddToOpenList() end

--- CNavArea:ClearSearchLists
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function ClearSearchLists() end

--- CNavArea:ComputeAdjacentConnectionHeightChange
-- @usage server
-- Returns the height difference between the edges of two connected navareas.
--
-- @param  navarea CNavArea 
-- @return number The height change
function ComputeAdjacentConnectionHeightChange( navarea) end

--- CNavArea:ComputeDirection
-- @usage server
-- Returns the NavDir_ Enums direction that the given vector faces on this CNavArea.
--
-- @param  pos Vector  The position to compute direction towards.
-- @return number The direction the vector is in relation to this CNavArea. See NavDir_ Enums.
function ComputeDirection( pos) end

--- CNavArea:ComputeGroundHeightChange
-- @usage server
-- Returns the height difference on the Z axis of the two CNavAreas. This is calculated from the center most point on both CNavAreas.
--
-- @param  navArea CNavArea  The nav area to test against.
-- @return number The ground height change.
function ComputeGroundHeightChange( navArea) end

--- CNavArea:Contains
-- @usage server
-- Returns true if this CNavArea contains the given vector.
--
-- @param  pos Vector  The position to test.
-- @return boolean True if the vector was inside and false otherwise.
function Contains( pos) end

--- CNavArea:Draw
-- @usage server
-- Draws this navarea on debug overlay.
--
function Draw() end

--- CNavArea:DrawSpots
-- @usage server
-- Draws the hiding spots on debug overlay. This includes sniper/exposed spots too!
--
function DrawSpots() end

--- CNavArea:GetAdjacentAreas
-- @usage server
-- Returns a table of all the CNavAreas that have a ( one and two way ) connection from this CNavArea.
--
-- @return table A table of all CNavArea that have a ( one and two way ) connection from this CNavArea. Returns an empty table if this area has no outgoing connections to any other areas.
function GetAdjacentAreas() end

--- CNavArea:GetAdjacentAreasAtSide
-- @usage server
-- Returns a table of all the CNavAreas that have a ( one and two way ) connection from this CNavArea in given direction.
--
-- @param  navDir number  The direction, in which to look for CNavAreas, see NavDir_ Enums.
-- @return table A table of all CNavArea that have a ( one and two way ) connection from this CNavArea in given direction.Returns an empty table if this area has no outgoing connections to any other areas in given direction.
function GetAdjacentAreasAtSide( navDir) end

--- CNavArea:GetAdjacentCount
-- @usage server
-- Returns the amount of CNavAreas that have a connection ( one and two way ) from this CNavArea.
--
-- @return number The amount of CNavAreas that have a connection ( one and two way ) from this CNavArea.
function GetAdjacentCount() end

--- CNavArea:GetAdjacentCountAtSide
-- @usage server
-- Returns the amount of CNavAreas that have a connection ( one or two way ) from this CNavArea in given direction.
--
-- @param  navDir number  The direction, in which to look for CNavAreas, see NavDir_ Enums.
-- @return number The amount of CNavAreas that have a connection ( one or two way ) from this CNavArea in given direction.
function GetAdjacentCountAtSide( navDir) end

--- CNavArea:GetAttributes
-- @usage server
-- Returns the attribute mask for the given CNavArea.
--
-- @return boolean Attribute mask for this CNavArea, see NAV_MESH_ Enums for the specific flags.     NOTE  A navmesh that was generated with nav_quicksave set to 1 will have all CNavAreas attribute masks set to 0 
function GetAttributes() end

--- CNavArea:GetCenter
-- @usage server
-- Returns the center most vector point for the given CNavArea.
--
-- @return Vector The center vector.
function GetCenter() end

--- CNavArea:GetClosestPointOnArea
-- @usage server
-- Returns the closest point of this Nav Area from the given position.
--
-- @param  pos Vector  The given position, can be outside of the Nav Area bounds.
-- @return Vector The closest position on this Nav Area.
function GetClosestPointOnArea( pos) end

--- CNavArea:GetCorner
-- @usage server
-- Returns the vector position of the corner for the given CNavArea.
--
-- @param  cornerid number  The target corner to get the position of, takes a NavCorner_ Enums.
-- @return Vector The corner position.
function GetCorner( cornerid) end

--- CNavArea:GetCostSoFar
-- @usage server
-- Internal function used when generating a path from one point to another in PathFollower:Compute.
--
-- @return number The cost so far.
function GetCostSoFar() end

--- CNavArea:GetExposedSpots
-- @usage server
-- Returns a table of very bad hiding spots in this area
--
-- @return table A table of Vectors
function GetExposedSpots() end

--- CNavArea:GetExtentInfo
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return table Returns a table containing the following keys:  Vector hi  Vector lo  number SizeX  number SizeY  number SizeZ
function GetExtentInfo() end

--- CNavArea:GetHidingSpots
-- @usage server
-- Returns a table of good hiding spots in this area
--
-- @return table A table of Vectors
function GetHidingSpots() end

--- CNavArea:GetID
-- @usage server
-- Returns this CNavAreas unique ID.
--
-- @return number The unique ID.
function GetID() end

--- CNavArea:GetIncomingConnections
-- @usage server
-- Returns a table of all the CNavAreas that have a one-way connection to this CNavArea.
--
-- @return table A table of all CNavAreas with one-way connection to this CNavArea.Returns an empty table if there are no one-way incoming connections to this CNavArea.
function GetIncomingConnections() end

--- CNavArea:GetIncomingConnectionsAtSide
-- @usage server
-- Returns a table of all the CNavAreas that have a one-way connection to this CNavArea from given direction.
--
-- @param  navDir number  The direction, from which to look for CNavAreas, see NavDir_ Enums.
-- @return table A table of all CNavAreas with one-way connection to this CNavArea from given direction.Returns an empty table if there are no one-way incoming connections to this CNavArea from given direction.
function GetIncomingConnectionsAtSide( navDir) end

--- CNavArea:GetLadders
-- @usage server
-- Returns all CNavLadders that have a ( one or two way ) connection from this CNavArea.
--
-- @return table The CNavLadders that have a ( one or two way ) connection from this CNavArea.
function GetLadders() end

--- CNavArea:GetLaddersAtSide
-- @usage server
-- Returns all CNavLadders that have a ( one or two way ) connection from ( one and two way ) this CNavArea in given direction.
--
-- @param  navDir number  The direction, in which to look for CNavLadders. 0 = Up ( LadderDirectionType::LADDER_UP )  1 = Down ( LadderDirectionType::LADDER_DOWN )
-- @return table The CNavLadders that have a ( one or two way ) connection from this CNavArea in given direction.
function GetLaddersAtSide( navDir) end

--- CNavArea:GetParent
-- @usage server
-- Returns the parent CNavArea
--
-- @return CNavArea The parent CNavArea
function GetParent() end

--- CNavArea:GetParentHow
-- @usage server
-- Returns how this CNavArea is connected to its parent.
--
-- @return number See NavTraverseType_ Enums
function GetParentHow() end

--- CNavArea:GetRandomAdjacentAreaAtSide
-- @usage server
-- Returns a random CNavArea that has an outgoing ( one or two way ) connection from this CNavArea in given direction.
--
-- @param  navDir number  The direction, in which to look for CNavAreas, see NavDir_ Enums.
-- @return CNavArea The random CNavArea that has an outgoing ( one or two way ) connection from this CNavArea in given direction, if any.
function GetRandomAdjacentAreaAtSide( navDir) end

--- CNavArea:GetRandomPoint
-- @usage server
-- Returns a random point on the nav area.
--
-- @return Vector The random point on the nav area.
function GetRandomPoint() end

--- CNavArea:GetSizeX
-- @usage server
-- Returns the width this Nav Area.
--
-- @return number 
function GetSizeX() end

--- CNavArea:GetSizeY
-- @usage server
-- Returns the height of this Nav Area.
--
-- @return number 
function GetSizeY() end

--- CNavArea:GetTotalCost
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetTotalCost() end

--- CNavArea:GetZ
-- @usage server
-- Returns the elevation of this Nav Area at the given position.
--
-- @param  pos Vector  The position to get the elevation from, the z value from this position is ignored and only the X and Y values are used to this task.
-- @return number The elevation.
function GetZ( pos) end

--- CNavArea:HasAttributes
-- @usage server
-- Returns true if the given CNavArea has this attribute flag set.
--
-- @param  attribs number  Attribute mask to check for, see NAV_MESH_ Enums
-- @return boolean True if the CNavArea matches the given mask. False otherwise.
function HasAttributes( attribs) end

--- CNavArea:IsBlocked
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsBlocked() end

--- CNavArea:IsClosed
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsClosed() end

--- CNavArea:IsConnected
-- @usage server
-- Returns whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea.
--
-- @param  navArea CNavArea  The CNavArea to test against.
-- @return boolean Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea.
function IsConnected( navArea) end

--- CNavArea:IsConnectedAtSide
-- @usage server
-- Returns whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea in given direction.
--
-- @param  navArea CNavArea  The CNavArea to test against.
-- @param  navDirType number  The direction, in which to look for the connection. See NavDir_ Enums
-- @return boolean Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea in given direction.
function IsConnectedAtSide( navArea,  navDirType) end

--- CNavArea:IsCoplanar
-- @usage server
-- Returns whether this Nav Area is in the same plane as the given one.
--
-- @param  navArea CNavArea  The Nav Area to test.
-- @return boolean Whether we're coplanar or not.
function IsCoplanar( navArea) end

--- CNavArea:IsFlat
-- @usage server
-- Returns if this Nav Area is flat within the tolerance of the nav_coplanar_slope_limit_displacement and nav_coplanar_slope_limit convars.
--
-- @return boolean Returns if we're mostly flat.
function IsFlat() end

--- CNavArea:IsOpen
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsOpen() end

--- CNavArea:IsOpenListEmpty
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsOpenListEmpty() end

--- CNavArea:IsOverlapping
-- @usage server
-- Returns if this position overlaps the Nav Area within the given tolerance.
--
-- @param  pos Vector  The overlapping position to test.
-- @param  tolerance=0 number  The tolerance of the overlapping, set to 0 for no tolerance.
-- @return boolean Whether the given position overlaps the Nav Area or not.
function IsOverlapping( pos,  tolerance) end

--- CNavArea:IsOverlappingArea
-- @usage server
-- Returns true if this CNavArea is overlapping the given CNavArea.
--
-- @param  navArea CNavArea  The CNavArea to test against.
-- @return boolean True if the given CNavArea overlaps this CNavArea at any point.
function IsOverlappingArea( navArea) end

--- CNavArea:IsRoughlySquare
-- @usage server
-- Returns if we're shaped like a square.
--
-- @return boolean If we're a square or not.
function IsRoughlySquare() end

--- CNavArea:IsUnderwater
-- @usage server
-- Whether this Nav Area is placed underwater.
--
-- @return boolean Whether we're underwater or not.
function IsUnderwater() end

--- CNavArea:IsValid
-- @usage server
-- Returns whether this CNavArea is valid or not.
--
-- @return boolean Whether this CNavArea is valid or not.
function IsValid() end

--- CNavArea:IsVisible
-- @usage server
-- Returns whether we can be seen from the given position.
--
-- @param  pos Vector  The position to check.
-- @return boolean Whether we can be seen or not.
-- @return Vector If we can be seen, this is returned with either the center or one of the corners of the Nav Area.
function IsVisible( pos) end

--- CNavArea:PopOpenList
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function PopOpenList() end

--- CNavArea:RemoveFromClosedList
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function RemoveFromClosedList() end

--- CNavArea:SetAttributes
-- @usage server
-- Sets the attributes for given CNavArea.
--
-- @param  attribs number  The attribute bitflag. See NAV_MESH_ Enums
function SetAttributes( attribs) end

--- CNavArea:SetParent
-- @usage server
-- Sets the new parent of this CNavArea.
--
-- @param  parent CNavArea  The new parent to set
function SetParent( parent) end

--- CNavArea:SetTotalCost
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  cost number 
function SetTotalCost( cost) end

--- CNavArea:UpdateOnOpenList
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UpdateOnOpenList() end
