local M = {}

M.ends_width = function(str, ending)
    return ending == "" or string.sub(str, - #ending) == ending
end

return M
