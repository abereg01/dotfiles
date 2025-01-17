function ..s --wraps='cd $HOME/lib/scripts/' --wraps='cd $HOME/lib/scripts/ && ll' --description 'alias ..s=cd $HOME/lib/scripts/ && ll'
  cd $HOME/lib/scripts/ && ll $argv
        
end
