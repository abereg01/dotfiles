function start_agent
    echo "Initializing new SSH agent..."
    ssh-agent -c | sed 's/^echo/set -x/' | source
    echo "succeeded"
    ssh-add
end

if not set -q SSH_AUTH_SOCK
    if not ps -U $USER | grep ssh-agent > /dev/null
        start_agent
    else
        setenv SSH_AUTH_SOCK (find /tmp -type s -name agent.\* 2>/dev/null | head -1)
        setenv SSH_AGENT_PID (ps -U $USER | grep ssh-agent | awk '{print $1}')
    end
end

