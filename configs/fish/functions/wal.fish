function wal --wraps='cd ~/lib/images/wappapers/ && ls' --wraps='cd ~/lib/images/wallpapers/ && ls' --description 'alias wal=cd ~/lib/images/wallpapers/ && ls'
  cd ~/lib/images/wallpapers/ && ls $argv
        
end
