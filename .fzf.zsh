# Setup fzf
# ---------
if [[ ! "$PATH" == */home/alex/.vim/bundle/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/alex/.vim/bundle/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/alex/.vim/bundle/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/alex/.vim/bundle/fzf/shell/key-bindings.zsh"
