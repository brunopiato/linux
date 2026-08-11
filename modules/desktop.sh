#!/usr/bin/env bash

module_desktop() {
  if [[ "$DESKTOP_ENV" =~ gnome|ubuntu|pop ]]; then
    command -v dconf >/dev/null 2>&1 || die "dconf não encontrado."
    run dconf load /org/gnome/desktop/wm/keybindings/ < "$ROOT_DIR/config/gnome/keybindings.dconf"
    run dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "$ROOT_DIR/config/gnome/custom-keybindings.dconf"
    run gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
    if [[ -f "$ROOT_DIR/config/gnome/terminal.dconf" ]]; then
      run dconf load /org/gnome/terminal/legacy/profiles:/ < "$ROOT_DIR/config/gnome/terminal.dconf"
    fi
  elif [[ "$DESKTOP_ENV" =~ kde|plasma ]]; then
    local kconfig
    kconfig="$(command -v kwriteconfig6 || command -v kwriteconfig5 || true)"
    [[ -n "$kconfig" ]] || die "kwriteconfig não encontrado."
    # Plasma 6 armazena atalhos de serviços em grupos aninhados [services][...].
    run "$kconfig" --file kglobalshortcutsrc --group services --group org.kde.konsole.desktop --key _launch $'Ctrl+Alt+T\tMeta+T'
    run "$kconfig" --file kglobalshortcutsrc --group services --group org.kde.dolphin.desktop --key _launch 'Meta+F'
    run "$kconfig" --file kglobalshortcutsrc --group preferred-apps --key browser 'Meta+B,none,Web Browser'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Window Close' $'Alt+F4\tMeta+Q,Alt+F4,Close Window'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Window Maximize' 'Meta+Up,Meta+PgUp,Maximize Window'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Window Minimize' 'Meta+H,Meta+PgDown,Minimize Window'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Window Maximize Toggle' $'Meta+M\tAlt+F10,none,Toggle Window Maximize'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Switch One Desktop Down' 'Meta+Page_Down,none,Switch One Desktop Down'
    run "$kconfig" --file kglobalshortcutsrc --group kwin --key 'Switch One Desktop Up' 'Meta+Page_Up,none,Switch One Desktop Up'
  else
    warn "Desktop não suportado ou não detectado: ${DESKTOP_ENV:-vazio}."
  fi
}
