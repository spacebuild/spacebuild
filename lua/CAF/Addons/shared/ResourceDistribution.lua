

--[[
	--
	nettable= {}
	nettable[netid] = {}
	nettable[netid].resources = {}
	nettable[netid].resources[resource] = {}
	nettable[netid].resources[resource] .value = value
	nettable[netid].resources[resource] .maxvalue = value
	nettable[netid].resources[resource].haschanged = true/false
	nettable[netid].entities = {}
	nettable[netid].haschanged = true/false
	nettable[netid].clear = true/false
	nettable[netid].new = true/false
				.cons = {}
	--
	ent_table = {}
	ent_table[entity] = {}
	ent_table[entity].resources = {}
	ent_table[entity].resources[resource] = {}
	ent_table[entity].resources[resource].maxvalue = value
	ent_table[entity].resources[resource].value = value
	ent_table[entity].resources[resource].haschanged = true/false
	ent_table[entity].network = networkid
	--ent_table[entity].linkedto = {}--remove if simplified RD
	ent_table[entity].clear = true/false
	ent_talbe[entity].haschanged = true/false
	ent_Table[entity].new = true/false
	--
	Simplified RD:
	
		Instead of being able to connect everything to everything you will only be able to connect something to a resource Node (as long as you are in it's radius, 1024?)
		You will also be able to connect resource nodes to eachother to combine resources like this.
		This system should make RD simplifief because it's got less network parts to go through, less networks should be formed in total to, meaning that less network traffic should be able to be achieved to. Because the smaller amount of networks and that everything is connected to only 1 thing it should also make 
		it use less CPU and RAM compared to the current RD.
		For linking this system can have 2 types of linking:
			1) Wireless: No wire is drawn
			2) wired: Same as the Wireless, but a wire is drawn (tool could be made like the wire stools, whit nodes you can put in between the start and end location of the wire.
		What do you  guys think?
			Pro's:
				Simpler in code
				Should be better performance wise
				Easier to detect what is connected to what
				Should be easier to make new devices to expand and stuff	
			Cons:
				No linking between devices anymore, always an intermediate Resource Node in between
]]








