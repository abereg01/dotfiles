set fish_greeting

# Load and run SSH agent setup
source $HOME/dotfiles/fish/ssh_agent.fish

# Source the color configuration
source ~/.config/fish/fzfcolors.fish

function fzf --wraps="fzf"
  set -Ux FZF_DEFAULT_OPTS "
        --color=fg:$color_fg,bg:$color_bg,hl:$color_hl
        --color=fg+:$color_fg_plus,bg+:$color_bg_plus,hl+:$color_hl_plus
        --color=border:$color_border,header:$color_header,gutter:$color_gutter
        --color=spinner:$color_spinner,info:$color_info
        --color=pointer:$color_pointer,marker:$color_marker,prompt:$color_prompt"  
  command fzf
end

starship init fish | source
