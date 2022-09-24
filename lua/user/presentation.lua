-- Markdown Presentation functions

-- Start of on the first first of your Presentation, 
-- click F4 to go to the next slide, F3 to back to the previous
-- F9 to reset the presentation, can init on any slide

local EXT = 'md'

local state = {
	index = 0,
	path = '',
	glow_open = false,
}

function Reset_presentation()
	state.index = 0
	state.path = ''
	state.glow_open = false
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- returns name of current open buffer

function Prev_slide()
	if state.path == '' then
		state.path = Presentation.filepath(vim.fn.expand('%'))
	end

	local prev_idx = state.index - 1
	local prev = state.path .. prev_idx .. '.' .. EXT
	local exists = Presentation.file_exists(prev)
	if exists then
		Presentation.open_file(prev)
		state.index = prev_idx
	end
end

function Next_slide()
	if state.path == '' then
		state.path = Presentation.filepath(vim.fn.expand('%'))
	end
	--
	local next_idx = state.index + 1
	local next = state.path .. next_idx .. '.' .. EXT
	local exists = Presentation.file_exists(next)
	if exists then
		Presentation.open_file(next)
		state.index = next_idx
	end
end

Presentation = {}

function Presentation.filename(path)
	return path:match("[^/]*.$")
end

-- returns path to current open buffer
function Presentation.filepath(path)
	return path:match[[^@?(.*[\/])[^\/]-$]]
end

function Presentation.open_file(file)
	if state.glow_open == true then
		vim.cmd(':Glow')
		state.glow_open = false
	end
	vim.cmd(':e ' .. file)
	if state.glow_open == false then
		vim.cmd(':Glow')
		vim.cmd(t('normal <C-w>|<CR>'))
		vim.cmd(t('normal <C-w>_<CR>'))
		state.glow_open = true
	end
end

function Presentation.file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end



