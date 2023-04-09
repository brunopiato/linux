#!/bin/bash

# Arquivo de configuração do sistema após formatação
: << 'COMMENT'
Pop OS 22.04 LTS (realeased in April 25, 2022)
    Linux Kernel 5.16
    Based on Ubuntu 22.04
    GNOME Shell 42
    GNOME Settings 41.4
    GNOME Terminal 3.43.9
Other features
    Better Multi-Monitor support
    Fixed layout on HiDPI displays
    Improved performance
    Pop!_OS Upgrade will only activate when you are checking or performing upgrades.
    When updating Debian packages, you get the ability to resume it if interrupted.
    Added support for laptop privacy screens.
    RDP by default for remote desktop use.
    New default profile icon.
    Workspace improvements.
    Icons are now SVG-based instead of PNG-based.
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
sudo apt install neofetch -y
sudo apt install curl
sudo apt install snapd -y
sudo snap install snap-store
sudo apt install gparted -y
sudo apt install os-prober -y 
sudo apt install unzip
sudo apt install dconf-editor
sudo apt install neovim -y

## Instalando utilitários do plank par asubstituir a doca
#sudo apt install plank
#flatpak install flathub com.github.maoschanz.DynamicWallpaperEditor

## Instalando o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -y
sudo apt install ./google-chrome-stable_current_amd64.deb
sudo rm ./google-chrome-stable_current_amd64.deb

## Instalando o Google Drive
wget https://github.com/alexkim205/G-Desktop-Suite/releases/download/v0.3.1/G-Desktop-Suite-0.3.1.deb -O gdesktopsuite.deb
sudo dpkg -i gdesktopsuite.deb
sudo apt install ./gdesktopsuite.deb

## Instalando as extensões do GNOME
sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions -y
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
sudo apt install vlc -y #VLC Media Player

## Instalando Dropbox
curl https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb --output dropbox_2020.03.04_amd64.deb
sudo apt install ./dropbox_2020.03.04_amd64.deb
sudo rm ./dropbox_2020.03.04_amd64.deb

## Instalando um colorizador de folders para o Nautilus
sudo add-apt-repository ppa:costales/yaru-colors-folder-color #Adicionar o repositório PPA
sudo apt update #Atualizar o sistema
sudo apt install yaru-colors-folder-color folder-color #Instalar o colorizador
nautilus -q  #Reiniciar o Nautilus para que as modificações tenham efeito

## Instalando e configurando o Calibre
sudo apt-get install calibre -y
#sudo touch /etc/profile.d/calibre.sh
#sudo echo "export CALIBRE_USE_DARK_PALETTE=1" >> /etc/profile.d/calibre.sh

## Instalando o NordVPN
curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | sh
sleep 1
sudo usermod -aG nordvpn $USER


#-----------------------------------------------------------------------------------------
# Instalando Git
#-----------------------------------------------------------------------------------------
#sudo apt update
#sudo apt install git


#-----------------------------------------------------------------------------------------
# Instalando o cliente GitHub
#-----------------------------------------------------------------------------------------
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y


#-----------------------------------------------------------------------------------------
# Instalando o pyenv e o Python
#-----------------------------------------------------------------------------------------
## Instalando o gerenciador de pacotes do Python
sudo apt install python3-pip -y
python3 -m pip install --upgrade pip
#sudo apt install python3.8-venv
pip install pipx #Permite instalações locais em um ambiente global sem polui-lo

## Instalando outros pacotes importantes do Python
pip install cython #Adiciona funcionalidades da linguagem C ao Python
pip install pip-autoremove #Um pacote para desinstalar outros pacotes junto com suas dependências
pip install pip-chill #Um pacote que mostra os pacotes que estão em uso
pipx install pipreqs #Um pacote para criar arquivo requirements.tx
pipx install pipreqsnb #Um pacote para criar arquivo requirements.tx para Jupyter Notebook
pipx install pipdeptree #Mostra as dependências de cada pacote

## Instalando o gerenciador de pacotes e ambientes virtuais poetry de forma isolada
pipx install poetry #Gerenciador de projetos e ambients virtuais
poetry completions bash >> ~/.bash_completion #Adiona a autocompleção com tab ao terminal

## Instalando o pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm gettext libncurses5-dev tk-dev tcl-dev blt-dev libgdbm-dev git python2-dev python3-dev aria2
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

sudo echo 'export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

## Instalando kernel iPython
pipx install ipykernel --include-deps
ipykernel install --user

## Instalando o Jupyter Notebook
pipx install notebook

## Instalando o Jupyter Notebook e suas extensões
pipx install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user

## Instalando o JupyterLab Desktop
wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-Debian.deb
sudo apt install ./JupyterLab-Setup-Debian.deb
sudo rm ./JupyterLab-Setup-Debian.deb


#-----------------------------------------------------------------------------------------
# Instalando o R
#-----------------------------------------------------------------------------------------
sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 -y
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
sudo apt install julia --classic #No Ubuntu é necessário adicionar o --classic


#-----------------------------------------------------------------------------------------
# Demais ajustes e configurações do sistema
#-----------------------------------------------------------------------------------------
## Tirando o tempo de espera do botão desligar
#gsettings set org.gnome.SessionManager logout-prompt false
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super>q']" #Adicionar o Super+Q para fechar a janela
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t', '<Super>t']" #Adicionar o Super+T para o terminal

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
# Configurando o prompt
#-----------------------------------------------------------------------------------------
echo "A instalação está terminando."
sleep 1
read -p "Gostaria de aplicar as customizações do prompt de comando?[S/N]: " resposta

if [ "$resposta" = "S" ] || [ "$resposta" = "s" ]]; then
	bash ~/repos/linux/prompt_config/prompt_config.sh
else sleep 1
	echo "Fique a vontade para customizar o prompt da forma que preferir."
fi


#-----------------------------------------------------------------------------------------
# Instalando as extensões GNOME
#-----------------------------------------------------------------------------------------
sleep 2
var=$(pwd)
sleep 1
echo "A INSTALAÇÃO ESTÁ TERMINANDO!"
echo "NÓS ESTAMOS TRABALHANDO NO DIRETÓRIO: $var."
sleep 1
echo "VOCÊ GOSTARIA DE INSTALAR AS SEGUINTES EXTENSÕES DO GNOME-SHELL:"
echo ""
ls -l $var/extencoes_gnome42
sleep 1
read -p "INSTALAR AGORA?[S/N]: " resposta

if [ $resposta = "S" -o $resposta = "s" ] ; then
	bash ./install_extensions_PopOS.sh
	echo "PRONTO!! AS EXTENSÕES FORAM DESCOMPACTADAS E PODERÃO SER ATIVADAS APÓS A REINICIALIZAÇÃO DO SISTEMA."
	echo "O COMANDO PARA A ATIVAÇÃO É 'gnome-extensions enable UUID', em que o UUID É O IDENTIFICADOR UNIVERSAL ÚNICO DA EXTENÇÃO."
else sleep 1
	echo "OK. VOCÊ PODE INSTALÁ-LAS MAIS TARDE A PARTIR DA LISTA DE EXTENSÕES CRIADA NA SUA PASTA PESSOAL (/home/usuario)."
	#bash ./write_ext_list_PopOS.sh
fi


#-----------------------------------------------------------------------------------------
# Mensagem final
#-----------------------------------------------------------------------------------------
neofetch
sleep 2
echo "A LISTA COM AS EXTENSÕES DO GNOME-SHELL RECOMENDADAS PARA SEREM INSTALADAS ESTÃO SALVAS EM ~/lista_ext.txt.
VÁ ATÉ LÁ VERIFICÁ-LAS."
echo ""
sleep 1
echo "A instalação terminou, mas precisamos reiniciar o computador."
sleep 1
read -p "Reiniciar agora?[S/N]: " resposta

if [ $resposta = "S" -o $resposta = "s" ] ; then
	reboot
else sleep 2
	echo "Reinicie o computador assim que possível."
fi
