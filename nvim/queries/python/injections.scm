; inherits: python

(
  (call
    function: (identifier) @_func
    arguments: (argument_list (string (string_content) @injection.content))
  )
  (#eq? @_func "text")
  (#set! injection.language "sql")
  (#set! injection.include-children)
)

(
  (call
    function: (identifier) @_func
    arguments: (argument_list (string (string_content) @injection.content))
  )
  (#eq? @_func "HTMLString")
  (#set! injection.language "html")
  (#set! injection.include-children)
)

