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
-- @description Library ENT
 module("ENT")

--- ENT:AcceptInput
-- @usage server
-- Called when another entity fires an event to this entity.
--
-- @param  inputName string  The name of the input that was triggered.
-- @param  activator Entity  The initial cause for the input getting triggered.
-- @param  called Entity  The entity that directly trigger the input.
-- @param  data string  The data passed.
-- @return boolean Should we suppress the default action for this input?
function AcceptInput( inputName,  activator,  called,  data) end

--- ENT:Initialize
-- @usage shared
-- Called when the entity is created. This is called when you Entity:Spawn the custom entity.
--
function Initialize() end

--- ENT:KeyValue
-- @usage server
-- Called when the engine sets a value for this entity.
--
-- @param  key string  The key that was affected.
-- @param  value string  The new value.
-- @return boolean Return true to suppress this KeyValue or return false or nothing to apply this key value.
function KeyValue( key,  value) end

--- ENT:OnReloaded
-- @usage shared
-- Called when the entity is reloaded by the auto-reload system.
--
function OnReloaded() end

--- ENT:OnRemove
-- @usage shared
-- Called when the entity is about to be removed.
--
function OnRemove() end

--- ENT:OnRestore
-- @usage shared
-- Called when the entity was reloaded from a save game.
--
function OnRestore() end

--- ENT:SpawnFunction
-- @usage server
-- This is the spawn function. It's called when a client calls the entity to be spawned.
--If you want to make your SENT spawnable you need this function to properly create the entity.
--
-- @param  ply Player  The player that is spawning this SENT
-- @param  tr table  A TraceResult structure from player eyes to their aim position
-- @param  ClassName string  The classname of your entity
function SpawnFunction( ply,  tr,  ClassName) end

--- ENT:StoreOutput
-- @usage server
-- Used to store an output so it can be triggered with ENTITY:TriggerOutput.
--Outputs compiled into a map are passed to entities as key/value pairs through ENTITY:KeyValue.
--
-- @param  name string  Name of output to store
-- @param  info string  Output info
function StoreOutput( name,  info) end

--- ENT:Think
-- @usage shared
-- Called every frame on the client.
--Called every tick on the server.
--
-- @return boolean Return true if you used Entity:NextThink to override the next execution time.
function Think() end

--- ENT:TriggerOutput
-- @usage server
-- Triggers all outputs stored using ENTITY:StoreOutput.
--
-- @param  output string  Name of output to fire
-- @param  activator Entity  Activator entity
-- @param  data=nil string  The data to give to the output.
function TriggerOutput( output,  activator,  data) end
