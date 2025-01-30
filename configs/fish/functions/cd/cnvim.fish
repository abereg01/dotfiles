function cnvim --wraps='cd ~/dotfiles/configs/nvim/ && ls' --description 'alias cnvim=cd ~/dotfiles/configs/nvim/ && ls'
  cd ~/dotfiles/configs/nvim/ && ls $argv
        
end
