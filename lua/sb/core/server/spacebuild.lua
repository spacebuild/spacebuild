
local timer = timer
local core = sb.core;

local time = 0;
local function sendData()
    time = CurTime();
    for _, ply in pairs(player.GetAll()) do
        if not ply.lastrdupdate or ply.lastupdate + 1 < time then
            for k, v in pairs(core.resource_tables) do
                v:send(ply.lastrdupdate, ply)
                PrintTable(v);
            end
        end
    end
end
timer.Simple(1, function() sendData() end)