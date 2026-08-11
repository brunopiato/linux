#!/usr/bin/env bash

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
success() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mAviso:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31mErro:\033[0m %s\n' "$*" >&2; exit 1; }

run() {
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run]'; printf ' %q' "$@"; printf '\n'
  else
    "$@"
  fi
}

run_shell() {
  local command="$1"
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run] %s\n' "$command"
  else
    bash -c "$command"
  fi
}

detect_platform() {
  [[ -r /etc/os-release ]] || die "Não foi possível ler /etc/os-release."
  # shellcheck source=/dev/null
  source /etc/os-release
  DISTRO_ID="${ID,,}"
  DISTRO_VERSION="${VERSION_ID:-desconhecida}"
  case " $DISTRO_ID ${ID_LIKE:-} " in
    *ubuntu*)
      DISTRO_FAMILY=ubuntu
      DISTRO_CODENAME="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
      ;;
    *debian*)
      DISTRO_FAMILY=debian
      DISTRO_CODENAME="${DEBIAN_CODENAME:-${VERSION_CODENAME:-}}"
      ;;
    *) die "Distribuição não suportada: $DISTRO_ID. Use Debian, Ubuntu ou derivada." ;;
  esac
  DESKTOP_ENV="${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-}}"
  DESKTOP_ENV="${DESKTOP_ENV,,}"
  export DISTRO_ID DISTRO_VERSION DISTRO_CODENAME DISTRO_FAMILY DESKTOP_ENV
}

load_user_config() {
  local config="$ROOT_DIR/config/user.env"
  if [[ -f "$config" ]]; then
    # shellcheck source=/dev/null
    source "$config"
  fi
}

apt_install_file() {
  local file="$1" packages=()
  while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    packages+=("$line")
  done < "$file"
  ((${#packages[@]})) && run sudo apt-get install -y "${packages[@]}"
}

ensure_line() {
  local line="$1" file="$2"
  [[ -f "$file" ]] && grep -Fqx "$line" "$file" && return 0
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run] adicionar %q em %q\n' "$line" "$file"
  else
    mkdir -p "$(dirname "$file")"
    printf '%s\n' "$line" >> "$file"
  fi
}

install_file() {
  local source_file="$1" target="$2" mode="${3:-0644}"
  run mkdir -p "$(dirname "$target")"
  run install -m "$mode" "$source_file" "$target"
}

write_root_file() {
  local target="$1" content="$2"
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run] gravar configuração em %s\n' "$target"
  else
    printf '%s\n' "$content" | sudo tee "$target" >/dev/null
  fi
}
