ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Climate Regulator"

list.Set( "LSEntOverlayText" , "climate_control", {HasOOO = true, num = 3, strings = {ENT.PrintName.." ","\nAir: ","\nCoolant: ","\nEnergy: "},resnames = {"air","coolant","energy"}} )
