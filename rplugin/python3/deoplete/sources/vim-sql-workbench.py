from .base import Base
from pynvim.api.nvim import NvimError

class Source(Base):
    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'sw'
        self.mark = '[sw]'
        self.filetypes = ['sql']

    def gather_candidates(self, context):
        try:
            # カーソル下の単語を補完したい
            return self.vim.call('sw#autocomplete#perform', 0, '')
        except NvimError:
            return ['ringo', 'mikan', 'suika']
