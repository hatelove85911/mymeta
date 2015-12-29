let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_linux = has("unix") && substitute(system("uname"), '\n', '', '') ==? "linux"
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))


"different setting between different os
if s:is_windows
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
else 
    set rtp+=~/.vim/bundle/Vundle.vim
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
"==================================================
" plugins
if s:is_windows
    call vundle#begin(path)
else 
    call vundle#begin()
endif
"Vundle
Plugin 'gmarik/Vundle.vim'

"snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" auto closing brackets
Plugin 'jiangmiao/auto-pairs'

" color scheme
Plugin 'sickill/vim-monokai'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

" status line
Plugin 'bling/vim-airline'

" show marks
Plugin 'kshenoy/vim-signature'

" multiple line edit
Plugin 'terryma/vim-multiple-cursors'

" operate on surroundings
Plugin 'tpope/vim-surround'

" directory tree
Plugin 'scrooloose/nerdtree'

" git
Plugin 'tpope/vim-fugitive'

" quick file finder 
" ag is a front end for the silver searcher ag program
Plugin 'rking/ag.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
"unite mru source
Plugin 'Shougo/neomru.vim'  

" smooth scroll when pressing ctrl+d or ctrl u
Plugin 'joeytwiddle/sexy_scroller.vim'

" syntax checker
Plugin 'scrooloose/syntastic'

" javascript related
" for the autoformat to work for javascript, first need to install a global
" node modue, npm install -g standard
Plugin 'Chiel92/vim-autoformat'
Plugin 'pangloss/vim-javascript' 
Plugin 'bigfish/vim-js-context-coloring'

" distinguish json from javascript
Plugin 'elzr/vim-json'

" easy motion( move around super fast )
Plugin 'Lokaltog/vim-easymotion'

" for navigation between items in quick fix or location list easier
Plugin 'tpope/vim-unimpaired'

" comment out code
Plugin 'tpope/vim-commentary'

" text object
" text objects depend on kana/vim-textobj-user
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'sgur/vim-textobj-parameter'  
Plugin 'beloglazov/vim-textobj-punctuation'
Plugin 'poetic/vim-textobj-javascript'
" javascript function text object, standalone, indepent of kana/vim-textobj-user
Plugin 'thinca/vim-textobj-function-javascript'

" window manager
" Plugin 'spolu/dwm.vim'
Plugin 'szw/vim-maximizer'

" for cursor shape change in difference terminal
Plugin 'jszakmeister/vim-togglecursor'

" relative number
Plugin 'myusuf3/numbers.vim'

" the ultimate code completion plugin
" Plugin 'Valloric/YouCompleteMe'

" xml 
Plugin 'sukima/xmledit'
Plugin 'mattn/emmet-vim'

" scratch pad
Plugin 'mtth/scratch.vim'

" vim submode
Plugin 'kana/vim-submode'

" Vim sugar for the UNIX shell commands that need it the most
Plugin 'tpope/vim-eunuch'

" generate incremental thing, like number, character
" calutil is needed by visIncr plugin for increamental date 
Plugin 'cskeeters/vim-calutil'
Plugin 'vim-scripts/VisIncr'

" camel case motion
Plugin 'bkad/CamelCaseMotion'
call vundle#end()

" use git protocol by default other than https
"let g:vundle_default_git_proto = 'git'

set nocompatible
filetype plugin indent on
syntax on

" map leader to space
let mapleader=" "

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow backspace to delete auto indention , line breaks, and the start of insertion
set backspace=indent,start
" always show status line
set laststatus=2
" no swap file
set noswapfile
" set hidden allowed
set hidden
" turn on wildmenu
set wildmenu
" access system clipboard
if s:is_linux 
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
" search ignore case by default
set ic
" highlight search
set hls
" increment search
set is
set nowrap
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=
set t_Co=256
let g:solarized_termcolors=256
silent! colorscheme monokai
set number
set showcmd
set cursorline
set showtabline=0

" indention
set smartindent
set autoindent
set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab

" open help in split vertical window
cabbrev h vert h

" natural split position
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocommand
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"markdown file extension recognization
au BufRead,BufNewFile *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" window management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:maximizer_set_default_mapping = 1

call submode#enter_with('ctrl_window', 'n', '', 'gw', '<Nop>')
" call submode#leave_with('ctrl_window', 'n', '', '<Esc>')

" widen or narrow a window
call submode#map('ctrl_window', 'n', '', 'l', '20<c-w>>')
call submode#map('ctrl_window', 'n', '', 'h', '20<c-w><')
" increase of decrease the hight of a window
call submode#map('ctrl_window', 'n', '', '+', '8<c-w>+')
call submode#map('ctrl_window', 'n', '', '-', '8<c-w>-')
" move to next/previous window
call submode#map('ctrl_window', 'n', '', 'j', '<c-w>w')
call submode#map('ctrl_window', 'n', '', 'k', '<c-w>W')
" swap position of window in the horizontal or vertical stack
nmap gws <c-w>r
nmap gwS <c-w>R
" toggle maximization of a window
nmap gwo :MaximizerToggle<CR>
" move to next/previous window
nmap ]w <c-w>w
nmap [w <c-w>W
" create split window
nmap <bar> :vs<CR>
nmap - :sp<CR>

function! MyRotate()
  if winnr('$') == 2
     " save the original position, jump to the first window
     let initial = winnr()
     exe 1 . "wincmd w"

     wincmd l
     if winnr() != 1
        " succeeded moving to the right window
        wincmd J " make it the bot window
     else
        " cannot move to the right, so we are at the top
        wincmd H " make it the left window
     endif

     " restore cursor to the initial window
     exe initial . "wincmd w"
  endif
endfunction
nmap gwt :call MyRotate()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [unite] <Nop>
nmap gu [unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <silent> [unite]b :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<CR>
nnoremap <silent> [unite]u :<C-u>Unite -no-split -buffer-name=files -start-insert buffer file_rec/async:!<CR>
nnoremap <silent> [unite]a :<C-u>Unite -no-split -buffer-name=all -start-insert buffer file file_rec/async:!<CR>
nnoremap <silent> [unite]m :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<CR>
nnoremap <silent> [unite]f :<C-u>Unite -no-split -buffer-name=file -start-insert file<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" code formatter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f :Autoformat<cr>
au FileType xml let g:formatdef_tidy_xml .= '." --indent-attributes 1"'
au FileType xhtml let g:formatdef_tidy_xhtml .= '." --indent-attributes 1"'
au FileType html let g:formatdef_htmlbeautify .= '." -A force"'
let g:formatters_js = ['standard']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scratch pad
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:scratch_no_mappings = 1
let g:scratch_horizontal = 0
nmap <leader>gi <plug>(scratch-insert-reuse)
nmap <leader>gs :Scratch<CR>
nmap <leader>gp :ScratchPreview<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline setting
" let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic configuration
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_javascript_checkers = ["standard"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" utltsnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ultisnips configuration
" define where to store the custom snippets created by me
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" define the directory names where ultisnips will go and search for .snippets 
let g:UltisnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
nmap <leader>se :UltiSnipsEdit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM configuration
let g:ycm_filetype_blacklist = {}
let g:ycm_key_list_select_completion=[]  " don't use tab to select next completion
let g:ycm_key_list_previous_completion=[] " don't use tab to select next completion

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy motion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy motion 
nmap <leader><leader>a  <Plug>(easymotion-jumptoanywhere)
nmap <leader><leader>w  <Plug>(easymotion-bd-w)
nmap <leader><leader>j  <Plug>(easymotion-bd-jk)
nmap <leader><leader>l  <Plug>(easymotion-lineanywhere)
nmap <leader><leader>s  <Plug>(easymotion-sn)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>nd :NERDTreeToggle<cr>
let g:NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" multi-cursor 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" multi-cursor configuration
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0
nmap <c-m> :MultipleCursorsFind 
vmap <c-m> :MultipleCursorsFind 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" js context coloring
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:js_context_colors_enabled = 1
let g:js_context_colors_usemaps = 0
" following unimpaired toggle key mapping convention
nmap coj :JSContextColorToggle<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" camelcasemotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call camelcasemotion#CreateMotionMappings('<leader>')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-textobj-punctuation configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" As most of the time, you need to operate on the text until punctuation, I add the following bindings to make it even more convenient to use:
" Now, you just need to press cu, du, yu, or vu to operate on the text until the closest punctuation.
xmap u iu
omap u iu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some shortcut mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick insert semicolon at the end of the line
nnoremap <leader>; A;<Esc>
"upper case Y to copy from cursor to line end
nnoremap Y v$hy
" select the whole line
nnoremap vv V
" select to the end of line
nnoremap V v$h
" for not to lose the yanked text after pasting over selection
xnoremap p pgvy
