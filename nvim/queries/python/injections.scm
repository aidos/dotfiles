; inherits: python

((call
  function: (identifier) @_func
  arguments: (argument_list (string) @sql))
(#eq? @_func "text")
(#offset! @sql 0 1 0 -1))

