function upd --wraps='sudo apt update && sudo apt upgrade -y' --description 'alias upd=sudo apt update && sudo apt upgrade -y'
  sudo apt update && sudo apt upgrade -y $argv
        
end
