set background=light

" vimrc_example.vim stuff
set autoindent
set autowrite

set backup
set backupdir^=~/.backup
set number

if has('persistent_undo')
	set undofile
	set undodir=$HOME/.undo
endif

if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

set termguicolors
set history=50

set ruler

set showcmd
set incsearch

set statusline^=%{coc#status()}

au VimLeave * :!clear

" copy to clipboard by visual selecting and pressing Ctrl-C
vnoremap <C-y> "+y
nnoremap <C-p> "+p
imap <C-p> <esc><C-p>
vnoremap <C-p> "+p

syntax on
set nohlsearch

" Settings when editing *.txt files
autocmd FileType text setlocal autoindent expandtab softtabstop=2 spell spelllang=en_us

" Don't do spell-checking on Vim help files
autocmd FileType help setlocal nospell

" Indenting and tabs. see: https://medium.com/@arisweedler/tab-settings-in-vim-1ea0863c5990 for explanation
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab

" Override by prepending search with \C for case sensitivity
set ignorecase

" Setting syntax highlighting for rofi .rasi files
au BufNewFile,BufRead /*.rasi setf css

" Vim-plug
call plug#begin()

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'lilydjwg/colorizer'
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'NovaDev94/lightline-onedark'
Plug 'edkolev/tmuxline.vim'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'psliwka/vim-smoothie'
Plug 'rakr/vim-one'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'xarthurx/taskwarrior.vim'
Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
" markdown plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" markdown preview
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install'}

call plug#end()

colorscheme solarized8_flat
set noshowmode

let g:lightline = {
		\ 'colorscheme': 'solarized'
		\}

let g:tmuxline_preset = {
      \'a'    : '',
      \'b'    : '#S',
      \'c'    : '',
      \'win'  : '#W',
      \'cwin' : '#W',
      \'x'    : '',
      \'y'    : '%R',
      \'z'    : ''}

let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

set timeoutlen=1000
set ttimeoutlen=10

let mapleader = " "

" CHADtree keybindings
nnoremap <silent> <Leader>t :CHADopen<cr>

" Moving windows noremap <silent> <Leader>H <C-W>H 
noremap <silent> <Leader>J <C-W>J
noremap <silent> <Leader>K <C-W>K
noremap <silent> <Leader>L <C-W>L
noremap <silent> <Leader>H <C-W>H

noremap <silent> <ALT-j> :exe "resize +5"<CR>
noremap <silent> <M-k> :exe "resize -5"<CR>
noremap <silent> <M-h> :exe "vertical resize +5"<CR>
noremap <silent> <M-l> :exe "vertical resize -5"<CR>

" keybindings...  
" Set our <leader> key to be space

" Controling windows noremap <Leader>q :q<CR> 
" Removing Q as entering ex mode for the sake of the following command
nnoremap Q <nop> 
noremap <Leader>Q :q!<CR>
noremap <Leader>q :q<CR>
noremap <Leader>w :w<CR>
noremap <Leader>W :wq<CR>
noremap <Leader>o <C-W>o
noremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
noremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" FZF
"let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -f -g ""'
map <F5> :Files<CR>
map <F6> :Files ~<CR>
map <F1> :Ag<CR>
map <leader>b :Buffers<CR> 

" Working with quickfix windows
map <C-n> :cnext<CR>
map <C-m> :cprev<CR>
nnoremap <leader>a :cclose<CR>

" Golang stuff
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
    let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
else
    let &t_SI .= "\e[=1c"
    let &t_EI .= "\e[=2c"
endif

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

let g:go_fmt_command = "goimports" " auto import on save

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

let g:go_list_type = "quickfix"

" Delegate this functionality to lsp
let g:go_def_mapping_enabled = 0 

" coc configuration
" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')




" Markdown preview settings
" disable folding on markdown
let g:vim_markdown_folding_disabled = 1
set conceallevel=2

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

let g:pyindent_open_paren = 'shiftwidth()'

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=254
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=246

nmap <silent> ds <Plug>(pydocstring)
let g:pydocstring_formatter = 'google'
