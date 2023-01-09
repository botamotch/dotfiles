#!/bin/sh

HOME_DIR=$HOME
GIT_DIR=$HOME/Git/dotfiles

# zsh
ln -s $GIT_DIR/zsh/zprofile $HOME_DIR/.zprofile

# starship
ln -s $GIT_DIR/starship/starship.toml $HOME_DIR/.config/starship.toml

# conky
ln -s $GIT_DIR/conky/conky.conf $HOME_DIR/.config/conky/conky.conf
ln -s $GIT_DIR/conky/start_conky.sh $HOME_DIR/.config/conky/start_conky.sh
ln -s $GIT_DIR/conky/start_conky.sh.desktop $HOME_DIR/.config/autostart/start_conky.sh.desktop

# xprofile
ln -s $GIT_DIR/xprofile/xprofile $HOME_DIR/.xprofile

# vim
ln -s $GIT_DIR/vim/vimrc $HOME_DIR/.vim/vimrc
ln -s $GIT_DIR/vim/gvimrc $HOME_DIR/.vim/gvimrc
ln -s $GIT_DIR/vim/dein.toml $HOME_DIR/.vim/dein.toml

# nvim
ln -s $GIT_DIR/nvim/init.lua $HOME_DIR/.config/nvim/init.lua

# wezterm
ln -s $GIT_DIR/wezterm/wezterm.lua $HOME_DIR/.config/wezterm/wezterm.lua

# rofi
ln -s $GIT_DIR/rofi/config.rasi $HOME_DIR/.config/rofi/config.rasi
ln -s $GIT_DIR/rofi/themes/iceberg.rasi $HOME_DIR/.config/themesiceberg.rasi.rasi
