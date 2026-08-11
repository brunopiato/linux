#!/usr/bin/env bash

module_apps() {
  # Primeiro corrige/configura o OnlyOffice: uma chave inválida já registrada
  # faria qualquer apt update executado pelos demais instaladores falhar.
  install_onlyoffice
  apt_install_file "$ROOT_DIR/packages/apps.txt"
  install_dbeaver
  install_vscode
}

install_dbeaver() {
  run sudo install -m 0755 -d /etc/apt/keyrings
  run sudo curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key -o /etc/apt/keyrings/dbeaver.asc
  run sudo chmod a+r /etc/apt/keyrings/dbeaver.asc
  write_root_file /etc/apt/sources.list.d/dbeaver-ce.list \
    'deb [signed-by=/etc/apt/keyrings/dbeaver.asc] https://dbeaver.io/debs/dbeaver-ce /'
  run sudo apt-get update
  run sudo apt-get install -y dbeaver-ce
}

install_vscode() {
  run sudo install -m 0755 -d /etc/apt/keyrings
  run curl -fsSL https://packages.microsoft.com/keys/microsoft.asc -o /tmp/linux-bootstrap-microsoft.asc
  run sudo gpg --dearmor --yes -o /etc/apt/keyrings/microsoft.gpg /tmp/linux-bootstrap-microsoft.asc
  local source_file=/etc/apt/sources.list.d/vscode.sources
  local content=$'Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64 arm64 armhf\nSigned-By: /etc/apt/keyrings/microsoft.gpg'
  write_root_file "$source_file" "$content"
  run sudo apt-get update
  run sudo apt-get install -y code
}

install_onlyoffice() {
  run sudo install -m 0755 -d /etc/apt/keyrings
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run] exportar chave CB2DE8E5 em /etc/apt/keyrings/onlyoffice.asc\n'
  else
    local key_dir
    key_dir="$(mktemp -d)"
    gpg --batch --homedir "$key_dir" --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8320CA65CB2DE8E5
    gpg --batch --homedir "$key_dir" --armor --export 8320CA65CB2DE8E5 > "$key_dir/onlyoffice.asc"
    [[ -s "$key_dir/onlyoffice.asc" ]] || die "Falha ao exportar a chave do OnlyOffice."
    sudo install -m 0644 "$key_dir/onlyoffice.asc" /etc/apt/keyrings/onlyoffice.asc
  fi
  write_root_file /etc/apt/sources.list.d/onlyoffice.list \
    'deb [signed-by=/etc/apt/keyrings/onlyoffice.asc] https://download.onlyoffice.com/repo/debian squeeze main'
  run sudo apt-get update
  run sudo apt-get install -y onlyoffice-desktopeditors
}
