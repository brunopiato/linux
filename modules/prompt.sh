#!/usr/bin/env bash

module_prompt() {
  local font_root="$HOME/.local/share/fonts"
  local release="${NERD_FONTS_VERSION:-v3.4.0}"
  local font_dir="$font_root/linux-bootstrap/FiraCode-$release"
  local version_marker="$font_dir/.installed-version"
  run mkdir -p "$font_root" "$HOME/.config"
  if [[ ! -f "$version_marker" ]] || [[ "$(< "$version_marker" 2>/dev/null || true)" != "$release" ]]; then
    local tmp_dir="${TMPDIR:-/tmp}/linux-bootstrap-fonts"
    run mkdir -p "$tmp_dir"
    run curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/download/$release/FiraCode.zip" -o "$tmp_dir/FiraCode.zip"
    run mkdir -p "$font_dir"
    run unzip -qo "$tmp_dir/FiraCode.zip" -d "$font_dir"
    if [[ "${DRY_RUN:-false}" == true ]]; then
      printf '[dry-run] registrar versão %s em %s\n' "$release" "$version_marker"
    else
      printf '%s\n' "$release" > "$version_marker"
    fi
    archive_legacy_nerd_fonts "$font_root"
    run fc-cache -f
  fi
  if ! command -v starship >/dev/null 2>&1; then
    run_shell 'curl -fsSL https://starship.rs/install.sh | sh -s -- -y'
  fi
  install_file "$ROOT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
  ensure_line 'eval "$(starship init bash)"' "$HOME/.bashrc"
  if [[ "$DESKTOP_ENV" =~ kde|plasma ]] && command -v kreadconfig6 >/dev/null 2>&1 && command -v kwriteconfig6 >/dev/null 2>&1; then
    local konsole_profile
    konsole_profile="$(kreadconfig6 --file konsolerc --group 'Desktop Entry' --key DefaultProfile)"
    if [[ -n "$konsole_profile" ]]; then
      run kwriteconfig6 --file "$HOME/.local/share/konsole/$konsole_profile" --group Appearance --key Font 'FiraCode Nerd Font Mono,12,-1,5,50,0,0,0,0,0'
      run kwriteconfig6 --file "$HOME/.local/share/konsole/$konsole_profile" --group Appearance --key LineSpacing 0
    fi
  fi
}

archive_legacy_nerd_fonts() {
  local font_root="$1"
  # O backup deve ficar fora de ~/.local/share/fonts, pois o Fontconfig
  # examina subdiretórios recursivamente e continuaria usando as fontes antigas.
  local backup_dir="$HOME/.local/share/linux-bootstrap/font-backups/legacy-nerd-fonts-v2"
  local legacy_fonts=()
  while IFS= read -r -d '' file; do
    legacy_fonts+=("$file")
  done < <(find "$font_root" -maxdepth 1 -type f -name '*Nerd Font Complete*' -print0)
  ((${#legacy_fonts[@]})) || return 0
  run mkdir -p "$backup_dir"
  local file
  for file in "${legacy_fonts[@]}"; do
    run mv "$file" "$backup_dir/"
  done
}
