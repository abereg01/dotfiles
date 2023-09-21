function dot --wraps='cd $HOME/dotfiles/.config && ls' --description 'alias dot=cd $HOME/dotfiles/.config && ls'
  cd $HOME/dotfiles/.config && ls $argv
        
end
