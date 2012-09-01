--[[
	Resources API
		Last Update: May 5 2012
		Authors: MadDog, CmdrMatthew, SnakeSVx

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
			ent:ResourcesGetAmount( resourcename )

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

local CLIENT, SERVER, pairs, AddCSLuaFile, type, FindMetaTable = CLIENT, SERVER, pairs, AddCSLuaFile, type, FindMetaTable;

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

local ResourcesDraw, ResourcesConsume, ResourcesSupply, ResourcesGetCapacity, ResourcesSetDeviceCapacity, ResourcesGetAmount, ResourcesGetDeviceAmount, ResourcesGetDeviceCapacity, ResourcesLink, ResourcesUnlink, ResourcesCanLink, ResourcesGetConnected, ResourcesBuildDupeInfo, ResourcesApplyDupeInfo


--function to create a new in the Life Support system
--Note: limit may be a number OR function (and called before a device is created)
function RESOURCES:ToolRegister(name, description, limit)
end

--adds a category row to the tool
--Note: limit may be a number OR function (and called before a device is created)
function RESOURCES:ToolRegisterCategory(toolname, categoryname, categorydescription, limit)
end

--This function will make it so custom devices could be added to your tool system.
--This call would be placed in the entities shared.lua file
--example: RESOURCES:ToolRegisterDevice("Life Support", "Storage Devices", "Air Tank", "air_tank", "models/props_c17/canister01a.mdl")
--makefunc is for backwards compatibility. This really should just but in the ENT:Initalize function
function RESOURCES:ToolRegisterDevice(toolname, categoryname, name, class, model, makefunc)
end

if CLIENT then

    --Used do draw any connections, "beams", info huds, etc for the devices.
    --this would be placed within the ENT:Draw() function
    ResourcesDraw = function(ent)
    --RD2 doesnt need this, it uses some funky custom ent creation stuff
    end

    --Gets the devices stored amount of resource from the connected network
    --  supply: resource name
    --  returns: number or table
    ResourcesGetAmount = function(ent, res)
        if res then
            --your code here
            return 0
        else
            --your code here
            return {} --table of resources
        end
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

        --your code here
        return 0
    end

    --Supplies the resource to the connected network
    -- supply: resource name or resource table
    -- returns: amount not supplied
    ResourcesSupply = function(ent, res, amount)
        if type(res) == "table" then
            local supply = {}
            for n, v in pairs(res) do
                supply[n] = ResourcesSupply(ent, n, v)
            end
            return supply
        end

        --your code here
        return 0
    end

    --Gets the devices networks total storage for the resource
    -- supply: resource name
    -- returns: number
    -- note: If passed in nothing (nil), return the capity for each resource
    ResourcesGetCapacity = function(ent, res)
        if res then
            --your code here
            return 0
        else
            --your code here
            return {} --table of resources
        end
    end

    --Sets the device max storage capacity
    -- supply: resource name or resource table
    ResourcesSetDeviceCapacity = function(ent, res, amount)
        if type(res) == "table" then
            for n, v in pairs(res) do ResourcesSetDeviceCapacity(ent, n, v) end
            return
        end

    --your code here
    end

    --  Gets the devices stored amount of resource from the connected network
    --  supply: resource name
    --  returns: number or table
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
    -- returns: number or table
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
    -- returns: number or table
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
    ResourcesLink = function(ent, entity)
    --your code here to link the two entities
    end

    --removes all link from a network
    -- supply: entity or table of entities (all optional)
    -- note: if an entity is passed in then unlink with that entity, otherwise unlink all
    ResourcesUnlink = function(ent, entity)
        if type(entity) == "table" then
            for _, v in pairs(entity) do ResourcesUnlink(ent, v) end
            return
        end

        if (not entity) then
            --your code to unlink all from this device
        else
            --your code to unlink entity from ent
        end
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
        return true
    end

    --Returns a list of connected entities
    ResourcesGetConnected = function(ent)
    --your code here
        return {}
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
          your shared code here (if needed)
      ]]

    if ent.ResourcesDraw or ent.ResourcesConsume then return end --already registered

    --client functions
    if CLIENT then
        --[[
                your client side code here
          ]]

        --Used do draw any connections, "beams", info huds, etc for the devices.
        --this would be placed within the ENT:Draw() function
        ent.ResourcesDraw = ResourcesDraw

        --  Gets the devices stored amount of resource from the connected network
        --  supply: resource name
        --  returns: number
        ent.ResourcesGetAmount = ResourcesGetAmount

        --server functions
    elseif SERVER then

        --[[
                your server side code here (if needed)
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