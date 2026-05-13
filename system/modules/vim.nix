{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    #((vim_configurable.override {  }).customize{
    #'vim_configurable' has been renamed to/replaced by 'vim-full'
    ((vim-full.override {  }).customize{
      name = "vim";
      # Install plugins 
      # vim-nix is for syntax highlighting of the nix language;
      # vim-lastplace re-opens files at your last edit position;
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace vim-wayland-clipboard];
        opt = [];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
        " aspas are vimrc's comment indicators
        set number
        set cursorline

        filetype plugin indent on

        hi linenr ctermfg=8
        hi cursorline cterm=none
        hi cursorlinenr cterm=none

        syntax on

        imap <C-BS> <C-W>
        noremap! <C-BS> <C-w>
        noremap! <C-h> <C-w>

        set encoding=utf-8
        set fileencoding=utf-8
        set termencoding=utf-8

        set foldmethod=syntax
        set foldlevel=999

        set tabstop=4
        set shiftwidth=4

        if has('mouse')
          set mouse=n
        endif
      '';
    }
  )];
}
