return {
	{
		"folke/flash.nvim",
		vscode = true,
		opts = {
			modes = {
				-- options used when flash is activated through
				-- `f`, `F`, `t`, `T`, `;` and `,` motions
				char = {
					jump_labels = true,
					multi_line = true,
				},
			},
		},
	},
}
