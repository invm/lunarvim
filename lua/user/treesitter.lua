local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

--[[ require'nvim-treesitter.install'.compilers = { "gcc" } -- might be needed on mac with m1 chip ]]

configs.setup({
	ensure_installed = "", -- one of "all" or a list of languages
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
