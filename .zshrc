
autoload -U colors && colors
PS1="%{$fg_bold[red]%}%m %{$fg[cyan]%}%~%{$reset_color%}%(!.#.$) "

PATH=/Users/alex/bin/:/Users/alex/.gem/ruby/1.8/bin:/usr/local/mysql/bin:/opt/subversion/bin:/usr/local/bin:$PATH

set -o vi
setopt autocd
unsetopt correct_all

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
