# Adicionar o repositório do Dcoker
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Instalar o Docker propriamente dito
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Testar a instalação do Docker
sudo docker run hello-world

# Permitir que o Docker rode fora do usuário raiz
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world # Para verificar se conseguimos rodar o Docker sem sudo

# Se houver um erro no passo anterior, rodar o seguinte:
# sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
# sudo chmod g+rwx "$HOME/.docker" -R

# Configurar o Docker para inicializar junto com o sistema
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Remover o Docker da inicialização do sistema
# sudo systemctl disable docker.service
# sudo systemctl disable containerd.service

