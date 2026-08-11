#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/lib/common.sh"

PROFILE="full"
MODULES=""
DRY_RUN=false
ASSUME_YES=false

usage() {
  cat <<'EOF'
Uso: ./install.sh [opções]

Opções:
  --profile NOME     Perfil: base, dev, desktop ou full (padrão: full)
  --modules LISTA    Executa apenas os módulos informados, separados por vírgula
  --dry-run          Exibe os comandos sem alterar o sistema
  --yes              Não pede confirmação inicial
  --list-modules     Lista os módulos disponíveis
  -h, --help         Exibe esta ajuda

Exemplos:
  ./install.sh --dry-run
  ./install.sh --profile dev
  ./install.sh --modules system,git,docker
EOF
}

while (($#)); do
  case "$1" in
    --profile) PROFILE="${2:?Informe o perfil}"; shift 2 ;;
    --modules) MODULES="${2:?Informe os módulos}"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    --yes) ASSUME_YES=true; shift ;;
    --list-modules) printf '%s\n' system git apps flatpak python docker desktop prompt wallpaper onedrive; exit 0 ;;
    -h|--help) usage; exit 0 ;;
    *) die "Opção desconhecida: $1" ;;
  esac
done

case "$PROFILE" in
  base) DEFAULT_MODULES=(system git) ;;
  dev) DEFAULT_MODULES=(system git apps flatpak python docker prompt) ;;
  desktop) DEFAULT_MODULES=(system apps flatpak desktop prompt wallpaper) ;;
  full) DEFAULT_MODULES=(system git apps flatpak python docker desktop prompt wallpaper) ;;
  *) die "Perfil inválido: $PROFILE" ;;
esac

if [[ -n "$MODULES" ]]; then
  IFS=',' read -r -a SELECTED_MODULES <<< "$MODULES"
else
  SELECTED_MODULES=("${DEFAULT_MODULES[@]}")
fi

detect_platform
load_user_config

info "Distribuição: $DISTRO_ID $DISTRO_VERSION ($DISTRO_FAMILY)"
info "Desktop: ${DESKTOP_ENV:-não detectado}"
info "Módulos: ${SELECTED_MODULES[*]}"
[[ "$DRY_RUN" == true ]] && warn "Modo de simulação: nenhuma alteração será feita."

if [[ "$ASSUME_YES" != true && "$DRY_RUN" != true ]]; then
  read -r -p "Continuar? [s/N] " answer
  [[ "$answer" =~ ^[Ss]$ ]] || exit 0
fi

for module in "${SELECTED_MODULES[@]}"; do
  module_file="$ROOT_DIR/modules/$module.sh"
  [[ -f "$module_file" ]] || die "Módulo inexistente: $module"
  # shellcheck source=/dev/null
  source "$module_file"
  info "Executando módulo: $module"
  "module_$module"
done

success "Bootstrap concluído. Abra uma nova sessão; reinicie se Docker, fontes ou atalhos exigirem."
