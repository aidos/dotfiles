local M = {}

local db_queries = [[
  (
    (call
      function: (attribute
        object: (call
          function: (attribute attribute: (identifier) @call_query)
          arguments: (argument_list (_) (_))
        )
        attribute: (identifier) @call_join
      )
    ) @to_find
    (#eq? @call_query "query")
    (#contains? @call_join "join")
  )
]]

M.find_results = function()
  local locations = {}

  for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
    local uri = vim.uri_from_bufnr(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "python")

    if parser then
      local tree = parser:parse()[1]
      local query = vim.treesitter.parse_query("python", db_queries)

      for id, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
        local name = query.captures[id] -- name of the capture in the query
        if name == "to_find" then
          local start_row, _, _ = node:start()
          local end_row, _, _ = node:end_()

          -- hacky push into qf format using lsp output structure
          local location = {
              uri = uri;
              range = {
                  start = { line = start_row; character = 0; };
                  ["end"] = { line = end_row; character = 0; };
              };
          };

          table.insert(locations, location)
        end
      end
    end
  end

  vim.fn.setqflist({}, ' ', {
    title = 'Query results';
    items = vim.lsp.util.locations_to_items(locations);
  })
  vim.api.nvim_command('copen')
end

return M
