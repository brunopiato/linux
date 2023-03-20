#!/bin/bash

# Arquivo de configuração do sistema após formatação

: << 'COMMENT'
Este arquivo serve como 
automatizacao do processo 
pos-instalacao e formatacao
do OS com Ubuntu.
COMMENT





#-----------------------------------------------------------------------------------------
# Atualizando o sistema
#-----------------------------------------------------------------------------------------

sudo apt update && sudo apt upgrade -y






#-----------------------------------------------------------------------------------------
# Instalações básicas
#-----------------------------------------------------------------------------------------

## Instalando utilitários do Ubuntu
sudo apt install tree
sudo apt install neofetch
sudo apt install curl
sudo apt install snapd
sudo snap install snap-store
sudo apt install gparted -y
sudo apt install os-prober -y
sudo apt install unzip

## Instalando o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo apt install ./google-chrome-stable_current_amd64.deb -y
sudo rm ./google-chrome-stable_current_amd64.deb -y

## Instalando as extensões do GNOME
sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions -y
sudo apt install chrome-gnome-shell -y

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
sudo apt install vlc -y #VLC Media Player

## Instalando Dropbox
curl https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb --output dropbox_2020.03.04_amd64.deb
sudo apt install ./dropbox_2020.03.04_amd64.deb -y
sudo rm ./dropbox_2020.03.04_amd64.deb

## Instalando um colorizador de folders para o Nautilus
sudo add-apt-repository ppa:costales/yaru-colors-folder-color #Adicionar o repositório PPA
sudo apt update #Atualizar o sistema
sudo apt install yaru-colors-folder-color folder-color  -y #Instalar o colorizador
nautilus -q  #Reiniciar o Nautilus para que as modificações tenham efeito

## Instalando e configurando o Calibre
sudo apt-get install calibre -y

sudo su
touch /etc/profile.d/calibre.sh
echo "export CALIBRE_USE_DARK_PALETTE=1" >> /etc/profile.d/calibre.sh
exit

## Instalando o NordVPN
sudo curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh
sudo usermod -aG nordvpn $USER






#-----------------------------------------------------------------------------------------
# Instalando Git
#-----------------------------------------------------------------------------------------

sudo apt update
sudo apt install git -y






#-----------------------------------------------------------------------------------------
# Instalando o pyenv e o Python
#-----------------------------------------------------------------------------------------

## Instalando o Python
#sudo apt install python3.11 -y
#
## Instalando o gerenciador de pacotes do Python
sudo apt install python3-pip -y
sudo pip3 install --upgrade pip
pip install --upgrade pip
pip install cython -y

## Instalando o pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm gettext libncurses5-dev tk-dev tcl-dev blt-dev libgdbm-dev git python2-dev python3-dev aria2
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

sudo echo 'export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

pyenv install 3.11
pyenv virtualenv 3.11 ambiente
pyenv activate ambiente

## Instalando kernel iPython
python3 -m pip install ipykernel
python3 -m ipykernel install --user

## Instalando o Jupyter Notebook
pip install notebook

## Instalando o Jupyter Notebook e suas extensões
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user

## Instalando o JupyterLab Desktop
wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-Debian.deb
sudo apt install ./JupyterLab-Setup-Debian.deb









#-----------------------------------------------------------------------------------------
# Instalando o R 
#-----------------------------------------------------------------------------------------

sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/cran.gpg
echo deb [signed-by=/usr/share/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/ | sudo tee /etc/apt/sources.list.d/cran.list
sudo apt update
sudo apt install r-base -y
R --version

## Instalando o RStudio
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2022.12.0-353-amd64.deb
sudo apt install -f ./rstudio-2022.12.0-353-amd64.deb -y
sudo rm ./rstudio-2022.12.0-353-amd64.deb





#-----------------------------------------------------------------------------------------
# Instalando Julia
#-----------------------------------------------------------------------------------------

sudo apt install julia -y #--classic #No Ubuntu é necessário adicionar o --classic





#-----------------------------------------------------------------------------------------
# Demais ajustes e configurações do sistema
#-----------------------------------------------------------------------------------------

## Tirando o tempo de espera do botão desligar
gsettings set org.gnome.SessionManager logout-prompt false

## Criando um arquivo com aliases para comandos resumidos
echo "alias upd='sudo apt update && sudo apt upgrade'" >> ~/.bash_aliases







#-----------------------------------------------------------------------------------------
# Arrumando o menu de boot no ****Pop!OS****
#-----------------------------------------------------------------------------------------

#sudo mount /dev/nvme0n1p1 /mnt 
#cd /mnt/EFI
#
#sudo cp -ax Microsoft /boot/efi/EFI
#
#sudo echo "timeout 5
#console-mode max" >> /boot/efi/loader/loader.conf






#-----------------------------------------------------------------------------------------
# Instalando o grub-customizer no ****Ubuntu****
#-----------------------------------------------------------------------------------------
#
#sudo add-apt-repository ppa:danielrichter2007/grub-customizer
#sudo apt install grub-customizer -y










#-----------------------------------------------------------------------------------------
# Criando um arquivo com uma lista de extensões a serem baixadas
#-----------------------------------------------------------------------------------------

touch ~/lista_ext.txt

echo "
# ArcMenu
Adiciona um menu tipo Menu Iniciar do Windows e tem muitos icones legais
https://extensions.gnome.org/extension/3628/arcmenu/

# Aylur's Widgets
Esta extensão adiciona uma série de wigdets à área de trabalho e à barra de tarefas.
https://extensions.gnome.org/extension/5338/aylurs-widgets/

# Control Blur Effect On Lock Screen
Permite o plano de fundo aparecer na tela de bloqueio
https://extensions.gnome.org/extension/2935/control-blur-effect-on-lock-screen/

# Dash to dock for Cosmic
Um painel de ajustes para a doca do Pop_OS
https://extensions.gnome.org/extension/5004/dash-to-dock-for-cosmic/

# Just Perfection
Adiciona diversos controles de ajustes da interface
https://extensions.gnome.org/extension/3843/just-perfection/

# Maximize to workspace with history
Quando janelas são maximizadas, elas pulam de workspace
https://extensions.gnome.org/extension/2857/maximize-to-workspace-with-history/

# OpenWeather
Extensão de previsão meteorológica
https://extensions.gnome.org/extension/750/openweather/

# Rounded Window Corners
Arredonda as quinas das janelas
https://github.com/yilozt/rounded-window-corners

# Show Desktop Button
Adicionar botão de visualizar o desktop
https://extensions.gnome.org/extension/1194/show-desktop-button/

# Switch workspace
Facilita a mudança entre workspaces
https://extensions.gnome.org/extension/1231/switch-workspace/

# Time ++
Adiciona um timer com cronômetro e pomodoros
https://extensions.gnome.org/extension/1238/time/

# Unite
A extensão Unite permite arrumar visualmente o ambiente Ubuntu, ajustando a aparência da interface.
https://extensions.gnome.org/extension/1287/unite/

# GNOME Clipboard
CLipboard do GNOME
https://extensions.gnome.org/extension/4422/gnome-clipboard/

" >> ~/lista_ext.txt






#-----------------------------------------------------------------------------------------
# Instalando as exntensões GNOME
#-----------------------------------------------------------------------------------------












#-----------------------------------------------------------------------------------------
# Mensagem final
#-----------------------------------------------------------------------------------------

neofetch

sleep 2
echo "A LISTA COM AS EXTENSÕES DO GNOME-SHELL RECOMENDADAS PARA SEREM INSTALADAS ESTÃO SALVAS EM ~/lista_ext.txt.
VÁ ATÉ LÁ VERIFICÁ-LAS."
echo ""

sleep 2
echo "A instalação terminou, mas precisamos reiniciar o computador."

sleep 2
echo "Reiniciar agora?[S/N]: "
read resposta
if [ $resposta == "S" -o $resposta == "s" ] ; then
reboot 
else sleep 2 
echo "Reinicie o computador assim que possível."
fi
