
c = get_config()

c.InteractiveShellApp.exec_lines = ['%autoreload 2']
c.InteractiveShellApp.extensions = ['autoreload']

c.TerminalInteractiveShell.autoindent = False

c.TerminalInteractiveShell.editing_mode = 'vi'

c.InteractiveShell.colors='linux'

#c.Completer.greedy = True


## https://github.com/ipython/ipython/issues/9915
# from IPython.terminal.prompts import Prompts, Token
# from prompt_toolkit.key_binding.vi_state import InputMode
# class MyPrompts(Prompts):
#     def in_prompt_tokens(self, cli=None):
#         mode = 'ins' if cli.vi_state.input_mode == InputMode.INSERT else 'cmd'
#         return [
#             (Token.Prompt, '(%s)In [' % mode),
#             (Token.PromptNum, str(self.shell.execution_count)),
#             (Token.Prompt, ']: ')
#         ]
# c.TerminalInteractiveShell.prompts_class = MyPrompts

