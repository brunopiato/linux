#!/bin/bash

set -euo pipefail

# Arquivo de configuração do sistema após formatação
: << 'COMMENT'
Ubuntu 24.04.3 LTS (Noble)
    Linux Kernel 6.14.0-37-generic
    GNOME Shell 46
    Shell: bash 5.2.21
    
COMMENT


#-----------------------------------------------------------------------------------------
# Atualizando o sistema
#-----------------------------------------------------------------------------------------
sudo apt update && sudo apt upgrade -y


#-----------------------------------------------------------------------------------------
# Instalações básicas
#-----------------------------------------------------------------------------------------
git config --global user.name "brunopiato"
git config --global user.email "piatobio@gmail.com"

sudo apt install -y tree neofetch curl gparted os-prober unzip dconf-editor rclone vlc calibre gedit gdebi notepadqq timeshift


# Instalando Grub-Customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install grub-customizer -y


# Instalando o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
sudo rm ./google-chrome-stable_current_amd64.deb


# Instalando as extensões do GNOME
sudo apt install -y gnome-tweaks gnome-shell-extensions chrome-gnome-shell gnome-shell-extension-manager


# Instalando coisas com snap
sudo snap install code --classic
sudo snap install discord emote onlyoffice-desktopeditors
sudo snap install obsidian --classic


# Configurações de teclado
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t', '<Super>t']" #Adicionar o Super+T para o terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>f']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super>q']" #Adicionar o Super+Q para fechar a janela
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Page_Down']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Page_Up']" 
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>up']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Alt>F10', '<Super>m']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"


#-----------------------------------------------------------------------------------------
# Instalando o pyenv
#-----------------------------------------------------------------------------------------
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl https://pyenv.run | bash

cat << 'EOF' >> ~/.bashrc
# Comandos do pyenv
export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF


#-----------------------------------------------------------------------------------------
# Instalando Docker
#-----------------------------------------------------------------------------------------

echo "Iniciando a instalação do Docker"
sudo apt remove -y docker docker-engine docker.io containerd runc

sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

sudo systemctl enable docker


#-----------------------------------------------------------------------------------------
# Configurando o terminal
#-----------------------------------------------------------------------------------------
echo "A instalação está terminando."
sleep 1
read -p "Gostaria de aplicar as customizações do terminal?[S/N]: " resposta

if [ "$resposta" = "S" ] || [ "$resposta" = "s" ]; then
	bash ~/repos/linux/prompt_config/prompt_config.sh
else sleep 1
	echo "Fique a vontade para customizar o terminal da forma que preferir."
fi


#-----------------------------------------------------------------------------------------
# Mensagem final
#-----------------------------------------------------------------------------------------
sleep 1
read -p "Gostaria de instalar e configurar o OneDrive agora? [S/N]: " resposta
if [ "$resposta" = "S" ] || [ "$resposta" = "s" ]; then
	sudo apt install rclone
    mkdir ~/OneDrive
    rclone config
    rclone --vfs-cache-mode writes mount "OneDrive":  ~/OneDrive
    echo "[Desktop Entry]
Type=Application
Exec=sh -c 'rclone --vfs-cache-mode writes mount \\"OneDrive\\": ~/OneDrive'
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[pt_BR]=OneDrive
Name=OneDrive
Comment[pt_BR]=
Comment=" >> ~/.config/autostart/sh.desktop
else sleep 1
	echo "Você poderá fazer a instalação mais tarde."
fi

sleep 1
neofetch
# sleep 2
# echo "A LISTA COM AS EXTENSÕES DO GNOME-SHELL RECOMENDADAS PARA SEREM INSTALADAS ESTÃO SALVAS EM ~/lista_ext.txt.
# VÁ ATÉ LÁ VERIFICÁ-LAS."
# echo ""
read -p "A instalação terminou, mas precisamos reiniciar o computador. Reiniciar agora? [S/N]: " resposta
if [ "$resposta" = "S" ] || [ "$resposta" = "s" ]; then
	reboot
else sleep 2
	source ~/.bashrc
	echo "Reinicie o computador assim que possível."
fi
