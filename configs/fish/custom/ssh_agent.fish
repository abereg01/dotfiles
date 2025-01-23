function start_ssh_agent
    eval (ssh-agent -c | sed 's/^echo/#echo/')
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

function load_ssh_agent
    if test -n "$SSH_AGENT_PID"
        ps -p $SSH_AGENT_PID >/dev/null
        if test $status -eq 0
            return
        end
    end

    if test -f ~/.ssh/agent.env
        source ~/.ssh/agent.env >/dev/null
        ps -p $SSH_AGENT_PID >/dev/null
        if test $status -eq 0
            return
        end
    end

    start_ssh_agent
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/.ssh/agent.env
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> ~/.ssh/agent.env
end

function add_ssh_keys
    set keys_to_add ~/.ssh/id_ed25519_arch ~/.ssh/id_ed25519_work

    for key in $keys_to_add
        if test -f $key
            ssh-add -l | grep -q (ssh-keygen -lf $key | awk '{print $2}')
            if test $status -ne 0
                ssh-add $key
            end
        else
            echo "Warning: $key does not exist"
        end
    end
end

if status is-interactive
    load_ssh_agent
    add_ssh_keys
end
