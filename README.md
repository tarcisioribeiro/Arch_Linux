# 🐧 Arch Linux Setup Automatizado

Uma solução completa para configuração automatizada do Arch Linux com tema Dracula, ferramentas de produtividade e ambiente de desenvolvimento otimizado.

## 📋 Visão Geral

Este projeto automatiza a instalação e configuração de um ambiente Arch Linux completo, incluindo:

- **Gerenciador de Janelas**: i3wm com configurações personalizadas
- **Terminal**: ZSH com Oh My Posh e tema Dracula
- **Tema Visual**: Dracula aplicado consistentemente em todo o sistema
- **Ferramentas de Desenvolvimento**: Git, Docker, VS Code, Node.js, e mais
- **Utilitários**: Tmux, FZF, Yazi, Cava, e outras ferramentas modernas

## 🚀 Instalação Rápida

```bash
git clone https://github.com/seu-usuario/Arch_Linux.git ~/Development/Arch_Linux
cd ~/Development/Arch_Linux
./installation_1.sh
```

## 📦 Scripts de Instalação

### `installation_1.sh` - Configuração Base
- Instala pacotes essenciais do sistema
- Configura ZSH com Oh My ZSH e Oh My Posh
- Instala fontes Nerd Font
- Configura Tmux e Stow
- Aplica tema Dracula (GTK, ícones)

### `installation_2.sh` - Aplicações e Ferramentas
- Instala aplicações via Flatpak
- Configura aplicações AUR (yay)
- Instala Steam, VS Code, GitHub Desktop
- Configura tema Dracula para TTY e Yazi

### `installation_3.sh` - Ferramentas Avançadas
- Instala Ollama (IA local)
- Configura Docker e Portainer
- Instala Open WebUI
- Otimiza performance do CPU

## 🗂️ Estrutura do Projeto

```
Arch_Linux/
├── customization/          # Configurações personalizadas
│   ├── bash/              # Configurações do Bash
│   ├── git/               # Configurações do Git
│   ├── tmux/              # Configurações do Tmux
│   ├── vim/               # Configurações do Vim
│   └── zsh/               # Configurações do ZSH
├── fonts/                 # Fontes Nerd Font
├── packages/              # Scripts de instalação
├── scripts/               # Scripts utilitários
├── stow/                  # Dotfiles gerenciados pelo Stow
└── README.md             # Atalhos do i3wm
```

## ⌨️ Atalhos Principais do i3

| Atalho | Ação |
|--------|------|
| `Super + Return` | Terminal (Alacritty) |
| `Super + d` | Google Chrome |
| `Super + t` | VS Code |
| `Super + e` | Gerenciador de arquivos |
| `Super + q` | Fechar janela |
| `Super + f` | Tela cheia |

[Ver todos os atalhos](README.md)

## 🎨 Tema Dracula

O tema Dracula está aplicado em:
- Terminal (ZSH/Oh My Posh)
- GTK 3.0 e 4.0
- Ícones do sistema
- TTY (console)
- Aplicações (Yazi, Cava, etc.)

## ⚠️ Pré-requisitos

- **Sistema**: Arch Linux
- **Conexão**: Internet ativa
- **Privilégios**: Sudo configurado
- **Espaço**: ~2GB livres

## 🔧 Personalização

### Modificar Tema
Edite os arquivos em `customization/` para personalizar:
- Cores do terminal: `customization/zsh/.zshrc`
- Atalhos do i3: Veja documentação do i3wm
- Alias do ZSH: `customization/zsh/.zsh_aliases`

### Adicionar Aplicações
Modifique `installation_2.sh` para incluir suas aplicações preferidas.

## 🛠️ Solução de Problemas

### Erro de Conexão
```bash
ping -c 3 8.8.8.8  # Testar conectividade
```

### Reinstalar Oh My ZSH
```bash
rm -rf ~/.oh-my-zsh
./packages/oh_my_zsh_install.sh
```

### Verificar Logs
```bash
journalctl -xe  # Logs do sistema
```

## 📚 Ferramentas Incluídas

### Desenvolvimento
- Git com Delta (diff colorido)
- VS Code
- Node.js + npm
- Docker + Portainer
- GitHub Desktop

### Terminal
- ZSH + Oh My ZSH + Oh My Posh
- Tmux (multiplexer)
- FZF (fuzzy finder)
- Yazi (file manager)
- Fastfetch (system info)

### Multimídia
- Cava (visualizador de áudio)
- Steam + emuladores
- Telegram, Postman

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/nova-funcionalidade`
3. Commit suas mudanças: `git commit -m 'Adiciona nova funcionalidade'`
4. Push para a branch: `git push origin feature/nova-funcionalidade`
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para detalhes.

## 📞 Suporte

- **Issues**: Abra uma issue no GitHub
- **Discussões**: Use as discussões do repositório
- **Email**: seu-email@example.com

---

**⭐ Se este projeto foi útil, considere dar uma estrela no GitHub!**