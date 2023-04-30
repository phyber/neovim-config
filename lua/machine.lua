-- Machine module
-- Helpful information about the machine we're running on.

-- Return true if the system is FreeBSD
local is_freebsd
do
    local freebsd = vim.loop.os_uname().sysname == "FreeBSD"

    is_freebsd = function()
        return freebsd
    end
end

-- Return true if the system appears to be a Raspberry Pi
-- Works on a Raspberry Pi 4.
local is_raspberry_pi
do
    local pi = false

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

    is_raspberry_pi = function()
        return pi
    end
end

-- Exposed API
return {
    is_freebsd      = is_freebsd,
    is_raspberry_pi = is_raspberry_pi,
}
