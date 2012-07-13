
/*---------------------------------------------------------

  Space Build Gamemode

---------------------------------------------------------*/

GM.Name 	= "SpaceBuild2"
GM.Author 	= "LS-RD-SB Team"
GM.Email 	= ""
GM.Website 	= "http://gee-linx.ath.cx"

DeriveGamemode("sandbox")
GM.IsSandboxDerived = true
GM.IsSpaceBuildDerived = true
GM.affected = {
	"player",
	"prop_physics",
	"prop_ragdoll",
	"npc_grenade_frag",
	"npc_grenade_bugbait",
	"npc_satchel",
	"grenade_ar2",
	"crossbow_bolt",
	"phys_magnet",
	"prop_vehicle_airboat",
	"prop_vehicle_jeep",
	"prop_vehicle_prisoner_pod"
}

volumes = {}
