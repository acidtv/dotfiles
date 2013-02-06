
setopt PROMPT_SUBST
autoload -U colors && colors

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
		echo "%{$fg_bold[blue]%}$(hg_branch)%{$reset_color%}"
    fi
}

PS1="%{$fg_bold[red]%}%m %{$fg[cyan]%}%~%{$reset_color%}%(!.#.$) "
RPROMPT='☿:$(hg_prompt)'

set -o vi
setopt autocd
unsetopt correct_all

alias ...='cd ../..'
alias l='ls -alhG'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

# Bacward search in the shell history with <C-r>
# bindkey ^r  history-incremental-search-backward
setopt hist_ignore_all_dups

# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward

# [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
# [[ "$terminfo[kcuu1]" == " O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history

export SVN_EDITOR=vim
export MAGICK_HOME="$HOME/bin/imagemagick/"
export PATH="$MAGICK_HOME/bin:$PATH:/Users/alex/pear/bin"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"
