" Vundle plugin manager {{{
set nocompatible              " be improved, required for Vundle
filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" User defined plugins
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Rip-Rip/clang_complete'
" Plugin 'davidhalter/jedi-vim'
Plugin 'sigidagi/vim-cmake-project'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'christoomey/vim-run-interactive'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'taglist.vim'
" Plugin 'jmcantrell/vim-virtualenv'
Plugin 'janko-m/vim-test'
Plugin 'neomake/neomake'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'smancill/conky-syntax.vim'
Plugin 'jlesquembre/peaksea'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
" Plugin 'vifm/neovim-vifm'
Plugin 'Wenir/true-colors.vim'
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/utl.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'mattn/calendar-vim'
Plugin 'inkarkat/vim-SyntaxRange'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
" }}}

" Main settings
syntax on
let mapleader=","

colorscheme true-colors
set background=dark

set noautochdir

set autoindent
set smartindent
set breakindent
set breakindentopt=shift:4
set tabstop=4
set shiftwidth=4
set noexpandtab

set number
set norelativenumber
set colorcolumn=0

set hlsearch
set incsearch

set splitright

set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o

set wildmode=longest:list,full
set matchpairs+=<:>
set equalalways
set winheight=20
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le
set laststatus=2
filetype plugin on
set path+=**
set wildmenu
set visualbell
set cursorline

set nobackup
set noswapfile

set undodir=~/.vim/undodir
set undofile
set fillchars+=vert:│

set mouse=a

" set statusline=%f\ %m%r%h%w\ %y\ %{&ff}\ %{&enc}->%{&fenc}%=col:%2c%2V\ line:%2l/%L\ [%2p%%]\ [ch:%3b\ hex:%2B]
" Options for NeoVim
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Cursor shape {{{
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
" Changing cursor shape per mode
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
else
	let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
    autocmd VimLeave * silent !echo -ne "\033[0 q"
endif
" }}}
" Menu for reopen file with encoding {{{
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.cp1251  :e ++enc=cp1251<CR>
menu Encoding.cp866   :e ++enc=cp866<CR>
menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>
" }}}
" Text folding preferences {{{
" Custom foldtext function {{{
function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
            let line = getline(v:foldstart)
        else
            let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+ ", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage) + 4)
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
" }}}
set foldtext=CustomFoldText()
set foldcolumn=1
set foldmethod=syntax
set foldlevel=1
" }}}
" Extend standart peaksea colorscheme {{{
function! ChangeScheme()
    highlight Normal ctermbg=0
    highlight FoldColumn   ctermfg=NONE ctermbg=233
    highlight VertSplit    ctermfg=0    ctermbg=20
    highlight TabLineFill  ctermfg=233
    highlight TabLine      ctermfg=NONE ctermbg=233
"     highlight VertSplit     guifg=#c0c0c0 guibg=#c0c0c0 gui=NONE
"     highlight FoldColumn    guifg=#e0e0e0 guibg=#1b1b1b gui=NONE
"     highlight LineNr        guifg=#b0b0b0 guibg=#1b1b1b gui=NONE
"     highlight CursorLineNr  guibg=#1b1b1b
"     highlight ColorColumn   ctermbg=DarkGreen ctermfg=White
"     highlight FoldColumn    ctermbg=Black
"     if &t_Co==256
"         highlight SignColumn                ctermbg=235
"         highlight LineNr       ctermfg=NONE ctermbg=235
"         highlight TabLineFill               ctermbg=18
"         highlight TabLine                   ctermbg=18
"     endif
"     highlight ExtraWhitespace ctermbg=red guibg=red
endfunction

autocmd ColorScheme * call ChangeScheme()
call ChangeScheme()
" }}}
" Auto switch between relative and norelative numbering {{{
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
" }}}
" Restore coursor position {{{
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
" }}}
" Map Space to : {{{
nnoremap <space> :
vnoremap <space> :
" }}}
" Some trash functions to bind buttons {{{
function! BindF5_C()
     map <f5>      :!konsole --noclose --workdir ./build -e ./build/main<cr>
    imap <f5> <esc>:!konsole --noclose --workdir ./build -e ./build/main<cr>
endfunction
au FileType c,cc,cpp,h,hpp,s call BindF5_C()

function! BindF5_PY()
     map <f5>      :w <cr> :silent exec "!konsole --noclose --workdir ./ -e python2 %" <cr>
    imap <f5> <esc>:w <cr> :silent exec "!konsole --noclose --workdir ./ -e python2 %" <cr>
endfunction
au FileType python call BindF5_PY()

function! BindF6_PY()
     map <f6>      :w <cr> :!python2 % <cr>
    imap <f6> <esc>:w <cr> :!python2 % <cr>
endfunction
au FileType python call BindF6_PY()

"function! BindF7_PY()
"     map <f7>      :w <cr> :execute 'vnew | read ! python2 ' expand('%') <cr> :vertical resize 55 <cr>
"    imap <f7> <esc>:w <cr> :execute 'vnew | read ! python2 ' expand('%') <cr> :vertical resize 55 <cr>
"endfunction
"au FileType python call BindF7_PY()
" }}}
" Don't move around in insert mode {{{
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}
" Switch splits with Ctrl+ h, j, k, l {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Autocommands {{{
autocmd FileType c,cpp,objc set cindent
autocmd FileType c,cpp,objc,asm set noexpandtab
autocmd FileType c,cpp,objc  map <f3> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vmap <f3> :ClangFormat<CR>
autocmd FileType c,cpp,objc imap <f3> <esc>:ClangFormat<CR>

autocmd FileType make set noexpandtab
autocmd FileType make set nocindent

autocmd FileType python set nocindent
autocmd FileType vim set foldmethod=marker

autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/
autocmd Syntax !help syn match ExtraWhitespace /[^\t]\zs\t\+/

autocmd BufWritePost *.cpp Neomake!
autocmd BufWritePost *.S Neomake!
" }}}
" Key bindings {{{

" Use double space to save the file
nnoremap <space><space> :w<cr>

" Save as root
noremap <Leader>W :w !sudo tee % > /dev/null

" vim-run-interactive plugin
nnoremap <leader>ri :RunInInteractiveShell<space>

" CTRL-F4 is :tabclose
nnoremap <C-F4> :tabclose<CR>

"search word under cursor without jump-to-next
nnoremap * *N

"search selected sequence of symbols
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>

" Change behaviour so that it jumps to the next row in the editor
nnoremap j gj
nnoremap k gk

" russian keyboard layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
nnoremap о gj
nnoremap л gk


nnoremap <leader>k :NERDTreeToggle<cr>
nnoremap <leader>m :TlistToggle<CR>
nnoremap <leader>n :tabn<cr>
nnoremap <leader>p :tabp<cr>
nnoremap <leader>s :Prosession .<cr>
map <F4> :call g:ClangUpdateQuickFix()<cr>
map <F12> :emenu Encoding.<Tab>
nnoremap <C-PageUp> :tabp<CR>
nnoremap <C-PageDown> :tabn<CR>
nmap <F8> :TagbarToggle<CR>
" }}}

" airline plugin {{{
let g:airline_powerline_fonts = 1
" }}}

" clang_complete plugin {{{
let g:clang_snippets=1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_periodic_quickfix=0
let g:clang_hl_errors=1
let g:clang_close_preview=1
let g:clang_complete_copen=1
let g:clang_user_options="-std=c++11 -I/usr/lib/clang/3.8.0/include/ -I/usr/include/zaychenko/"
let g:clang_library_path="/usr/lib/libclang.so"
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "AllowShortIfStatementsOnASingleLine": "false",
            \ "SpacesInParentheses": "true",
            \ "SpacesInSquareBrackets": "true",
            \ "BreakBeforeBraces" : "Stroustrup"}
" }}}

" taglist plugin {{{
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
" }}}

" gist-vim github Gist plugin {{{
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_post_private = 1
" }}}

" UltiSnips plugin {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=['my_snippets', 'UltiSnips']
" }}}

" GitGlutter plugin {{{
let g:gitgutter_sign_column_always = 1
" }}}

" Tmuxline plugin {{{
let g:airline#extensions#tmuxline#enabled = 0
" }}}

let g:promptline_preset = {
        \'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" Hex mode command {{{
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()
" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
" }}}

set exrc
set secure
" vim: foldlevel=0
