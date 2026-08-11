#!/usr/bin/env bash

module_flatpak() {
  run sudo apt-get install -y flatpak plasma-discover-backend-flatpak
  run flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  while IFS= read -r app_id; do
    [[ -z "$app_id" || "$app_id" =~ ^[[:space:]]*# ]] && continue
    if flatpak info --user "$app_id" >/dev/null 2>&1; then
      run flatpak update --user -y "$app_id"
    else
      run flatpak install --user -y flathub "$app_id"
    fi
  done < "$ROOT_DIR/packages/flatpaks.txt"
}
