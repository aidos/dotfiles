
c = get_config()

c.InteractiveShellApp.exec_lines = ['%autoreload 2']
c.InteractiveShellApp.extensions = ['autoreload']

c.TerminalInteractiveShell.autoindent = False

# c.TerminalInteractiveShell.editing_mode = 'vi'

c.TerminalInteractiveShell.colors = 'linux'
c.TerminalInteractiveShell.highlighting_style = 'dracula'
c.TerminalInteractiveShell.highlight_matching_brackets = True


#c.Completer.greedy = True

