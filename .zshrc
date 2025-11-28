# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Type name of directory to make it current directory
setopt autocd

# Increase shell history size
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history

setopt HIST_FIND_NO_DUPS

setopt inc_append_history
setopt share_history

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
	jsontools
	# web-search
 	zsh-autosuggestions
	zsh-vi-mode
  fast-syntax-highlighting
	fzf
  you-should-use
  zsh-bat
  sudo
)

source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/madhavramesh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/madhavramesh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/madhavramesh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/madhavramesh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias vi=nvim
alias vim=nvim

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# used to provide tab completion for git aliases listed below
_branches() {
  local branches
  branches=$(git branch --format='%(refname:short)')

  _arguments "1:branch:($echo $branches))" "2:branch:($echo $branches))" "3:branch:($(echo $branches))" "4:branch:($echo $branches))" "5:branch:($(echo $branches))"
}

# gbdel - delete branches locally whose PRs have been merged 
gbdel() {
  for br in ($git branch | grep -v '*'); do 
    exists=0
    for r in ($git remote); do 
      if [ "$(git branch -r --list $r/$br)" != "" ]; then
        exists=1
      fi
    done

    if [ $exists eq 1 ]; then 
      echo "existing: $br"
    else 
      echo "No remotes for $br. Remove [y/N]? \c"; read ans
      if [ "$ans" = "y" -o "$ans" = "Y" ]; then
        git branch _d $br
      fi
    fi
  done
}

alias gsm='git checkout master and git branch -d master && git checkout -b master'

# gpo - create a PR on this branch
gpo() {
  username=$(git config github.username)
  branch=$(git branch --show-current)}

  if [ "$branch" = "master"]; then
    echo "Warning: You are on the master branch. Please switch to a project-specific branch before creating a PR"
    return 1
  fi

  if ] "$1" = "pull" ]; then
    git pull master
  fi
}

# gfs - fetch from master and switch to a new branch
gfs() {
  git fetch master
  git switch -c "$1" master
}

# gconf - show merge/rebase conflicts
gconf() {
  echo "Merge conflicts detected. Listing conflicted files:"
    git diff --name-only --diff-filter=U | while read file;
  do echo -e "  \033[31m$file\033[0m"
  done
}

# glgr - concise git log showing past 20 commits
glgr() {
  c="HEAD"
  n=20
  arg=""
  
  if [ $# -ge 1 ]; then 
    if [ "$1" = "-fp" ]; then 
      arg="--first-parent"
    else
      c="$1"
    fi
  fi
  
  if [ $# -ge 2 ]; then
    n="$2"
  fi

  # Check if the specified range is valid
  if git rev-parse "$c~$n" >/dev/null 2>&1; then
    range="${c}~${n}..${c}"
  else
    range="$c"
  fi
  
  git log "$range" $arg --graph --oneline \
    --pretty=format:"%C(yellow)%h%Creset - %C(green)%cd%C(auto)%d%Creset - %C(red)%an%Creset : %s" \
    --date=format-local:'%Y-%m-%d %H:%M:%S' --decorate=full
}

compdef _branches glgr

# up - cd up multiple levels easily
up() { cd $(eval printf '../'%.0s {1..$1}); }

alias weather="curl -s v2.wttr.in/72034"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Add clangd to environment path 
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Setting GOPATH 
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Setting python version
export PATH=/Library/Frameworks/Python.framework/Versions/3.11/bin/python3:$PATH

# Change editor for ranger
export VISUAL=nvim
export EDITOR=nvim

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[[ -s "/Users/madhavramesh/.gvm/scripts/gvm" ]] && source "/Users/madhavramesh/.gvm/scripts/gvm"

export PATH="/opt/homebrew/opt/mysql/bin:$PATH"

export PATH=/Users/madhavramesh/.tiup/bin:$PATH
