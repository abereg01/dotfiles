function ls --wraps='exa -ll --color=always --group-directories-first' --wraps='exa -lah --color=always --group-directories-first' --wraps='exa -lh --color=always --group-directories-first' --description 'alias ls=exa -lh --color=always --group-directories-first'
  exa -lh --color=always --group-directories-first $argv
        
end
