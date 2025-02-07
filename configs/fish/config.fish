set fish_greeting
set fish_confirm_exit 0

set fish_function_path $fish_function_path ~/.config/fish/functions/cd
set fish_function_path $fish_function_path ~/.config/fish/functions/scripts
set fish_function_path $fish_function_path ~/.config/fish/functions/software

set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# Source custom configurations
source ~/.config/fish/custom/fzfcolors.fish
source ~/.config/fish/custom/lf.fish
source ~/.config/fish/custom/fzfcolorapply.fish

# Initialize starship
starship init fish | source

rxfetch
