autoload -U compinit
setopt auto_list
setopt auto_menu
setopt list_types
setopt auto_param_keys
setopt auto_param_slash
setopt MARK_DIRS
setopt IGNORE_EOF
setopt CORRECT
compinit
export LANG=ja_JP.UTF-8
autoload -U colors; colors
bindkey -e
# ================ プロンプトの表示形式の設定 =====================
PROMPT="%{$fg[green]%}>> %D{%Y-%m-%d %K:%M} %n@%m [%~]%{$reset_color%}
%{$fg_bold[green]%}$%{$reset_color%} "
PROMPT2="%{$fg_bold[green]%}>%{$reset_color%} "
# ================ 履歴の保存数、場所を設定 ======================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
# ================ コマンド履歴補間のキーバインドを設定 ==========
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -a"
alias less='/usr/share/vim/vim74/macros/less.sh'
# export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# eval `opam config env`
alias R="R -q"
alias python="python -q"
export PATH=$HOME/sml/bin:$HOME/bin:$PATH
alias luajitlatex='luajittex --fmt=luajitlatex.fmt'
