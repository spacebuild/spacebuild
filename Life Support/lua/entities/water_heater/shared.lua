ENT.Type 		= "anim"
ENT.Base 		= "base_rd_entity"
ENT.PrintName 	= "Water Heater"

list.Set( "LSEntOverlayText" , "water_heater", {HasOOO = true, num = 2, strings = {ENT.PrintName.."\n","\nEnergy: ","\nWater: "},resnames = {"energy","water"}} )
