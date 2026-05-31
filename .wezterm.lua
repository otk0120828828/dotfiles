local wezterm = require 'wezterm'
local mux = wezterm.mux

----------------------------------------------------
-- 起動時の画面分割設定（横3列に均等分割）
----------------------------------------------------
wezterm.on('gui-startup', function(cmd)
  -- 1つ目の画面（左側）
  local tab, pane_left, window = mux.spawn_window(cmd or {})
  
  -- 2つ目の画面を右側に50:50で分割
  local pane_right_top = pane_left:split({ direction = 'Right', size = 0.5 })
  
  -- 右側の画面を「上下」に50:50で分割して3つ目の画面を作る
  local pane_right_bottom = pane_right_top:split({ direction = 'Bottom', size = 0.5 })
end)

-- config_builderを使うと、エラー時のフォールバックが効くため安全です
local config = wezterm.config_builder()

-- アクティブウィンドウの切り替えコマンド
local act = wezterm.action
config.keys = {
  -- Alt + 矢印キー でアクティブなペインを移動
  { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  -- Ctrl + Alt + Shift + "+" で 上下分割（現在のペインの右側に作成）
  {
    key = '+',
    mods = 'CTRL|ALT|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Ctrl + Alt + ";" で 左右分割（現在のペインの右側に作成）
  {
    key = ';',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

----------------------------------------------------
-- 1. 背景の透過設定
----------------------------------------------------
-- 0.0（透明）〜 1.0（不透明）の間で指定します
config.window_background_opacity = 0.85

-- ちなみに、すりガラス効果（ブラー）を使いたい場合は以下も有効にしてください
-- config.win32_system_backdrop = 'Acrylic' 

----------------------------------------------------
-- 2. 起動時のデフォルトをWSL (Ubuntu) にする
----------------------------------------------------
-- WezTermは自動的にWSLを認識し、 'WSL:ディストリビューション名' というドメインを作ります
config.default_domain = 'WSL:Ubuntu-24.04'

----------------------------------------------------
-- 3. その他の基本設定（おすすめ）
----------------------------------------------------
-- カラーテーマ（WezTermは数多くのテーマを内蔵しています）
config.color_scheme = 'Tokyo Night'

-- フォント設定（Poderline対応フォントなどがおすすめ）
-- config.font = wezterm.font 'Cica' 
config.font_size = 12.0

-- タブバーのデザインを少し見やすくする
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

return config
