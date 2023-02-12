local plugin = {
    "neomake/neomake",
    config = function()
        local util = require "util"

        util.create_augroups({
            neomake = {
                -- Run Neomake after any buffer write.
                {"BufWritePost", "*", "Neomake"},
            },
        })
    end,
}

return plugin
