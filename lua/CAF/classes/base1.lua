CAF.class.extend("base")

function CLASS:__construct(arg1, arg2, arg3, arg4) --Constructor
    self.parent:__construct(data)
    Msg("In Base1 Class Constructor: " .. tostring(self.type) .. "\n");
    Msg("Arg1: " .. tostring(arg1) .. "\n")
    Msg("Arg2: " .. tostring(arg2) .. "\n")
    Msg("Arg3: " .. tostring(arg3) .. "\n")
    Msg("Arg4: " .. tostring(arg4) .. "\n")
end