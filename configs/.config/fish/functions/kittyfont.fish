function kittyfont --wraps='kitty list-fonts | grep -i "SFMono"' --description 'alias kittyfont=kitty list-fonts | grep -i "SFMono"'
  kitty list-fonts | grep -i "SFMono" $argv
        
end
