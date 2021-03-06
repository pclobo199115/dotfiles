# _______| |__  _ __ ___
#|_  / __| '_ \| '__/ __|
# / /\__ \ | | | | | (__
#/___|___/_| |_|_|  \___|

# Enable Colors and Prompt
	autoload -Uz promptinit
	promptinit
	prompt pure

# Autocd
    setopt autocd

# History
	HISTFILE="$ZDOTDIR/.history"
	HISTSIZE='10000'
	SAVEHIST='10000'

# Basic Auto/Tab complete:
	autoload -U compinit
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)		# Include hidden files.

# vi Mode
	bindkey -v
	export KEYTIMEOUT=1

# Use vim Keys in Tab Complete Menu:
	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -v '^?' backward-delete-char

# Change Cursor Shape for Different vi Modes.
	function zle-keymap-select {
	  if [[ ${KEYMAP} == vicmd ]] ||
	     [[ $1 = 'block' ]]; then
	    echo -ne '\e[1 q'
	  elif [[ ${KEYMAP} == main ]] ||
	       [[ ${KEYMAP} == viins ]] ||
	       [[ ${KEYMAP} = '' ]] ||
	       [[ $1 = 'beam' ]]; then
	    echo -ne '\e[5 q'
	  fi
	}
	zle -N zle-keymap-select
	zle-line-init() {
	    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	    echo -ne "\e[5 q"
	}
	zle -N zle-line-init
	echo -ne '\e[5 q' # Use beam shape cursor on startup.
	preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use beam shape cursor on startup
	echo -ne '\e[5 q'
	preexec() { echo -ne '\e[5 q' ;}

# Shortcuts for shell commands
	bindkey -s "^z" "clear\n"
	bindkey -s "^h" "history\n"

# Load aliases and shortcuts
	source $HOME/.config/alias

# * means all files excluding hidden ones
	setopt glob

# zsh autosuggestions
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting; should be last
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
