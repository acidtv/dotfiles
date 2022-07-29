
setopt PROMPT_SUBST
autoload -U colors && colors

# load completion system
autoload -U compinit && compinit

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# when pressing tab auto insert first match from menu
setopt menu_complete

# extended globbing, needed to find parent .hg dir
setopt extended_glob

# select file in completion menu
zstyle ':completion:*' menu select

function git_prompt() {
	if [[ $EUID -eq 0 ]]; then
		return
	fi

	# use globbing to find parent .hg dir
	git_dir=`echo (../)#.git(N/Y1:h)`

	if [ -z $git_dir ]; then
		return
	fi

	branch=`git branch --show-current`

	if [ $branch ]; then
		echo "⎇: %{$fg_bold[blue]%}$branch%{$reset_color%}"
	fi
}
function hg_prompt() {
	if [[ $EUID -eq 0 ]]; then
		return
	fi

	# use globbing to find parent .hg dir
	hg_dir=`echo (../)#.hg(N/Y1:h)`

	if [ -z $hg_dir ]; then
		return
	fi

	branch=`cat $hg_dir/.hg/branch 2> /dev/null`
	bookmark=`cat $hg_dir/.hg/bookmarks.current 2> /dev/null`

    if [ $branch ]; then
		echo "☿:%{$fg_bold[blue]%}$bookmark:$branch%{$reset_color%}"
    fi
}

# fix find!
ffind() {
	find . -name "*$1*"
}

PS1='%{$fg_bold[red]%}%m %{$fg[cyan]%}%$(( $COLUMNS/25 ))c%{$reset_color%}%(!.#.$) '
RPROMPT='$(git_prompt) %T'

set -o vi
setopt autocd
setopt autopushd
unsetopt correct_all

alias ...='cd ../..'
alias l='ls --color=always -alh'
alias ll='ls --color=always -alh'
alias b='cd -'
alias pd='popd'
alias fixdbus='export $(dbus-launch)'
alias ip='ip -c'
alias ipa='ip -br -c a'
alias prettyjson='python3 -m json.tool'
alias de='docker-compose exec'
alias dtu='export CDIR=${PWD##*/}; docker-compose exec dev $CDIR/vendor/bin/phpunit -c $CDIR/test --colors=always --testsuite "Objectenregister Unit Test Suite"'

alias git-list-gone='git branch -vv | grep ": gone" |  grep -v "\*" | cut -f3 -d" " | xargs -r git branch -D'
alias git-remove-gone='git-list-gone | xargs -r git branch -D'

# nvim is being unstable...
#alias vi='nvim'
#alias vim='nvim'
#alias view='nvim -R'
#alias svim='sudo nvim'

alias gd='git diff HEAD | view -'
alias gs='git status'
alias gb='git branch -vv'
alias hgd='hg diff -p | nvim -R -'
alias hgs='hg st -S'
alias hgio='echo "Incoming:"; hg in --quiet -T "{author}@{branch}: {desc}\n"; echo "\nOutgoing:"; hg out --quiet'

# Bacward search in the shell history with <C-r>
# bindkey ^r  history-incremental-search-backward
setopt hist_ignore_all_dups

export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#append into history file
setopt INC_APPEND_HISTORY
#add timestamp for each entry
setopt EXTENDED_HISTORY

# set timeout shorter so switching between vi modes is faster
export KEYTIMEOUT=2

# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward

# [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
# [[ "$terminfo[kcuu1]" == " O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history

# debian fix: move cursor to end of line when browsing history
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# history search with page-up / -down
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# run mac specific conf
if [[ `uname` != 'Linux' ]]; then
   source ~/code/dotfiles/.zshrc.mac
fi

#if grep -q "ColorForeground=#839496" ~/.config/xfce4/terminal/terminalrc; then
#	export LIGHT_MODE=dark
#else
#	export LIGHT_MODE=light
#fi

export TERM=xterm-256color
export SVN_EDITOR=nvim
export EDITOR=nvim
export HGEDITOR="nvim +Hgdiff"
export GIT_EDITOR="nvim +Gitdiff"
export MAGICK_HOME="$HOME/bin/imagemagick/"
#export PATH="$MAGICK_HOME/bin:$PATH:/Users/alex/pear/bin"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"
#export PYTHONPATH=$PYTHONPATH:/home/alex/code/caffe/python
export GOBIN=/home/alex/bin

export LIGHT_MODE=dark

# Android SDK envs for react-native
#export ANDROID_HOME=$HOME/Android/Sdk
#export PATH=$PATH:$ANDROID_HOME/emulator
#export PATH=$PATH:$ANDROID_HOME/tools
#export PATH=$PATH:$ANDROID_HOME/tools/bin
#export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=~/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# include fzf (https://github.com/junegunn/fzf) keyboard shortcuts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# execute previous command and pipe through fpp
alias pfpp='`fc -ln -1` | fpp'

if [ -f "~/.zshrc.local" ]; then
	source ~/.zshrc.local
fi

function ssh_reverse() {
	if [ -z "$1" ]
	then
		echo 'Usage: ssh_reverse <local_forward_to>'
		return
	fi
	
	ssh -N -R :8080:$1:80 kurkuma.qwoot.net &
	echo 'Connected, visit: http://<site>.qwoot.net:8080'
}

function ssh() {
	/usr/bin/ssh -t $@ -- "tmux attach || tmux || /bin/bash"
}

_fzf_complete_git() {
    ARGS="$@"
    if [[ $ARGS == 'git ci'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
			git status --porcelain | rev | cut -d" " -f1 | rev 
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}
