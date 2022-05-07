local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node


local function copy(args)
  return args[1]
end

local function copy_name_or_alias(args)
  for x in string.gmatch(args[1][1], "%S+") do last = x end
  return last
end


ls.add_snippets(nil, {
    all = { },
    python = {
        s("shebang", {
            t{ "#!/usr/bin/env python", "" },
            i(0),
        }),
    },
    sql = {
        s("select", {
            t{ "select", "  " },
            i(2, "*"),
            t{ "", "from", "  " },
            i(1, "table"),
            t{ "", "where", "  true" },
            i(0)
        }),
        s("joindown", {
            t{ "join " }, i(1, "child"),
            t{ " on "},
            i(2, "parent"), t{ ".id = "}, f(copy_name_or_alias, 1), t{ ".", }, f(copy, 2), t{"_id" },
            i(0),
        }),
        s("joinup", {
            t{ "join " }, i(1, "parent"),
            t{ " on "},
            f(copy_name_or_alias, 1), t{ ".id = "}, i(2, "child"), t{ ".", }, f(copy_name_or_alias, 1), t{"_id" },
            i(0),
        }),
    },
})

