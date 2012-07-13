-- shanjaq: Start Life Support mod.
-- HUDMod by Kyzer

local FairTemp_Min = 288
local FairTemp_Max = 303
local ls_habitat = 0
local ls_air = 0
local ls_tmp = 0
local ls_coolant = 0
local ls_energy = 0

local ScH	= ScrH()
local MidW	= ScrW() / 2
local Left	= MidW - 70
local Left2	= MidW - 80
local Right	= MidW + 70
local H1	= ScH / 10
local H2	= ScH - H1
local H3	= H1 - 5
local TH	= { H2 + 5, H2 + 20, H2 + 35, H2 + 50 }
local Font	= "ScoreboardText"

local White	= Color(225,225,225,255)
local Black	= Color(0,0,0,100)
local Cold	= Color(0,225,255,255)
local Hot	= Color(225,0,0,255)
local Warn	= Color(255,165,0,255)

local function lifesupport_HUDPaint()

	if GetConVarString('cl_hudversion') == "" then
		
		local ply = LocalPlayer()
		if not ply or not ply:Alive() then return end
		
		if ply:WaterLevel() > 2 or ls_habitat == 1 or (ls_tmp > 0 and not (ls_tmp >= FairTemp_Min and ls_tmp <= FairTemp_Max)) then
			
			local Temp = ls_tmp
			local Air = ls_air / 20
			local Coolant = ls_coolant / 20
			local Energy = ls_energy / 20
			local ValCol = { White, White, White, White }
			
			if		Temp < FairTemp_Min then ValCol[1] = Cold
			elseif	Temp > FairTemp_Max then ValCol[1] = Hot
			end
			
			if Air		< 4 then ValCol[2] = Warn end
			if Coolant	< 4 then ValCol[3] = Warn end
			if Energy	< 4 then ValCol[4] = Warn end
			
			draw.RoundedBox( 8, Left2 , H2, 160, H3, Black)
			
			draw.DrawText( "Temperature:",			Font, Left,	TH[1], White,		0 )
			draw.DrawText( tostring(Temp).." K",	Font, Right,TH[1], ValCol[1],	2 )
			draw.DrawText( "Air:",					Font, Left,	TH[2], White,		0 )
			draw.DrawText( tostring(Air).."%",		Font, Right,TH[2], ValCol[2],	2 )
			draw.DrawText( "Coolant:",				Font, Left,	TH[3], White,		0 )
			draw.DrawText( tostring(Coolant).."%",	Font, Right,TH[3], ValCol[3],	2 )
			draw.DrawText( "Energy:",				Font, Left,	TH[4], White, 		0 )
			draw.DrawText( tostring(Energy).."%",	Font, Right,TH[4], ValCol[4],	2 )
			
		end
		
	end
	
end 
hook.Add("HUDPaint", "Shan_LifeSupport_HUDPaint", lifesupport_HUDPaint)
-- shanjaq: End Life Support mod.

function LS_umsg_hook( um )
	ls_habitat = um:ReadShort()
	ls_air = um:ReadShort()
	ls_tmp = um:ReadShort()
	ls_coolant = um:ReadShort()
	ls_energy = um:ReadShort()
end
usermessage.Hook("LS_umsg", LS_umsg_hook) 

-- Start eHud Stuff
if not huddata then
	huddata = {}
end

function lifesupport_think()

	if not LocalPlayer():IsValid() or not LocalPlayer():Alive() then
		return
	end

	huddata.lssAir = ls_air / 100
	huddata.lssAirRes = (huddata.lssAir - 1) / 19
	huddata.lssTmp = ls_tmp / 288
	huddata.lssCool = ls_coolant / 100
	huddata.lssEnergy = ls_energy / 100
end
hook.Add("Think","lifesupport_think",lifesupport_think)
-- End eHud Stuff

