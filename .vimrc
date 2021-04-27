" Modified from Fisa-vim-config http://fisadev.github.io/fisa-vim-config/
" 2021.04.25 by Cory Chu
"
" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif
" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif
" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use

call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Git integration
Plug 'motemen/git-vim'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Vim colorscheme
Plug 'patstockwell/vim-monokai-tasty'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better autocompletion
Plug 'Shougo/neocomplcache.vim'

" Python and other languages code checker
Plug 'scrooloose/syntastic'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Code commenter
Plug 'scrooloose/nerdcommenter'


call plug#end()

" ============================================================================
" Install plugins the first time vim runs
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4


" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on
" show line numbers
set nu

" colorscheme
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
    colorscheme vim-monokai-tasty
else
    colorscheme delek
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3


" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest


" persistent undos - undo after you re-open the file
set undofile                      
set undodir=~/.vim/dirs/undos


" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif


" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1




" NeoComplCache ------------------------------
"
" " most of them not documented because I'm not sure how they work
" " (docs aren't good, had to do a lot of trial and error to make
" " it play nice)
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_min_syntax_length = 1
" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'




" Signify ------------------------------
"
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Airline ------------------------------
let g:airline_powerline_fonts = 0
let g:airline_theme = 'badwolf'
let g:airline#extensions#whitespace#enabled = 0


set tags=tags,./tags,../tags,src/tags
