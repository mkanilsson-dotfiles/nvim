local M = {}

M.ends_with = function(str, ending)
    return ending == "" or string.sub(str, - #ending) == ending
end

M.starts_with = function(str, start)
    return start == "" or string.sub(str, 1, #start) == start
end

return M
