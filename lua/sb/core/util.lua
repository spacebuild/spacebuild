

local util = sb.core.util;

util.SCOPES = {
    SERVER = "server/",
    CLIENT = "client/",
    SHARED = ""
}

util.createReadOnlyTable = function(t)
    return setmetatable({},{
        __index = t,
        __newindex = function (t,k,v)
            print("Attempt to update a read-only table")
        end,
        __metatable = false
    })
end

util.mergeTable = function(base,ext)

        for k,v in pairs(base) do
            if ext[k] == nil then
                ext[k] = v
            end
        end
        return ext

end
