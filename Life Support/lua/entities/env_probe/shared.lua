ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Atmospheric Probe"

function ENT:GetOverlayText()
	local txt = ""
	
	if (self.OOOActive == 1) then
		local Hab = self.dt.Habitable == 1 and "Yes" or "No"
		txt = self.PrintName.." (ON)\nHabitable: " .. Hab .. "\nPressure: " .. self.dt.Pressure .. " Atmospheres\nTemperature: " .. self.dt.Temperature .. " K\nGravity: " .. math.floor(self.dt.Gravity) .." G"
	else
		txt =  self.PrintName.." (OFF)"
	end
	
	local PlayerName = self:GetPlayerName()
	if ( !game.SinglePlayer() and PlayerName != "") then
		txt = txt .. "\n- " .. PlayerName .. " -"
	end
	
	return txt
end

function ENT:SetupDataTables()
	self:DTVar("Int",0,"Habitable")
	self:DTVar("Int",1,"Pressure")
	self:DTVar("Int",2,"Temperature")
	self:DTVar("Int",3,"Gravity")
end