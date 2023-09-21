function ll --wraps='exa -lah --color=always --group-directories-first' --description 'alias ll=exa -lah --color=always --group-directories-first'
  exa -lah --color=always --group-directories-first $argv
        
end
