--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

---
-- @description Library EFFECT
 module("EFFECT")

--- EFFECT:EndTouch
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function EndTouch() end

--- EFFECT:Init
-- @usage client
-- Called when the effect is created.
--
-- @param  effectData CEffectData  The effect data used to create the effect.
function Init( effectData) end

--- EFFECT:PhysicsCollide
-- @usage client
-- Called when the effect collides with anything.
--
-- @param  colData table  Information regarding the collision. See CollisionData structure
-- @param  collider PhysObj  The physics object of the entity that collided with the effect.
function PhysicsCollide( colData,  collider) end

--- EFFECT:Render
-- @usage client
-- Called when the effect should be rendered.
--
function Render() end

--- EFFECT:StartTouch
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function StartTouch() end

--- EFFECT:Think
-- @usage client
-- Called when the effect should think, return false to kill the effect.
--
-- @return boolean Return false to remove this effect.
function Think() end

--- EFFECT:Touch
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function Touch() end
