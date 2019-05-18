#!/bin/sh

man -k . | dmenu -l 30 | awk '{print $1}' | xargs -r man -Tpdf | zathura -
