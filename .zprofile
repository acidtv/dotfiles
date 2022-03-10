PATH=/usr/local/mysql/bin:/usr/local/bin:/home/alex/.composer/vendor/bin:~/.npm-global/bin:/home/alex/bin/PathPicker-master/:$PATH

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
