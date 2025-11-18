local wezterm = require("wezterm")

return {
	-- 폰트
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font", -- 코드/영어
		{ family = "D2CodingLigature Nerd Font", style = "Normal" }, -- 한글
		"Noto Color Emoji", -- 이모지
	}),

	-- 폰트 크기 & 행간
	font_size = 17.0,
	line_height = 1.1,

	-- 내부 여백 제거
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- 테마
	color_scheme_dirs = { os.getenv("HOME") .. "/vimrc-boilerplate/wezterm" },
	color_scheme = "solarized-osaka",

	-- 투명도
	window_background_opacity = 0.90,

	-- 시작할 때 창 크기 (열 x 행)
	initial_cols = 120, -- 너비 (열)
	initial_rows = 40, -- 높이 (행)

	keys = {
		-- 전체화면 전환 (Cmd + Enter)
		{
			key = "Enter",
			mods = "CMD",
			action = wezterm.action.ToggleFullScreen,
		},
		-- 스크롤 올리기 (Ctrl + Cmd + p)
		{
			key = "p",
			mods = "CTRL|CMD",
			action = wezterm.action.ScrollByPage(-1), -- -1이면 위로 스크롤
		},
		-- 스크롤 내리기 (Ctrl + Cmd + n)
		{
			key = "n",
			mods = "CTRL|CMD",
			action = wezterm.action.ScrollByPage(1), -- 1이면 아래로 스크롤
		},
	},
}
