#!/bin/bash
# Iniciar copiando os arquivos .bashrc e o gterminal.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/repos/linux/prompt_config/gnome-terminal.properties
cp ~/repos/linux/prompt_config/.bashrc ~/.bashrc

# Baixar as fontes necessárias
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip

# Descompactar as fontes na pasta ~/.local/share/fonts
mkdir ~/.local/share/fonts
unzip ~/Downloads/FiraCode.zip -d ~/.local/share/fonts
unzip ~/Downloads/NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts

# Deletar os .zip baixados 
rm ~/Downloads/FiraCode.zip
rm ~/Downloads/NerdFontsSymbolsOnly.zip

# Recarregar o cache de fontes
fc-cache -f -v

# Instalar o starship
curl -sS https://starship.rs/install.sh | sh

# Copiar a configuração do starship
cp /home/bruno/repos/linux/prompt_config/starship.toml ~/.config

# Adicionar o ativador do starship ao arquivo .bashrc
sudo echo 'eval "$(starship init bash)"' >> ~/.bashrc
