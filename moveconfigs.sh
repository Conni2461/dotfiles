#!/bin/bash 
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo $BASEDIR

cd
cp .i3status-rs.conf $BASEDIR
cp startup.sh $BASEDIR
cp .tmux.conf $BASEDIR
cp .vimrc $BASEDIR
cp .xinitrc $BASEDIR
cp .zshrc $BASEDIR
cp .bashrc $BASEDIR
cp .config/i3/config $BASEDIR/.config/i3

