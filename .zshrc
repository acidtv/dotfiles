
setopt PROMPT_SUBST
autoload -U colors && colors

# load completion system
autoload -U compinit && compinit

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# when pressing tab auto insert first match from menu
setopt menu_complete

# select file in completion menu
zstyle ':completion:*' menu select

PATH=/Users/alex/bin/:/Users/alex/.gem/ruby/1.8/bin:/usr/local/mysql/bin:/opt/subversion/bin:/usr/local/bin:$PATH

function in_hg() {
	hg su > /dev/null 2>&1
	result=$?
    if [[ $result == 0 ]]; then
        echo 1
    fi
}

function hg_branch() {
	hg branch
}

function hg_prompt() {
    if [ $(in_hg) ]; then
		echo "☿:%{$fg_bold[blue]%}$(hg_branch)%{$reset_color%}"
    fi
}

# fix find!
ffind() {
	find . -name "*$1*"
}

PS1="%{$fg_bold[red]%}%m %{$fg[cyan]%}%~%{$reset_color%}%(!.#.$) "
RPROMPT='$(hg_prompt) %T'

set -o vi
setopt autocd
setopt autopushd
unsetopt correct_all

alias ...='cd ../..'
alias l='ls --color=always -alh'
alias b='cd -'
alias pd='popd'
alias hgd='hg di | view -'
alias hgs='hg st -S'

# Bacward search in the shell history with <C-r>
# bindkey ^r  history-incremental-search-backward
setopt hist_ignore_all_dups

# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward

# [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
# [[ "$terminfo[kcuu1]" == " O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history

# debian fix: move cursor to end of line when browsing history
[[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
[[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history

# run mac specific conf
if [[ `uname` != 'Linux' ]]; then
   source ~/code/dotfiles/.zshrc.mac
fi

export TERM=xterm-256color
export SVN_EDITOR=vim
export MAGICK_HOME="$HOME/bin/imagemagick/"
export PATH="$MAGICK_HOME/bin:$PATH:/Users/alex/pear/bin"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"
