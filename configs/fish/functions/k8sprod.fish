function k8sprod --wraps='kubectl config use-context admin@k8s-prod' --description 'alias k8sprod=kubectl config use-context admin@k8s-prod'
  kubectl config use-context admin@k8s-prod $argv
        
end
