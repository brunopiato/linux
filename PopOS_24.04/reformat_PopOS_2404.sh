#!/bin/bash

# Arquivo de configuração do sistema após formatação
: << 'COMMENT'
Pop!_OS 24.04 LTS
    Linux Kernel 6.5
    GNOME Shell 45
    Gnome Kernel 6.5.0
    Shell: bash 5.2.15
    
COMMENT

#-----------------------------------------------------------------------------------------
# Atualizando o sistema
#-----------------------------------------------------------------------------------------
sudo apt update && sudo apt upgrade


#-----------------------------------------------------------------------------------------
# Instalações básicas
#-----------------------------------------------------------------------------------------
sudo apt install -y tree neofetch curl gparted os-prober unzip dconf-editor rclone vlc calibre gedit gdebi


#-----------------------------------------------------------------------------------------
# Instalando e configurando o Git
#-----------------------------------------------------------------------------------------
#sudo apt update
#sudo apt install git
git config --global user.name brunopiato
git config --global user.email piatobio@gmail.com


#-----------------------------------------------------------------------------------------
# Instalando o pyenv
#-----------------------------------------------------------------------------------------
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl https://pyenv.run | bash

sudo echo '# Comandos do pyenv
export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc


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


