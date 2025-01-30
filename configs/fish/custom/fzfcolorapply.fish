# Function to apply colors to fzf
function fzf
     command fzf \
        --color=fg:$color_fg,bg:$color_bg,hl:$color_hl \
        --color=fg+:$color_fg_plus,bg+:$color_bg_plus,hl+:$color_hl_plus \
        --color=border:$color_border,header:$color_header,gutter:$color_gutter \
        --color=spinner:$color_spinner,info:$color_info \
        --color=pointer:$color_pointer,marker:$color_marker,prompt:$color_prompt \
        $argv
end
