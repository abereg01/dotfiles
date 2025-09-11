function ceph --wraps='kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash' --description 'alias ceph=kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash'
  kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash $argv
        
end
