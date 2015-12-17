""C-Space"C-Space"C-Space"C-Space"C-Space""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent><C-p> :CtrlSpace O<CR>
" my functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MyDetectOS()
    if has("win32") || has("win16") || has("win64")
        return "windows"
    elseif has("mac") || has("macunix")
        return "mac"
    elseif has("win32unix")
        return "cygwin"
    elseif has("unix")
        let l:uname = substitute(system("uname"), '\n', '', '')
        if l:uname ==? "linux"
            return "linux"
        else
            return "unix"
        endif
    endif
endfunction

function! MyDetectTerminal()

endfunction


"different setting between different os
if MyDetectOS() ==? "windows"
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
if has("win32") || has("win16")
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
Plugin 'BusyBee'
Plugin 'altercation/vim-colors-solarized'
Plugin 'goatslacker/mango.vim'

" status line
Plugin 'bling/vim-airline'

" show marks
Plugin 'kshenoy/vim-signature'

" multiple line edit
" Plugin 'terryma/vim-multiple-cursors'

" operate on surroundings
Plugin 'tpope/vim-surround'

" directory tree
Plugin 'scrooloose/nerdtree'

" tagbar
" Plugin 'majutsushi/tagbar'
" Plugin 'marijnh/tern_for_vim'

Plugin 'tpope/vim-fugitive'

" quick file finder 
" Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/unite.vim'

" ctrlspace
" ag is recommended by ctrlspace
Plugin 'rking/ag.vim'
Plugin 'szw/vim-ctrlspace'

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

" mark down
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'shime/vim-livedown'

" easy motion( move around super fast )
Plugin 'Lokaltog/vim-easymotion'

" local vimrc solution
Plugin 'MarcWeber/vim-addon-local-vimrc'

" for navigation between items in quick fix or location list easier
Plugin 'tpope/vim-unimpaired'

" nodejs plugin
Plugin 'moll/vim-node'
" Plugin 'sidorares/node-vim-debugger'

" comment out code
Plugin 'tpope/vim-commentary'

" create my own text object
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'thinca/vim-textobj-function-javascript'

" window manager
Plugin 'spolu/dwm.vim'
" Plugin 'zhaocai/GoldenView.Vim'

" for cursor shape change in difference terminal
Plugin 'jszakmeister/vim-togglecursor'

" relative number
Plugin 'myusuf3/numbers.vim'


" the ultimate code completion plugin
" Plugin 'Valloric/YouCompleteMe'

" xml 
Plugin 'sukima/xmledit'

" scratch pad
Plugin 'mtth/scratch.vim'
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
if MyDetectOS() ==? "linux" 
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocommand
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"markdown file extension recognization
au BufRead,BufNewFile *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" window management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap _ <c-w><
nnoremap + <c-w>>
nnoremap ( <c-w>-
nnoremap ) <c-w>+
nmap <silent> <c-n>  <Plug>GoldenViewSplit
nmap <silent> ]w  <Plug>GoldenViewNext
nmap <silent> [w  <Plug>GoldenViewPrevious
nmap <silent> <c-m>  <Plug>GoldenViewSwitchToggle
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :qa<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>ww :wa<CR>
nnoremap <leader>xa :xa<CR>

"maximize and restore window
nnoremap <leader>o :call MaximizeToggle()<CR>
function! MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" code formatter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f :Autoformat<cr>
au FileType xml let g:formatdef_tidy_xml .= '." --indent-attributes 1"'
au FileType xhtml let g:formatdef_tidy_xhtml .= '." --indent-attributes 1"'
au FileType html let g:formatdef_htmlbeautify .= '." -A force"'
let g:formatters_js = ['standard']


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrl-space
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

let g:CtrlSpaceSetDefaultMapping = 0
nnoremap <silent><leader>p :CtrlSpace<CR>

let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scratch pad
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:scratch_no_mappings = 1
nmap <leader>gs <plug>(scratch-insert-reuse)
nmap <leader>gg :Scratch<CR>
nmap <leader>gp :ScratchPreview<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp settings
" let g:ctrlp_map = ''
" nmap <leader>p :CtrlP<CR>
" nmap <leader>b :CtrlPBuffer<CR>

" let g:ctrlp_working_path_mode=0  
" let g:ctrlp_max_files=0
" let g:ctrlp_max_height=20
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = {
"             \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
"             \ 'file': '\v\.(exe|so|dll)$',
"             \ 'link': 'some_bad_symbolic_links',
"             \ }

" let g:ctrlp_user_command = {
"             \ 'types': {
"             \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
"             \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"             \ },
"             \ 'fallback': 'find %s -type f'
"             \ }


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
nmap <leader><leader>w  <Plug>(easymotion-bd-w)
nmap <leader><leader>j  <Plug>(easymotion-bd-jk)
nmap <leader><leader>l  <Plug>(easymotion-lineanywhere)
nmap <leader><leader>s  <Plug>(easymotion-sn)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" livedown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" livedown(markdown preview)
nmap <leader>ll :LivedownPreview<CR>
nmap <leader>lk :LivedownKill<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some shortcut mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle tag bar
nnoremap <leader>tb :TagbarToggle<CR>
" quick insert semicolon at the end of the line
nnoremap <leader>; A;<Esc>
" for not to lose the yanked text after pasting over selection
xnoremap p pgvy
" nerdtree 
nmap  <leader>nd :NERDTreeToggle<cr>
let g:NERDTreeShowHidden=1

" multi-cursor configuration
let g:multi_cursor_exit_from_insert_mode = 0

" use node to execute js code directly and output to shell directly
nnoremap <leader>node :Node %<cr>

" upper case Y to copy from cursor to line end
nnoremap Y v$hy

" script to output shell command output to a new buffer in a separate window 
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    let isfirst = 1
    let words = []
    for word in split(a:cmdline)
        if isfirst
            let isfirst = 0  " don't change first word (shell command)
        else
            if word[0] =~ '\v[%#<]'
                let word = expand(word)
            endif
            let word = shellescape(word, 1)
        endif
        call add(words, word)
    endfor
    let expanded_cmdline = join(words)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:  ' . a:cmdline)
    call setline(2, 'Expanded to:  ' . expanded_cmdline)
    call append(line('$'), substitute(getline(2), '.', '=', 'g'))
    silent execute '$read !'. expanded_cmdline
    1
endfunction
command! -complete=file -nargs=* Node call s:RunShellCommand('node '.<q-args>)

