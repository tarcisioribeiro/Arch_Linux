# Guia de Instalação - Arch Linux Setup v2.0

## Novo Script Unificado

Este repositório agora possui um **script de instalação unificado** (`install_unified.sh`) que consolida todos os scripts de instalação anteriores em um único arquivo.

## Principais Vantagens

✅ **Sem Recarregamentos**: Não é necessário recarregar o shell ou reiniciar a máquina durante a instalação
✅ **Tudo em Um**: Todos os componentes (base, aplicações e ferramentas avançadas) em um único script
✅ **Instalação Inteligente**: Carrega automaticamente o Homebrew após instalação
✅ **Melhor Tratamento de Erros**: Verificações e mensagens de erro mais claras
✅ **Menu Interativo**: Escolha exatamente o que deseja instalar

## Como Usar

### Instalação Rápida (Completa)

```bash
cd ~/Development/Arch_Linux
./install_unified.sh
# Escolha a opção 5 (Instalação Completa)
```

### Instalação Seletiva

```bash
cd ~/Development/Arch_Linux
./install_unified.sh
# Escolha as opções desejadas (ex: 1 2 para Base + Aplicações)
```

## Opções Disponíveis

1. **📦 Configuração Base**
   - ZSH + Oh My ZSH + Oh My Posh
   - Tmux com plugins
   - Fontes (JetBrains Mono, FantasqueSans)
   - Tema Dracula (GTK + Ícones)
   - Flatpak
   - HomeBrew
   - Stow configs (cava, lazygit, gtk, kitty)

2. **🚀 Aplicações Essenciais**
   - Pacotes Homebrew (git-delta, onefetch)
   - Apps Flatpak (Postman, Telegram, Emuladores)
   - Pacotes AUR (VS Code, Yazi, Steam, GitHub Desktop)
   - Configurações para root
   - Tema Dracula para TTY e Yazi

3. **🤖 Ferramentas Avançadas**
   - Ollama + Llama3
   - Docker + Docker Compose
   - Portainer (se disponível)
   - Open WebUI

4. **🎨 Apenas Tema Dracula**
   - Instalação isolada do tema GTK
   - Ícones Tela Dracula

5. **⚡ Instalação Completa**
   - Todas as opções acima em sequência

## Diferenças dos Scripts Antigos

### Scripts Antigos (Descontinuados)
- `install.sh`: Menu que chamava outros scripts
- `installation_1.sh`: Configuração base
- `installation_2.sh`: Aplicações
- `installation_3.sh`: Ferramentas avançadas

**Problemas:**
- Necessitava recarregar o shell entre scripts
- Homebrew não estava disponível imediatamente após instalação
- Múltiplos arquivos para gerenciar

### Novo Script Unificado
- `install_unified.sh`: Tudo em um único script
- Carrega Homebrew automaticamente no ambiente atual
- Executa tudo sequencialmente sem recarregamentos
- Melhor tratamento de erros e feedback

## O Que Mudou Tecnicamente

### Carregamento Automático do Homebrew
```bash
# O script agora carrega o brew imediatamente após instalação
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Execução Inline
Todo o código está no mesmo arquivo, eliminando dependências entre scripts.

### Melhor Verificação de Pré-requisitos
- Verifica Arch Linux
- Verifica conexão com internet
- Verifica existência do diretório do projeto
- Verifica se comandos existem antes de usar

### Tratamento de Erros Robusto
- Cada operação crítica é verificada
- Mensagens de aviso para operações não críticas
- Continua a instalação mesmo se algumas partes falharem

## Após a Instalação

### Para Aplicar Todas as Mudanças

```bash
# Opção 1: Recarregar configuração do ZSH (recomendado)
source ~/.zshrc

# Opção 2: Fazer logout e login novamente (para mudar shell padrão)
```

### Verificar Instalação

```bash
# Verificar ZSH
zsh --version

# Verificar Oh My Posh
oh-my-posh --version

# Verificar Homebrew
brew --version

# Verificar Docker (se instalou ferramentas avançadas)
docker --version

# Verificar Ollama (se instalou ferramentas avançadas)
ollama --version
```

## Solução de Problemas

### Homebrew não encontrado após instalação base
```bash
# Execute manualmente:
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Docker precisa de sudo
```bash
# Adicione seu usuário ao grupo docker:
sudo usermod -aG docker $USER
# Faça logout e login novamente
```

### Fontes não aparecem
```bash
# Reconstrua o cache de fontes:
fc-cache -fv
```

### Tema Dracula não aplicado
```bash
# Use o nwg-look para selecionar o tema:
nwg-look
# Selecione "Dracula" em Themes e "Tela-dracula" em Icons
```

## Scripts Auxiliares

Os scripts antigos foram mantidos para referência, mas não são mais necessários:
- `install.sh` → Use `install_unified.sh` em vez disso
- `installation_1.sh` → Integrado em `install_unified.sh`
- `installation_2.sh` → Integrado em `install_unified.sh`
- `installation_3.sh` → Integrado em `install_unified.sh`

## Estrutura do Projeto

```
Arch_Linux/
├── install_unified.sh          # ← NOVO SCRIPT PRINCIPAL
├── install.sh                  # (descontinuado)
├── installation_1.sh           # (descontinuado)
├── installation_2.sh           # (descontinuado)
├── installation_3.sh           # (descontinuado)
├── customization/
│   ├── bash/
│   ├── zsh/
│   ├── tmux/
│   └── git/
├── fonts/
├── packages/
│   ├── oh_my_zsh_install.sh
│   └── brew_install.sh
├── stow/
│   ├── cava/
│   ├── lazygit/
│   ├── gtk-3.0/
│   ├── gtk-4.0/
│   └── kitty/
└── scripts/
```

## Contribuindo

Se encontrar problemas ou tiver sugestões:
1. Abra uma issue descrevendo o problema
2. Inclua logs relevantes
3. Descreva seu ambiente (versão do Arch, kernel, etc.)

## Licença

Este projeto é de código aberto. Sinta-se livre para usar e modificar.
