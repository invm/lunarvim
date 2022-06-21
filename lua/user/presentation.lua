-- Markdown Presentation functions

-- Start of on the first first of your Presentation, 
-- click F4 to go to the next slide, F3 to back to the previous
-- F9 to reset the presentation, can init on any slide

local EXT = 'md'

global = {
	index = 0,
	path = '',
	glow_open = false,
}

function reset_presentation()
	global.index = 0
	global.path = ''
	global.glow_open = false
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- returns name of current open buffer
function filename(path)
	return path:match("[^/]*.$")
end

-- returns path to current open buffer
function filepath(path) 
	return path:match[[^@?(.*[\/])[^\/]-$]]
end

function prev_slide() 
	if global.path == '' then
		global.path = filepath(vim.fn.expand('%')) 
	end

	local prev_idx = global.index - 1
	local prev = global.path .. prev_idx .. '.' .. EXT
	local exists = file_exists(prev)
	if exists then
		open_file(prev)
		global.index = prev_idx
	end 
end

function next_slide() 
	if global.path == '' then
		global.path = filepath(vim.fn.expand('%')) 
	end
	--
	local next_idx = global.index + 1
	local next = global.path .. next_idx .. '.' .. EXT
	local exists = file_exists(next)
	if exists then 
		open_file(next)
		global.index = next_idx
	end 
end

function open_file(file)
	if global.glow_open == true then
		vim.cmd(':Glow')
		global.glow_open = false
	end
	vim.cmd(':e ' .. file)
	if global.glow_open == false then
		vim.cmd(':Glow')
		vim.cmd(t('normal <C-w>|<CR>'))
		vim.cmd(t('normal <C-w>_<CR>'))
		global.glow_open = true
	end
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end



