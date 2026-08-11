# Runbook de manutenção

Guia para modificar, testar e reparar manualmente o Linux Bootstrap.

## Princípios do projeto

- Um único instalador coordena módulos pequenos.
- Pacotes são dados em `packages/`, não comandos espalhados pelos scripts.
- Diferenças de distribuição ficam no módulo que precisa delas.
- Configurações pessoais ou segredos nunca entram no Git.
- Toda mudança deve suportar uma segunda execução sem causar duplicações ou perda de configuração.

## Adicionar ou remover pacotes

Edite uma das listas:

- `packages/base.txt`: ferramentas essenciais para qualquer perfil.
- `packages/apps.txt`: aplicativos de desktop e utilitários.
- `packages/python-build.txt`: bibliotecas necessárias para compilar Python.
- `packages/flatpaks.txt`: IDs de aplicativos instalados no escopo do usuário pelo Flathub.

Use um pacote por linha e comentários iniciados por `#`. Depois rode:

```bash
./install.sh --dry-run --modules system,apps,flatpak
```

Antes de adicionar um pacote APT, confirme que ele existe tanto em Debian quanto em Ubuntu. Se for específico, crie lógica condicional no módulo em vez de colocá-lo na lista comum.

Aplicativos com repositórios oficiais para Debian/Ubuntu devem preferir APT. Use Flatpak para aplicativos desktop portáveis entre distribuições; Snap não faz parte da política do projeto.

## Criar um módulo

1. Crie `modules/NOME.sh`.
2. Declare uma função `module_NOME`.
3. Use `run` para comandos mutáveis, `install_file` para arquivos e `ensure_line` para linhas únicas.
4. Adicione o nome a `--list-modules` e, se apropriado, a um perfil em `install.sh`.
5. Documente-o no README.

Modelo:

```bash
#!/usr/bin/env bash

module_exemplo() {
  run mkdir -p "$HOME/.config/exemplo"
  install_file "$ROOT_DIR/config/exemplo.conf" "$HOME/.config/exemplo/config"
}
```

## Atualizar configurações do GNOME

Exporte somente o escopo necessário:

```bash
dconf dump /org/gnome/desktop/wm/keybindings/ > config/gnome/keybindings.dconf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > config/gnome/custom-keybindings.dconf
dconf dump /org/gnome/terminal/legacy/profiles:/ > config/gnome/terminal.dconf
```

Revise o diff antes de versionar, pois dumps podem conter identificadores específicos da máquina.

## Atualizar Starship ou fontes

Edite `config/starship.toml` e valide abrindo um shell com Starship. Para mudar a versão padrão das fontes, altere `NERD_FONTS_VERSION` em `config/user.env.example`; usuários existentes podem sobrescrevê-la em `config/user.env`.

As fontes são instaladas em um diretório versionado. Arquivos antigos com a nomenclatura Nerd Fonts 2.x (`Complete`) são movidos para `~/.local/share/linux-bootstrap/font-backups/legacy-nerd-fonts-v2`, fora da árvore examinada pelo Fontconfig. No KDE, o módulo também fixa `LineSpacing=0` no perfil ativo do Konsole para reduzir emendas nos separadores Powerline.

## Testes antes de commit

```bash
bash -n install.sh lib/common.sh modules/*.sh
shellcheck install.sh lib/common.sh modules/*.sh
./install.sh --list-modules
./install.sh --dry-run --profile full
git diff --check
```

Se ShellCheck não estiver instalado, instale-o manualmente ou registre essa limitação na revisão. O teste real deve ser feito primeiro em uma VM limpa de cada família suportada.

## Diagnóstico comum

### APT informa repositório ou codename inválido

Confira:

```bash
. /etc/os-release
printf 'ID=%s ID_LIKE=%s CODENAME=%s\n' "$ID" "${ID_LIKE:-}" "${VERSION_CODENAME:-}"
cat /etc/apt/sources.list.d/docker.list
```

Derivadas podem publicar seu próprio codename, que o repositório Docker não reconhece. Nesses casos, defina explicitamente o codename da distribuição-base na lógica de `detect_platform` e documente a derivada testada.

O instalador prioriza `UBUNTU_CODENAME` em derivadas de Ubuntu, conforme a forma recomendada pela documentação do Docker.

### APT ignora a chave do OnlyOffice por formato não suportado

O arquivo em `/etc/apt/keyrings/onlyoffice.asc` deve ser uma chave pública ASCII exportada, e não o banco interno (`keybox`) do GnuPG. Execute novamente o módulo `apps`; ele baixa, exporta e substitui a chave corretamente.

### Docker funciona somente com sudo

```bash
getent group docker
id
sudo usermod -aG docker "$USER"
```

Encerre completamente a sessão e entre novamente. Não altere permissões do socket Docker indiscriminadamente.

### Pyenv não aparece no terminal

```bash
grep linux-bootstrap ~/.bashrc
cat ~/.config/linux-bootstrap/shell.sh
exec bash
```

Confirme que `~/.pyenv/bin` existe e que nenhuma configuração anterior retorna do `.bashrc` antes da linha gerenciada.

### Atalhos GNOME não foram aplicados

Execute o módulo dentro de uma sessão gráfica do mesmo usuário:

```bash
printf '%s\n' "$XDG_CURRENT_DESKTOP" "$DBUS_SESSION_BUS_ADDRESS"
./install.sh --modules desktop
```

`dconf` depende do barramento da sessão; SSH ou console virtual podem não ter o ambiente necessário.

### Reverter uma configuração

O projeto não remove pacotes automaticamente. Para configurações, restaure seu backup ou use as ferramentas nativas (`dconf reset`, `git config --global --unset`, remoção da linha gerenciada no `.bashrc`). Antes de automatizar desinstalações, crie um módulo de rollback explícito e testado.

## Processo recomendado de mudança

1. Abra uma branch.
2. Faça uma mudança pequena e atualize a documentação correspondente.
3. Execute validação estática e dry-run.
4. Teste em VM limpa Debian e Ubuntu; teste GNOME/KDE se a mudança afetar desktop.
5. Registre no commit quais combinações foram testadas.
6. Faça merge somente depois de uma segunda execução bem-sucedida, comprovando idempotência.
