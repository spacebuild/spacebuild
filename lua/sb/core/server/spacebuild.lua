
local timer = timer
local core = sb.core;

local time = 0;
local function sendData()
    time = CurTime();
    for _, ply in pairs(player.GetAll()) do
        if not ply.lastrdupdate or ply.lastrdupdate + 1 < time then
            for k, v in pairs(core.resource_tables) do
                v:send(ply.lastrdupdate or 0, ply)
                PrintTable(v);
            end
            ply.lastrdupdate = time
        end
    end
end
hook.Add( "Think", "some_unique_name", sendData )