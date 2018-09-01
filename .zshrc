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

source ~/.aliasrc

alias -g th='(){tail -$1 | head -$2}'
alias -g h='(){head -$1}'
alias -g t='(){tail -$1}'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

function pk() {
    ps ax | grep $1 | grep -v 'grep' | awk '{print $1}' | xargs kill -9
}

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

# export
export EDITOR=vim

cdpath=(~)

source ~/.zsh_local

