-- Much love to the WireMod team for their superb LUA coding
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName	= "Resource Distribution Entity"
ENT.Author		= "Thresher and TAD2020"
ENT.Purpose		= "Base for all RD Sents"
ENT.Instructions	= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

local BasicOOO = {}
BasicOOO[0] = "(Off)"
BasicOOO[1] = "(On)"
BasicOOO[2] = "(OVERDRIVE)"
ENT.OOOActive = 0
ENT.OverlayTextOOO = BasicOOO[ 0 ]
ENT.OverlayText = ""

--
--	=OverLayTextOutput=
--list.Set( "LSEntOverlayText" , "entclass", {HasOOO = [true/false/nil], num = [number],, strings = {list of strings},resnames = {list of res names}} )
--
--to have it print all resources on all it's nets, use:
--num = -1
--list.Set( "LSEntOverlayText" , "class", {num = -1} )
--and to have a title on the overlay, use:
--num = -2
--list.Set( "LSEntOverlayText" , "class", {num = -2, strings = {"some title:\n"}} )
--num = -3 -- same as above, but only shows resources that are >1
--don't use -2 or -3 with HasOOO
--num = -4, like -1 but only shows resources that are >1 (HasOOO ok)
--
--HasOOO = true
--string[1] .. [(off)/(on)/(OVERDRIVE)] .. (rest)
--use num = 0 to just use OOO
--
--Override MakeOverlayText function
--either do it in your ent's shared or do this
--list.Set( "LSEntOverlayText" , "entclass", {func = function( ent ) return txt end} )
--

function ENT:SetOverlayText( txt )
	self.OverlayText = txt
	if ( SERVER ) then
		self:OldMethodSetOverlayText(txt)
	else
		self:SetNetworkedString( "GModOverlayText", txt )
	end
end

function ENT:MakeOverlayText( OverlaySettings ) 
	local txt = ""
	local HasOOO = OverlaySettings.HasOOO
	local num = OverlaySettings.num
	local strings = OverlaySettings.strings
	local resnames = OverlaySettings.resnames
	if (!num) then return "" end --no num, nothing to do
	
	local o = 0
	if (HasOOO) then
		txt = strings[1] .. self.OverlayTextOOO
		o = 1
		if (num < 0) then txt = txt .. "\n" end
	end
	
	if (resnames and num > 0) then
		for n,resname in pairs(resnames) do
			txt = txt .. strings[n + o] .. self:GetResourceAmountText( resname )
		end
	elseif (num < 0) then --print all resources on ent
		if (num == -2 or num == -3) then --has a name
			txt = txt .. strings[1]
		end
		txt = txt .. self:GetAllResourcesAmountsText( (num == -3 or num == -4) )
	end
	
	if (num >= 0 and strings and strings[num + o + 1]) then
		txt = txt .. strings[num + o + 1]
	end
	
	return txt
end

function ENT:GetOverlayText()
	local txt = ""
	
	local OverlaySettings = list.Get( "LSEntOverlayText" )[self:GetClass()]
	
	if (OverlaySettings) then
		if (OverlaySettings.func) then
			txt = OverlaySettings.func( self ) or ""
		else
			txt = self:MakeOverlayText( OverlaySettings ) or ""
		end
	else
		txt = self:GetNetworkedString( "GModOverlayText" ) or ""
	end
	
	local PlayerName = self:GetPlayerName()
	if ( not game.SinglePlayer() and PlayerName ~= "") then
		txt = txt .. "\n- " .. PlayerName .. " -"
	end
	
	return txt
end

function ENT:RecvOOO( act )
	self.OOOActive = act
	self.OverlayTextOOO = BasicOOO[ act ]
end
