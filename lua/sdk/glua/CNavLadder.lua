---
-- @description Library CNavLadder
 module("CNavLadder")

--- CNavLadder:ConnectTo
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  area CNavArea 
function ConnectTo( area) end

--- CNavLadder:GetBottomArea
-- @usage server
-- Returns the bottom area of the CNavLadder.
--
-- @return CNavArea 
function GetBottomArea() end

--- CNavLadder:GetID
-- @usage server
-- Returns this CNavLadders unique ID.
--
-- @return number The unique ID.
function GetID() end

--- CNavLadder:GetLength
-- @usage server
-- Returns the length of the ladder.
--
-- @return number The length of the ladder.
function GetLength() end

--- CNavLadder:GetNormal
-- @usage server
-- Returns the direction of this CNavLadder. ( The direction in which players back will be facing if they are looking directly at the ladder )
--
-- @return Vector The direction of this CNavLadder.
function GetNormal() end

--- CNavLadder:GetPosAtHeight
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  height number  The Z position in world space coordinates.
-- @return Vector The closest point on the ladder to that height.
function GetPosAtHeight( height) end

--- CNavLadder:GetTopBehindArea
-- @usage server
-- Returns the top behind CNavArea of the CNavLadder.
--
-- @return CNavArea The top behind CNavArea of the CNavLadder.
function GetTopBehindArea() end

--- CNavLadder:GetTopForwardArea
-- @usage server
-- Returns the top forward CNavArea of the CNavLadder.
--
-- @return CNavArea The top forward CNavArea of the CNavLadder.
function GetTopForwardArea() end

--- CNavLadder:GetTopLeftArea
-- @usage server
-- Returns the top left CNavArea of the CNavLadder.
--
-- @return CNavArea The top left CNavArea of the CNavLadder.
function GetTopLeftArea() end

--- CNavLadder:GetTopRightArea
-- @usage server
-- Returns the top right CNavArea of the CNavLadder.
--
-- @return CNavArea The top right CNavArea of the CNavLadder.
function GetTopRightArea() end

--- CNavLadder:IsConnectedAtSide
-- @usage server
-- Returns whether this CNavLadder has an outgoing ( one or two way ) connection to given CNavArea in given direction.
--
-- @param  navArea CNavArea  The CNavArea to test against.
-- @param  navDirType number  The direction, in which to look for the connection. See NavDir_ Enums
-- @return boolean Whether this CNavLadder has an outgoing ( one or two way ) connection to given CNavArea in given direction.
function IsConnectedAtSide( navArea,  navDirType) end

--- CNavLadder:IsValid
-- @usage server
-- Returns whether this CNavLadder is valid or not.
--
-- @return boolean Whether this CNavLadder is valid or not.
function IsValid() end

--- CNavLadder:SetBottomArea
-- @usage server
-- Sets the bottom area of the CNavLadder.
--
-- @param  area CNavArea 
function SetBottomArea( area) end

--- CNavLadder:SetTopBehindArea
-- @usage server
-- Sets the top behind area of the CNavLadder.
--
-- @param  area CNavArea 
function SetTopBehindArea( area) end

--- CNavLadder:SetTopForwardArea
-- @usage server
-- Sets the top forward area of the CNavLadder.
--
-- @param  area CNavArea 
function SetTopForwardArea( area) end

--- CNavLadder:SetTopLeftArea
-- @usage server
-- Sets the top left area of the CNavLadder.
--
-- @param  area CNavArea 
function SetTopLeftArea( area) end

--- CNavLadder:SetTopRightArea
-- @usage server
-- Sets the top right area of the CNavLadder.
--
-- @param  area CNavArea 
function SetTopRightArea( area) end
