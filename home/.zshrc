# install antigen
# 1st. mkdir in home directory  .zsh-antigen
# 2nd. download antigen.zsh  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > antigen.zsh
ZSH_ANTIGEN=$HOME/.zsh-antigen
source $ZSH_ANTIGEN/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle tmux
antigen bundle vi-mode
antigen bundle fasd

antigen bundle Tarrasch/zsh-bd
antigen bundle djui/alias-tips
antigen bundle tarruda/zsh-autosuggestions
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# theme
# antigen theme avit
antigen theme amuse

antigen apply


# bundle configuration
# zsh history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down



# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git tmux vi-mode)

# User configuration

export PATH=./node_modules/.bin:$HOME/bin:/usr/local/bin/:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# intialize fasd
eval "$(fasd --init auto)"

# source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh" # This loads nvm
#nvm use node

# enable extended globbing
setopt extended_glob

# IGNOREEOF forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

# source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ~='cd ~'
alias -- -='cd -'
alias ..='cd ..'

alias l='ls -la'
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias vimrc="vim ~/.vimrc" 
alias msh="vim ~/Dropbox/mymeta/mothership/mac/mothership.yml"
if [[  "$OSTYPE" == "darwin"*  ]]; then
  alias ngconf="vim /usr/local/etc/nginx/nginx.conf"
elif [[  "$OSTYPE" == "linux"*  ]]; then
  alias ngconf="vim /etc/nginx/sites-enabled/default"
fi

# tmux 
alias td="tmux detach"
alias tlc="tmux list-commands"
alias tlk="tmux list-keys"
alias ti="tmux info"
alias stmconf="tmux source-file ~/.tmux.conf"
alias tmconf="vim ~/.tmux.conf"

# git
alias glg="git lg"
alias gdt="git difftool"
alias gdtca="git difftool --cached"
alias gdth="git difftool HEAD"

alias grs="git reset"
alias grss="git reset --soft"
alias grsh="git reset --hard"

# node debug
alias nd="node"
alias ndbg="node-debug -p 8090"

alias dt="devtool"
dtw(){
  dt $1 --watch
}

alias lyn="learnyounode"

# quick use vim edit file
alias v="f -e vim"
alias vv="sf -e vim"

# brew cask
alias brck="brew cask"

alias atige="brew cask"

# jekyll
alias jk="jekyll"

mcd(){
  mkdir -p "$1" ; cd $_ ;
}

stty ixany
stty ixoff -ixon


LS_COLORS=$LS_COLORS:'ow=34;40:' ; export LS_COLORS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
