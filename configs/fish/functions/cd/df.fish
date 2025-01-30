function df --wraps='cd ~/dotfiles/configs/ && ls' --description 'alias df=cd ~/dotfiles/configs/ && ls'
  cd ~/dotfiles/configs/ && ls $argv
        
end
