# CLAUDE.md

複数マシンで共有するための dotfiles リポジトリ(`~/Git/dotfiles`)。設定ファイルは本リポジトリを実体とし、各アプリの設定場所にシンボリックリンクを張って使う。git で同期することで、マシン間で似た使用感を保つ。

## 重点的にメンテナンスしているもの
Neovim, zsh, tmux, alacritty, nb。それ以外(vim, helix, wezterm, ghostty, zed, hyprland, rofi, wofi, conky, Firefox, texlive など)はメンテナンスされていないものもあるため、頼まれない限り積極的に触らない。

## マシン
- マシン1: Linux (Arch) / GNOME Wayland / Dell XPS 14
- マシン2: MacBook Pro (macOS)

編集時は両OSで動くかを意識する(パス、`pbcopy`/`wl-copy`、`sed -i` や `date` など BSD/GNU 差異、Homebrew のパス等)。OS依存の設定は分岐させるか、その旨を明記する。

## 配置方法(シンボリックリンク)
リンク先は明文化されていなかったため、現状確認できたものを記す。リポジトリ側のファイル → リンク先:

| リポジトリ | リンク先 |
|---|---|
| `zsh/zshrc` | `~/.zshrc` |
| `zsh/zprofile` | `~/.zprofile` |
| `zsh/zshenv` | `~/.zshenv`(想定) |
| `tmux/tmux.conf` | `~/.tmux.conf`(`common.conf` / `toybox.conf` は併用) |
| `nvim/init.lua` | `~/.config/nvim/init.lua` |
| `nvim/lsp/*.lua` | `~/.config/nvim/lsp/*.lua`(ファイル単位) |
| `nvim/lua/*.lua` | `~/.config/nvim/lua/*.lua`(ファイル単位) |
| `alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `nb/nbrc` | `~/.nbrc` |
| `starship/starship.toml` | `~/.config/starship.toml` |

- nvim の `lsp/` `lua/` はディレクトリごとではなくファイル単位でリンクされている。新しいファイルを追加したらリンクも必要。
- `install.sh` に一部のリンク作成コマンドがあるが古く、実態と一致しない箇所がある(例: rofi のパスが壊れている)。信頼しすぎず、`ls -la ~/.config` 等で実際のリンクを確認すること。
- 新しい設定ファイルを追加/移動したら、リンク先をこの表にも追記する。

## ディレクトリ・ファイルの注意点
- `nvim/`: `init.lua` が本体(Neovim 0.11+ 形式の `lsp/*.lua` を使用、プラグイン管理は lazy.nvim、`lazy-lock.json` は `~/.config/nvim` 側にある)。`init.vim` / `dein.toml` は旧構成。
- `nb/`: `nbrc`、`nb-fzf.sh`、`post-commit`(nb の git hook。ノートのコミット時に `~/.nb/home/README.md` を生成)、`generate-readme.sh`(docsify 用の索引生成)。シェルスクリプトは `#!/bin/sh` と bash 記法が混在しているので、編集時は shebang と構文の整合に注意。
- `README.md`: 古い Vim 中心のメモ。構成の正とはしない。
- ドキュメント・コメント・コミットメッセージは日本語/英語混在。既存ファイルの流儀に合わせる。

## 作業ルール
- 設定を変更するときは、リポジトリ内のファイルを編集する(リンク先ではなく)。リンク先は実体への参照なので同じ内容になる。
- 既存のコメント量・命名・インデントに合わせる。無関係なリファクタや整形はしない。
- 動作確認は可能な範囲で行う(`zsh -n zsh/zshrc`、`tmux source-file`、`nvim --headless +q`、`alacritty` の設定パース等)。実機の反映が必要なものはユーザーに依頼する。
- コミットメッセージは `update <対象>` の短い形式(例: `update zshrc`, `update alacritty.toml (disable quit shortcut)`)。コミットはユーザーが求めたときのみ。
- 秘密情報(トークン、APIキー、個人パス以外の機微情報)を設定に書かない。
