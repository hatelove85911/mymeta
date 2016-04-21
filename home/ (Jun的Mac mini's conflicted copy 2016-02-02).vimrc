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
" Prefer local repo install of eslint over global install with syntastic
" Plugin 'mtscout6/syntastic-local-eslint.vim'

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

" vim save session(window, position, layout, open folds)
" basically used by tmux resurrent to restore tmux session with vim opened
Plugin 'tpope/vim-obsession'


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
  " vmap "+y :!xclip -f -sel clip
  " map "+p :r!xclip -o -sel clip
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

" ask for confirmation first when quit when there're noname buffer
set confirm

" auto read file again if the file has been detected to have been
" changed outside of vim and it has not been changed inside of vim
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocommand
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"markdown file extension recognization
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.eslintrc set filetype=json

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
" swap position of window in the horizontal or vertical stack
nmap gws <c-w>r
nmap gwS <c-w>R
" toggle maximization of a window
nmap gwo :MaximizerToggle<cr>
" move to next/previous window
nmap ]w <c-w>w
nmap [w <c-w>W
" create split window
nmap <bar> :vs<cr>
nmap - :sp<cr>

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
nmap gwr :call MyRotate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [unite] <Nop>
nmap gu [unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_source_rec_async_command =
      \ ['ag', '--follow', '--nocolor', '--nogroup',
      \  '--hidden', '-g', '']

nnoremap <silent> [unite]b :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>
nnoremap <silent> [unite]u :<C-u>Unite -no-split -buffer-name=files -start-insert buffer file_rec/async:!<cr>
nnoremap <silent> [unite]a :<C-u>Unite -no-split -buffer-name=all -start-insert buffer file file_rec/async:!<cr>
nnoremap <silent> [unite]m :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap <silent> [unite]f :<C-u>Unite -no-split -buffer-name=file -start-insert file<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" code formatter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f :Autoformat<cr>
au FileType xml let g:formatdef_tidy_xml .= '." --indent-attributes 1"'
au FileType xhtml let g:formatdef_tidy_xhtml .= '." --indent-attributes 1"'
au FileType html let g:formatdef_htmlbeautify .= '." -A force"'
au FileType javascript nmap <buffer> <leader>f :silent !standard % --format<cr>:redraw!<cr>
" au FileType javascript let g:formatdef_standard = '"standard --format"' 
" let g:formatters_javascript = ['standard']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scratch pad
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:scratch_no_mappings = 1
let g:scratch_horizontal = 0
nmap <leader>si <plug>(scratch-insert-reuse)
nmap <leader>sr :Scratch<cr>
nmap <leader>sp :ScratchPreview<cr>

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
let g:syntastic_mode_map = { 
      \ 'mode': 'passive',
      \ 'active_filetypes': ['javascript']}
let g:syntastic_javascript_checkers = ["eslint", "standard"]
" 0 the error window will be neither opened nor closed
" automatically, 1 open and close auto 2 close auto, open manual
let g:syntastic_auto_loc_list = 0
" when active mode is on, 1 means syntax check will be done
" when the file is opened
let g:syntastic_check_on_open = 1
" when active mode is on, 1 means syntax check will be done
" whenever buffer is written to disk
let g:syntastic_check_on_wq = 1

nmap <leader>c :SyntasticCheck<cr>
nmap <leader>sf :SyntasticInfo<cr>

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
nmap <leader>se :UltiSnipsEdit<cr>

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
" disable context coloring by default, find it's slow
let g:js_context_colors_enabled = 0
let g:js_context_colors_usemaps = 0
" following unimpaired toggle key mapping convention
nmap coj :JSContextColorToggle<cr> 

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
" vim-obsession
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" track session
nmap <leader>ts :Obsession<cr>
" stop trakcing session
nmap <leader>tn :Obsession!<cr>
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
" for quick switch between two buffer in the same window
nmap <leader>b :b#<cr>
" save all
nmap <c-s> :wa<cr>
" quit all
nmap <c-q> :qa<cr>
" force quit all
nmap <c-x> :qa!<cr>
" quite window
nmap gwq :q<cr>
" write current file
nmap gww :w<cr>
" force qite current window
nmap gwx :q!<cr>
" diffget BASE in three merge
nmap dob :diffget BA<cr>
" diffget LOCAL in three merge
nmap dol :diffget LO<cr>
" diffget REMOTE in three merge
nmap dor :diffget RE<cr>
" diffupdate
nmap dfu :diffupdate<cr>
" move between in windows
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
" 0 to the start of line
nnoremap 0 ^
" g0 to the column 1
nnoremap g0 0
" move the cursor out of a pair like 'sxxx|' to 'sxxx'|
imap <c-l> <Esc>la
" put cursor to the end of the wrapping {}|
imap <c-}> <Esc>]}a
