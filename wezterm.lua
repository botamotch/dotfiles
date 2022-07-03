local wezterm = require 'wezterm';

return {
  initial_cols = 100,
  initial_rows = 40,
  font_size = 10.0,
  -- color_scheme = "zenwritten_dark",
  color_scheme = "UltraDark",
  -- color_scheme = "Wryan",
  font = wezterm.font("Noto Sans Mono CJK JP"),
  use_fancy_tab_bar = false,
  window_background_opacity = 0.95,
  text_background_opacity = 0.70,
}
