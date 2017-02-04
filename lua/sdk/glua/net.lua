---
-- @description Library net
 module("net")

--- net.Broadcast
-- @usage server
-- Sends the currently built net message to all connected players.
--More information can be found in Net Library Usage.
--
function Broadcast() end

--- net.BytesWritten
-- @usage shared
-- Returns the size of the current message in bytes.
--
-- @return number bytes
function BytesWritten() end

--- net.Incoming
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--You may be looking for net.Receive.
-- @param  length number  The message length, in bits.
-- @param  client Player  The player that sent the message. This will be nil in the client state.
function Incoming( length,  client) end

--- net.ReadAngle
-- @usage shared
-- Reads an angle from the received net message.
--
-- @return Angle The read angle, or Angle(0,0,0) if no angle could be read
function ReadAngle() end

--- net.ReadBit
-- @usage shared
-- Reads a bit from the received net message.
--
-- @return number 0 or 1, or 0 if the bit could not be read.
function ReadBit() end

--- net.ReadBool
-- @usage shared
-- Reads a boolean from the received net message.
--
-- @return boolean true or false, or false if the bool could not be read.
function ReadBool() end

--- net.ReadColor
-- @usage shared
-- Reads a Color structure from the current net message.
--
-- @return table The Color structure read from the current net message, or Color(0,0,0,0) if the color could not be read.
function ReadColor() end

--- net.ReadData
-- @usage shared
-- Reads pure binary data from the message.
--
-- @param  length number  The length of the data to be read, in bytes.
-- @return string The binary data read, or a string containing one character with a byte of 0 if no data could be read.
function ReadData( length) end

--- net.ReadDouble
-- @usage shared
-- Reads a double-precision number from the received net message.
--
-- @return number The double-precision number, or 0 if no number could be read.
function ReadDouble() end

--- net.ReadEntity
-- @usage shared
-- Reads an entity from the received net message. You should always check if the specified entity exists as it may have been removed and therefor NULL if it is outside of the players PVS or was already removed.
--
-- @return Entity The entity, or Entity(0) if no entity could be read.
function ReadEntity() end

--- net.ReadFloat
-- @usage shared
-- Reads a floating point number from the received net message.
--
-- @return number The floating point number, or 0 if no number could be read.
function ReadFloat() end

--- net.ReadHeader
-- @usage shared
-- Returns the "header" of the message which contains a short which can be converted to the corresponding message name via util.NetworkIDToString.
--
-- @return number The header number
function ReadHeader() end

--- net.ReadInt
-- @usage shared
-- Reads an integer from the received net message.
--
-- @param  bitCount number  The amount of bits to be read.  This must be set to what you set to net.WriteInt. Read more information at net.WriteInt.
-- @return number The read integer number, or 0 if no integer could be read.
function ReadInt( bitCount) end

--- net.ReadMatrix
-- @usage shared
-- Reads a VMatrix from the received net message.
--
-- @return VMatrix The matrix, or an empty matrix if no matrix could be read.
function ReadMatrix() end

--- net.ReadNormal
-- @usage shared
-- Reads a normal vector from the net message.
--
-- @return Vector The normalized vector ( length = 1 ), or Vector(0,0,1) if no normal could be read.
function ReadNormal() end

--- net.ReadString
-- @usage shared
-- Reads a null terminated string from the net stream. The size of the string is 8 bits plus 8 bits for every ASCII character in the string.
--
-- @return string The read string, or a string with 0 length if no string could be read.
function ReadString() end

--- net.ReadTable
-- @usage shared
-- Reads a table from the received net message.
--
-- @return table Table recieved via the net message, or a blank table if no table could be read.
function ReadTable() end

--- net.ReadType
-- @usage shared
-- Reads a value from the net message with the specified type.
--
-- @param  typeID=net.ReadUInt(8) number  The type of value to be read, using TYPE_ Enums.
-- @return any The value, or the respective blank value based on the type you're reading if the value could not be read.
function ReadType( typeID) end

--- net.ReadUInt
-- @usage shared
-- Reads an unsigned integer with the specified number of bits from the received net message.
--
-- @param  numberOfBits number  The size of the integer to be read, in bits.
-- @return number The unsigned integer read, or 0 if the integer could not be read.
function ReadUInt( numberOfBits) end

--- net.ReadVector
-- @usage shared
-- Reads a vector from the received net message. Vectors sent by this function are compressed, which may result in precision loss. See net.WriteVector for more information.
--
-- @return Vector The read vector, or Vector(0,0,0) if no vector could be read.
function ReadVector() end

--- net.Receive
-- @usage shared
-- Adds a net message handler. Only one receiver can be used to receive the net message.
--
-- @param  messageName string  The message name to hook to.
-- @param  callback function  The function to be called if the specified message was received. Arguments are: number len - Length of the message, in bits  Player ply - The player that sent the message, works only serverside
function Receive( messageName,  callback) end

--- net.Send
-- @usage server
-- Sends the current message to the specified player, or to all players listed in the table.
--
-- @param  ply Player  The player(s) to send the message to. Can be a table of players or a CRecipientFilter.
function Send( ply) end

--- net.SendOmit
-- @usage server
-- Sends the current message to all except the specified, or to all except all players in the table.
--
-- @param  ply Player  The player(s) to NOT send the message to. Can be a table of players
function SendOmit( ply) end

--- net.SendPAS
-- @usage server
-- Sends the message to all players that are in the same potentially audible set(PAS) as the position, or simply said, it adds all players that can potentially hear sounds from this position.
--
-- @param  position Vector  PAS position.
function SendPAS( position) end

--- net.SendPVS
-- @usage server
-- Sends the message to all players the position is in the PVS of or, more simply said, sends the message to players that can potentially see this position.
--
-- @param  position Vector  Position that must be in players' visibility set.
function SendPVS( position) end

--- net.SendToServer
-- @usage client
-- Sends the current message to the server.
--
function SendToServer() end

--- net.Start
-- @usage shared
-- Begins a new net message.
--
-- @param  messageName string  The name of the message to send
-- @param  unreliable=false boolean  If set to true, the message is not guaranteed to reach its destination
-- @return boolean True if the message has been started.
function Start( messageName,  unreliable) end

--- net.WriteAngle
-- @usage shared
-- Writes an angle to the current net message.
--
-- @param  angle Angle  The angle to be sent.
function WriteAngle( angle) end

--- net.WriteBit
-- @usage shared
-- Appends a boolean (as 1 or 0) to the current net message.
--
-- @param  boolean boolean  Bit status (false = 0, true = 1)
function WriteBit( boolean) end

--- net.WriteBool
-- @usage shared
-- Appends a boolean to the current net message. Alias of net.WriteBit
--
-- @param  boolean boolean  Boolean value to write
function WriteBool( boolean) end

--- net.WriteColor
-- @usage shared
-- Appends a Color structure to the current net message.
--
-- @param  Color table  The Color structure you want to append to the net message.
function WriteColor( Color) end

--- net.WriteData
-- @usage shared
-- Writes a chunk of binary data to the message.
--
-- @param  binaryData string  The binary data to be sent.
-- @param  length number  The length of the binary data to be sent, in bytes.
function WriteData( binaryData,  length) end

--- net.WriteDouble
-- @usage shared
-- Appends a double-precision number to the current net message.
--
-- @param  double number  The double to be sent
function WriteDouble( double) end

--- net.WriteEntity
-- @usage shared
-- Appends an entity to the current net message.
--
-- @param  entity Entity  The entity to be sent.
function WriteEntity( entity) end

--- net.WriteFloat
-- @usage shared
-- Appends a float (number with decimals) to the current net message.
--
-- @param  float number  The float to be sent.
function WriteFloat( float) end

--- net.WriteInt
-- @usage shared
-- Appends an integer (number without decimals) to the current net message.
--
-- @param  integer number  The integer to be sent.
-- @param  bitCount number  The amount of bits the number consists of. (signed) This must be 32 or less. If you are unsure what to set, just set it to 32. To determine just how many bits exactly you're going to need for your integer, you first need to understand what those bits actually are. A bit can have two possible states: 0 and 1. For every bit you add, you get an exponentially increasing amount of possible combinations. 2 bits allow for 2^2 = 4 possible combinations (namely 00, 01, 10 and 11), 3 bits allow for 2^3 = 8 possible combinations, 4 bits allow for 2^4 = 16 possible combinations and so on. Since we start counting from 0, a 4-bit integer would thus be able to represent any integer number between 0 and 15. Do note that Garry's Mod is using the first bit for purposes other than storing your integer's value. Just figure out how many bits you'd normally need, then increase that number by one (so if you want to send an integer that may assume any number between 0 and 15, you don't use a 4 as your bitCount but rather a 5).  Consult this table for a quick reference on how many bits you need for a given value.
function WriteInt( integer,  bitCount) end

--- net.WriteMatrix
-- @usage shared
-- Writes a VMatrix to the current net message.
--
-- @param  matrix VMatrix  The matrix to be sent.
function WriteMatrix( matrix) end

--- net.WriteNormal
-- @usage shared
-- Writes a normalized/direction vector ( Vector with length of 1 ) to the net message.
--
-- @param  normal Vector  The normalized/direction vector to be send.
function WriteNormal( normal) end

--- net.WriteString
-- @usage shared
-- Appends a string to the current net message. The size of the string is 8 bits plus 8 bits for every ASCII character in the string. The maximum allowed length of a single written string is 65533 characters.
--
-- @param  string string  The string to be sent.
function WriteString( string) end

--- net.WriteTable
-- @usage shared
-- Appends a table to the current net message.
--
-- @param  table table  The table to be sent.
function WriteTable( table) end

--- net.WriteType
-- @usage shared
-- Appends any type of value to the current net message.
--
-- @param  Data any  The data to be sent. A UInt(8) indicating the type will automatically be written to the packet before the value, in order to facilitate reading with net.ReadType.
function WriteType( Data) end

--- net.WriteUInt
-- @usage shared
-- Appends an unsigned integer with the specified number of bits to the current net message.
--
-- @param  unsignedInteger number  The unsigned integer to be sent.
-- @param  numberOfBits number  The size of the integer to be sent, in bits. Acceptable values range from any number 1 to 32 inclusive. For reference, 1 = bit, 4 = nibble, 8 = byte, 16 = short, 32 = long.
function WriteUInt( unsignedInteger,  numberOfBits) end

--- net.WriteVector
-- @usage shared
-- Appends a vector to the current net message.
--Vectors sent by this function are compressed, which may result in precision loss. XYZ components greater than 16384 or less than -16384 are irrecoverably altered (most significant bits are trimmed) and precision after the decimal point is low.
--
-- @param  vector Vector  The vector to be sent.
function WriteVector( vector) end
