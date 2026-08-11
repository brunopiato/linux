# Linux Bootstrap

Automação pessoal, modular e repetível para preparar uma instalação nova de Debian, Ubuntu ou uma distribuição derivada.

O projeto instala ferramentas comuns, configura o ambiente de desenvolvimento e aplica preferências de desktop sem manter um script diferente para cada distribuição. As diferenças entre Debian e Ubuntu e entre GNOME e KDE são detectadas durante a execução.

## Início rápido

```bash
git clone <URL-DESTE-REPOSITORIO> ~/repos/linux
cd ~/repos/linux
cp config/user.env.example config/user.env
# Edite config/user.env com seus dados.
./install.sh --dry-run
./install.sh
```

Não execute o instalador inteiro com `sudo`. Ele solicitará elevação apenas nas operações de sistema.

## Perfis

| Perfil | Conteúdo |
|---|---|
| `base` | Atualização do sistema, pacotes essenciais e Git |
| `dev` | Base, aplicativos APT/Flatpak, Python, Docker e prompt |
| `desktop` | Sistema, aplicativos APT/Flatpak, atalhos, prompt e wallpaper |
| `full` | Todos os anteriores, exceto OneDrive interativo |

O perfil padrão é `full`. Exemplos:

```bash
./install.sh --profile dev
./install.sh --modules system,git,docker
./install.sh --list-modules
```

## Módulos

- `system`: atualiza a distribuição e instala `packages/base.txt`.
- `git`: configura identidade global a partir de `config/user.env`.
- `apps`: instala pacotes APT, DBeaver CE, VS Code e OnlyOffice por repositórios oficiais.
- `flatpak`: instala Flatpak, integra-o ao Discover e instala Obsidian e Discord pelo Flathub.
- `python`: instala dependências de compilação, Pyenv e uv.
- `docker`: configura o repositório oficial correto para Debian ou Ubuntu.
- `desktop`: aplica atalhos e perfil de terminal no GNOME ou atalhos no KDE.
- `prompt`: instala FiraCode Nerd Font, Starship e sua configuração.
- `wallpaper`: copia e aplica o wallpaper no KDE Plasma ou GNOME.
- `onedrive`: abre o assistente do rclone e cria o autostart de montagem.

O OneDrive é propositalmente separado por exigir interação:

```bash
./install.sh --modules onedrive
```

## Estrutura

```text
.
├── install.sh             # CLI e orquestração
├── lib/common.sh          # detecção, logs e funções idempotentes
├── modules/               # uma função module_<nome> por recurso
├── packages/              # listas declarativas de pacotes
├── config/                # configurações copiadas para a máquina
│   ├── gnome/
│   ├── shell/
│   └── autostart/
├── wallpapers/            # ativos visuais
├── PLAYBOOK.md            # instalação de uma máquina nova
└── RUNBOOK.md             # manutenção e resolução de problemas
```

## Segurança e comportamento

- `--dry-run` mostra a maior parte das ações sem alterar o sistema.
- Dados pessoais ficam em `config/user.env`, ignorado pelo Git.
- Arquivos de configuração são instalados em caminhos dedicados quando possível.
- O `.bashrc` recebe somente linhas de carregamento, evitando sua substituição.
- Downloads usam HTTPS, mas instaladores remotos de Pyenv, uv e Starship ainda exigem confiança nos respectivos fornecedores.
- Docker, DBeaver, VS Code e OnlyOffice usam seus repositórios oficiais para receber atualizações pelo APT.
- O projeto não usa Snap. Aplicativos desktop sem repositório APT adequado ficam em `packages/flatpaks.txt`.
- O instalador não reinicia a máquina automaticamente.

## Compatibilidade

O alvo principal é Debian/Ubuntu em arquiteturas suportadas pelos repositórios oficiais usados. GNOME e KDE Plasma recebem tratamento específico. Derivadas são aceitas quando `/etc/os-release` declara parentesco com Debian ou Ubuntu, mas devem ser testadas primeiro com `--dry-run`.

Consulte [PLAYBOOK.md](PLAYBOOK.md) para uso e [RUNBOOK.md](RUNBOOK.md) para manutenção.
