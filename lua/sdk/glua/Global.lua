
--- AccessorFunc
-- @usage shared_m
-- Adds simple Get/Set accessor functions on the specified table.
--Can also force the value to be set to a number, bool or string.
--
-- @param  tab table  The table to add the accessor functions too.
-- @param  key any  The key of the table to be get/set.
-- @param  name string  The name of the functions (will be prefixed with Get and Set).
-- @param  force=nil number  The type the setter should force to (uses FORCE_ Enums).
function AccessorFunc( tab,  key,  name,  force) end

--- Add_NPC_Class
-- @usage shared_m
-- Defines a global entity class variable with an automatic value in order to prevent collisions with other CLASS_ Enums. You should prefix your variable with CLASS_ for consistency.
--
-- @param  name string  The name of the new enum/global variable.
function Add_NPC_Class( name) end

--- AddBackgroundImage
-- @usage menu
-- Adds the specified image path to the main menu background pool. Image can be png or jpeg.
--
-- @param  path string  Path to the image.
function AddBackgroundImage( path) end

--- AddConsoleCommand
-- @usage shared_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--Use concommand.Run instead.
-- @param  name string  The name of the console command to add.
-- @param  helpText string  The help text.
-- @param  flags number  Concommand flags using FCVAR_ Enums
function AddConsoleCommand( name,  helpText,  flags) end

--- AddCSLuaFile
-- @usage shared
-- Marks a Lua file to be sent to clients when they join the server. Doesn't do anything on the client - this means you can use it in a shared file without problems.
--
-- @param  file=current file string  The name/path to the Lua file that should be sent, relative to the garrysmod/lua folder. If no parameter is specified, it sends the current file.  The file path can be relative to the script it is ran from. For example, if your script is in lua/myfolder/stuff.lua, calling AddCSLuaFile("otherstuff.lua") and AddCSLuaFile("myfolder/otherstuff.lua") is the same thing.
function AddCSLuaFile( file) end

--- AddonMaterial
-- @usage client_m
-- Loads the specified image from the /cache folder, used in combination steamworks.Download.
--
-- @param  name string  The name of the file.
-- @return IMaterial The material, returns nil if the cached file is not an image.
function AddonMaterial( name) end

--- AddOriginToPVS
-- @usage server
-- Adds the specified vector to the PVS which is currently building. This allows all objects in visleafs visible from that vector to be drawn.
--
-- @param  position Vector  The origin to add.
function AddOriginToPVS( position) end

--- AddWorldTip
-- @usage client
-- This function creates a World Tip, similar to the one shown when aiming at a Thruster where it shows you its force.
--
-- @param  entindex=nil number  This argument is no longer used; it has no effect on anything. You can use nil in this argument.
-- @param  text string  The text for the world tip to display.
-- @param  dieTime=SysTime() + 0.05 number  This argument is no longer used; when you add a World Tip it will always last only 0.05 seconds. You can use nil in this argument.
-- @param  pos=ent:GetPos() Vector  Where in the world you want the World Tip to be drawn. If you add a valid Entity in the next argument, this argument will have no effect on the actual World Tip.
-- @param  ent=nil Entity  Which entity you want to associate with the World Tip. This argument is optional. If set to a valid entity, this will override the position set in pos with the Entity's position.
function AddWorldTip( entindex,  text,  dieTime,  pos,  ent) end

--- Angle
-- @usage shared_m
-- Creates an Angle object.
--
-- @param  pitch=0 number  The pitch value of the angle. If this is an Angle, this function will return a copy of the given angle. If this is a string, this function will try to parse the string as a angle. If it fails, it returns a 0 angle.  (See examples)
-- @param  yaw=0 number  The yaw value of the angle.
-- @param  roll=0 number  The roll value of the angle.
-- @return Angle Created angle
function Angle( pitch,  yaw,  roll) end

--- AngleRand
-- @usage shared_m
-- Returns an angle with a randomized pitch, yaw and roll, first one between -90 and 90, the rest between -180 and 180 degrees.
--
-- @return Angle The randomly generated angle.
function AngleRand() end

--- assert
-- @usage shared_m
-- If the result of the first argument is false or nil, an error is thrown with the second argument as the message.
--
-- @param  expression any  The expression to assert.
-- @param  errorMessage="assertion failed!" string  The error message to throw when assertion fails.
-- @return any If successful, returns the result of the first argument.
function assert( expression,  errorMessage) end

--- BroadcastLua
-- @usage server
-- Sends the specified Lua code to all connected clients and executes it.
--
-- @param  code string  The code to be executed. Capped at length of 254 characters.
function BroadcastLua( code) end

--- BuildNetworkedVarsTable
-- @usage shared
-- Dumps the networked variables of all entities into one table and returns it.
--
function BuildNetworkedVarsTable() end

--- CancelLoading
-- @usage menu
-- Aborts joining of the server you are currently joining.
--
function CancelLoading() end

--- ChangeBackground
-- @usage menu
-- Sets the active main menu background image to a random entry from the background images pool. Images are added with AddBackgroundImage.
--
-- @param  currentgm string  Apparently does nothing.
function ChangeBackground( currentgm) end

--- ChangeTooltip
-- @usage client_m
-- Automatically called by the engine when a panel is hovered over with the mouse
--
-- @param  panel Panel  Panel that has been hovered over
function ChangeTooltip( panel) end

--- ClearBackgroundImages
-- @usage menu
-- Empties the pool of main menu background images.
--
function ClearBackgroundImages() end

--- ClientsideModel
-- @usage client
-- Creates a non physical entity that only exists on the client.
--
-- @param  model string  The file path to the model.
-- @param  renderGroup=RENDERGROUP_OTHER number  The rendergroup of the entity, see RENDERGROUP_ Enums.
-- @return CSEnt Created client-side model. ( C_BaseFlex )
function ClientsideModel( model,  renderGroup) end

--- ClientsideRagdoll
-- @usage client
-- Creates a fully clientside ragdoll.
--
-- @param  model string  The file path to the model.
-- @param  renderGroup=RENDER_GROUP_OPAQUE number  The RENDERGROUP_ Enums to assign.
-- @return CSEnt The newly created client-side ragdoll. ( C_ClientRagdoll )
function ClientsideRagdoll( model,  renderGroup) end

--- ClientsideScene
-- @usage client
-- Creates a scene entity based on the scene name and the entity.
--
-- @param  name string  The name of the scene.
-- @param  targetEnt Entity  The entity to play the scene on.
-- @return CSEnt C_SceneEntity
function ClientsideScene( name,  targetEnt) end

--- CloseDermaMenus
-- @usage client_m
-- Closes all Derma menus that have been passed to RegisterDermaMenuForClose and calls GM:CloseDermaMenus
--
function CloseDermaMenus() end

--- collectgarbage
-- @usage shared_m
-- Executes the specified action on the garbage collector.
--
-- @param  action="collect" string  The action to run.  Valid actions are "collect", "stop", "restart", "count", "step", "setpause" and "setstepmul".
-- @param  arg number  The argument of the specified action, only applicable for "step", "setpause" and "setstepmul".
-- @return number 
function collectgarbage( action,  arg) end

--- Color
-- @usage shared_m
-- Creates a Color structure.
--
-- @param  r number  An integer from 0-255 describing the red value of the color.
-- @param  g number  An integer from 0-255 describing the green value of the color.
-- @param  b number  An integer from 0-255 describing the blue value of the color.
-- @param  a=255 number  An integer from 0-255 describing the alpha (transparency) of the color.
-- @return table The created Color structure.
function Color( r,  g,  b,  a) end

--- ColorAlpha
-- @usage shared_m
-- Returns a new Color structure with the RGB components of the given Color structure and the alpha value specified.
--
-- @param  color table  The Color structure from which to take RGB values. This color will not be modified.
-- @param  alpha number  The new alpha value, a number between 0 and 255. Values above 255 will be clamped.
-- @return table The new Color structure with the modified alpha value
function ColorAlpha( color,  alpha) end

--- ColorRand
-- @usage shared_m
-- Creates a Color structure with randomized red, green, and blue components. If the alpha argument is true, alpha will also be randomized.
--
-- @param  a=false boolean  Should alpha be randomized.
-- @return table The created Color structure.
function ColorRand( a) end

--- ColorToHSV
-- @usage shared_m
-- Converts a Color structure into HSV color space.
--
-- @param  color table  The Color structure.
-- @return number The hue in degrees.
-- @return number The saturation in the range 0-1.
-- @return number The value in the range 0-1.
function ColorToHSV( color) end

--- CompileFile
-- @usage shared
-- Attempts to compile the given file. If successful, returns a function that can be called to perform the actual execution of the script.
--
-- @param  path string  Path to the file, relative to the garrysmod/lua/ directory.
-- @return function The function which executes the script.
function CompileFile( path) end

--- CompileString
-- @usage shared_m
-- This function will compile the code argument as lua code and return a function that will execute that code.
--
-- @param  code string  The code to compile.
-- @param  identifier string  An identifier in case an error is thrown. (The same identifier can be used multiple times)
-- @param  HandleError=true boolean  If false this function will return an error string instead of throwing an error.
-- @return function A function that, when called, will execute the given code.
function CompileString( code,  identifier,  HandleError) end

--- ConsoleAutoComplete
-- @usage menu
-- Returns a table of console command names beginning with the given text.
--
-- @param  text string  Text that the console commands must begin with.
-- @return table Table of console command names.
function ConsoleAutoComplete( text) end

--- ConVarExists
-- @usage shared_m
-- Returns whether a ConVar with the given name exists or not
--
-- @param  name string  Name of the ConVar.
-- @return boolean True if the ConVar exists, false otherwise.
function ConVarExists( name) end

--- CreateClientConVar
-- @usage shared_m
-- Makes a clientside-only console variable
--
-- @param  name string  Name of the ConVar to be created and able to be accessed.  This cannot be a name of existing console command or console variable. It will silently fail if it is.
-- @param  default string  Default value of the ConVar.
-- @param  shouldsave=true boolean  Should the ConVar be saved across sessions
-- @param  userdata=false boolean  Should the ConVar and its containing data be sent to the server when it has changed. This make the convar accessible from server using Player:GetInfoNum and similar functions.
-- @param  helptext="" string  Help text to display in the console.
-- @return ConVar Created convar.
function CreateClientConVar( name,  default,  shouldsave,  userdata,  helptext) end

--- CreateConVar
-- @usage shared_m
-- Creates a console variable (ConVar), in general these are for things like gamemode/server settings.
--
-- @param  name string  Name of the convar.  This cannot be a name of an engine console command or console variable. It will silently fail if it is. If it is the same name as another lua ConVar, it will return that ConVar object.
-- @param  value string  Default value of the convar.
-- @param  flags number  Flags of the convar, see FCVAR_ Enums, either as bitflag or as table.
-- @param  helptext string  The help text to show in the console.
-- @return ConVar The ConVar created
function CreateConVar( name,  value,  flags,  helptext) end

--- CreateMaterial
-- @usage client_m
-- Creates a new material with the specified name and shader.
--
-- @param  name string  The material name. Must be unique.
-- @param  shaderName string  The shader name. See Category: Shaders.
-- @param  materialData table  Key-value table that contains shader parameters and proxies.  See: List of Shader Parameters on Valve Developers Wiki and each shader's page from Category: Shaders.    NOTE  Unlike IMaterial:SetTexture, this table will not accept ITexture values. Instead, use the texture's name (see ITexture:GetName). 
-- @return IMaterial Created material
function CreateMaterial( name,  shaderName,  materialData) end

--- CreateParticleSystem
-- @usage client
-- Creates a new particle system
--
-- @param  ent Entity  The entity to attach the control point to.
-- @param  effect string  The name of the effect to create. It must be precached.
-- @param  partAttachment number  See PATTACH_ Enums.
-- @param  entAttachment=0 number  The attachment ID on the entity to attach the particle system to
-- @param  offset=Vector( 0, 0, 0 ) Vector  The offset from the Entity:GetPos of the entity we are attaching this CP to.
-- @return CNewParticleEffect The created particle system.
function CreateParticleSystem( ent,  effect,  partAttachment,  entAttachment,  offset) end

--- CreateSound
-- @usage shared
-- Returns a sound parented to the specified entity.
--
-- @param  targetEnt Entity  The target entity.
-- @param  soundName string  The sound to play.
-- @param CPASAttenuationFilter CRecipientFilter  A CRecipientFilter of the players that will have this sound networked to them.    NOTE  This argument only works serverside. 
-- @return CSoundPatch The sound object
function CreateSound( targetEnt,  soundName, CPASAttenuationFilter) end

--- CreateSprite
-- @usage client
-- Creates and returns a new DSprite element with the supplied material.
--
-- @param  material IMaterial  Material the sprite should draw.
-- @return Panel The new DSprite element.
function CreateSprite( material) end

--- CurTime
-- @usage shared_m
-- Returns the uptime of the server in seconds (to at least 4 decimal places)
--
function CurTime() end

--- DamageInfo
-- @usage shared
-- Returns an CTakeDamageInfo object.
--
-- @return CTakeDamageInfo The CTakeDamageInfo object.
function DamageInfo() end

--- DebugInfo
-- @usage shared_m
-- Writes text to the right hand side of the screen, like the old error system. Messages disappear after a couple of seconds.
--
-- @param  slot number  The location on the right hand screen to write the debug info to. Starts at 0, no upper limit
-- @param  info string  The debugging information to be written to the screen
function DebugInfo( slot,  info) end

--- DeriveGamemode
-- @usage shared
-- Retrieves data from a gamemode to use in yours. This also sets a BaseClass field on your GM table to the gamemode you are deriving from. It appears that this function works by running the init and cl_init Lua files of the target gamemode, then overriding functions that appear in both the target and your gamemode with your gamemode's functions.
--
-- @param  base string  Gamemode name to derive from.
function DeriveGamemode( base) end

--- Derma_Anim
-- @usage client_m
-- Creates a new derma animation.
--
-- @param  name string  Name of the animation to create
-- @param  panel Panel  Panel to run the animation on
-- @param  func function  Function to call to process the animation Arguments:   Panel pnl - the panel passed to Derma_Anim  table anim - the anim table  number delta - the fraction of the progress through the animation  any data - optional data passed to the run metatable method
-- @return table A lua metatable containing four methods:  Run() - Should be called each frame you want the animation to be ran.  Active() - Returns if the animation is currently active (has not finished and stop has not been called)  Stop() - Halts the animation at its current progress.  Start( Length, Data ) - Prepares the animation to be ran for Length seconds. Must be called once before calling Run(). The data parameter will be passed to the func function.
function Derma_Anim( name,  panel,  func) end

--- Derma_DrawBackgroundBlur
-- @usage client_m
-- Draws background blur around the given panel.
--
-- @param  panel Panel  Panel to draw the background blur around
-- @param  startTime number  Time that the blur began being painted
function Derma_DrawBackgroundBlur( panel,  startTime) end

--- Derma_Hook
-- @usage client_m
-- Creates panel method that calls the supplied Derma skin hook via derma.SkinHook
--
-- @param  panel Panel  Panel to add the hook to
-- @param  functionName string  Name of panel function to create
-- @param  hookName string  Name of Derma skin hook to call within the function
-- @param  typeName string  Type of element to call Derma skin hook for
function Derma_Hook( panel,  functionName,  hookName,  typeName) end

--- Derma_Install_Convar_Functions
-- @usage client_m
-- Makes the panel (usually an input of sorts) respond to changes in console variables by adding next functions to the panel:
--
-- @param  target Panel  The panel the functions should be added to.
function Derma_Install_Convar_Functions( target) end

--- Derma_Message
-- @usage client_m
-- Creates a derma window to display information
--
-- @param  Text string  The text within the created panel.
-- @param  Title string  The title of the created panel.
-- @param  Button string  The text of the button to close the panel.
function Derma_Message( Text,  Title,  Button) end

--- Derma_Query
-- @usage client_m
-- Shows a message box in the middle of the screen, with up to 4 buttons they can press.
--
-- @param  text="Message Text (Second Parameter)" string  The message to display.
-- @param  title="Message Title (First Parameter)" string  The title to give the message box.
-- @param  btn1text string  The text to display on the first button.
-- @param  btn1func function  The function to run if the user clicks the first button.
-- @param  btn2text string  The text to display on the second button.
-- @param  btn2func function  The function to run if the user clicks the second button.
-- @param  btn3text string  The text to display on the third button
-- @param  btn3func function  The function to run if the user clicks the third button.
-- @param  btn4text string  The text to display on the third button
-- @param  btn4func function  The function to run if the user clicks the fourth button.
-- @return Panel The Panel object of the created window.
function Derma_Query( text,  title,  btn1text,  btn1func,  btn2text,  btn2func,  btn3text,  btn3func,  btn4text,  btn4func) end

--- Derma_StringRequest
-- @usage client_m
-- Creates a derma window asking players to input a string.
--
-- @param  title string  The title of the created panel.
-- @param  subtitle string  The text above the input box
-- @param  default string  The default text for the input box.
-- @param  confirm function  The function to be called once the user has confirmed their input.
-- @param  cancel=nil function  The function to be called once the user has cancelled their input
-- @param  confirmText="OK" string  Allows you to override text of the "OK" button
-- @param  cancelText="Cancel" string  Allows you to override text of the "Cancel" button
-- @return Panel The created DFrame
function Derma_StringRequest( title,  subtitle,  default,  confirm,  cancel,  confirmText,  cancelText) end

--- DermaMenu
-- @usage client_m
-- Creates a DMenu similar to a contextmenu and closes any current menus
--
-- @param  parent Panel  The panel to parent the created menu to.
-- @return Panel The created DMenu
function DermaMenu( parent) end

--- DisableClipping
-- @usage client_m
-- Sets whether rendering should be limited to being inside a panel or not
--
-- @param  disable boolean  Whether or not clipping should be disabled
function DisableClipping( disable) end

--- DOF_Kill
-- @usage client
-- Cancels current DOF post-process effect started with DOF_Start
--
function DOF_Kill() end

--- DOF_Start
-- @usage client
-- Cancels any existing DOF post-process effects.
--Begins the DOF post-process effect.
--
function DOF_Start() end

--- DOFModeHack
-- @usage client
-- A hacky method used to fix some bugs regarding DoF.
--
function DOFModeHack() end

--- DrawBackground
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function DrawBackground() end

--- DrawBloom
-- @usage client
-- Draws the bloom shader, which creates a glowing effect from bright objects.
--
-- @param  Darken number  Determines how much to darken the effect. A lower number will make the glow come from lower light levels. A value of 1 will make the bloom effect unnoticeable. Negative values will make even pitch black areas glow.
-- @param  Multiply number  Will affect how bright the glowing spots are. A value of 0 will make the bloom effect unnoticeable.
-- @param  SizeX number  The size of the bloom effect along the horizontal axis.
-- @param  SizeY number  The size of the bloom effect along the vertical axis.
-- @param  Passes number  Determines how much to exaggerate the effect.
-- @param  ColorMultiply number  Will multiply the colors of the glowing spots, making them more vivid.
-- @param  Red number  How much red to multiply with the glowing color. Should be between 0 and 1
-- @param  Green number  How much green to multiply with the glowing color. Should be between 0 and 1
-- @param  Blue number  How much blue to multiply with the glowing color. Should be between 0 and 1
function DrawBloom( Darken,  Multiply,  SizeX,  SizeY,  Passes,  ColorMultiply,  Red,  Green,  Blue) end

--- DrawColorModify
-- @usage client
-- Draws the Color Modify shader, which can be used to adjust colors on screen.
--
-- @param  modifyParameters table  Color modification parameters. See g_colourmodify Shader and the example below. Note that if you leave out a field, it will retain its last value which may have changed if another caller uses this function.
function DrawColorModify( modifyParameters) end

--- DrawMaterialOverlay
-- @usage client
-- Draws a material overlay on the screen.
--
-- @param  Material string  This will be the material that is drawn onto the screen.
-- @param  RefractAmount number  This will adjust how much the material will refract your screen.
function DrawMaterialOverlay( Material,  RefractAmount) end

--- DrawMotionBlur
-- @usage client
-- Creates a motion blur effect by drawing your screen multiple times.
--
-- @param  AddAlpha number  How much alpha to change per frame.
-- @param  DrawAlpha number  How much alpha the frames will have. A value of 0 will not render the motion blur effect.
-- @param  Delay number  Determines the amount of time between frames to capture.
function DrawMotionBlur( AddAlpha,  DrawAlpha,  Delay) end

--- DrawSharpen
-- @usage client
-- Draws the sharpen shader, which creates more contrast.
--
-- @param  Contrast number  How much contrast to create.
-- @param  Distance number  How large the contrast effect will be.
function DrawSharpen( Contrast,  Distance) end

--- DrawSobel
-- @usage client
-- Draws the sobel shader, which detects edges and draws a black border.
--
-- @param  Threshold number  Determines the threshold of edges. A value of 0 will make your screen completely black.
function DrawSobel( Threshold) end

--- DrawSunbeams
-- @usage client
-- Renders the post-processing effect of beams of light originating from the map's sun. Utilises the "pp/sunbeams" material
--
-- @param  darken number  $darken property for sunbeams material
-- @param  multiplier number  $multiply property for sunbeams material
-- @param  sunSize number  $sunsize property for sunbeams material
-- @param  sunX number  $sunx property for sunbeams material
-- @param  sunY number  $suny property for sunbeams material
function DrawSunbeams( darken,  multiplier,  sunSize,  sunX,  sunY) end

--- DrawTexturize
-- @usage client
-- Draws the texturize shader, which replaces each pixel on your screen with a different part of the texture depending on its brightness. See g_texturize for information on making the texture.
--
-- @param  Scale number  Scale of the texture. A smaller number creates a larger texture.
-- @param  BaseTexture number  This will be the texture to use in the effect. Make sure you use Material to get the texture number
function DrawTexturize( Scale,  BaseTexture) end

--- DrawToyTown
-- @usage client
-- Draws the toy town shader, which blurs the top and bottom of your screen. This can make very large objects look like toys, hence the name.
--
-- @param  Passes number  An integer determining how many times to draw the effect. A higher number creates more blur.
-- @param  Height number  The amount of screen which should be blurred on the top and bottom.
function DrawToyTown( Passes,  Height) end

--- DropEntityIfHeld
-- @usage shared
-- Drops the specified entity if it is being held by any player with Gravity Gun or +use pickup.
--
-- @param  ent Entity  The entity to drop.
function DropEntityIfHeld( ent) end

--- DynamicLight
-- @usage client
-- Creates or replaces a dynamic light with the given id.
--
-- @param  index number  Usually an entity index is used here.
-- @return table A DynamicLight structured table. See DynamicLight structure
function DynamicLight( index) end

--- EffectData
-- @usage shared
-- Returns a CEffectData object to be used with util.Effect.
--
-- @return CEffectData The CEffectData object.
function EffectData() end

--- Either
-- @usage shared_m
-- An 'if then else'. This is almost equivalent to (condition and truevar or falsevar) in Lua. The difference is that if truevar evaluates to false, the plain Lua method stated would return falsevar regardless of condition whilst this function would take condition into account.
--
-- @param  condition boolean  The condition to check if true or false.
-- @param  truevar any  If the condition is true, returns this variable.
-- @param  falsevar any  If the condition is false, returns this variable.
-- @return any The result.
function Either( condition,  truevar,  falsevar) end

--- EmitSentence
-- @usage shared
-- Plays a sentence from scripts/sentences.txt
--
-- @param  soundName string  The sound to play
-- @param  position Vector  The position to play at
-- @param  entity number  The entity to emit the sound from. Must be Entity:EntIndex
-- @param  channel=CHAN_AUTO number  The sound channel, see CHAN_ Enums.
-- @param  volume=1 number  The volume of the sound, from 0 to 1
-- @param  soundLevel=75 number  The sound level of the sound, see SNDLVL_ Enums
-- @param  soundFlags=0 number  The flags of the sound, see SND_ Enums
-- @param  pitch=100 number  The pitch of the sound, 0-255
function EmitSentence( soundName,  position,  entity,  channel,  volume,  soundLevel,  soundFlags,  pitch) end

--- EmitSound
-- @usage shared
-- Emits the specified sound at the specified position.
--Seems to work only clientside.
--
-- @param  soundName string  The sound to play
-- @param  position Vector  The position to play at
-- @param  entity number  The entity to emit the sound from. Must be Entity:EntIndex
-- @param  channel=CHAN_AUTO number  The sound channel, see CHAN_ Enums.
-- @param  volume=1 number  The volume of the sound, from 0 to 1
-- @param  soundLevel=75 number  The sound level of the sound, see SNDLVL_ Enums
-- @param  soundFlags=0 number  The flags of the sound, see SND_ Enums
-- @param  pitch=100 number  The pitch of the sound, 0-255
function EmitSound( soundName,  position,  entity,  channel,  volume,  soundLevel,  soundFlags,  pitch) end

--- EndTooltip
-- @usage client_m
-- Removes the currently active tool tip from the screen.
--
-- @param  panel Panel  This is the panel that has a tool tip.
function EndTooltip( panel) end

--- Entity
-- @usage shared
-- Returns the entity with the matching Entity:EntIndex.
--
-- @param  entityIndex number  The entity index.
-- @return Entity The entity if it exists.
function Entity( entityIndex) end

--- Error
-- @usage shared_m
-- Throws a Lua error with the specified message and stack level.
--
-- @param  arguments vararg  Converts all arguments to strings and prints them with no spacing or line breaks.
function Error( arguments) end

--- error
-- @usage shared_m
-- Throws a Lua error and breaks out of the current call stack.
--
-- @param  message string  The error message to throw.
-- @param  errorLevel=1 number  The level to throw the error at.
function error( message,  errorLevel) end

--- ErrorNoHalt
-- @usage shared_m
-- Throws a Lua error but does not break out of the current call stack.
--
-- @param  arguments vararg  Converts all arguments to strings and prints them with no spacing.
function ErrorNoHalt( arguments) end

--- EyeAngles
-- @usage client
-- Returns the angles of the players view calculated by GM:CalcView.
--
-- @return Angle The angle of the LocalPlayer's view.
function EyeAngles() end

--- EyePos
-- @usage client
-- Returns the position of the local player's view point as calculated by GM:CalcView.
--
function EyePos() end

--- EyeVector
-- @usage client
-- Returns the normal of the players view calculated by GM:CalcView similar to EyeAngles.
--
function EyeVector() end

--- FindMetaTable
-- @usage shared_m
-- Returns the meta table for the class with the matching name.
--
-- @param  metaName string  The object type to retrieve the meta table of.
-- @return table The corresponding meta table.
function FindMetaTable( metaName) end

--- FindTooltip
-- @usage client_m
-- Returns the tool-tip text and tool-tip-panel (if any) of the given panel as well as itself
--
-- @param  panel Panel  Panel to find tool-tip of
-- @return string tool-tip text
-- @return Panel tool-tip panel
-- @return Panel panel that the function was called with
function FindTooltip( panel) end

--- Format
-- @usage shared_m
-- Formats the specified values into the string given. Same as string.format.
--
-- @param  format string  The string to be formatted.  Follows this format: http://www.cplusplus.com/reference/cstdio/printf/
-- @param  formatParameters vararg  Values to be formatted into the string.
-- @return string The formatted string
function Format( format,  formatParameters) end

--- FrameNumber
-- @usage client
-- Returns the number of frames rendered since the game was launched.
--
function FrameNumber() end

--- FrameTime
-- @usage shared_m
-- Returns the CurTime-based time in seconds it took to render the last frame.
--
-- @return number time (in seconds)
function FrameTime() end

--- GameDetails
-- @usage menu
-- Callback function for when the client has joined a server. This function shows the server's loading URL by default.
--
-- @param  servername string  Server's name.
-- @param  serverurl string  Server's loading screen URL, or "" if the URL is not set.
-- @param  mapname string  Server's current map's name.
-- @param  maxplayers number  Max player count of server.
-- @param  steamid string  The local player's Player:SteamID64.
-- @param  gamemode string  Server's current gamemode's folder name.
function GameDetails( servername,  serverurl,  mapname,  maxplayers,  steamid,  gamemode) end

--- gcinfo
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This function was deprecated in Lua 5.1 and is removed in Lua 5.2. Use collectgarbage( "count" ) instead.
-- @return number The current floored dynamic memory usage of Lua, in kilobytes.
function gcinfo() end

--- GetConVar
-- @usage shared_m
-- Gets the ConVar with the specified name. This function caches the ConVar object internally.
--
-- @param  name string  Name of the ConVar to get
-- @return ConVar The ConVar object
function GetConVar( name) end

--- GetConVar_Internal
-- @usage shared_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  name string  Name of the ConVar to get
-- @return ConVar The ConVar object
function GetConVar_Internal( name) end

--- GetConVarNumber
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Store the ConVar object retrieved with GetConVar and call ConVar:GetInt or ConVar:GetFloat on it.
-- @param  name string  Name of the ConVar to get.
-- @return number The ConVar's value.
function GetConVarNumber( name) end

--- GetConVarString
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Store the ConVar object retrieved with GetConVar and call ConVar:GetString on it.
-- @param  name string  Name of the ConVar to get.
-- @return string The ConVar's value.
function GetConVarString( name) end

--- GetDefaultLoadingHTML
-- @usage menu
-- Returns the default loading screen URL (asset://garrysmod/html/loading.html)
--
-- @return string Default loading url (asset://garrysmod/html/loading.html)
function GetDefaultLoadingHTML() end

--- GetDemoFileDetails
-- @usage menu
-- Retrieves data about the demo with the specified filename. Similar to GetSaveFileDetails.
--
-- @param  filename string  The file name of the demo.
-- @return table Demo data.
function GetDemoFileDetails( filename) end

--- GetDownloadables
-- @usage menu
-- Returns a table with the names of files needed from the server you are currently joining.
--
-- @return table table of file names
function GetDownloadables() end

--- getfenv
-- @usage shared_m
-- Returns the environment table of either the stack level or the function specified.
--
-- @param  location=1 function  The object to get the enviroment from. Can also be a number that specifies the function at that stack level: Level 1 is the function calling getfenv.
-- @return table The environment.
function getfenv( location) end

--- GetGlobalAngle
-- @usage shared
-- Returns an angle that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default=Angle( 0, 0, 0 ) Angle  The value to return if the global value is not set.
function GetGlobalAngle( index,  default) end

--- GetGlobalBool
-- @usage shared
-- Returns a boolean that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default=false boolean  The value to return if the global value is not set.
function GetGlobalBool( index,  default) end

--- GetGlobalEntity
-- @usage shared
-- Returns an entity that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default=NULL Entity  The value to return if the global value is not set.
function GetGlobalEntity( index,  default) end

--- GetGlobalFloat
-- @usage shared
-- Returns a float that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default=0 number  The value to return if the global value is not set.
function GetGlobalFloat( index,  default) end

--- GetGlobalInt
-- @usage shared
-- Returns an integer that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default=0 number  The value to return if the global value is not set.
function GetGlobalInt( index,  default) end

--- GetGlobalString
-- @usage shared
-- Returns a string that is shared between the server and all clients.
--
-- @param  index string  The unique index to identify the global value with.
-- @param  default="" string  The value to return if the global value is not set.
function GetGlobalString( index,  default) end

--- GetGlobalVector
-- @usage shared
-- Returns a vector that is shared between the server and all clients.
--
-- @param  Index string  The unique index to identify the global value with.
-- @param  Default Vector  The value to return if the global value is not set.
function GetGlobalVector( Index,  Default) end

--- GetHostName
-- @usage shared
-- Returns the name of the current server.
--
function GetHostName() end

--- GetHUDPanel
-- @usage client
-- Returns the panel that is used as a wrapper for the HUD.
--
function GetHUDPanel() end

--- GetLoadPanel
-- @usage menu
-- Returns the loading screen panel and creates it if it doesn't exist.
--
-- @return Panel The loading screen panel
function GetLoadPanel() end

--- GetLoadStatus
-- @usage menu
-- Returns the current status of the server join progress.
--
-- @return string The current status
function GetLoadStatus() end

--- GetMapList
-- @usage menu
-- Returns a table with the names of all maps and categories that you have on your client.
--
-- @return table table of map names and categories
function GetMapList() end

--- getmetatable
-- @usage shared_m
-- Returns the metatable of an object. This function obeys the metatable's __metatable field, and will return that field if the metatable has it set.
--
-- @param  object any  The value to return the metatable of.
-- @return any The metatable of the value. This is not always a table.
function getmetatable( object) end

--- GetOverlayPanel
-- @usage menu
-- Returns the menu overlay panel, a container for panels like the error panel created in GM:OnLuaError.
--
-- @return Panel The overlay panel
function GetOverlayPanel() end

--- GetRenderTarget
-- @usage client
-- Creates or gets the rendertarget with the given name.
--
-- @param  name string  The internal name of the render target.
-- @param  width number  The width of the render target, must be power of 2.
-- @param  height number  The height of the render target, must be power of 2.
-- @param  additive boolean  Sets whenever the rt should be additive.
-- @return ITexture The render target
function GetRenderTarget( name,  width,  height,  additive) end

--- GetRenderTargetEx
-- @usage client
-- Creates or gets the rendertarget with the given name, this function allows to adjust the creation of a rendertarget more than GetRenderTarget
--
-- @param  name string  The internal name of the render target.
-- @param  width number  The width of the render target, must be power of 2.
-- @param  height number  The height of the render target, must be power of 2.
-- @param  sizeMode number  Bitflag that influences the sizing of the render target, see RT_SIZE_ Enums.
-- @param  depthMode number  Bitflag that determines the depth buffer usage of the render target MATERIAL_RT_DEPTH_ Enums.
-- @param  textureFlags number  Bitflag that configurates the texture, see TEXTUREFLAGS_ Enums. List of flags can also be found on the Valve's Developer Wiki:  https://developer.valvesoftware.com/wiki/Valve_Texture_Format
-- @param  rtFlags number  Flags that controll the HDR behaviour of the render target, see CREATERENDERTARGETFLAGS_ Enums.
-- @param  imageFormat number  Image format, see IMAGE_FORMAT_ Enums.
-- @return ITexture The new render target.
function GetRenderTargetEx( name,  width,  height,  sizeMode,  depthMode,  textureFlags,  rtFlags,  imageFormat) end

--- GetSaveFileDetails
-- @usage menu
-- Retrieves data about the save with the specified filename. Similar to GetDemoFileDetails.
--
-- @param  filename string  The file name of the save.
-- @return table Save data.
function GetSaveFileDetails( filename) end

--- GetViewEntity
-- @usage client
-- Returns the entity the client is using to see from (such as the player itself, the camera, or another entity).
--
-- @return Entity The view entity.
function GetViewEntity() end

--- HSVToColor
-- @usage shared_m
-- Converts a color from HSV color space into RGB color space and returns a Color structure.
--
-- @param  hue number  Hue in degrees.
-- @param  saturation number  Saturation from 0 - 1.
-- @param  value number  Value from 0 - 1.
-- @return table The Color structure created from the HSV color space.
function HSVToColor( hue,  saturation,  value) end

--- HTTP
-- @usage shared_m
-- Launches a threaded http request with the given parameters
--
-- @param  parameters table  The request parameters. See HTTPRequest structure.
-- @return boolean true if we made a request, nil if we failed.
function HTTP( parameters) end

--- include
-- @usage shared_m
-- Executes a Lua script either relative to the current file, or absolute(relative to the /lua/ folder).
--
-- @param  fileName string  The name of the script to be executed.
-- @return vararg Anything that the executed Lua script returns.
function include( fileName) end

--- IncludeCS
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--To send the target file to the client simply call AddCSLuaFile() in the target file itself.
-- @param  filename string  The filename of the Lua file you want to include.
function IncludeCS( filename) end

--- ipairs
-- @usage shared_m
-- Returns an iterator function for a for loop, to return ordered key-value pairs from a table.
--
-- @param  tab table  The table to iterate over.
-- @return function The iterator function.
-- @return table The table being iterated over
-- @return number The origin index =0
function ipairs( tab) end

--- isangle
-- @usage shared_m
-- Returns if the passed object is an Angle.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is an Angle.
function isangle( variable) end

--- isbool
-- @usage shared_m
-- Returns if the passed object is a boolean.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a boolean.
function isbool( variable) end

--- IsColor
-- @usage shared_m
-- Returns whether the given object does or doesn't have a metatable of a color.
--
-- @param  Object any  The object to be tested
-- @return boolean Whether the given object is a color or not
function IsColor( Object) end

--- IsEnemyEntityName
-- @usage shared_m
-- Returns if the given NPC class name is an enemy.
--
-- @param  className string  Class name of the entity to check
-- @return boolean Is an enemy
function IsEnemyEntityName( className) end

--- IsEntity
-- @usage shared
-- Returns if the passed object is an Entity. Alias of isentity.
--
-- @param  variable any  The variable to check.
-- @return boolean True if the variable is an Entity.
function IsEntity( variable) end

--- isentity
-- @usage shared_m
-- Returns if the passed object is an Entity.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is an Entity.
function isentity( variable) end

--- IsFirstTimePredicted
-- @usage shared
-- Returns if this is the first time this hook was predicted.
--
-- @return boolean Whether or not this is the first time being predicted.
function IsFirstTimePredicted() end

--- IsFriendEntityName
-- @usage shared_m
-- Returns if the given NPC class name is a friend.
--
-- @param  className string  Class name of the entity to check
-- @return boolean Is a friend
function IsFriendEntityName( className) end

--- isfunction
-- @usage shared_m
-- Returns if the passed object is a function.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a function.
function isfunction( variable) end

--- IsInGame
-- @usage menu
-- Returns true if the client is currently playing either a singleplayer or multiplayer game.
--
-- @return boolean True if we are in a game.
function IsInGame() end

--- ismatrix
-- @usage shared_m
-- Returns whether the passed object is a VMatrix.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a VMatrix.
function ismatrix( variable) end

--- IsMounted
-- @usage shared_m
-- Checks whether or not a game is currently mounted. Uses data given by engine.GetGames. Currently does not work correctly serverside on dedicated servers.
--
-- @param  game string  The game string/app ID to check.
-- @return boolean True if the game is mounted.
function IsMounted( game) end

--- isnumber
-- @usage shared_m
-- Returns if the passed object is a number.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a number.
function isnumber( variable) end

--- ispanel
-- @usage shared_m
-- Returns if the passed object is a Panel.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a Panel.
function ispanel( variable) end

--- isstring
-- @usage shared_m
-- Returns if the passed object is a string.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a string.
function isstring( variable) end

--- istable
-- @usage shared_m
-- Returns if the passed object is a table.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a table.
function istable( variable) end

--- IsTableOfEntitiesValid
-- @usage shared_m
-- Returns whether or not every element within a table is a valid entity
--
-- @param  table table  Table containing entities to check
-- @return boolean All entities valid
function IsTableOfEntitiesValid( table) end

--- IsUselessModel
-- @usage shared_m
-- Returns whether or not a model is useless by checking that the file path is that of a proper model.
--
-- @param  modelName string  The model name to be checked
-- @return boolean Whether or not the model is useless
function IsUselessModel( modelName) end

--- IsValid
-- @usage shared_m
-- Returns whether an object is valid or not. (Such as Entitys, Panels, custom table objects and more)Checks that an object is not nil, has an IsValid method and if this method returns true.
--
-- @param  toBeValidated any  The table or object to be validated.
-- @return boolean True if the object is valid.
function IsValid( toBeValidated) end

--- isvector
-- @usage shared_m
-- Returns if the passed object is a Vector.
--
-- @param  variable any  The variable to perform the type check for.
-- @return boolean True if the variable is a Vector.
function isvector( variable) end

--- JoinServer
-- @usage menu
-- Joins the server with the specified IP.
--
-- @param  IP string  The IP of the server to join
function JoinServer( IP) end

--- JS_Language
-- @usage client_m
-- Adds javascript function 'language.Update' to an HTML panel as a method to call Lua's language.GetPhrase function.
--
-- @param  htmlPanel Panel  Panel to add javascript function 'language.Update' to.
function JS_Language( htmlPanel) end

--- JS_Utility
-- @usage client_m
-- Adds javascript function 'util.MotionSensorAvailable' to an HTML panel as a method to call Lua's motionsensor.IsAvailable function.
--
-- @param  htmlPanel Panel  Panel to add javascript function 'util.MotionSensorAvailable' to.
function JS_Utility( htmlPanel) end

--- JS_Workshop
-- @usage client_m
-- Adds workshop related javascript functions to an HTML panel, used by the "Dupes" and "Saves" tabs in the spawnmenu.
--
-- @param  htmlPanel Panel  Panel to add javascript functions to.
function JS_Workshop( htmlPanel) end

--- Label
-- @usage client_m
-- Convenience function that creates a DLabel, sets the text, and returns it
--
-- @param  text string  The string to set the label's text to
-- @param  parent=nil Panel  Optional. The panel to parent the DLabel to
-- @return Panel The created DLabel
function Label( text,  parent) end

--- LanguageChanged
-- @usage menu
-- Callback function for when the client's language changes. Called by the engine.
--
-- @param  lang string  The new language code.
function LanguageChanged( lang) end

--- Lerp
-- @usage shared_m
-- Performs a linear interpolation from the start number to the end number.
--
-- @param  t number  The fraction for finding the result. This number is clamped between 0 and 1.
-- @param  from number  The starting number. The result will be equal to this if delta is 0.
-- @param  to number  The ending number. The result will be equal to this if delta is 1.
-- @return number The result of the linear interpolation, (1 - t) * from + t * to.
function Lerp( t,  from,  to) end

--- LerpAngle
-- @usage shared_m
-- Returns point between first and second angle using given fraction and linear interpolation
--
-- @param  ratio number  Ratio of progress through values
-- @param  angleStart Angle  Angle to begin from
-- @param  angleEnd Angle  Angle to end at
-- @return Angle angle
function LerpAngle( ratio,  angleStart,  angleEnd) end

--- LerpVector
-- @usage shared_m
-- Linear interpolation between two vectors. It is commonly used to smooth movement between two vectors.
--
-- @param  fraction number  Fraction ranging from 0 to 1
-- @param  from Vector  The initial Vector
-- @param  to Vector  The desired Vector
-- @return Vector The lerped vector.
function LerpVector( fraction,  from,  to) end

--- LoadLastMap
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function LoadLastMap() end

--- LoadPresets
-- @usage client
-- Loads all preset settings for the presets module and returns them in a table
--
-- @return table Preset data
function LoadPresets() end

--- Localize
-- @usage client_m
-- Returns a localisation for the given token, if none is found it will return the default(second) parameter.
--
-- @param  localisationToken string  The token to find a translation for.
-- @param  default string  The default value to be returned if no translation was found.
function Localize( localisationToken,  default) end

--- LocalPlayer
-- @usage client
-- Returns the player object of the current client.
--
-- @return Player The player object representing the client.
function LocalPlayer() end

--- LocalToWorld
-- @usage shared
-- Translates the specified position and angle from the specified coordinate system into worldspace coordinates
--
-- @param  localPos Vector  The position that should be translated from specified system to world coordinates
-- @param  localAng Angle  The angle that should be translated from specified system to world angles
-- @param  originPos Vector  The origin of the system to translate from
-- @param  originAngle Angle  The angles of the system to translate from
-- @return Vector World position
-- @return Angle World angles
function LocalToWorld( localPos,  localAng,  originPos,  originAngle) end

--- Material
-- @usage shared_m
-- Either returns the material with the given name, or loads the material interpreting the first argument as the path.
--
-- @param  materialName string  The material name or path. The path is relative to the materials/ folder. You do not need to add materials/ to your path.  To retrieve a Lua material created with CreateMaterial, just prepend a "!" to the material name.
-- @param  pngParameters=nil string  A string containing keywords which will be used to add material parameters.    NOTE  Only works with .png files, and only clientside.  Possible values are: vertexlitgeneric unlitgeneric nocull alphatest mips noclamp smooth  
-- @return IMaterial Generated material
-- @return number How long it took for the function to run
function Material( materialName,  pngParameters) end

--- Matrix
-- @usage shared
-- Returns a VMatrix object.
--
-- @param  data=nil table  Initial data to initialize the matrix with. Leave empty to initialize an empty matrix. See examples for usage.
-- @return VMatrix New matrix.
function Matrix( data) end

--- Mesh
-- @usage client
-- Returns a new mesh object.
--
-- @param  mat=nil IMaterial  The material the mesh is intended to be rendered with. It's merely a hint that tells that mesh what vertex format it should use.
-- @return IMesh The created object.
function Mesh( mat) end

--- Model
-- @usage shared_m
-- Runs util.PrecacheModel and returns the string
--
-- @param  model string  The model to precache
-- @return string The same string entered as an argument
function Model( model) end

--- module
-- @usage shared_m
-- Creates a table with the specified module name and sets the function environment for said table.
--
-- @param  name string  The name of the module. This will be used to access the module table in the runtime environment.
-- @param  loaders vararg  Calls each function passed with the new table as an argument.
function module( name,  loaders) end

--- Msg
-- @usage shared_m
-- Writes every given argument to the console.
--Automatically attempts to convert each argument to a string. (See tostring)
--Unlike print, arguments are not separated by anything. They are simply concatenated.
--
-- @param  args vararg  List of values to print.
function Msg( args) end

--- MsgAll
-- @usage shared
-- Works exactly like Msg except that, if called on the server, will print to all players consoles plus the server console.
--
-- @param  args vararg  List of values to print.
function MsgAll( args) end

--- MsgC
-- @usage shared_m
-- Just like Msg, except it can also print colored text, just like chat.AddText.
--
-- @param  args vararg  Values to print. If you put in a color, all text after that color will be printed in that color.
function MsgC( args) end

--- MsgN
-- @usage shared_m
-- Just like Msg, except it adds a newline ("\n") at the end.
--
-- @param  args vararg  List of values to print.
function MsgN( args) end

--- NamedColor
-- @usage client
-- Returns named color defined in resource/ClientScheme.res.
--
-- @param  name string  Name of color
-- @return table A Color structure or nil
function NamedColor( name) end

--- newproxy
-- @usage shared_m
-- Returns a new userdata object.
--
-- @param  addMetatable=false boolean  If true, the userdata will get its own metatable automatically.
-- @return userdata The newly created userdata.
function newproxy( addMetatable) end

--- next
-- @usage shared_m
-- Returns the next key and value pair in a table.
--
-- @param  tab table  The table
-- @param  prevKey=nil any  The previous key in the table.
-- @return any The next key for the table. If the previous key was nil, this will be the first key in the table. If the previous key was the last key in the table, this will be nil.
-- @return any The value associated with that key. If the previous key was the last key in the table, this will be nil.
function next( tab,  prevKey) end

--- NumDownloadables
-- @usage menu
-- Returns the number of files needed from the server you are currently joining.
--
-- @return number The number of downloadables
function NumDownloadables() end

--- NumModelSkins
-- @usage client
-- Returns the amount of skins the specified model has
--
-- @param  modelName string  Model to return amount of skins of
-- @return number Amount of skins
function NumModelSkins( modelName) end

--- OnModelLoaded
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  modelName string  Name of the model.
-- @param  numPostParams number  Number of pose parameters the model has.
-- @param  numSeq number  Number of sequences the model has.
-- @param  numAttachments number  Number of attachments the model has.
-- @param  numBoneControllers number  Number of bone controllers the model has.
-- @param  numSkins number  Number of skins that the model has.
-- @param  size number  Size of the model.
function OnModelLoaded( modelName,  numPostParams,  numSeq,  numAttachments,  numBoneControllers,  numSkins,  size) end

--- OpenFolder
-- @usage menu
-- Opens a folder with the given name in the garrysmod folder using the operating system's file browser. Currently broken on OS X and Linux.
--
-- @param  folder string  The subdirectory to open in the garrysmod folder.
function OpenFolder( folder) end

--- OrderVectors
-- @usage shared_m
-- Modifies the given vectors so that all of vector2's axis are larger than vector1's by switching them around. Also known as ordering vectors.
--
-- @param  vector1 Vector  Bounding box min resultant
-- @param  vector2 Vector  Bounding box max resultant
function OrderVectors( vector1,  vector2) end

--- pairs
-- @usage shared_m
-- Returns an iterator function(next) for a for loop that will return the values of the specified table in an arbitrary order.
--
-- @param  tab table  The table to iterate over
-- @return function The iterator (next)
-- @return table The table being iterated over
-- @return any nil (for the constructor)
function pairs( tab) end

--- Particle
-- @usage shared_m
-- Calls game.AddParticles and returns given string.
--
-- @param  file string  The particle file.
-- @return string The particle file.
function Particle( file) end

--- ParticleEffect
-- @usage shared
-- Creates a particle effect.
--
-- @param  particleName string  The name of the particle effect.
-- @param  position Vector  The start position of the effect.
-- @param  angles Angle  The orientation of the effect.
-- @param  parent=NULL Entity  If set, the particle will be parented to the entity.
function ParticleEffect( particleName,  position,  angles,  parent) end

--- ParticleEffectAttach
-- @usage shared
-- Creates a particle effect with specialized parameters.
--
-- @param  particleName string  The name of the particle effect.
-- @param  attachType number  Attachment type using PATTACH_ Enums.
-- @param  entity Entity  The entity to be used in the way specified by the attachType.
-- @param  attachmentID number  The id of the attachment to be used in the way specified by the attachType.
function ParticleEffectAttach( particleName,  attachType,  entity,  attachmentID) end

--- ParticleEmitter
-- @usage client
-- Creates a new CLuaEmitter.
--
-- @param  position Vector  The start position of the emitter.  This is only used to determine particle drawing order for translucent particles.
-- @param  use3D boolean  Whenever to render the particles in 2D or 3D mode.
-- @return CLuaEmitter The new particle emitter.
function ParticleEmitter( position,  use3D) end

--- Path
-- @usage server
-- Creates a path for the bot to follow
--
-- @param  type string  The name of the path to create.  This is going to be "Follow" or "Chase" right now.
-- @return PathFollower The path
function Path( type) end

--- pcall
-- @usage shared_m
-- Calls a function and catches an error that can be thrown while the execution of the call.
--
-- @param  func function  Function to be executed and of which the errors should be caught of
-- @param  arguments vararg  Arguments to call the function with.
-- @return boolean If the function had no errors occur within it.
-- @return vararg If an error occurred, this will be a string containing the error message. Otherwise, this will be the return values of the function passed in.
function pcall( func,  arguments) end

--- Player
-- @usage shared
-- Returns the player with the matching Player:UserID.
--
-- @param  playerIndex number  The player index.
-- @return Player The retrieved player.
function Player( playerIndex) end

--- PositionSpawnIcon
-- @usage client
-- Moves the given model to the given position and returns view information based on its properties
--
-- @param  model Entity  Model that is being rendered to the spawn icon
-- @param  position Vector  Position that the model is being rendered at
-- @return table Table of information of the view which can be used for rendering
function PositionSpawnIcon( model,  position) end

--- PrecacheParticleSystem
-- @usage shared
-- Precaches the particle with the specified name.
--
-- @param  particleSystemName string  The name of the particle system.
function PrecacheParticleSystem( particleSystemName) end

--- PrecacheScene
-- @usage server
-- Precaches a scene file.
--
-- @param  scene string  Path to the scene file to precache.
function PrecacheScene( scene) end

--- PrecacheSentenceFile
-- @usage server
-- Load and precache a custom sentence file.
--
-- @param  filename string  The path to the custom sentences.txt.
function PrecacheSentenceFile( filename) end

--- PrecacheSentenceGroup
-- @usage server
-- Precache a sentence group in a sentences.txt definition file.
--
-- @param  group string  The group to precache.
function PrecacheSentenceGroup( group) end

--- print
-- @usage shared_m
-- Writes every given argument to the console.
--Automatically attempts to convert each argument to a string. (See tostring)
--Separates arguments with a tab character ("\t").
--
-- @param  args vararg  List of values to print.
function print( args) end

--- PrintMessage
-- @usage server
-- Displays a message in the chat, console, or center of screen of every player.
--
-- @param  type number  Which type of message should be sent to the players (see HUD_ Enums)
-- @param  message string  Message to be sent to the players
function PrintMessage( type,  message) end

--- PrintTable
-- @usage shared_m
-- Recursively prints the contents of a table to the console.
--
-- @param  tableToPrint table  The table to be printed
-- @param  indent=0 number  Number of tabs to start indenting at. Increases by 2 when entering another table.
-- @param  done={} table  Internal argument, you shouldn't normally change this. Used to check if a nested table has already been printed so it doesn't get caught in a loop.
function PrintTable( tableToPrint,  indent,  done) end

--- ProjectedTexture
-- @usage client
-- Creates a new ProjectedTexture.
--
-- @return ProjectedTexture Newly created projected texture.
function ProjectedTexture() end

--- ProtectedCall
-- @usage shared
-- Runs a function without stopping the whole script on error.
--
-- @param  func function  Function to run
-- @return boolean Were there any errors or not
function ProtectedCall( func) end

--- RandomPairs
-- @usage shared_m
-- Returns an iterator function that can be used to loop through a table in random order
--
-- @param  table table  Table to create iterator for
-- @param  descending boolean  Whether the iterator should iterate descending or not
-- @return function Iterator function
function RandomPairs( table,  descending) end

--- rawequal
-- @usage shared_m
-- Compares the two values without calling their __eq operator.
--
-- @param  value1 any  The first value to compare.
-- @param  value2 any  The second value to compare.
-- @return boolean Whether or not the two values are equal.
function rawequal( value1,  value2) end

--- rawget
-- @usage shared_m
-- Gets the value with the specified key from the table without calling the __index method.
--
-- @param  table table  Table to get the value from.
-- @param  index any  The index to get the value from.
-- @return any The value.
function rawget( table,  index) end

--- rawset
-- @usage shared_m
-- Sets the value with the specified key from the table without calling the __newindex method.
--
-- @param  table table  Table to get the value from.
-- @param  index any  The index to get the value from.
-- @param  value any  The value to set for the specified key.
function rawset( table,  index,  value) end

--- RealFrameTime
-- @usage client
-- Returns the real frame-time which is unaffected by host_timescale. To be used for GUI effects (for example)
--
-- @return number Real frame time
function RealFrameTime() end

--- RealTime
-- @usage shared
-- Returns the uptime of the game/server in seconds (to at least 4 decimal places)
--
function RealTime() end

--- RecipientFilter
-- @usage server
-- Creates a new CRecipientFilter.
--
-- @return CRecipientFilter The new created recipient filter.
function RecipientFilter() end

--- RecordDemoFrame
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function RecordDemoFrame() end

--- RegisterDermaMenuForClose
-- @usage client_m
-- Registers a Derma element to be closed the next time CloseDermaMenus is called
--
-- @param  menu Panel  Menu to be registered for closure
function RegisterDermaMenuForClose( menu) end

--- RememberCursorPosition
-- @usage client_m
-- Saves position of your cursor on screen. You can restore it by using RestoreCursorPosition.
--
function RememberCursorPosition() end

--- RemoveTooltip
-- @usage client_m
-- Does the removing of the tooltip panel. Called by EndTooltip.
--
function RemoveTooltip() end

--- RenderAngles
-- @usage client
-- Returns the angle that the clients view is being rendered at
--
-- @return Angle Render Angles
function RenderAngles() end

--- RenderDoF
-- @usage client
-- Renders a Depth of Field effect
--
-- @param  origin Vector  Origin to render the effect at
-- @param  angle Angle  Angle to render the effect at
-- @param  usableFocusPoint Vector  Point to focus the effect at
-- @param  angleSize number  Angle size of the effect
-- @param  radialSteps number  Amount of radial steps to render the effect with
-- @param  passes number  Amount of render passes
-- @param  spin boolean  Whether to cycle the frame or not
-- @param  inView table  Table of view data
-- @param  fov number  FOV to render the effect with
function RenderDoF( origin,  angle,  usableFocusPoint,  angleSize,  radialSteps,  passes,  spin,  inView,  fov) end

--- RenderStereoscopy
-- @usage client
-- Renders the stereoscopic post-process effect
--
-- @param  viewOrigin Vector  Origin to render the effect at
-- @param  viewAngles Angle  Angles to render the effect at
function RenderStereoscopy( viewOrigin,  viewAngles) end

--- RenderSuperDoF
-- @usage client
-- Renders the Super Depth of Field post-process effect
--
-- @param  viewOrigin Vector  Origin to render the effect at
-- @param  viewAngles Angle  Angles to render the effect at
-- @param  viewFOV number  Field of View to render the effect at
function RenderSuperDoF( viewOrigin,  viewAngles,  viewFOV) end

--- require
-- @usage shared_m
-- First tries to load a binary module with the given name, if unsuccessful, it tries to load a Lua module with the given name.
--
-- @param  name string  The name of the module to be loaded.
function require( name) end

--- RestoreCursorPosition
-- @usage client_m
-- Restores position of your cursor on screen. You can save it by using RememberCursorPosition.
--
function RestoreCursorPosition() end

--- RunConsoleCommand
-- @usage shared_m
-- Executes the given console command with the parameters.
--
-- @param  command string  The command to be executed.
-- @param  arguments vararg  The arguments. Note, that unlike Player:ConCommand, you must pass each argument as a new string, not separating them with a space.
function RunConsoleCommand( command,  arguments) end

--- RunGameUICommand
-- @usage menu
-- Runs a menu command. Equivalent to RunConsoleCommand( "gamemenucommand", command ) unless the command starts with the "engine" keyword in which case it is equivalent to RunConsoleCommand( command ).
--
-- @param  command string  The menu command to run Should be one of the following:   Disconnect - Disconnects from the current server.  OpenBenchmarkDialog - Opens the "Video Hardware Stress Test" dialog.  OpenChangeGameDialog - Does not work in GMod.  OpenCreateMultiplayerGameDialog - Opens the Source dialog for creating a listen server.  OpenCustomMapsDialog - Does nothing.  OpenFriendsDialog - Does nothing.  OpenGameMenu - Does not work in GMod.  OpenLoadCommentaryDialog - Opens the "Developer Commentary" selection dialog. Useless in GMod.  OpenLoadDemoDialog - Does nothing.  OpenLoadGameDialog - Opens the Source "Load Game" dialog.  OpenNewGameDialog - Opens the "New Game" dialog. Useless in GMod.  OpenOptionsDialog - Opens the options dialog.  OpenPlayerListDialog - Opens the "Mute Players" dialog that shows all players connected to the server and allows to mute them.  OpenSaveGameDialog - Opens the Source "Save Game" dialog.  OpenServerBrowser - Opens the legacy server browser.  Quit - Quits the game without confirmation (unlike other Source games).  QuitNoConfirm - Quits the game without confirmation (like other Source games).  ResumeGame - Closes the menu and returns to the game.  engine <concommand> - Runs a console command. Equivalent to RunConsoleCommand( <concommand> ).
function RunGameUICommand( command) end

--- RunString
-- @usage shared_m
-- Evaluates and executes the given code, will throw an error on failure.
--
-- @param  code string  The code to execute.
-- @param  identifier="RunString" string  The name that should appear in any error messages caused by this code.
-- @param  handleError=true boolean  If false, this function will return a string containing any error messages instead of throwing an error.
-- @return string If handleError is false, the error message (if any).
function RunString( code,  identifier,  handleError) end

--- RunStringEx
-- @usage shared_m
-- Alias of RunString.
--
function RunStringEx() end

--- SafeRemoveEntity
-- @usage shared_m
-- Removes the given entity unless it is a player or the world entity
--
-- @param  ent Entity  Entity to safely remove.
function SafeRemoveEntity( ent) end

--- SafeRemoveEntityDelayed
-- @usage shared_m
-- Removes entity after delay using SafeRemoveEntity
--
-- @param  entity Entity  Entity to be removed
-- @param  delay number  Delay for entity removal in seconds
function SafeRemoveEntityDelayed( entity,  delay) end

--- SaveLastMap
-- @usage menu
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  map string  The name of the map.
-- @param  category string  The name of the category to which this map belongs.
function SaveLastMap( map,  category) end

--- SavePresets
-- @usage client
-- Overwrites all presets with the supplied table. Used by the presets module for preset saving
--
-- @param  presets table  Presets to be saved
function SavePresets( presets) end

--- ScreenScale
-- @usage client
-- Returns a number based on the Size argument and your screen's width. The screen's width is always equal to size 640. This function is primarily used for scaling font sizes.
--
-- @param  Size number  The number you want to scale.
function ScreenScale( Size) end

--- ScrH
-- @usage client_m
-- Returns the height of GMod's window (in pixels).
--
-- @return number The height of GMod's window in pixels
function ScrH() end

--- ScrW
-- @usage client_m
-- Gets the width of GMod window (in pixels).
--
-- @return number The width of GMods window in pixels
function ScrW() end

--- select
-- @usage shared_m
-- Used to select single values from a vararg or get the count of values in it.
--
-- @param  parameter any  Can be a number or string.   If it's a string and starts with "#", the function will return the amount of values in the vararg (ignoring the rest of the string).  If it's a positive number, the function will return all values starting from the given index.  If the number is negative, it will return the amount specified from the end instead of the beginning.
-- @param  vararg vararg  The vararg. These are the values from which you want to select.
-- @return any Returns a number or vararg, depending on the select method.
function select( parameter,  vararg) end

--- SendUserMessage
-- @usage shared
-- Send a usermessage
--
-- @param  name string  The name of the usermessage
-- @param  recipients any  Can be a CRecipientFilter, table or Player object.
-- @param  args vararg  Data to send in the usermessage
function SendUserMessage( name,  recipients,  args) end

--- ServerLog
-- @usage server
-- Prints "ServerLog: PARAM" without a newline, to the server log and console.
--
-- @param  parameter string  The value to be printed to console.
function ServerLog( parameter) end

--- SetClipboardText
-- @usage client_m
-- Adds the given string to the computers clipboard, which can then be pasted in or outside of GMod with Ctrl + V.
--
-- @param  text string  The text to add to the clipboard.
function SetClipboardText( text) end

--- setfenv
-- @usage shared_m
-- Sets the enviroment for a function or a stack level, if a function is passed, the return value will be the function, otherwise nil.
--
-- @param  location function  The function to set the enviroment for or a number representing stack level.
-- @param  enviroment table  Table to be used as enviroment.
function setfenv( location,  enviroment) end

--- SetGlobalAngle
-- @usage shared
-- Defines an angle to be automatically networked to clients
--
-- @param  index any  Index to identify the global angle with
-- @param  angle Angle  Angle to be networked
function SetGlobalAngle( index,  angle) end

--- SetGlobalBool
-- @usage shared
-- Defined a boolean to be automatically networked to clients
--
-- @param  index any  Index to identify the global boolean with
-- @param  bool boolean  Boolean to be networked
function SetGlobalBool( index,  bool) end

--- SetGlobalEntity
-- @usage shared
-- Defines an entity to be automatically networked to clients
--
-- @param  index any  Index to identify the global entity with
-- @param  ent Entity  Entity to be networked
function SetGlobalEntity( index,  ent) end

--- SetGlobalFloat
-- @usage shared
-- Defines a floating point number to be automatically networked to clients
--
-- @param  index any  Index to identify the global float with
-- @param  float number  Float to be networked
function SetGlobalFloat( index,  float) end

--- SetGlobalInt
-- @usage shared
-- Sets an integer that is shared between the server and all clients.
--
-- @param  Index string  The unique index to identify the global value with.
-- @param  Value number  The value to set the global value to
function SetGlobalInt( Index,  Value) end

--- SetGlobalString
-- @usage shared
-- Defines a string with a maximum of 199 characters to be automatically networked to clients
--
-- @param  index any  Index to identify the global string with
-- @param  string string  String to be networked
function SetGlobalString( index,  string) end

--- SetGlobalVector
-- @usage shared
-- Defines a vector to be automatically networked to clients
--
-- @param  index any  Index to identify the global vector with
-- @param  vec Vector  Vector to be networked
function SetGlobalVector( index,  vec) end

--- setmetatable
-- @usage shared_m
-- Sets, changes or removes a table's metatable. Returns Tab (the first argument).
--
-- @param  Tab table  The table who's metatable to change.
-- @param  Metatable table  The metatable to assign.If it's nil, the metatable will be removed.
-- @return table The first argument.
function setmetatable( Tab,  Metatable) end

--- SetPhysConstraintSystem
-- @usage shared
-- Called by the engine to set which constraint system [1] the next created constraints should use
--
-- @param  constraintSystem Entity  Constraint system to use
function SetPhysConstraintSystem( constraintSystem) end

--- SortedPairs
-- @usage shared_m
-- This function can be used in a for loop instead of pairs. It sorts all keys alphabetically.
--
-- @param  table table  The table to sort
-- @param  desc=false boolean  Reverse the sorting order
-- @return function Iterator function
-- @return table The table being iterated over
function SortedPairs( table,  desc) end

--- SortedPairsByMemberValue
-- @usage shared_m
-- Returns an iterator function that can be used to loop through a table in order of member values, when the values of the table are also tables and contain that member.
--
-- @param  table table  Table to create iterator for.
-- @param  memberKey any  Key of the value member to sort by.
-- @param  descending=false boolean  Whether the iterator should iterate in descending order or not.
-- @return function Iterator function
-- @return table The table the iterator was created for.
function SortedPairsByMemberValue( table,  memberKey,  descending) end

--- SortedPairsByValue
-- @usage shared_m
-- Returns an iterator function that can be used to loop through a table in order of its values.
--
-- @param  table table  Table to create iterator for
-- @param  descending=false boolean  Whether the iterator should iterate in descending order or not
-- @return function Iterator function
-- @return table 
function SortedPairsByValue( table,  descending) end

--- Sound
-- @usage shared_m
-- Runs util.PrecacheSound and returns the string
--
-- @param  soundPath string  The soundpath to precache
-- @return string The string passed as the first argument
function Sound( soundPath) end

--- SoundDuration
-- @usage shared
-- Returns the duration of the sound specified in seconds.
--
-- @param  soundName string  The sound name.
-- @return number Sound duration in seconds.
function SoundDuration( soundName) end

--- SQLStr
-- @usage shared_m
-- Returns the input value in an escaped form so that it can safely be used inside of queries. The returned value is surrounded by quotes unless noQuotes is true. Alias of sql.SQLStr
--
-- @param  input string  String to be escaped
-- @param  noQuotes=false boolean  Whether the returned value should be surrounded in quotes or not
-- @return string Escaped input
function SQLStr( input,  noQuotes) end

--- SScale
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using ScreenScale instead.
-- @param  Size number  The number you want to scale.
function SScale( Size) end

--- STNDRD
-- @usage shared_m
-- Returns the ordinal suffix of a given number.
--
-- @param  number number  The number to find the ordinal suffix of.
-- @return string suffix
function STNDRD( number) end

--- SuppressHostEvents
-- @usage server
-- Suppress any networking from the server to the specified player. This is automatically called by the engine before/after a player fires their weapon, reloads, or causes any other similar shared-predicted event to occur.
--
-- @param  suppressPlayer Player  The player to suppress any networking to.
function SuppressHostEvents( suppressPlayer) end

--- SysTime
-- @usage shared_m
-- Returns a highly accurate time since the start up, ideal for benchmarking.
--
function SysTime() end

--- TauntCamera
-- @usage shared
-- Returns a TauntCamera object
--
-- @return table TauntCamera
function TauntCamera() end

--- TextEntryLoseFocus
-- @usage client_m
-- Clears focus from any text entries player may have focused.
--
function TextEntryLoseFocus() end

--- TimedCos
-- @usage shared_m
-- Returns a cosine value that fluctuates based on the current time
--
-- @param  frequency number  The frequency of fluctuation
-- @param  min number  Minimum value
-- @param  max number  Maxmimum value
-- @param  offset number  Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
-- @return number Cosine value
function TimedCos( frequency,  min,  max,  offset) end

--- TimedSin
-- @usage shared_m
-- Returns a sine value that fluctuates based on CurTime. The value returned will be between the start value plus/minus the range value.
--
-- @param  frequency number  The frequency of fluctuation, in hertz
-- @param  origin number  The center value of the sine wave.
-- @param  max number  This argument's distance from origin defines the size of the full range of the sine wave. For example, if origin is 3 and max is 5, then the full range of the sine wave is 5-3 = 2. 3 is the center point of the sine wave, so the sine wave will range between 2 and 4.
-- @param  offset number  Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
-- @return number Sine value
function TimedSin( frequency,  origin,  max,  offset) end

--- tobool
-- @usage shared_m
-- Attempts to return an appropriate boolean for the given value
--
-- @param  val any  The object to be converted to a boolean
-- @return boolean false for the boolean false.false for "false".false for "0".false for numeric 0.false for nil.true otherwise.
function tobool( val) end

--- ToggleFavourite
-- @usage menu
-- Toggles whether or not the named map is favorited in the new game list.
--
-- @param  map string  Map to toggle favorite.
function ToggleFavourite( map) end

--- tonumber
-- @usage shared_m
-- Attempts to convert the value to a number.
--
-- @param  value any  The value to convert. Can be a number or string.
-- @param  base=10 number  The numeric base used in the string. Can be any integer between 2 and 36, inclusive.
-- @return number The numeric representation of the value with the given base, or nil if the conversion failed.
function tonumber( value,  base) end

--- tostring
-- @usage shared_m
-- Attempts to convert the value to a string. If the value is an object and its metatable has defined the __tostring metamethod, this will call that function.
--
-- @param  value any  The object to be converted to a string.
-- @return string The string representation of the value.
function tostring( value) end

--- TranslateDownloadableName
-- @usage menu
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  filename string 
-- @return string Translated filename
function TranslateDownloadableName( filename) end

--- type
-- @usage shared_m
-- Returns a string representing the name of the type of the passed object.
--
-- @param  var any  The object to get the type of.
-- @return string The name of the object's type.
function type( var) end

--- TypeID
-- @usage shared
-- Gets the associated type ID of the variable.
--
-- @param  variable any  The variable to get the type ID of.
-- @return number The type ID of the variable. See the TYPE_ Enums.
function TypeID( variable) end

--- unpack
-- @usage shared_m
-- This function takes a numeric indexed table and return all the members as a vararg. If specified, it will start at the given index and end at end index.
--
-- @param  tbl table  The table to generate the vararg from.
-- @param  startIndex=1 number  Which index to start from. Optional.
-- @param  endIndex=#tbl number  Which index to end at. Optional, even if you set StartIndex.
-- @return vararg Output values
function unpack( tbl,  startIndex,  endIndex) end

--- UnPredictedCurTime
-- @usage shared_m
-- Returns the current asynchronous in-game time.
--
function UnPredictedCurTime() end

--- UpdateLoadPanel
-- @usage menu
-- Runs JavaScript on the loading screen panel (GetLoadPanel).
--
-- @param  javascript string  JavaScript to run on the loading panel.
function UpdateLoadPanel( javascript) end

--- UpdateRenderTarget
-- @usage server
-- Renders the rt material with the current angles and position of the given entity.
--
-- @param  ent Entity  Given entity
function UpdateRenderTarget( ent) end

--- UTIL_IsUselessModel
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use IsUselessModel instead.
-- @param  modelName string  The model name to be checked
-- @return boolean Whether or not the model is useless
function UTIL_IsUselessModel( modelName) end

--- ValidPanel
-- @usage client_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use IsValid instead
-- @param  panel Panel  The panel to validate.
function ValidPanel( panel) end

--- Vector
-- @usage shared_m
-- Creates a Vector object.
--
-- @param  x=0 number  The x component of the vector. If this is a Vector, this function will return a copy of the given vector. If this is a string, this function will try to parse the string as a vector. If it fails, it returns a 0 vector.  (See examples)
-- @param  y=0 number  The y component of the vector.
-- @param  z=0 number  The z component of the vector.
-- @return Vector The created vector object.
function Vector( x,  y,  z) end

--- VectorRand
-- @usage shared_m
-- Returns a random vector whose components are each between -1 and 1
--
-- @return Vector The random direction vector
function VectorRand() end

--- VGUIFrameTime
-- @usage client_m
-- Returns the time in seconds it took to render the VGUI.
--
function VGUIFrameTime() end

--- VGUIRect
-- @usage client
-- Returns a DShape Derma element with the given dimensions
--
-- @param  x number  X position of the created element
-- @param  y number  Y position of the created element
-- @param  w number  Width of the created element
-- @param  h number  Height of the created element
-- @return Panel DShape Derma element
function VGUIRect( x,  y,  w,  h) end

--- VisualizeLayout
-- @usage client_m
-- Briefly displays layout details of the given panel on-screen
--
-- @param  panel Panel  Panel to display layout details of
function VisualizeLayout( panel) end

--- WorkshopFileBase
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  namespace string  Namespace for the file base
-- @param  requiredTags table  Tags required for a Workshop submission to be interacted with by the filebase
-- @return table WorkshopFileBase element
function WorkshopFileBase( namespace,  requiredTags) end

--- WorldToLocal
-- @usage shared
-- Translates the specified position and angle into the specified coordinate system.
--
-- @param  position Vector  The position that should be translated from the current to the new system.
-- @param  angle Angle  The angles that should be translated from the current to the new system.
-- @param  newSystemOrigin Vector  The origin of the system to translate to.
-- @param  newSystemAngles Angle  The angles of the system to translate to.
-- @return Vector Local position
-- @return Angle Local angles
function WorldToLocal( position,  angle,  newSystemOrigin,  newSystemAngles) end

--- xpcall
-- @usage shared_m
-- Attempts to call the first function. If the execution succeeds, this returns true followed by the returns of the function. If execution fails, this returns false and the second function is called with the error message.
--
-- @param  func function  The function to call initially.
-- @param  errorCallback function  The function to be called if execution of the first fails; the error message is passed as a string.  You cannot throw an error() from this callback: it will have no effect (not even stopping the callback).
-- @param  arguments vararg  Arguments to pass to the initial function.
-- @return boolean Status of the execution; true for success, false for failure.
-- @return vararg The returns of the first function if execution succeeded, otherwise the first return value of the error callback.
function xpcall( func,  errorCallback,  arguments) end
