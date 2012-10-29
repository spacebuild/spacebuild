ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Atmospheric Probe"

function ENT:GetOverlayText()
	local txt = ""
	
	if (self:GetOOO() == 1) then
		local Hab = self:GetHabitable() and "Yes" or "No"
		txt = self.PrintName.." (ON)\nHabitable: " .. Hab .. "\nPressure: " .. self:GetPressure() .. " Atmospheres\nTemperature: " .. self:GetTemperature() .. " K\nGravity: " ..  math.Round(self:GetSBGravity(),1) .." G"
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
	self:NetworkVar("Bool",0,"Habitable")
	self:NetworkVar("Int",0,"Pressure")
	self:NetworkVar("Int",1,"Temperature")
	self:NetworkVar("Float",0,"SBGravity")
	
	self:SetHabitable( false )
	self:SetPressure( 0 )
	self:SetTemperature( 0 )
	self:SetSBGravity( 0 )
	
	return self.BaseClass.SetupDataTables(self)
end