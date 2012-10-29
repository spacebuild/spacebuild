ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Plant"

function ENT:GetOverlayText()
	local txt = ""
	
	if (self.OOOActive == 1) then
		txt = "Plant\nWater left: " .. self.dt.Water
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
	self:DTVar("Int",0,"Water")
end
