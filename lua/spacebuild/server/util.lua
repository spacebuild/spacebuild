--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 14/01/2017
-- Time: 22:48
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local log = SB.log
local internal = SB.internal


local damage = {}
local wire = {}

damage.repair = function(ent)
    ent:SetHealth(ent:GetMaxHealth())
end

damage.doDamage = function(ent, amountOfDamage)
    if not (ent and ent:IsValid() and amountOfDamage) then return end
    if ent:GetMaxHealth( ) == 0 then return end
    amountOfDamage = math.floor(amountOfDamage / 2)
    if (ent:Health( ) > 0) then
        local HP = ent:Health( ) - amountOfDamage
        ent:SetHealth( HP )
        if (ent:Health( ) <= (ent:GetMaxHealth( ) / 2)) then
            if ent.Damage then
                ent:Damage()
            end
        end
        damage.changeColor(ent, 2, 200)
        damage.changeColor(ent, 3, 175)
        damage.changeColor(ent, 4, 150)
        damage.changeColor(ent, 5, 125)
        damage.changeColor(ent, 6, 100)
        damage.changeColor(ent, 7, 75)
        if (ent:Health( ) <= 0) then
            ent:SetColor(Color(50, 50, 50, 255))
            if ent.Destruct then
                ent:Destruct()
            else
                damage.destruct( ent, true )
            end
        end
    end

end

damage.changeColor = function(ent, hpDivider, colorCode)
    if not ent or not hpDivider or not colorCode or not IsValid(ent) then return end
    if (ent:Health() <= (ent:GetMaxHealth( ) / hpDivider)) then
        ent:SetColor(Color(colorCode, colorCode, colorCode, 255))
    end
end

local function RemoveEntity( ent )
    if (ent:IsValid()) then
        ent:Remove()
    end
end

local function Explode1( ent )
    if ent:IsValid() then
        local Effect = EffectData()
        Effect:SetOrigin(ent:GetPos() + Vector( math.random(-60, 60), math.random(-60, 60), math.random(-60, 60) ))
        Effect:SetScale(1)
        Effect:SetMagnitude(25)
        util.Effect("Explosion", Effect, true, true)
    end
end

local function Explode2( ent )
    if ent:IsValid() then
        local Effect = EffectData()
        Effect:SetOrigin(ent:GetPos())
        Effect:SetScale(3)
        Effect:SetMagnitude(100)
        util.Effect("Explosion", Effect, true, true)
        RemoveEntity( ent )
    end
end

damage.destruct = function ( ent, useSimpleEffects )
    if useSimpleEffects then
        Explode2( ent )
    else
        timer.Simple(1, function() Explode1(ent) end)
        timer.Simple(1.2, function() Explode1(ent) end)
        timer.Simple(2, function() Explode1(ent) end)
        timer.Simple(2, function() Explode2(ent) end)
    end
end

damage.burnQuiet = function(ent)
    if not ent then return end
    ent:StopSound( "NPC_Stalker.BurnFlesh" )
end

damage.performBurnedEffect = function(ent)
    if not ent then return end
    ent:EmitSound( "NPC_Stalker.BurnFlesh" )
    ent:SetModel("models/player/charple.mdl")
    timer.Simple(3, function() damage.burnQuiet(ent) end)
end

damage.zapArea = function (pos, magnitude)
    if not (pos and magnitude) then return end
    local zap = ents.Create("point_tesla")
    zap:SetKeyValue("targetname", "teslab")
    zap:SetKeyValue("m_SoundName" ,"DoSpark")
    zap:SetKeyValue("texture" ,"sprites/physbeam.spr")
    zap:SetKeyValue("m_Color" ,"200 200 255")
    zap:SetKeyValue("m_flRadius" ,tostring(magnitude*80))
    zap:SetKeyValue("beamcount_min" ,tostring(math.ceil(magnitude)+4))
    zap:SetKeyValue("beamcount_max", tostring(math.ceil(magnitude)+12))
    zap:SetKeyValue("thick_min", tostring(magnitude))
    zap:SetKeyValue("thick_max", tostring(magnitude*8))
    zap:SetKeyValue("lifetime_min" ,"0.1")
    zap:SetKeyValue("lifetime_max", "0.2")
    zap:SetKeyValue("interval_min", "0.05")
    zap:SetKeyValue("interval_max" ,"0.08")
    zap:SetPos(pos)
    zap:Spawn()
    zap:Fire("DoSpark","",0)
    zap:Fire("kill","", 1)
end


damage.performFrostyEffects = function (ent)
    if not ent then return end
    ent:EmitSound( "vehicles/v8/skid_lowfriction.wav" )
end

damage.performCrushEffects = function(ent)
    if not ent then return end
    ent:EmitSound( "Player.FallGib" )
end


SB.util.damage =  internal.readOnlyTable(damage)
SB.util.wire =  internal.readOnlyTable(wire)












