#!/usr/bin/env bash
#
# nb-fzf.sh - fzf を使って nb のメモをインタラクティブに開くスクリプト
#
# インストール:
#   chmod +x ~/Git/dotfiles/nb/nb-fzf.sh
#   ln -s ~/Git/dotfiles/nb/nb-fzf.sh ~/.nb-fzf.sh
#
# 使い方:
#   nb-fzf          # メモを選択して編集
#   nb-fzf --show   # メモを選択して表示（読み取り専用）
#   nb-fzf --add    # 新規メモを作成
#
# キーバインド（fzf内）:
#   Enter     選択して編集
#   Ctrl-p    プレビューのスクロールアップ
#   Ctrl-n    プレビューのスクロールダウン
#   Ctrl-r    リロード
#   Ctrl-d    選択したメモを削除

set -euo pipefail

# nb コマンドの存在チェック
if ! command -v nb &>/dev/null; then
  echo "Error: 'nb' が見つかりません。インストールしてください。" >&2
  exit 1
fi

# fzf コマンドの存在チェック
if ! command -v fzf &>/dev/null; then
  echo "Error: 'fzf' が見つかりません。インストールしてください。" >&2
  exit 1
fi

# tmux セッション内かつ fzf-tmux が使えるなら fzf-tmux を使用
# fzf-tmux のオプション: -p でポップアップウィンドウ、サイズ指定可能
if [[ -n "${TMUX:-}" ]] && command -v fzf-tmux &>/dev/null; then
  FZF_CMD=(fzf-tmux -p 90%,85%)
else
  FZF_CMD=(fzf)
fi

MODE="${1:-}"

# 新規メモ作成モード
if [[ "$MODE" == "--add" ]]; then
  nb add
  exit 0
fi

# 表示モードの決定
if [[ "$MODE" == "--show" ]]; then
  ACTION="show"
else
  ACTION="edit"
fi

# プレビューコマンド: ノートIDを取り出して nb show する
PREVIEW_CMD='
  id=$(echo {} | grep -oE "^\[([^]]+)\]" | tr -d "[]")
  if [[ -n "$id" ]]; then
    nb show "$id" --print  2>/dev/null || echo "(プレビューを表示できません)"
  fi
'

# バインドコマンド: Ctrl-d で削除後にリロード
DELETE_CMD='
  id=$(echo {} | grep -oE "^\[([^]]+)\]" | tr -d "[]")
  if [[ -n "$id" ]]; then
    nb delete "$id" --force && echo "削除しました: $id" || echo "削除に失敗しました"
  fi
'

# メイン: nb list でノート一覧を取得し fzf に渡す
selected=$(
  nb list --no-color --no-indicator 2>/dev/null \
    | "${FZF_CMD[@]}" \
        --layout reverse \
        --ansi \
        --no-sort \
        --prompt="nb> " \
        --header="Enter:${ACTION}  Ctrl-A:add  Ctrl-D:delete  Ctrl-R:reload" \
        --preview="$PREVIEW_CMD" \
        --preview-window="right:60%" \
        --bind="ctrl-p:preview-up" \
        --bind="ctrl-n:preview-down" \
        --bind="ctrl-r:reload(nb list --no-color --no-indicator 2>/dev/null)" \
        --bind="ctrl-a:execute(nb add)+reload(nb list --no-color --no-indicator 2>/dev/null)" \
        --bind="ctrl-d:execute($DELETE_CMD)+reload(nb list --no-color --no-indicator 2>/dev/null)" \
        --bind="ctrl-s:toggle-preview" \
  || true
)

# 選択がなければ終了
[[ -z "$selected" ]] && exit 0

# ノートIDを抽出して開く
note_id=$(echo "$selected" | grep -oE "^\[([^]]+)\]" | tr -d "[]")

if [[ -n "$note_id" ]]; then
  nb "$ACTION" "$note_id"
else
  echo "Error: ノートIDを取得できませんでした。" >&2
  exit 1
fi
