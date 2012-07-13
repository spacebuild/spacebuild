ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Plant"

function ENT:GetOverlayText()
	local txt = ""
	
	if (self.OOOActive == 1) then
		txt = "Plant\nWater left: " .. self:GetNetworkedInt( 1 ) 
	else
		txt =  "Plant\nNeeds watering";
	end
	
	local PlayerName = self:GetPlayerName()
	if ( !SinglePlayer() and PlayerName ~= "") then
		txt = txt .. "\n- " .. PlayerName .. " -"
	end
	
	return txt
end
