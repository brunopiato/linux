#!/bin/bash

echo "VOCÊ GOSTARIA DE COPIAR OS ATALHOS OU REDEFINIR OS ATALHOS?"
read -p "[C]Copiar as configuraçoes do PC para o arquivo
[R]Aplicar as configuraçoes no PC a partir de um arquivo
" resposta

if [ "$resposta" == "C" ]; then 
    dconf dump '/org/gnome/desktop/wm/keybindings/' > keybindings.dconf
    dconf dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' > /custom-keybindings.dconf
elif [ "$resposta" == "R" ]; then 
    dconf load '/org/gnome/desktop/wm/keybindings/' < keybindings.dconf
    dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' < custom-keybindings.dconf
    dconf update
else echo "Fim"
fi
