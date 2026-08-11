#!/usr/bin/env bash

module_onedrive() {
  command -v rclone >/dev/null 2>&1 || die "rclone não está instalado."
  if [[ "${DRY_RUN:-false}" != true ]]; then
    info "O assistente interativo do rclone será aberto. Crie um remote chamado OneDrive."
    rclone config
  fi
  run mkdir -p "$HOME/OneDrive" "$HOME/.config/autostart"
  install_file "$ROOT_DIR/config/autostart/onedrive-mount.desktop" "$HOME/.config/autostart/onedrive-mount.desktop"
}
