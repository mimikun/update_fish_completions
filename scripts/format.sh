#!/bin/bash

format() {
  shfmt "$1" >/tmp/fmt-"$1"
  mv /tmp/fmt-"$1" "$1"
  chmod +x "$1"
}

format update_bat_fish_completion.sh
format update_fish_completions.sh
format update_ripgrep_fish_completion.sh
