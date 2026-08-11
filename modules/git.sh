#!/usr/bin/env bash

module_git() {
  if [[ -n "${GIT_USER_NAME:-}" ]]; then
    run git config --global user.name "$GIT_USER_NAME"
  else
    warn "GIT_USER_NAME não definido; Git global não foi alterado."
  fi
  if [[ -n "${GIT_USER_EMAIL:-}" ]]; then
    run git config --global user.email "$GIT_USER_EMAIL"
  else
    warn "GIT_USER_EMAIL não definido; Git global não foi alterado."
  fi
}
