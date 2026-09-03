local wezterm = require 'wezterm'
local mux = wezterm.mux

----------------------------------------------------
-- 起動時の画面分割＆全画面＆ディレクトリ設定
----------------------------------------------------
wezterm.on('gui-startup', function(cmd)
  -- 起動時に開きたいディレクトリのパスを変数に定義
  local workspace_dir = '/home/superotk/Ubnt_workspace'

  -- 1つ目の画面用のオプションに cwd を設定
  local window_opts = cmd or {}
  window_opts.cwd = workspace_dir

end)

-- config_builderを使うと、エラー時のフォールバックが効くため安全です
local config = wezterm.config_builder()

-- アクティブウィンドウの切り替えコマンド
local act = wezterm.action
config.keys = {
  { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  {
    key = '+',
    mods = 'CTRL|ALT|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = ';',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

----------------------------------------------------
-- 1. 背景の透過設定
----------------------------------------------------
config.window_background_opacity = 0.80
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

----------------------------------------------------
-- 2. 起動時のデフォルトをWSL (Ubuntu) にする
----------------------------------------------------
config.default_domain = 'WSL:Ubuntu-24.04'

----------------------------------------------------
-- カラー設定：ミニマルなダークグレー
----------------------------------------------------
config.colors = {
  -- 背景と通常文字
  foreground = '#D8D8D6',
  background = '#242526',

  -- カーソル
  cursor_bg = '#8FAEC4',
  cursor_fg = '#202122',
  cursor_border = '#8FAEC4',

  -- 選択範囲
  selection_fg = '#F0F0EE',
  selection_bg = '#465866',

  -- スクロールバーとペイン境界
  scrollbar_thumb = '#55565A',
  split = '#4A4B4E',

  -- 通常ANSIカラー
  ansi = {
    '#303134', -- black
    '#C76B6B', -- red: エラー
    '#7FA681', -- green: 成功、Git追加
    '#C49A55', -- yellow: 警告
    '#7297B5', -- blue: 情報、リンク
    '#A484AD', -- magenta
    '#72A2A2', -- cyan
    '#C9C9C6', -- white
  },

  -- 強調ANSIカラー
  brights = {
    '#747579', -- コメント、補助情報
    '#E08080', -- bright red
    '#95BF97', -- bright green
    '#DEB56A', -- bright yellow
    '#89AFCE', -- bright blue
    '#BD9BC7', -- bright magenta
    '#89BBBB', -- bright cyan
    '#F0F0ED', -- bright white
  },

  -- タブバー
  tab_bar = {
    background = '#1E1F20',

    active_tab = {
      bg_color = '#343538',
      fg_color = '#EEEEEB',
      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = '#1E1F20',
      fg_color = '#898A8C',
    },

    inactive_tab_hover = {
      bg_color = '#2B2C2E',
      fg_color = '#C8C8C5',
    },

    new_tab = {
      bg_color = '#1E1F20',
      fg_color = '#898A8C',
    },

    new_tab_hover = {
      bg_color = '#2B2C2E',
      fg_color = '#C8C8C5',
    },
  },

  -- Quick Select
  quick_select_label_bg = {
    Color = '#C49A55',
  },
  quick_select_label_fg = {
    Color = '#202122',
  },
  quick_select_match_bg = {
    Color = '#465866',
  },
  quick_select_match_fg = {
    Color = '#F0F0EE',
  },

  compose_cursor = '#A484AD',
}

----------------------------------------------------
-- 3. その他の基本設定（おすすめ）
----------------------------------------------------
config.font_size = 10
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

return config
