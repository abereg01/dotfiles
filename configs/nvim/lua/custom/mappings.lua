local M = {}

M.docker = {
 n = {
   ["<leader>dc"] = { "<cmd>!docker-compose up -d<CR>", "Docker Compose Up" },
   ["<leader>ds"] = { "<cmd>!docker service ls<CR>", "List Services" },
   ["<leader>dn"] = { "<cmd>!docker node ls<CR>", "List Nodes" },
   ["<leader>dl"] = { "<cmd>!docker service logs<CR>", "Service Logs" }
 }
}

M.ssh = {
 n = {
   ["<leader>sr"] = { "<cmd>SSHRemote DSM01<CR>", "SSH Remote" },
   ["<leader>sl"] = { "<cmd>SSHList<CR>", "List SSH Connections" },
   ["<leader>sc"] = { "<cmd>SSHConfig<CR>", "Edit SSH Config" }
 }
}

return M
