
c = get_config()

c.InteractiveShellApp.exec_lines = ['%autoreload 2']
c.InteractiveShellApp.extensions = ['autoreload']

c.TerminalInteractiveShell.autoindent = False
