function gbc --wraps='go mod tidy && go build -o $HOME/clementine/bin/clementine cmd/portal/*.go' --description 'alias gbc=go mod tidy && go build -o $HOME/clementine/bin/clementine cmd/portal/*.go'
  go mod tidy && go build -o $HOME/clementine/bin/clementine cmd/portal/*.go $argv
        
end
