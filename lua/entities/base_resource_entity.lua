AddCSLuaFile( )

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Base Resource Entity"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.GENERATOR)
end


function ENT:OnRemove()
    sb.removeDevice(self)
end

if ( CLIENT ) then

    function ENT:BeingLookedAtByLocalPlayer()

        if ( LocalPlayer():GetEyeTrace().Entity ~= self ) then return false end
        if ( EyePos():Distance( self:GetPos() ) > 256 ) then return false end

        return true

    end

    function ENT:Draw()
        if self:BeingLookedAtByLocalPlayer() and self.rdobject then
            local resources = self.rdobject:getResources()
            local res_gen_string = ""
            local res_store_string = ""
            local full_string = self.PrintName .. "\n"
            local am, maxam
            for _, v in pairs(resources) do
                maxam = self.rdobject:getMaxResourceAmount( v:getName())
                if maxam > 0 then
                    res_store_string = res_store_string ..v:getName().." = "..tostring(self.rdobject:getResourceAmount(v:getName())).."/"..tostring(maxam).."\n"
                else
                    res_gen_string = res_gen_string .. v:getName() .. "\n"
                end
            end
            if string.len(res_store_string) > 0 then
                full_string = full_string .. "Stores:\n" ..res_store_string
            end

            if string.len(res_gen_string) > 0 then
                full_string = full_string .. "Produces/Requires:\n" ..res_gen_string
            end

            AddWorldTip(self:EntIndex(), full_string, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end


