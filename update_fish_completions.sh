#!/bin/bash

COMPLETIONS_DIR="$HOME/.config/fish/completions"

command_exist() {
  if type "$1" >/dev/null 2>&1; then
    return 0
  else
    echo "$1: not found"
    return 1
  fi
}

pueue add -- "fish -c 'fish_update_completions'"

for cmd in "poetry" "rustup" "starship" "deno"; do
  if command_exist "${cmd}"; then
    pueue add -- "'${cmd}' completions fish > '${COMPLETIONS_DIR}'/'${cmd}'.fish"
  fi
done

if command_exist asdf; then
  pueue add -- cp "'${HOME}'/.asdf/completions/asdf.fish '${COMPLETIONS_DIR}'/asdf.fish"
fi

if command_exist bun; then
  pueue add -- "bun completions"
fi

for cmd in "chezmoi" "flyctl" "runme"; do
  if command_exist "${cmd}"; then
    pueue add -- "'${cmd}' completion fish > '${COMPLETIONS_DIR}'/'${cmd}'.fish"
  fi
done

if command_exist pnpm; then
  pueue add -- "pnpm install-completion fish"
fi

if command_exist yq; then
  pueue add -- "yq shell-completion fish > '${COMPLETIONS_DIR}'/yq.fish"
fi

if command_exist gh; then
  pueue add -- "gh completion -s fish > '${COMPLETIONS_DIR}'/gh.fish"
fi

if command_exist fd; then
  pueue add -- "fd --gen-completions fish > '${COMPLETIONS_DIR}'/fd.fish"
fi

if command_exist zellij; then
  pueue add -- "zellij setup --generate-completion fish > '${COMPLETIONS_DIR}'/zellij.fish"
fi

if command_exist exa; then
  pueue add -- "curl -L https://raw.githubusercontent.com/ogham/exa/master/completions/fish/exa.fish -o '${COMPLETIONS_DIR}'/exa.fish"
fi

if command_exist tldr; then
  pueue add -- "curl -L https://raw.githubusercontent.com/dbrgn/tealdeer/main/completion/fish_tealdeer -o '${COMPLETIONS_DIR}'/tldr.fish"
fi

if command_exist bat; then
  pueue add -- "update_bat_fish_completion"
fi

if command_exist rg; then
  pueue add -- "update_ripgrep_fish_completion"
fi
