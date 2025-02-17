require("riznykleo")
local function safe_replace_commands()
	local commands = {
		"%s/UNASSIGNED/DOING/g",
	}

	for _, cmd in ipairs(commands) do
		vim.cmd("silent! " .. cmd)
	end
end

-- Create a Neovim command to call the function
vim.api.nvim_create_user_command("SafeReplace", safe_replace_commands, {})
