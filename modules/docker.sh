#!/usr/bin/env bash

module_docker() {
  local repo_os="$DISTRO_FAMILY"
  [[ -n "$DISTRO_CODENAME" ]] || die "Codename da distribuição não identificado."

  run sudo apt-get remove -y docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc || true
  run sudo install -m 0755 -d /etc/apt/keyrings
  run sudo curl -fsSL "https://download.docker.com/linux/$repo_os/gpg" -o /etc/apt/keyrings/docker.asc
  run sudo chmod a+r /etc/apt/keyrings/docker.asc

  local arch source_line
  arch="$(dpkg --print-architecture)"
  source_line="deb [arch=$arch signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$repo_os $DISTRO_CODENAME stable"
  if [[ "${DRY_RUN:-false}" == true ]]; then
    printf '[dry-run] gravar %s em /etc/apt/sources.list.d/docker.list\n' "$source_line"
  else
    printf '%s\n' "$source_line" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  fi
  run sudo apt-get update
  run sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  run sudo usermod -aG docker "$USER"
  run sudo systemctl enable --now docker
}
