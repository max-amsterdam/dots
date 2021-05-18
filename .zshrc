source /etc/profile
autoload -U colors && colors

PROMPT="%{$fg[red]%}>%{$fg[yellow]%}>%{$fg[green]%}> "
RPROMPT="%~%"

export GOPATH=~/code/go:~/school/dist_systems/4113:/usr/lib/go
export PATH=${PATH}:~/code/scripts:~/code/scripts/potato:${HOME}/.local/bin:~/code/go/bin
export PYTHONPATH=${PYTHONPATH}:${HOME}/code
export LLVM_HOME=~/school/plt/hw2.1/llvm-project

export EDITOR=nvim

export LANG=en_US.UTF-8
export SHELL=/bin/zsh

setopt autocd # Automatically cd into typed dir

#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY

# basic autotab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias ls='ls -hNl --color=auto --group-directories-first'
alias ll='ls -al --color=auto'
alias grep="grep --color=auto"
alias pretty="python -m json.tool"

bindkey -s '^p' 'nvim -o $(fzf -m)\n'

wal-tile() {
	wal -n -i "$@" 
	feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}

wal-tile-light() {
	wal -n -l -i "$@" 
	feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}

sc () {
	echo $@ | socat - UNIX-CONNECT:/tmp/spotifyd 2>/dev/null
}


# Vi mode stuff
bindkey -v
export KEYTIMEOUT=1
function zle-keymap-select {
	if [ $KEYMAP = vicmd ]; then
		printf "\033[2 q"
	else
		printf "\033[4 q"
	fi
}

zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf '\033[4 q'
}
zle -N zle-line-init


# FZF settings
# source /usr/share/fzf/completion.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER='**'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s /home/mamsterdam/.autojump/etc/profile.d/autojump.sh ]] && source /home/mamsterdam/.autojump/etc/profile.d/autojump.sh

# [ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }

# NNN 
NNN_COLORS=3

autoload edit-command-line; zle -N edit-command-line

# fzf sourcing
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 
# Load syntax highlighting. Supposed to be last
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
# substring history search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=251'
