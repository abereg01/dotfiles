function remove --wraps='sudo apt autoremove' --description 'alias remove=sudo apt autoremove'
  sudo apt autoremove $argv
        
end
