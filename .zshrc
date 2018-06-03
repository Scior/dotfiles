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
# if ls --color=auto >/dev/null 2>&1 ; then 
#     alias l='ls -ltr --color=auto'
#     alias la='ls -la --color=auto'
#     alias ll='ls -l --color=auto'
# elif ls -G >/dev/null 2>&1 ; then 
#     alias l='ls -ltrG'
#     alias la='ls -laG'
#     alias ll='ls -lG'
# else
    alias l='ls -ltr'
    alias la='ls -la'
    alias ll='ls -l'
# fi

alias so='source'
alias soz='source ~/.zshrc'

alias c='cdr'
alias g='grep --color=auto'

## vim
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'

## git
alias ga='git add'
alias gs='git status'
alias gc='git commit'
alias gb='git branch'
alias gp='git push'

## perl
alias p='perl'
alias pe='perl -e'
alias ppe='perl -pe'
alias pne='perl -ne'

# prompt text
if [ "$SSH_CONNECTION" ]; then
    PROMPT='%n@%m $ '
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
if [ -x "`which pbcopy`" ]; then
    alias cbc='pbcopy' # Mac
    alias cbp='pbpaste'
elif [ -x "`which xsel`" ]; then
    alias cbc='xsel --clipboard --input ' # Linux
    alias cbp='xsel --clipboard --output'
fi

# export
export EDITOR=vim

cdpath=(~)

# others
eval "$(rbenv init -)"
