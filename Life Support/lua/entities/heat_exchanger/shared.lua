ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Heat Exchanger"

list.Set( "LSEntOverlayText" , "heat_exchanger", {HasOOO = true, num = 2, strings = {ENT.PrintName.." ","\nCoolant: ","\nEnergy: "},resnames = {"coolant","energy"}} )
