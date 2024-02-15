function gc --wraps='git clone' --wraps=git\ commit\ -m\ \'save\' --description alias\ gc=git\ commit\ -m\ \'save\'
  git commit -m 'save' $argv
        
end
