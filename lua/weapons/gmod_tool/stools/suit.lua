local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.ls")
TOOL.Name = '#Suit control'
TOOL.Command = nil
TOOL.ConfigName = ''
TOOL.Tab = "Spacebuild"

local SB = SPACEBUILD

-- Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then
	lang.register( "tool.grav_plate.name" )
	lang.register( "tool.grav_plate.desc" )
	lang.register( "tool.grav_plate.0" )
end

function TOOL:LeftClick( trace )
	if CLIENT then return true end
	self:GetOwner().suit:setActive(true)
	SB.util.messages.notify(self:GetOwner(), "helmet put on" )
	return true
end

function TOOL:RightClick( trace )
	self:GetOwner().suit:setActive(false)
	SB.util.messages.notify(self:GetOwner(), "helmet put off" )
	return true
end
