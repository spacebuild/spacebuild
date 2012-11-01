--[[
	Resources API
		Last Update: 1 May 2012
		Authors: MadDog, CmdrMatthew, SnakeSVx
		Type: RD3 implementation (SnakeSVx)

		file: resources_api.lua

	Use this in your Life Support devices. Using these function names will
	insure they are compatibile with other systems that use this API.

	This will be called as a shared file as it contains both SERVER and
	CLIENT functions.

	To setup a device you need to run the code:
		ent:InitResources()

	After that the following functions are available to use:
		Client Side Functions:
			ent:ResourcesDraw()

		Server Side Functions:
			ent:ResourcesConsume( resourcename, amount )
			ent:ResourcesSupply( resourcename, amount )
			ent:ResourcesGetCapacity( resourcename )
			ent:ResourcesSetDeviceCapacity( resourcename, amount )
			ent:ResourcesGetAmount( resourcename )
			ent:ResourcesGetDeviceAmount( resourcename )
			ent:ResourcesGetDeviceCapacity( resourcename )
			ent:ResourcesLink( entity )
			ent:ResourcesUnlink( entity )
			ent:ResourcesCanLink( entity )
]]

local CLIENT, SERVER, pairs, AddCSLuaFile, type, FindMetaTable, RD = CLIENT, SERVER, pairs, AddCSLuaFile, type, FindMetaTable, nil;


if SERVER then
    AddCSLuaFile("autorun/resources_api.lua") --if you change the file name or path change this!
end

RESOURCES = {}
--[[
<major>.<minor>.<patch>

And constructed with the following guidelines:

Breaking backward compatibility bumps the major (and resets the minor and patch)
New additions without breaking backward compatibility bumps the minor (and resets the patch)
Bug fixes and misc changes bumps the patch
 ]]
RESOURCES.Version = {
    major = 1,
    minor = 0,
    patch = 0
}
RESOURCES.Types = {
    UNKNOWN = 0,
    ENTITY = 1,
    NETWORK = 2,
    PUMP = 3,
    VALVE = 4
}

local ResourcesDraw, ResourcesConsume, ResourcesSupply, ResourcesGetCapacity, ResourcesSetDeviceCapacity, ResourcesGetAmount, ResourcesGetDeviceAmount, ResourcesGetDeviceCapacity, ResourcesLink, ResourcesUnlink, ResourcesGetLinks, ResourcesCanLink, ResourcesGetConnected, ResourcesBuildDupeInfo, ResourcesApplyDupeInfo

local function getRD()
    if not RD then
        RD = CAF.GetAddon("Resource Distribution");
    end
    return RD;
end

if CLIENT then


    --Used do draw any connections, "beams", info huds, etc for the devices.
    --this would be placed within the ENT:Draw() function
    ResourcesDraw = function(ent)
    end

elseif SERVER then

    --Can be negitive or positive (for consume and generate)
    -- supply: resource name or resource table
    -- returns: amount not consumed
    ResourcesConsume = function(ent, res, amount)
        if type(res) == "table" then
            local consume = {}
            for n, v in pairs(res) do
                consume[n] = ResourcesConsume(ent, n, v)
            end
            return consume
        end
        -- TODO add net support
        return amount - getRD().ConsumeResource(ent, res, amount); --0 = success. Anything larger and it couldnt consume the amount
    end

    --Supplies the resource to the connected network
    -- supply: resource name or resource table
    -- returns:  amount not supplied
    ResourcesSupply = function(ent, res, amount)
        if type(res) == "table" then
            local supply = {}
            for n, v in pairs(res) do
                supply[n] = ResourcesSupply(ent, n, v)
            end
            return supply
        end
        -- TODO add net support
        return getRD().SupplyResource(ent, res, amount); --0 = success. Anything larger and it couldnt supply the amount (insufficient storage)
    end

    --Gets the devices networks total storage for the resource
    -- supply: resource name
    -- returns: number
    -- note: If passed in nothing (nil), return the capity for each resource
    ResourcesGetCapacity = function(ent, res)
        if res then
            -- TODO add net support
            return getRD().GetNetworkCapacity(ent, res);
        else
            local res_table = {}
            local ent_table = getRD().GetEntityTable(ent)
            for k, v in pairs(ent_table.resources) do
                -- TODO add net support
                res_table[k] = getRD().GetNetworkCapacity(ent, v);
            end
            return res_table;
        end
    end

    --Sets the device max storage capacity
    -- supply: resource name or resource table
    -- returns:
    ResourcesSetDeviceCapacity = function(ent, res, amount)
        if type(res) == "table" then
            for n, v in pairs(res) do ResourcesSetDeviceCapacity(ent, n, v) end
            return
        end

    --your code here
    end

    --  Gets the devices stored amount of resource from the connected network
    --  supply: resource name
    --  returns: number
    ResourcesGetAmount = function(ent, res)
        if res then
            --your code here
            return 0
        else
            --your code here
            return {} --table of resources
        end
    end

    --how much this devive is holding
    -- supply: resource name
    -- returns: number
    ResourcesGetDeviceAmount = function(ent, res)
        if res then
            --your code here
            return 0
        else
            --your code here
            return {} --table of resources
        end
    end

    --how much this devives network is holding
    -- supply: resource name
    -- returns: number
    ResourcesGetDeviceCapacity = function(ent, res)
        if res then
            --your code here
            return 0
        else
            --your code here
            return {} --table of resources
        end
    end

    --link to another device/network
    -- supply: entity
    -- returns:
    ResourcesLink = function(ent, entity)
    --your code here
    end

    --removes all link from a network
    -- supply: entity or table of entities (all optional)
    -- returns:
    -- note: if an entity is passed in then unlink with that entity, otherwise unlink all
    ResourcesUnlink = function(ent, entity)
        if type(entity) == "table" then
            for _, v in pairs(entity) do ResourcesUnlink(ent, v) end
            return
        end

        if (not entity) then
            --your code here, unlink all
        else
            --your code here, unlink with entity
        end
    end


    ResourcesGetLinks = function(ent)
        return {} --table of connected entities
    end

    --Determains if two devices can be linked
    -- supply: entity or table of entities
    -- returns: boolean (if entity passed in), or table (if table of entities passed in)
    ResourcesCanLink = function(ent, entity)
        if type(entity) == "table" then
            local links = {}
            for _, v in pairs(entity) do
                links[entity] = ResourcesCanLink(ent, v)
            end
            return links
        end

        --your code here
        return false
    end

    --Returns a list of connected entities
    ResourcesGetConnected = function(ent)
        return {} --returns a table of all connected entities
    end

    --This function is called to save any resource info so it can be saved using the duplicator
    --this goes into ENT:PreEntityCopy
    ResourcesBuildDupeInfo = function(ent)
    --your code here
    end

    --This function is called to store any resource info after a dup
    --this goes into ENT:PostEntityPaste
    ResourcesApplyDupeInfo = function(ent, ply, entity, CreatedEntities)
    --your code here
    end
end


--register the device clientside
function RESOURCES:Setup(ent, type)
    --[[
         your shared code here
     ]]

    --client functions
    if CLIENT then
        --[[
              your client side code here
        ]]

        --Used do draw any connections, "beams", info huds, etc for the devices.
        --this would be placed within the ENT:Draw() function
        ent.ResourcesDraw = ResourcesDraw;

        --server functions
    elseif SERVER then

        --[[
              your server side code here
          ]]

        --Can be negitive or positive (for consume and generate)
        -- supply: resource name or resource table
        -- returns: amount not consumed
        ent.ResourcesConsume = ResourcesConsume;

        --Supplies the resource to the connected network
        -- supply: resource name or resource table
        -- returns: amount not supplied
        ent.ResourcesSupply = ResourcesSupply

        --Gets the devices networks total storage for the resource
        -- supply: resource name
        -- returns: number
        -- note: If passed in nothing (nil), return the capity for each resource
        ent.ResourcesGetCapacity = ResourcesGetCapacity

        --Sets the device max storage capacity
        -- supply: resource name or resource table
        -- returns:
        ent.ResourcesSetDeviceCapacity = ResourcesSetDeviceCapacity

        --  Gets the devices stored amount of resource from the connected network
        --  supply: resource name
        --  returns: number
        ent.ResourcesGetAmount = ResourcesGetAmount

        --how much this devive is holding
        -- supply: resource name
        -- returns: number
        ent.ResourcesGetDeviceAmount = ResourcesGetDeviceAmount

        --how much this devives network is holding
        -- supply: resource name
        -- returns: number
        ent.ResourcesGetDeviceCapacity = ResourcesGetDeviceCapacity


        --link to another device/network
        -- supply: entity
        -- returns:
        ent.ResourcesLink = ResourcesLink

        --removes all link from a network
        -- supply: entity or table of entities (all optional)
        -- returns:
        -- note: if an entity is passed in then unlink with that entity, otherwise unlink all
        ent.ResourcesUnlink = ResourcesUnlink

        ent.ResourcesGetLinks = ResourcesGetLinks

        --Determains if two devices can be linked
        -- supply: entity or table of entities
        -- returns: boolean (if entity passed in), or table (if table of entities passed in)
        ent.ResourcesCanLink = ResourcesCanLink

        --Returns a list of connected entities
        ent.ResourcesGetConnected = ResourcesGetConnected

        --This function is called to save any resource info so it can be saved using the duplicator
        --this goes into ENT:PreEntityCopy
        ent.ResourcesBuildDupeInfo = ResourcesBuildDupeInfo


        --This function is called to store any resource info after a dup
        --this goes into ENT:PostEntityPaste
        ent.ResourcesApplyDupeInfo = ResourcesApplyDupeInfo
    end
end

local meta = FindMetaTable("Entity")

--sets up the functions to be used on the "Life Support" devices
-- supply: entity
function meta:InitResources()
    RESOURCES:Setup(self)
end