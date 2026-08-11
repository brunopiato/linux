#!/usr/bin/env bash

module_wallpaper() {
  local source_image="$ROOT_DIR/wallpapers/snowy-mountains-sunset.jpg"
  local target="$HOME/.local/share/wallpapers/linux-bootstrap-snowy-mountains.jpg"
  install_file "$source_image" "$target"
  if [[ "$DESKTOP_ENV" =~ kde|plasma ]]; then
    command -v plasma-apply-wallpaperimage >/dev/null 2>&1 || die "plasma-apply-wallpaperimage não encontrado."
    run plasma-apply-wallpaperimage "$target"
  elif [[ "$DESKTOP_ENV" =~ gnome|ubuntu|pop ]]; then
    run gsettings set org.gnome.desktop.background picture-uri "file://$target"
    run gsettings set org.gnome.desktop.background picture-uri-dark "file://$target"
  else
    warn "Não sei aplicar o wallpaper em: ${DESKTOP_ENV:-desktop desconhecido}."
  fi
}
