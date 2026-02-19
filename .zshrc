#------------------------#
#  Zsh Settings
#  Author: Suita Fujino
#------------------------#

autoload -Uz colors
colors

autoload -Uz compinit
compinit

setopt share_history
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt correct
setopt auto_cd
setopt auto_pushd
export EDITOR=vim
export HOMEBREW_NO_AUTO_UPDATE=1

#-----------------
#  Key Binds
#-----------------
bindkey -v 
bindkey "jk" vi-cmd-mode

bindkey "^r" history-incremental-pattern-search-backward
# bindkey "^s" history-incremental-pattern-search-forward

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

#-----------------
#  Aliases
#-----------------
source ~/.aliasrc

alias -g th='(){tail -$1 | head -$2}'
alias -g h='(){head -$1}'
alias -g t='(){tail -$1}'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

#-----------------
#  Refresh Prompt Message
#-----------------
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

    # RPROMPT
    RPROMPT='${vcs_info_msg_0_}'
    if [ -e "`git rev-parse --git-dir 2>/dev/null`/hooks/pre-push" ]; then
        RPROMPT="🔒"$RPROMPT
    fi
    BRANCH="`git rev-parse --abbrev-ref HEAD 2>/dev/null`"
    if [ "$BRANCH" ]; then
        STASHED="`git stash list | grep $BRANCH | head -1 | awk -F: '{print $1}'`"
        if [ "$STASHED" ]; then
          RPROMPT=$STASHED@$RPROMPT
        fi
    fi

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

#-----------------
#  Git Status
#-----------------
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{230}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{169}+"
zstyle ':vcs_info:*' formats "%F{195}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# man deco
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

cdpath=(~)

# Read Local Settings
source ~/.zsh_local

