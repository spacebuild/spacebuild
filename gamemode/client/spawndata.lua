-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOORS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local DTT = {}

DTT.SmallBridge = {}
DTT.SmallBridge["Doors"] = {
	"models/smallbridge/panels/sbpaneldoor.mdl",
	"models/smallbridge/panels/sbpaneldoorsquare.mdl",
	"models/smallbridge/panels/sbpaneldooriris.mdl",
	"models/smallbridge/panels/sbpaneliris.mdl",
	"models/smallbridge/panels/sbpaneldoorwide.mdl",
	"models/smallbridge/panels/sbpaneldoordh.mdl",
	"models/smallbridge/panels/sbpaneldoordhdw.mdl",
	"models/smallbridge/panels/sbpaneldoordw.mdl",
	"models/smallbridge/panels/sbpaneldoordw2.mdl",
	"models/smallbridge/panels/sbpaneldoorsquaredw.mdl",
	"models/smallbridge/panels/sbpaneldoorsquaredw2.mdl",
	"models/smallbridge/panels/sbpaneldockin.mdl",
	"models/smallbridge/panels/sbpaneldockout.mdl",
	"models/smallbridge/ship parts/sbhulldse.mdl",
	"models/smallbridge/ship parts/sbhulldseb.mdl",
	"models/smallbridge/ship parts/sbhulldst.mdl",
	"models/smallbridge/ship parts/sbhulldsdwe.mdl",
	"models/slyfo/slypaneldoor1.mdl",
	"models/slyfo/doublehatch.mdl",
	"models/sbep_community/d12MBSFrame.mdl"
}

DTT.SmallBridge["Hatches (Base)"] = {
	"models/smallbridge/elevators_small/sbselevb.mdl",
	"models/smallbridge/elevators_small/sbselevbe.mdl",
	"models/smallbridge/elevators_small/sbselevbedh.mdl",
	"models/smallbridge/elevators_small/sbselevbedw.mdl",
	"models/smallbridge/elevators_small/sbselevbr.mdl",
	"models/smallbridge/elevators_small/sbselevbt.mdl",
	"models/smallbridge/elevators_small/sbselevbx.mdl",
	"models/smallbridge/elevators_large/sblelevb.mdl",
	"models/smallbridge/elevators_large/sblelevbe.mdl",
	"models/smallbridge/elevators_large/sblelevbedh.mdl",
	"models/smallbridge/elevators_large/sblelevbr.mdl",
	"models/smallbridge/elevators_large/sblelevbt.mdl",
	"models/smallbridge/elevators_large/sblelevbx.mdl"
}

DTT.SmallBridge["Hatches (Mid)"] = {
	"models/smallbridge/elevators_small/sbselevm.mdl",
	"models/smallbridge/elevators_small/sbselevme.mdl",
	"models/smallbridge/elevators_small/sbselevmedh.mdl",
	"models/smallbridge/elevators_small/sbselevmedw.mdl",
	"models/smallbridge/elevators_small/sbselevmr.mdl",
	"models/smallbridge/elevators_small/sbselevmt.mdl",
	"models/smallbridge/elevators_small/sbselevmx.mdl",
	"models/smallbridge/elevators_large/sblelevm.mdl",
	"models/smallbridge/elevators_large/sblelevme.mdl",
	"models/smallbridge/elevators_large/sblelevmedh.mdl",
	"models/smallbridge/elevators_large/sblelevmr.mdl",
	"models/smallbridge/elevators_large/sblelevmt.mdl",
	"models/smallbridge/elevators_large/sblelevmx.mdl"
}

DTT.SmallBridge["Hatches (Top)"] = {
	"models/smallbridge/elevators_small/sbselevt.mdl",
	"models/smallbridge/elevators_small/sbselevte.mdl",
	"models/smallbridge/elevators_small/sbselevtedh.mdl",
	"models/smallbridge/elevators_small/sbselevtedw.mdl",
	"models/smallbridge/elevators_small/sbselevtr.mdl",
	"models/smallbridge/elevators_small/sbselevtt.mdl",
	"models/smallbridge/elevators_small/sbselevtx.mdl",
	"models/smallbridge/elevators_large/sblelevt.mdl",
	"models/smallbridge/elevators_large/sblelevte.mdl",
	"models/smallbridge/elevators_large/sblelevtedh.mdl",
	"models/smallbridge/elevators_large/sblelevtr.mdl",
	"models/smallbridge/elevators_large/sblelevtt.mdl",
	"models/smallbridge/elevators_large/sblelevtx.mdl"
}

DTT.SmallBridge["Other"] = {
	"models/smallbridge/panels/sbpaneldbsmall.mdl",
	"models/smallbridge/station parts/sbbaydps.mdl",
	"models/mandrac/smallbridgeaddon/2room.mdl"
}

DTT.ModBridge = {}
DTT.ModBridge["ModBridge"] = {
	"models/Cerus/Modbridge/Misc/Doors/door11a.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door11b.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door12b.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door12a.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door13a.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door23a.mdl",
	"models/Cerus/Modbridge/Misc/Doors/door33a.mdl",
	"models/Cerus/Modbridge/Misc/Accessories/acc_furnace1.mdl"
}

for k, v in pairs(DTT) do
	list.Set("SB4_DoorToolModels", k, v)
end

local DCT = {}

DCT["models/smallbridge/panels/sbpaneldoor.mdl"] = { { type = "Door_AnimS1" } }
DCT["models/smallbridge/panels/sbpaneldoorsquare.mdl"] = { { type = "Door_AnimS2" } }
DCT["models/smallbridge/panels/sbpaneldooriris.mdl"] = { { type = "Door_SIris" } }
DCT["models/smallbridge/panels/sbpaneliris.mdl"] = { { type = "Door_SIris" } }
DCT["models/smallbridge/panels/sbpaneldoorwide.mdl"] = { { type = "Door_AnimW" } }
DCT["models/smallbridge/panels/sbpaneldoordh.mdl"] = { { type = "Door_AnimT" } }
DCT["models/smallbridge/panels/sbpaneldoordhdw.mdl"] = { { type = "Door_AnimL" } }
DCT["models/smallbridge/panels/sbpaneldoordw.mdl"] = { { type = "Door_AnimS1" } }
DCT["models/smallbridge/panels/sbpaneldoordw2.mdl"] = {
	{ type = "Door_AnimS1", V = Vector(0, 111.6, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimS1", V = Vector(0, -111.6, 0) }
}
DCT["models/smallbridge/panels/sbpaneldoorsquaredw.mdl"] = { { type = "Door_AnimS2" } }
DCT["models/smallbridge/panels/sbpaneldoorsquaredw2.mdl"] = {
	{ type = "Door_AnimS2", V = Vector(0, 111.6, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -111.6, 0) }
}
DCT["models/smallbridge/panels/sbpaneldockin.mdl"] = { { type = "Door_AnimS2" } }
DCT["models/smallbridge/panels/sbpaneldockout.mdl"] = { { type = "Door_AnimS2" } }
DCT["models/smallbridge/ship parts/sbhulldse.mdl"] = {
	{ type = "Door_Hull" },
	{ type = "Door_Hull", nil, A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/ship parts/sbhulldseb.mdl"] = { { type = "Door_Hull" } }
DCT["models/smallbridge/ship parts/sbhulldst.mdl"] = { { type = "Door_Hull" } }
DCT["models/smallbridge/ship parts/sbhulldsdwe.mdl"] = {
	{ type = "Door_Hull", V = Vector(0, 111.6, 0) },
	{ type = "Door_Hull", V = Vector(0, -111.6, 0), A = Angle(0, 180, 0) }
}
DCT["models/slyfo/slypaneldoor1.mdl"] = { { type = "Door_Sly1" } }
DCT["models/slyfo/doublehatch.mdl"] = { { type = "Door_SlyDHatch" } }
DCT["models/SBEP_community/d12MBSFrame.mdl"] = { { type = "Door_d12MBSFrame" } }
local p = {}
function p:Hello()
	print("")
end


DCT["models/cerus/modbridge/misc/doors/door11a.mdl"] = { { type = "Door_ModBridge_11a" } }
DCT["models/cerus/modbridge/misc/doors/door11b.mdl"] = { { type = "Door_ModBridge_11b" } }
DCT["models/cerus/modbridge/misc/doors/door12b.mdl"] = { { type = "Door_ModBridge_12b" } }
DCT["models/cerus/modbridge/misc/doors/door12a.mdl"] = { { type = "Door_ModBridge_12a" } }
DCT["models/cerus/modbridge/misc/doors/door13a.mdl"] = { { type = "Door_ModBridge_13a" } }
DCT["models/cerus/modbridge/misc/doors/door23a.mdl"] = { { type = "Door_ModBridge_23a" } }
DCT["models/cerus/modbridge/misc/doors/door33a.mdl"] = { { type = "Door_ModBridge_33a" } }
DCT["models/cerus/modbridge/misc/accessories/acc_furnace1.mdl"] = { { type = "ACC_Furnace1" } }

DCT["models/smallbridge/elevators_small/sbselevb.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbe.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbedh.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 190.65) },
	{ type = "Door_AnimT", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimT", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbedw.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbr.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 270, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbt.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevbx.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/elevators_large/sblelevb.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbe.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbedh.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 190.65) },
	{ type = "Door_AnimL", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimL", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbedw.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbr.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbt.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevbx.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/elevators_small/sbselevm.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevme.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevmedh.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 190.65) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimT", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimT", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevmedw.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevmr.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 270, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevmt.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevmx.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/elevators_large/sblelevm.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevme.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevmedh.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 190.65) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimL", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimL", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevmedw.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevmr.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevmt.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevmx.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, 60.45) },
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/elevators_small/sbselevt.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevte.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevtedh.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimT", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimT", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevtedw.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevtr.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 270, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevtt.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_small/sbselevtx.mdl"] = {
	{ type = "Door_ElevHatch_S", V = Vector(0, 0, -60.45) },
	{ type = "Door_AnimS2", V = Vector(60.45, 0, 0) },
	{ type = "Door_AnimS2", V = Vector(-60.45, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimS2", V = Vector(0, 60.45, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimS2", V = Vector(0, -60.45, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/elevators_large/sblelevt.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevte.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevtedh.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimL", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimL", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevtedw.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevtr.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevtt.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}
DCT["models/smallbridge/elevators_large/sblelevtx.mdl"] = {
	{ type = "Door_ElevHatch_L", V = Vector(0, 0, -60.45), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(176.7, 0, 0) },
	{ type = "Door_AnimW", V = Vector(-176.7, 0, 0), A = Angle(0, 180, 0) },
	{ type = "Door_AnimW", V = Vector(0, 176.7, 0), A = Angle(0, 90, 0) },
	{ type = "Door_AnimW", V = Vector(0, -176.7, 0), A = Angle(0, -90, 0) }
}

DCT["models/smallbridge/panels/sbpaneldbsmall.mdl"] = { { type = "Door_DBS" } }
DCT["models/smallbridge/station parts/sbbaydps.mdl"] = {
	{ type = "Door_AnimS2", V = Vector(51.15, 0, 0) },
	{ type = "Door_SIris", V = Vector(-37.2, 0, -60.45), A = Angle(90, 0, 0) }
}
DCT["models/mandrac/smallbridgeaddon/2room.mdl"] = {
	{ type = "Door_Insert", V = Vector(34.5, 7.62, 65.1) },
	{ type = "Door_Insert", V = Vector(-34.5, 7.62, 65.1) }
}

for m, D in pairs(DCT) do
	list.Set("SB4_DoorControllerModels", m, D)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON MOUNTS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local WTT = {}

WTT["Wings"] = {
	"models/Spacebuild/milcock4_wing1.mdl",
	"models/Spacebuild/milcock4_wing2.mdl",
	"models/Spacebuild/milcock4_wing3.mdl",
	"models/Spacebuild/milcock4_wing4.mdl",
	"models/Spacebuild/milcock4_wing5l.mdl",
	"models/Spacebuild/milcock4_wing5r.mdl",
	"models/Spacebuild/milcock4_wing6.mdl",
	"models/Spacebuild/milcock4_wing7.mdl"
}

WTT["Rover"] = {
	"models/Slyfo/rover1_backpanel.mdl",
	"models/Slyfo/rover1_leftpanel.mdl",
	"models/Slyfo/rover1_leftpanelmount.mdl",
	"models/Slyfo/rover1_rightpanel.mdl",
	"models/Slyfo/rover1_rightpanelmount.mdl"
}

for k, v in pairs(WTT) do
	list.Set("SB4_WeaponMountToolModels", k, v)
end

local WMMT = {}
WMMT["models/Spacebuild/milcock4_wing1.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = { { Type = { "Small", "Tiny" }, Pos = Vector(0, 24, 0), Angle = Angle(0, 0, 180) } }
}
WMMT["models/Spacebuild/milcock4_wing2.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = { { Type = { "Small", "Tiny" }, Pos = Vector(0, 16, 0), Angle = Angle(0, 0, 180) } }
}
WMMT["models/Spacebuild/milcock4_wing3.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = {
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 21, 5), Angle = Angle(0, 0, 0) },
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 21, -5), Angle = Angle(0, 0, 180) },
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 192, 2), Angle = Angle(0, 0, 0) },
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 192, -2), Angle = Angle(0, 0, 180) }
	}
}
WMMT["models/Spacebuild/milcock4_wing4.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = {
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 64, 5), Angle = Angle(0, 0, 0) },
		{ Type = { "Small", "Tiny" }, Pos = Vector(0, 64, -5), Angle = Angle(0, 0, 180) }
	}
}
WMMT["models/Spacebuild/milcock4_wing5l.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = { { Type = { "Small", "Tiny" }, Pos = Vector(-11, 28, 5), Angle = Angle(0, 0, 180) } }
}
WMMT["models/Spacebuild/milcock4_wing5r.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, -90),
	HP = { { Type = { "Small", "Tiny" }, Pos = Vector(-11, -28, 5), Angle = Angle(0, 0, 180) } }
}
WMMT["models/Spacebuild/milcock4_wing6.mdl"] = {
	type = "Wing",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 90),
	HP = { { Type = { "Small", "Tiny" }, Pos = Vector(0, 96, 0), Angle = Angle(0, 0, -90) } }
}
WMMT["models/Spacebuild/milcock4_wing7.mdl"] = {
	type = "Wing",
	V = Vector(-5, 27, -4),
	A = Angle(0, 0, 90),
	HP = {
		{ Type = { "Small", "Tiny" }, Pos = Vector(-5, -4, 14), Angle = Angle(0, 0, 0) },
		{ Type = { "Small", "Tiny" }, Pos = Vector(-5, -4, -6), Angle = Angle(0, 0, 180) }
	}
}

WMMT["models/Slyfo/rover1_backpanel.mdl"] = {
	type = "RBackPanel",
	V = Vector(0, 0, -6),
	A = Angle(0, 0, 0),
	HP = { { Type = "Small", Pos = Vector(0, 14, -12) } }
}
WMMT["models/Slyfo/rover1_leftpanel.mdl"] = { type = "RLeftPanel", V = Vector(0, 0, 0), A = Angle(0, 0, 0) }
WMMT["models/Slyfo/rover1_leftpanelmount.mdl"] = {
	type = "RLeftPanel",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 0),
	HP = { { Type = { "Tiny", "Small" }, Pos = Vector(-6, 6, -2), Angle = Angle(0, 0, 270) } }
}
WMMT["models/Slyfo/rover1_rightpanel.mdl"] = { type = "RRightPanel", V = Vector(0, 0, 0), A = Angle(0, 0, 0) }
WMMT["models/Slyfo/rover1_rightpanelmount.mdl"] = {
	type = "RRightPanel",
	V = Vector(0, 0, 0),
	A = Angle(0, 0, 0),
	HP = { { Type = { "Tiny", "Small" }, Pos = Vector(-6, -6, -2), Angle = Angle(0, 0, 90) } }
}

for k, v in pairs(WMMT) do
	list.Set("SB4_WeaponMountModels", k, v)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOCKING CLAMPS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local DTT = {}

DTT["Doors"] = {
	"models/smallbridge/ship parts/sblandramp.mdl",
	"models/smallbridge/ship parts/sblanduramp.mdl",
	"models/smallbridge/panels/sbpaneldockin.mdl",
	"models/smallbridge/panels/sbpaneldockout.mdl",
	"models/smallbridge/ship parts/sblandrampdw.mdl",
	"models/smallbridge/ship parts/sblandurampdw.mdl",
	"models/smallbridge/ship parts/sblandrampdwdh.mdl",
	"models/smallbridge/ship parts/sblandurampdwdh.mdl"
}

DTT["MedBridge"] = {
	"models/slyfo/airlock_docksys.mdl"
}

DTT["ElevatorSmall"] = {
	"models/smallbridge/elevators_small/sbselevb.mdl",
	"models/smallbridge/elevators_small/sbselevt.mdl"
}

DTT["PHX"] = {
	"models/props_phx/construct/metal_wire1x1.mdl",
	"models/props_phx/construct/metal_wire2x2b.mdl"
}

for k, v in pairs(DTT) do
	list.Set("SB4_DockClampToolModels", k, v)
end

local DCMT = {}
DCMT["models/smallbridge/ship parts/sblandramp.mdl"] = {
	ALType = "SWSHA",
	Compatible = { { Type = "SWSHB", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-65, -110, 50), sp = 0 },
		{ vec = Vector(-90, 95, -60), sp = 3 },
		{ vec = Vector(90, 95, -60), sp = 0 },
		{ vec = Vector(65, -110, 50), sp = 1 }
	}
}
DCMT["models/smallbridge/ship parts/sblanduramp.mdl"] = {
	ALType = "SWSHB",
	Compatible = { { Type = "SWSHA", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-65, 100, 60), sp = 0 },
		{ vec = Vector(-90, -110, -50), sp = 3 },
		{ vec = Vector(90, -110, -50), sp = 0 },
		{ vec = Vector(65, 100, 60), sp = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/smallbridge/panels/sbpaneldockin.mdl"] = {
	ALType = "PLockA",
	Compatible = { { Type = "PLockB", AF = -4.65 } },
	EfPoints = {
		{ vec = Vector(-60, -10, 60), sp = 1 },
		{ vec = Vector(-95, -10, 0), sp = 0 },
		{ vec = Vector(-87, -10, -60), sp = 3 },
		{ vec = Vector(87, -10, -60), sp = 0 },
		{ vec = Vector(95, -10, 0), sp = 5 },
		{ vec = Vector(60, -10, 60), sp = 0 }
	}
}
DCMT["models/smallbridge/panels/sbpaneldockout.mdl"] = {
	ALType = "PLockB",
	Compatible = { { Type = "PLockA", AF = 4.65 } },
	EfPoints = {
		{ vec = Vector(-60, 10, 60), sp = 0 },
		{ vec = Vector(-95, 10, 0), sp = 2 },
		{ vec = Vector(-87, 10, -60), sp = 0 },
		{ vec = Vector(87, 10, -60), sp = 4 },
		{ vec = Vector(95, 10, 0), sp = 5 },
		{ vec = Vector(60, 10, 60), sp = 6 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/slyfo/airlock_docksys.mdl"] = {
	ALType = "MedGLB",
	Compatible = { { Type = "MedGLB", AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-70, -30, 125), sp = 0 },
		{ vec = Vector(-190, -30, 60), sp = 5 },
		{ vec = Vector(-195, -30, -115), sp = 0 },
		{ vec = Vector(195, -30, -125), sp = 3 },
		{ vec = Vector(195, -30, 60), sp = 2 },
		{ vec = Vector(70, -30, 125), sp = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/smallbridge/ship parts/sblandrampdw.mdl"] = {
	ALType = "DWSHA",
	Compatible = { { Type = "DWSHB", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-175, -110, 50), sp = 0 },
		{ vec = Vector(-200, 95, -60), sp = 3 },
		{ vec = Vector(200, 95, -60), sp = 0 },
		{ vec = Vector(175, -110, 50), sp = 1 }
	}
}
DCMT["models/smallbridge/ship parts/sblandurampdw.mdl"] = {
	ALType = "DWSHB",
	Compatible = { { Type = "DWSHA", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-175, 100, 60), sp = 0 },
		{ vec = Vector(-200, -110, -50), sp = 3 },
		{ vec = Vector(200, -110, -50), sp = 0 },
		{ vec = Vector(175, 100, 60), sp = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/smallbridge/ship parts/sblandrampdwdh.mdl"] = {
	ALType = "DWDHA",
	Compatible = { { Type = "DWDHB", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-175, -110, 180), sp = 0 },
		{ vec = Vector(-200, 90, -60), sp = 3 },
		{ vec = Vector(200, 90, -60), sp = 0 },
		{ vec = Vector(175, -110, 180), sp = 1 }
	}
}
DCMT["models/smallbridge/ship parts/sblandurampdwdh.mdl"] = {
	ALType = "DWDHB",
	Compatible = { { Type = "DWDHA", AF = 0, AYaw = 180 } },
	EfPoints = {
		{ vec = Vector(-175, 100, 190), sp = 0 },
		{ vec = Vector(-200, -120, -60), sp = 3 },
		{ vec = Vector(200, -120, -60), sp = 0 },
		{ vec = Vector(175, 100, 190), sp = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/smallbridge/elevators_small/sbselevb.mdl"] = {
	ALType = "ElevSU",
	Compatible = {
		{ Type = "ElevSU", AU = 65.1, RYaw = 90, ARoll = 180 },
		{ Type = "ElevSD", AU = 65.1, RYaw = 90 }
	},
	EfPoints = {
		{ vec = Vector(-60.45, 60.45, 69.75), sp = 1 },
		{ vec = Vector(-60.45, -60.45, 69.75), sp = 0 },
		{ vec = Vector(60.45, -60.45, 69.75), sp = 3 },
		{ vec = Vector(60.45, 60.45, 69.75), sp = 0 }
	}
}
DCMT["models/smallbridge/elevators_small/sbselevt.mdl"] = {
	ALType = "ElevSD",
	Compatible = {
		{ Type = "ElevSD", AU = -65.1, RYaw = 90, ARoll = 180 },
		{ Type = "ElevSU", AU = -65.1, RYaw = 90 }
	},
	EfPoints = {
		{ vec = Vector(-60.45, 60.45, -69.75), sp = 0 },
		{ vec = Vector(-60.45, -60.45, -69.75), sp = 2 },
		{ vec = Vector(60.45, -60.45, -69.75), sp = 0 },
		{ vec = Vector(60.45, 60.45, -69.75), sp = 4 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DCMT["models/props_phx/construct/metal_wire1x1.mdl"] = {
	ALType = "PHX1x1",
	Compatible = { { Type = "PHX1x1", AU = 6, RYaw = 90, ARoll = 180 } },
	EfPoints = {
		{ vec = Vector(-20, 20, 8), sp = 0 },
		{ vec = Vector(-20, -20, 8), sp = 2 },
		{ vec = Vector(20, -20, 8), sp = 0 },
		{ vec = Vector(20, 20, 8), sp = 4 }
	}
}
DCMT["models/props_phx/construct/metal_wire2x2b.mdl"] = {
	ALType = "PHX2x2",
	Compatible = { { Type = "PHX2x2", AU = 6, RYaw = 90, ARoll = 180 } },
	EfPoints = {
		{ vec = Vector(-44.5, 44.5, 8), sp = 0 },
		{ vec = Vector(-44.5, -44.5, 8), sp = 2 },
		{ vec = Vector(44.5, -44.5, 8), sp = 0 },
		{ vec = Vector(44.5, 44.5, 8), sp = 4 }
	}
}

for k, v in pairs(DCMT) do
	list.Set("SB4_DockingClampModels", k, v)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
