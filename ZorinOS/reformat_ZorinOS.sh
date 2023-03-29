#!/bin/bash

# Arquivo de configuração do sistema após formatação
: << 'COMMENT'

Zorin OS 16 (latest version in 24/03/2023)
Base system
    Ubuntu 20.04 LTS
Supported until (with software updates and security patches)
    April 2025
Initially released
    17 August 2021
Supported app formats
    APT
    Flatpak
    Snap
    .deb
    AppImage
    .exe & .msi
    (with optional Windows App Support)
Default software repositories
    Zorin OS APT repositories
    Ubuntu packages
    Flathub
    Snap Store
Desktop environment
    GNOME Shell (Core & Pro editions)
    XFCE (Lite editions)
Linux kernel version
    5.15
Processor architecture support
    64-bit x86 Intel or AMD CPUs

COMMENT





#-----------------------------------------------------------------------------------------
# Atualizando o sistema
#-----------------------------------------------------------------------------------------
sudo apt update && sudo apt upgrade




#-----------------------------------------------------------------------------------------
# Instalações básicas
#-----------------------------------------------------------------------------------------
## Instalando utilitários do Ubuntu
sudo apt install tree
sudo apt install neofetch
sudo apt install curl
sudo apt install snapd
sudo snap install snap-store
sudo apt install gparted
sudo apt install os-prober
sudo apt install unzip
sudo apt install dconf-editor

## Instalando utilitários do Zorin OS
sudo apt install plank
flatpak install flathub com.github.maoschanz.DynamicWallpaperEditor


## Instalando o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
sudo rm ./google-chrome-stable_current_amd64.deb

## Instalando as extensões do GNOME
sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions
sudo apt install chrome-gnome-shell

## Instalando o VSCode
sudo snap install code --classic

## Instalando aplicativos do Snap
sudo snap install drawio #Drawio
sudo snap install spotify #Spotify
sudo snap install dbeaver-ce #DBeaver
sudo snap install discord #Discord
sudo snap install inkscape #Inkscape
sudo snap install notion-snap #Notion
sudo snap install pycharm-community --classic #PyCharm Community
sudo apt install vlc #VLC Media Player

## Instalando Dropbox
curl https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb --output dropbox_2020.03.04_amd64.deb
sudo apt install ./dropbox_2020.03.04_amd64.deb
sudo rm ./dropbox_2020.03.04_amd64.deb

## Instalando um colorizador de folders para o Nautilus
sudo add-apt-repository ppa:costales/yaru-colors-folder-color #Adicionar o repositório PPA
sudo apt update #Atualizar o sistema
sudo apt install yaru-colors-folder-color folder-color  -y #Instalar o colorizador
nautilus -q  #Reiniciar o Nautilus para que as modificações tenham efeito

## Instalando e configurando o Calibre
sudo apt-get install calibre
sudo touch /etc/profile.d/calibre.sh
sudo echo "export CALIBRE_USE_DARK_PALETTE=1" >> /etc/profile.d/calibre.sh

## Instalando o NordVPN
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
sleep 1
sudo usermod -aG nordvpn $USER



#-----------------------------------------------------------------------------------------
# Instalando Git
#-----------------------------------------------------------------------------------------
sudo apt update
sudo apt install git



#-----------------------------------------------------------------------------------------
# Instalando o pyenv e o Python
#-----------------------------------------------------------------------------------------
## Instalando o Python
#sudo apt install python3.11 -y
#
## Instalando o gerenciador de pacotes do Python
sudo apt install python3-pip
sudo pip3 install --upgrade pip
pip install --upgrade pip
pip install cython #Adiciona funcionalidades da linguagem C ao Python
pip install pip-autoremove #Um pacote para desinstalar outros pacotes junto com suas dependências
pip install pipreqs #Um pacote para criar arquivo requirements.tx
pip install pipreqsnb #Um pacote para criar arquivo requirements.tx para Jupyter Notebook
pip install pip-chill #Um pacote que mostra os pacotes que estão em uso
pip install pipdeptree #Mostra as dependências de cada pacote

## Instalando o pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm gettext libncurses5-dev tk-dev tcl-dev blt-dev libgdbm-dev git python2-dev python3-dev aria2
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

sudo echo 'export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

## Instalando kernel iPython
#python3 -m pip install ipykernel
#python3 -m ipykernel install --user

## Instalando o Jupyter Notebook
#pip install notebook

## Instalando o Jupyter Notebook e suas extensões
#pip install jupyter_contrib_nbextensions
#jupyter contrib nbextension install --user

## Instalando o JupyterLab Desktop
#wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-Debian.deb
#sudo apt install ./JupyterLab-Setup-Debian.deb
#sudo rm ./JupyterLab-Setup-Debian.deb






#-----------------------------------------------------------------------------------------
# Instalando o R
#-----------------------------------------------------------------------------------------
sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/cran.gpg
echo deb [signed-by=/usr/share/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/ | sudo tee /etc/apt/sources.list.d/cran.list
sudo apt update
sudo apt install r-base
R --version

## Instalando o RStudio
wget -c https://download1.rstudio.org/electron/bionic/amd64/rstudio-2023.03.0-386-amd64.deb
sudo dpkg -i ./rstudio-2023.03.0-386-amd64.deb
sudo rm -r ./rstudio-2023.03.0-386-amd64.deb







#-----------------------------------------------------------------------------------------
# Instalando Julia
#-----------------------------------------------------------------------------------------
sudo apt install julia



#-----------------------------------------------------------------------------------------
# Demais ajustes e configurações do sistema
#-----------------------------------------------------------------------------------------
## Tirando o tempo de espera do botão desligar
#gsettings set org.gnome.SessionManager logout-prompt false

## Adicionando atalhos de teclado
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super>q']" #Adicionar o Super+Q para fechar a janela
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t', '<Super>t']" #Adicionar o Super+T para o terminal

## Criando um arquivo com aliases para comandos resumidos
echo "alias upd='sudo apt update && sudo apt upgrade'" >> ~/.bash_aliases




#-----------------------------------------------------------------------------------------
# Instalando as exntensões GNOME
#-----------------------------------------------------------------------------------------
mkdir /home/bruno/.local/share/gnome-shell/extensions

unzip ~/repos/linux/ZorinOS/extensions_ZorinOS/dash-to-plankhardpixel.eu.v15.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/dash-to-plank@hardpixel.eu

unzip ~/repos/linux/ZorinOS/extensions_ZorinOS/just-perfection-desktopjust-perfection.v24.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection

unzip ~/repos/linux/ZorinOS/extensions_ZorinOS/unitehardpixel.eu.v70.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu

unzip ~/repos/linux/ZorinOS/extensions_ZorinOS/timepp-master.zip -d \
 ~/.local/share/gnome-shell/extensions/timepp@zagortenay333

unzip ~/repos/linux/ZorinOS/extensions_ZorinOS/gnome-clipboardb00f.github.io.v17.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/gnome-clipboard@b00f.github.io





#-----------------------------------------------------------------------------------------
# Mensagem final
#-----------------------------------------------------------------------------------------
neofetch

sleep 2
echo "A LISTA COM AS EXTENSÕES DO GNOME-SHELL RECOMENDADAS PARA SEREM INSTALADAS ESTÃO SALVAS EM ~/lista_ext.txt.
VÁ ATÉ LÁ VERIFICÁ-LAS."
echo ""

sleep 2
echo "A instalação terminou, mas precisamos reiniciar o computador para que as alterações tenham efeito."

sleep 2
echo "Reiniciar agora?[S/N]: "
read resposta
if [ $resposta == "S" -o $resposta == "s" ] ; then
reboot
else sleep 2
echo "Reinicie o computador assim que possível."
fi
