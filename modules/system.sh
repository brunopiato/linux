#!/usr/bin/env bash

module_system() {
  run sudo apt-get update
  run sudo env DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
  apt_install_file "$ROOT_DIR/packages/base.txt"
}
