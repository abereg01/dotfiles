function k8s --wraps='cd $HOME/lib/work/k8s/ && ls' --description 'alias k8s=cd $HOME/lib/work/k8s/ && ls'
  cd $HOME/lib/work/k8s/ && ls $argv
        
end
