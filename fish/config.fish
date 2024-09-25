set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

# Check if any keys are already added
if not ssh-add -l > /dev/null 2>&1
    # List of keys to add
    set keys_to_add ~/.ssh/id_ed25519_arch ~/.ssh/id_ed25519_work

    # Loop through the keys and add them
    for key in $keys_to_add
        if test -f $key
            ssh-add $key
        else
            echo "Warning: $key does not exist"
        end
    end
end


function fzf --wraps="fzf"
  set -Ux FZF_DEFAULT_OPTS "
        --color=fg:#908caa,bg:#232136,hl:#ea9a97
        --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
        --color=border:#44415a,header:#3e8fb0,gutter:#232136
        --color=spinner:#f6c177,info:#9ccfd8
        --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"  
  command fzf
end

starship init fish | source
