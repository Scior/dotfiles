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
alias lst='ls -ltr'
alias l='ls -ltr'
alias la='ls -la'
alias ll='ls -l'

alias so='source'
alias soz='source ~/.zshrc'

alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'

alias c='cdr'
alias g='grep --color=auto'

alias gs='git status'
alias gc='git commit'
alias gb='git branch'
alias gp='git push'

alias pe='perl -e'
alias ppe='perl -pe'
alias pne='perl -ne'

# set prompt text
PROMPT="%(?.%F{104}.%F{212})%n%F{244}@%F{111}%m%F{250}(%*%) %F{135}%~%f
%# "

# git
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

# others
eval "$(rbenv init -)"
