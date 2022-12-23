-- Color table for highlights
-- stylua: ignore
local colors = {
  green    = '#50C878',
  orange   = '#FF8800',
  red      = '#ec5f67',
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"filename",
				path = 0,
			},
		},
		lualine_c = {
			{
				"diff",
				symbols = { added = " ", modified = "柳", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
			},
		},
		lualine_x = { "searchcount" },
		lualine_y = {},
		lualine_z = { "diagnostics" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
