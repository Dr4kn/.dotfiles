" GENERAL

" change <Leader>  to space
map <Space> <Leader>
" relative line number
set relativenumber
" increase undo limit
set history=1000
" undo even when file was closed
set undodir=~/.vim/.undo/
" a copy of the file when you opened it
set backupdir=~/.vim/.backup/
" contains unsaved changes
set directory=~/.vim/.swp/
" go half a screen up or down and move cursor in the middle of the screen
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
" disable: <Press ENTER or type command to continue> message
set shortmess=a



" HIGHLIGHTING

" Wrap text that goes beyond the screen length
set wrap
" syntax highlighting
set syntax
" Enable 256 colors palette in Gnome Terminal
<<<<<<< HEAD
set t_Co=256
||||||| a6f25a9
=======
>>>>>>> 738679637b3a5894877109736c79255afb5db6d2



" STATUS LINE

" From https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641
" theme status bar 
" insert mode
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
" normal mode
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
" visual mode
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

" Show status bar
set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%1*\ %<%f%m%r%h%w\                       " relative File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%3*│                                     " Separator
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode

" colors for the statusbar blocks
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e



" INDENTATION

" Use spaces instead of tabs
set expandtab
" indents further with tabs depending on context
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4



" COPY PASTE

" yank to global clipboard
set clipboard=unnamedplus
" copy paste to x11 mouse selection which can be pasted by the middle mouse button
noremap <Leader>y "*y
noremap <Leader>p "*p
" copy paste to desktop clipboard
noremap <Leader>Y "+y
noremap <Leader>P "+p
" Copy from cursor to the end of line.
nnoremap Y y$



" SEARCHING

" Visual mode pressing * searches for the current selection
" Super useful! From an idea by Michael Naumann
function! s:getSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction

vnoremap <silent> * :call setreg("/",
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
" ignore case when searching
set ignorecase
" replace words while keeping original upper/lowercase style
set smartcase
" Hom many tenths of a second to blink when matching brackets
set mat=2
" Set regular expression engine automatically
set regexpengine=0
" Show current mode in last line
set showmode
" Show the partially typed command on the last line
set showcmd
" Show matching words during a search
set showmatch
" Highly while searching
set hlsearch
" Press leader key + / to turn of the search hightling until the next one
:map <Leader>h :noh<CR>
" searches while typing
set incsearch



" PLUGINS

" if plug.vim isn't installed install it
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" install color scheme
Plug 'fugalh/desert.vim'
try
    colorscheme desert
catch
endtry

" does as the name implies
Plug 'machakann/vim-highwlightedyank'
" indefinite highlight duration
let g:highlightedyank_highlight_duration = -1

" Usage: 
"   change cs<from><to>, 
"   delete ds<to>, 
"   add ys<from><to>, 
"   add in Visual Mode S<from><to>
Plug 'tpope/vim-surround'

" Comment out / in code in normal mode
" Usage: 
"   gcc Comment current line
"   gc + motion: Comment with motion
"   gc Comment selected text
Plug 'tpope/vim-commentary'

" highlight the first letter to move with f and t
Plug 'unblevable/quick-scope'
" Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
" Note that you must use nmap/xmap instead of their non-recursive versions (nnoremap/xnoremap).
nmap <leader>q <plug>(QuickScopeToggle)
xmap <leader>q <plug>(QuickScopeToggle)


" adds rainbow brackets to vim
Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 1

call plug#end()
