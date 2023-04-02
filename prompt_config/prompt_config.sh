#!/bin/bash
# Iniciar copiando os arquivos .bashrc e o gterminal.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/repos/linux/gterminal.dconf
cp ~/repos/linux/prompt_config/.bashrc ~/.bashrc

# Baixar as fontes necessárias
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip

# Descompactar as fontes na pasta ~/.local/share/fonts
mkdir ~/.local/share/fonts
unizip ~/Downloads/Firacode.zip ~/.local/share/fonts
unizip ~/Downloads/NerdFontsSymbolsOnly.zip ~/.local/share/fonts

# Deletar os .zip baixados 
rm ~/Downloads/Firacode.zip
rm ~/Downloads/NerdFontsSymbolsOnly.zip

# Instalar o starship
curl -sS https://starship.rs/install.sh | sh

# Copiar a configuração do starship
cp ~/repos/linux/promp_config/starship.toml ~/.config

# Adicionar o ativador do starship ao arquivo .bashrc
sudo echo 'eval "$(starship init bash)"' >> ~/.bashrc