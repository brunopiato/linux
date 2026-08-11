#!/usr/bin/env bash

module_python() {
  apt_install_file "$ROOT_DIR/packages/python-build.txt"
  if [[ ! -d "$HOME/.pyenv" ]]; then
    run_shell 'curl -fsSL https://pyenv.run | bash'
  fi
  if ! command -v uv >/dev/null 2>&1; then
    run_shell 'curl -LsSf https://astral.sh/uv/install.sh | sh'
  fi
  install_file "$ROOT_DIR/config/shell/bootstrap.sh" "$HOME/.config/linux-bootstrap/shell.sh"
  ensure_line 'source "$HOME/.config/linux-bootstrap/shell.sh"' "$HOME/.bashrc"
}
