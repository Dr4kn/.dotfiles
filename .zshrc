# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# MAKES STARTUP FASTER

# direnv call speedup
# https://zdharma-continuum.github.io/zinit/wiki/Direnv-explanation/
zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

# ls colors speedup
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit light dracula/zsh

# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# PLUGINS

# loaded before first prompt
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# loaded after first prompt
zinit wait lucid for \
        hlissner/zsh-autopair \
        zsh-users/zsh-syntax-highlighting \
        urbainvaes/fzf-marks \
        zdharma-continuum/history-search-multi-word \
        ael-code/zsh-colored-man-pages

# loads several git plugins 1s after prompt
zi as'null' lucid sbin wait'1' for \
  Fakerr/git-recall \
  davidosomething/git-my \
  iwata/git-now \
  paulirish/git-open \
  paulirish/git-recent \
    atload'export _MENU_THEME=legacy' \
  arzzen/git-quick-stats \
    make'install' \
  tj/git-extras \
    make'GITURL_NO_CGITURL=1' \
    sbin'git-url;git-guclone' \
  zdharma-continuum/git-url

# ZSH AUTOCOMPLETE CONFIG
# First autocomplete common strings and then show the menu:
# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

# COMPLETION SETTINGS
# makes suggestions case unsensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# COMPLETIONS
# Load completions
autoload -Uz compinit && compinit
# makes them much load much faster
zinit cdreplay -q

export HISTFILE="$HOME/.zsh_history"
# number of events loaded in memoryh
export HISTSIZE=268435456
# number of events stored in zsh hist file
export SAVEHIST="$HISTSIZE"
# writes to hist file before command is executed
setopt inc_append_history
# shares history across all open zsh shells
setopt sharehistory
# doesn't save commands with a space before them
setopt hist_ignore_space
# don't duplicate commands to history
setopt hist_ignore_all_dups
# do not find duplicate command when searching
setopt hist_find_no_dups

# ALIASES

# lsd shortcuts
alias ll="/bin/lsd --long --group-dirs=first"
alias lla="/bin/lsd --long --all --group-dirs=first"
alias k=lla
alias llt="/bin/lsd --tree --all"
# a bit of color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
# just lazy shortcuts
alias p="ping google.com"
alias ..='cd ..'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/.zsh/.p10k.zsh ]] || source ~/.config/.zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
