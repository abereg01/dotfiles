function fsumount --wraps='fusermount -u ~/remote-server' --description 'alias fsumount=fusermount -u ~/remote-server'
  fusermount -u ~/remote-server $argv
        
end
