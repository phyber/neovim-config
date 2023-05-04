-- Machine module
-- Helpful information about the machine we're running on.
local SYSNAME = vim.loop.os_uname().sysname

-- Return true if the system is FreeBSD
local function is_freebsd()
    return SYSNAME == "FreeBSD"
end

-- Return true if the system is Linux
local function is_linux()
    return SYSNAME == "Linux"
end

-- Return true if the system appears to be a Raspberry Pi
-- Works on a Raspberry Pi 4.
local is_raspberry_pi
do
    local pi = false

    -- No Pis that aren't Linux so far, but guard it anyway.
    if is_linux() then
        local f = io.open("/proc/cpuinfo")
        if f then
            for line in f:lines() do
                if line:find("Model", 1, true) then
                    pi = line:find("Raspberry Pi") ~= nil
                    break
                end
            end

            f:close()
        end
    end

    is_raspberry_pi = function()
        return pi
    end
end

-- Exposed API
return {
    is_freebsd      = is_freebsd,
    is_linux        = is_linux,
    is_raspberry_pi = is_raspberry_pi,
}
