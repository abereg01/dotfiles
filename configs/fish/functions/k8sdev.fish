function k8sdev --wraps='kubectl config use-context admin@k8sdev' --description 'alias k8sdev=kubectl config use-context admin@k8sdev'
  kubectl config use-context admin@k8sdev $argv
        
end
