autoload -Uz colors
colors

autoload -Uz compinit
compinit

setopt share_history
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt correct
setopt auto_cd
setopt auto_pushd

# vim bind
bindkey -v 
bindkey "jk" vi-cmd-mode

bindkey "^r" history-incremental-pattern-search-backward
# bindkey "^s" history-incremental-pattern-search-forward

# alias
if ls --color=auto >/dev/null 2>&1 ; then 
    alias l='ls -ltr --color=auto'
    alias la='ls -la --color=auto'
    alias ll='ls -l --color=auto'
elif ls -G >/dev/null 2>&1 ; then 
    export LSCOLORS=xcfxcxdxbxegedabagacad
    alias l='ls -ltrG'
    alias la='ls -laG'
    alias ll='ls -lG'
else
    alias l='ls -ltr'
    alias la='ls -la'
    alias ll='ls -l'
fi

# cdr g (!)
mkdir -p $HOME/.cache/shell/
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*:*:cdr:*:*' menu selection
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi

alias zz='echo "\n\n\n\n\n"'

alias so='source'
alias soz='source ~/.zshrc'
alias se='sudoedit'

alias c='cdr'
alias g='grep --color=auto'
alias cl='clear'

alias mkd='(){mkdir -p $1; cd $_}'

alias fl='(){cd `pwd``find . -type f | grep -m1 $1 | perl -pe "s/(^\.|\/[^\/]*$)//g"`}'
alias fxg='find . -type f | xargs grep --color -n '
alias lc='tail -2 $HISTFILE | head -1 | perl -pe "s/^[^;]+;//g"'
alias -g th='(){tail -$1 | head -$2}'

alias umm='(){repeat $1 echo -n 🤔; echo}'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

## vim
mkdir -p ~/vtmp
alias v='vim'
alias vi='vim'
alias vt='(){mkdir -p `dirname $1`;vim ~/vtmp/$1}'

## dotfiles
alias vz='vim ~/.zshrc'
alias vzl='vim ~/.zsh_local'
alias vv='vim ~/.vimrc'
alias dot='cd ~/dotfiles'

## git
alias ga='git add'
alias gs='git status'
alias gc='git checkout'
alias gm='git merge'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias grao='git remote add origin'
alias gd='git diff'
alias gf='git fetch'
alias gb='git branch'
alias gpl='git pull'
alias gp='git push'
alias gpo='git push origin'
alias gl='git log'
alias glo='git log --oneline'
alias glf='git log --graph --branches --pretty=format:"%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset"'
alias gls='git log --oneline --stat --graph'
alias ghooks='(){cp ~/dotfiles/githooks/* ./.git/hooks/; chmod a+x ./.git/hooks/*}'

alias gign='(){cp .gitignore .gitignore_; wget https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore -O .gitignore}'

## perl
alias p='perl'
alias pe='perl -e'
alias ppe='perl -pe'
alias pne='perl -ne'

## Homebrew
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'

# Vagrant
alias vag='vagrant'

# virtualenv
alias venv='virtualenv'
alias von='source bin/activate'
alias voff='deactivate'

# prompt text
if [ "$SSH_CONNECTION" ]; then
    PRE_PROMPT="%(?.%F{085}.%F{212})%n%F{244}@%F{043}%m%F{250}(%*%)"
    SUF_PROMPT=" %F{117}%~%f%k"
else
    PRE_PROMPT="%(?.%F{104}.%F{212})%n%F{244}@%F{111}%m%F{250}(%*%)"
    SUF_PROMPT=" %F{135}%~%f%k"
fi

# PRE_PROMPT="%(?.%F{229}.%F{212})%n%F{248}@%F{222}%m%F{252}(%*%)"
# SUF_PROMPT=" %F{221}%~%f%k
# %# "

# refresh prompt
function zle-line-init zle-keymap-select {
    VIM_NORMAL="🤔"
    # VIM_INSERT="%F{231}in%f"
    VIM_INSERT=""
    
    PROMPT=$PRE_PROMPT"${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"$SUF_PROMPT
    
    if [ "$VPN_AC_CONNECTION" ]; then
        PROMPT="🌐"$PROMPT
    fi
    
    if [ "$VIRTUAL_ENV" ]; then
        SECOND_PROMPT="
(%F{047}`basename \"$VIRTUAL_ENV\"`%f) %# "
    else
        SECOND_PROMPT="
%# "
    fi

    PROMPT=$PROMPT$SECOND_PROMPT

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# git status
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{230}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{169}+"
zstyle ':vcs_info:*' formats "%F{195}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# clipboard
if which pbcopy >/dev/null 2>&1 ; then
    alias cbc='pbcopy' # Mac
    alias cbp='pbpaste'
elif which xsel >/dev/null 2>&1 ; then
    alias cbc='xsel --clipboard --input ' # Linux
    alias cbp='xsel --clipboard --output'
fi

# export
export EDITOR=vim

cdpath=(~)

source ~/.zsh_local

