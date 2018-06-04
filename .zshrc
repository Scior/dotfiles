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

alias so='source'
alias soz='source ~/.zshrc'

alias c='cdr'
alias g='grep --color=auto'
alias cl='clear'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

## vim
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'

## git
alias ga='git add'
alias gs='git status'
alias gc='git commit'
alias gb='git branch'
alias gp='git pull'
alias gpo='git push origin'
alias gl='git log'
alias glo='git log --oneline'
alias glf='git log --graph --branches --pretty=format:"%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset"'
alias gls='git log --oneline --stat --graph'

## perl
alias p='perl'
alias pe='perl -e'
alias ppe='perl -pe'
alias pne='perl -ne'

# prompt text
if [ "$SSH_CONNECTION" ]; then
    PROMPT="%(?.%F{085}.%F{212})%n%F{244}@%F{043}%m%F{250}(%*%) %F{117}%~%f
%# "
else
    PROMPT="%(?.%F{104}.%F{212})%n%F{244}@%F{111}%m%F{250}(%*%) %F{135}%~%f
%# "
fi

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

# others
# eval "$(rbenv init -)"
