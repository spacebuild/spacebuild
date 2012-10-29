-- shanjaq: Start Life Support mod.
-- HUDMod by Kyzer

local version = "WORKSHOP"

Msg("===============================\n===  LS2  "..version.."   Installed   ===\n===============================\n")

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

local FontName	= "LifeSupport_HUDText"
surface.CreateFont( FontName, {	font		= "Tahoma",
								size		= 16,
								weight		= 1000,
								antialias	= true,
								additive	= false })

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
			
			surface.SetFont(FontName)
			draw.RoundedBox( 8, Left2 , H2, 160, H3, Black)
			
			// Temperature
			draw.Text({	text = "Temperature:",
						font = FontName,
						pos = {Left, TH[1]},
						xalign = TEXT_ALIGN_LEFT,
						color = White})
			draw.Text({ text = tostring(Temp).." K",
						font = FontName,
						pos = {Right, TH[1]},
						xalign = TEXT_ALIGN_RIGHT,
						color = ValCol[1]})
			
			// Air
			draw.Text({ text = "Air:",
						font = FontName,
						pos = {Left, TH[2]},
						xalign = TEXT_ALIGN_LEFT,
						color = White})
			draw.Text({ text = tostring(Air).."%",
						font = FontName,
						pos = {Right, TH[2]},
						xalign = TEXT_ALIGN_RIGHT,
						color = ValCol[2]})
			
			// Coolant
			draw.Text({ text = "Coolant:",
						font = FontName,
						pos = {Left, TH[3]},
						xalign = TEXT_ALIGN_LEFT,
						color = White})
			draw.Text({ text = tostring(Coolant).."%",
						font = FontName,
						pos = {Right, TH[3]},
						xalign = TEXT_ALIGN_RIGHT,
						color = ValCol[3]})
			
			// Energy
			draw.Text({ text = "Energy:",
						font = FontName,
						pos = {Left, TH[4]},
						xalign = TEXT_ALIGN_LEFT,
						color = White})
			draw.Text({ text = tostring(Energy).."%",
						font = FontName,
						pos = {Right, TH[4]},
						xalign = TEXT_ALIGN_RIGHT,
						color = ValCol[4]})

		end
		
	end
	
end 
hook.Add("HUDPaint", "Shan_LifeSupport_HUDPaint", lifesupport_HUDPaint)

net.Receive("LS_netmessage", function( len )

	ls_habitat = net.ReadFloat()
	ls_air = net.ReadFloat()
	ls_tmp = net.ReadFloat()
	ls_coolant = net.ReadFloat()
	ls_energy = net.ReadFloat()

end)

-- End Life Support mod.

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

