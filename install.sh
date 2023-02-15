#!/bin/sh

ln -sv $(readlink -f src/main.vim) $HOME/.vimrc
