--
-- Created by IntelliJ IDEA.
-- User: Sam Elmer
-- Date: 8/11/12
-- Time: 9:03 AM
-- To change this template use File | Settings | File Templates.
--
RESOURCES = {}

--TODO: Complete Documentation
--TODO: For Developers: You need to fill this file out with your custom RD replacement/whatever.


if (SERVER) then
    AddCSLuaFile("autorun/resources_api.lua")
end



if (CLIENT) then
	local meta = FindMetaTable("Entity")

	--- Used to draw any connections, "beams", info huds, etc for the devices.
	-- This should go into ENT:Draw() or any other draw functions.
	-- @param ent The entity. Does this really need explanation?
	-- @return nil
	function meta:ResourcesDraw(ent)

    end
end

--Credit really should goto Maddog. I just rewrote these slighty
---Note: limit may be a function, value, or nil. So within tool make sure to check against function if type(limit)=="function"
--Optional: categories
function RESOURCES:ToolRegister(name, description, limit)
        self.Tools[toolname] = self.Tools[toolname] or {}
        self.Tools[toolname].limit = limit or 30
        self.Tools[toolname].description = description or ""
 
 
end
 
---adds a category row to the tool
function RESOURCES:ToolRegisterCategory( toolname, categoryname, categorydescription, limit )
        self.Tools[toolname] = self.Tools[toolname] or {}
        self.Tools[toolname].categories = self.Tools[toolname].categories or {}
        self.Tools[toolname].categories[categoryname] = {
                description = categorydescription,
                limit = limit
        }
end
 
---This function will make it so custom devices could be added to your tool system.
--This call would be placed in the entities shared.lua file
--example: RESOURCES:ToolRegisterDevice("Life Support", "Storage Devices", "Air Tank", "air_tank", "models/props_c17/canister01a.mdl")
--makefunc is for backwards compatibility. This really should just but in the ENT:Initalize function
--@params toolname The name of the Tools EG: 'Cdsweapons'
--@params categoryname The Name of the category
--@params name The print name of the entity to be added
--@params class No idea
--@params model The model 
--@params makefunc Backwards Compatibilty really
function RESOURCES:ToolRegisterDevice(toolname, categoryname, name, class, model, makefunc)
        if type(name) == "table" then
                for _, v in pairs(name) do CAF_AddStoolItem(toolname, categoryname, v.name, v.class, v.model, v.makefunc) end
                return
        end
 
        self.Tools[toolname] = self.Tools[toolname] or {}
        self.Tools[toolname].categories = self.Tools[toolname].categories or {}
        self.Tools[toolname].categories[categoryname] = self.Tools[toolname].categories[categoryname] or {}
        self.Tools[toolname].categories[categoryname].devices = self.Tools[toolname].categories[categoryname].devices or {}
        self.Tools[toolname].categories[categoryname].devices[name] = {
                class = class,
                model = model,
                makefunc = makefunc
        }
 
        CAF_AddStoolItem( category, name, model, class, makefunc )
end

if (SERVER) then
	
	
	function RESOURCES:Link(ent,ent1)
		RD.Link(ent,ent1)
	end
	
	
	
	
	--Start of Entity: Functions 
	local meta = FindMetaTable("Entity")
	
	function meta:Register(typeEnt)
		if (type(typeEnt) == "string") then
			if (typeEnt == "NonStorage") then
			    RD.RegisterNonStorageDevice(self)
            else
                RD.RegisterDevice(self)
            end
		end
	end
	
	--- Used to Consume Resources.
	-- Call it with ENT:ResConsume()
	--@param res The String or table of the resource(s) you want to consume
	--@param amt The amount you want to consume. Can be negative or positive.
	--@returns Amount Consumed.. If it is coded by Developers to.
	function meta:ResConsume( res, amt )
		if (type(res) == "table") then
			for k,v in pairs(res) do 
				local amtTotal = amtTotal + RD.Consume(self,v,amt)
			end
		elseif (type(res) == "string") then
			return RD.Consume(self,res,amt)
		end
	end
	--- Supplies the Resource to the connected network.
	-- Call it with ENT:ResourcesSupply()
	--@param res The string or table of the resource(s) you want to supply to the connected network.
	--@param amt The amount you want to supply
	--@returns Amount that could not be supplied.
	function meta:ResourcesSupply( res, amt )
		if (type(res) == "table") then
			for k,v in pairs(res) do 
				local amtTotal = amtTotal + RD.SupplyResource(self,v,amt)
			end
			return amtTotal
		elseif (type(res) == "string") then
			return RD.SupplyResource(self,res,amt)
		end	
	end
	--- Get's the network capacity of the entity.
	--@returns The Capcity of the network attached to the entity. This is the maximum amount of res it can have.
	--@param res The resource you want it to return the capacity of.
	function meta:ResourcesGetCapacity( res )
		RD.GetNetworkCapacity(self,res)
	end


	--- Set's the Capacity of the entity.
	--@param amt The capacity you want to set
	--@param res The resource (string or table) you want to set the capacity (amt) of
	--@param def The default amount you want the entity to contain.
	function meta:ResourcesSetDeviceCapacity( res, amt, def  )
		if (type(res) == "table") then
			for k,v in pairs(res) do 
				RD.AddResource(self, v, amt, def)
			end
		elseif (type(res) == "string") then
			RD.AddResource(self,res,amt,def) 
		end
	end
	
	
	--- Get's the amount of the entity.
	--@returns The amount contained
	--@params res The resource you want the amount of. (String or Table)
	function meta:ResourcesGetAmount( res )
		if (type(res) == "table") then
			resources = {}
			for _,v in pairs(res) do
				resources[v] = RD.GetResourceAmount(self, v)
			end
			return resources
		else
			return RD.GetResourceAmount(self, res )
		end
	end
	--- Get's how much of the resource is contained in the netowrk attached to this entity.
	--@returns The amount stored in the device's network
	--@params res The resource you want to return the amount of. (String or Table)
	function meta:ResourceGetDeviceCapaciy( res )
		if (type(res) == "table") then
			resources = {}
			for _,v in pairs(res) do
				resources[v] = RD.GetUnitCapacity(self, v)
			end
			return resources
		else
			return RD.GetUnitCapacity(self, res )
		end
	end

	--- Custom Link. Not needed for RD3 or RD2
	function ResourcesLink( ent, ent1)

	end
	-- No idea how this works.
	function meta:ResourcesGetConnected()
		 local ent = self
		
	end

	function meta:ResourcesApplyDupeInfo( ply, entity, CreatedEntities )
		RD.ApplyDupeInfo(self, CreatedEntities)
	end

	function meta:ResourceBuildDupeInfo()
		RD.BuildDupeInfo(self)
	end


end





