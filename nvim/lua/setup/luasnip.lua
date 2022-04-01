ls = require('luasnip')

ls.snippets = {
  typescriptreact = {
    ls.parser.parse_snippet("fnconst", "const $1 = ($2) => {\n\t$0\n}"),
    ls.parser.parse_snippet("fn", "function $1($2) {\n\t$0\n}"),
  },
}
