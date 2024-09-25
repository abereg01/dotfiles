function shutd --wraps='shutdown -h now' --description 'alias shutd=shutdown -h now'
  shutdown -h now $argv
        
end
