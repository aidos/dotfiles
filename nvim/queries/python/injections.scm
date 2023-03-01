; inherits: python

((call
  function: (identifier) @_func
  arguments: (argument_list (string) @sql))
(#eq? @_func "text")
(#offset! @sql 0 1 0 -1))

((call
  function: (identifier) @_func
  arguments: (argument_list (string) @html))
(#eq? @_func "HTMLString")
(#offset! @html 0 1 0 -1))

