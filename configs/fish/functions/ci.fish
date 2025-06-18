function ci --wraps='sh /home/abe/lib/work/docker/scripts/ci.sh' --wraps='clear && sh /home/abe/lib/work/docker/scripts/ci.sh' --description 'alias ci=clear && sh /home/abe/lib/work/docker/scripts/ci.sh'
  clear && sh /home/abe/lib/work/docker/scripts/ci.sh $argv
        
end
