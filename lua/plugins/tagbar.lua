local plugin = {
    "majutsushi/tagbar",
    cmd = "Tagbar",
    enabled = false,
    init = function()
        vim.g.tagbar_type_go = {
            ctagsargs = "-sort -silent",
            ctagsbin = "gotags",
            ctagstype = "go",
            sro = ".",
            kind2scope = {
                t = "ctype",
                n = "ntype",
            },
            kinds = {
                "p:package",
                "i:imports:1",
                "c:constants",
                "v:variables",
                "t:types",
                "n:interfaces",
                "w:fields",
                "e:embedded",
                "m:methods",
                "r:constructor",
                "f:functions",
            },
            scope2kind = {
                ctype = "t",
                ntype = "n",
            },
        }
    end,
}

return plugin
