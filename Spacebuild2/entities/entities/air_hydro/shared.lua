ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Plant"

function ENT:GetOverlayText()
	local txt = ""
	
	if (self:GetOOO() == 1) then
		txt = "Plant\nWater left: " .. self:GetWater()
	else
		txt =  "Plant\nNeeds watering";
	end
	
	local PlayerName = self:GetPlayerName()
	if ( !game.SinglePlayer() and PlayerName != "") then
		txt = txt .. "\n- " .. PlayerName .. " -"
	end
	
	return txt
end

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Water")
	
	return self.BaseClass.SetupDataTables(self)
end
