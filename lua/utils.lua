local M = {}

M.ends_with = function(str, ending)
    return ending == "" or string.sub(str, - #ending) == ending
end

M.starts_with = function(str, start)
    return start == "" or string.sub(str, 1, #start) == start
end

M.copy = function(text)
    return vim.fn.setreg('+', text)
end

M.expand = function(key)
    return vim.fn.expand(key)
end

M.expand_and_copy = function(key)
    return M.copy(M.expand(key))
end

return M
