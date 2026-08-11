# Playbook de instalação

Procedimento operacional para preparar uma máquina recém-instalada.

## 1. Antes de começar

1. Faça backup dos arquivos pessoais e das configurações que deseja preservar.
2. Confirme que a máquina usa Debian, Ubuntu ou uma derivada e possui acesso à internet.
3. Instale `git` se a imagem da distribuição não o incluir.
4. Clone o repositório como usuário comum, preferencialmente em `~/repos/linux`.

## 2. Configuração pessoal

```bash
cd ~/repos/linux
cp config/user.env.example config/user.env
editor config/user.env
```

Preencha `GIT_USER_NAME` e `GIT_USER_EMAIL`. O arquivo não será versionado.

## 3. Simulação obrigatória

```bash
./install.sh --dry-run --profile full
```

Revise a distribuição e o desktop detectados, os módulos selecionados, os pacotes e os repositórios externos. Se desejar uma instalação menor, escolha `base`, `dev` ou `desktop`.

O dry-run não consegue prever respostas dos servidores nem validar completamente operações interativas, mas não deve escrever configurações.

## 4. Execução

```bash
./install.sh --profile full
```

Informe a senha de `sudo` quando solicitado. Não feche o terminal durante atualizações do APT. Falhas interrompem o fluxo; depois de corrigir a causa, execute novamente — os módulos foram projetados para tolerar repetição.

## 5. OneDrive opcional

```bash
./install.sh --modules onedrive
```

No assistente do rclone, crie um remote chamado exatamente `OneDrive`. Depois, valide com:

```bash
rclone lsd OneDrive:
rclone --vfs-cache-mode writes mount OneDrive: "$HOME/OneDrive"
```

Interrompa o segundo comando após o teste; o autostart fará a montagem nas sessões futuras.

## 6. Validação final

```bash
git config --global --get-regexp '^user\.'
pyenv --version
uv --version
docker version
starship --version
flatpak list --app
fastfetch
```

Abra um terminal novo e teste os atalhos. Para Docker sem `sudo`, encerre e inicie a sessão ou reinicie a máquina, pois a associação ao grupo só é atualizada em uma nova sessão.

## 7. Recuperação

Se um módulo falhar, execute somente ele depois da correção:

```bash
./install.sh --modules docker
```

Não prossiga cegamente após erros de repositório APT. Use a seção correspondente do runbook para diagnóstico.
