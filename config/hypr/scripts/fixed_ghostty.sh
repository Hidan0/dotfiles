#!/usr/bin/env zsh

# fix: https://github.com/ghostty-org/ghostty/discussions/8894

case "${1}" in
  quick)
    GTK_IM_MODULE=simple ghostty --title="quickterm_ghostty" --class="com.ghostty.float"
  ;;
  qalc)
    GTK_IM_MODULE=simple ghostty --title="quickterm_ghostty" --class="com.ghostty.float" -e qalc
  ;;
  *)
    GTK_IM_MODULE=simple ghostty
esac
