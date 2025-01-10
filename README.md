# Arch Linux

Estes são meus dotfiles para o Arch Linux.

# Hyprland Keybindings

Abaixo estão as combinações de teclas configuradas no Hyprland, organizadas e explicadas. 

### Modificadores
- **$mainMod**: Tecla `Windows` (SUPER).
- **SUPER_SHIFT**: Combinação `Windows + Shift`.

---

### Aplicações Principais
| **Combinação**       | **Ação**                            | **Descrição**                                          |
|-----------------------|-------------------------------------|-------------------------------------------------------|
| `Windows + Enter`     | `exec, $terminal`                  | Abre o terminal.                                      |
| `Windows + Q`         | `killactive`                      | Fecha a janela ativa.                                 |
| `Windows + L`         | `exec, hyprlock`                  | Bloqueia a tela.                                      |
| `Windows + Shift + L` | `exec, nwg-bar`                   | Inicia o NWG-Bar.                                     |
| `Windows + D`         | `exec, $browser`                  | Abre o navegador configurado.                        |
| `Windows + E`         | `exec, $fileManager`              | Abre o gerenciador de arquivos.                      |
| `Windows + T`         | `exec, $ide`                      | Abre o IDE configurado.                              |
| `Windows + V`         | `togglefloating`                  | Alterna o estado da janela entre flutuante e fixada. |
| `Windows + Space`     | `exec, $menu`                     | Abre o menu configurado.                             |

---

### Janela e Divisões
| **Combinação**       | **Ação**                   | **Descrição**                                      |
|-----------------------|----------------------------|---------------------------------------------------|
| `Windows + J`         | `togglesplit`             | Alterna o layout de divisão da janela.           |
| `Windows + F`         | `fullscreen`              | Alterna o modo de tela cheia para a janela ativa. |
| `Windows + Escape`    | `exec, killall waybar \|\| waybar` | Reinicia o Waybar.                                |
| `Windows + R`         | `exec, killall hyprpaper \|\| hyprpaper` | Reinicia o Hyprpaper.                             |
| `Windows + Shift + R` | `exec, systemctl --user restart pulseaudio.service` | Reinicia o PulseAudio.                           |

---

### Controle de Áudio
| **Combinação**          | **Ação**                                    | **Descrição**                           |
|--------------------------|---------------------------------------------|------------------------------------------|
| `XF86AudioRaiseVolume`   | `wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+` | Aumenta o volume em 5%.                 |
| `XF86AudioLowerVolume`   | `wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-` | Diminui o volume em 5%.                 |
| `XF86AudioMute`          | `wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle` | Alterna o mute do áudio.                |
| `XF86AudioMicMute`       | `wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle` | Alterna o mute do microfone.           |
| `XF86AudioNext`          | `playerctl next`                           | Avança para a próxima faixa de música.  |
| `XF86AudioPause`         | `playerctl play-pause`                     | Alterna entre pausar e reproduzir.      |
| `XF86AudioPlay`          | `playerctl play-pause`                     | Alterna entre pausar e reproduzir.      |
| `XF86AudioPrev`          | `playerctl previous`                       | Volta para a faixa anterior.           |

---

### Controle de Tela
| **Combinação**          | **Ação**                          | **Descrição**                 |
|--------------------------|-----------------------------------|--------------------------------|
| `XF86MonBrightnessUp`    | `brightnessctl s 10%+`           | Aumenta o brilho em 10%.      |
| `XF86MonBrightnessDown`  | `brightnessctl s 10%-`           | Reduz o brilho em 10%.        |

---

### Controle de Foco
| **Combinação**       | **Ação**          | **Descrição**                                  |
|-----------------------|-------------------|-----------------------------------------------|
| `Windows + ←`         | `movefocus, l`   | Move o foco para a janela à esquerda.         |
| `Windows + →`         | `movefocus, r`   | Move o foco para a janela à direita.          |
| `Windows + ↑`         | `movefocus, u`   | Move o foco para a janela acima.              |
| `Windows + ↓`         | `movefocus, d`   | Move o foco para a janela abaixo.             |

---

### Workspaces
| **Combinação**                | **Ação**              | **Descrição**                                     |
|--------------------------------|-----------------------|--------------------------------------------------|
| `Windows + 1-9/0`             | `workspace, <n>`     | Vai para o workspace correspondente.            |
| `Windows + Shift + 1-9/0`     | `movetoworkspace, <n>` | Move a janela ativa para o workspace indicado. |

---

### Diversos
| **Combinação**          | **Ação**                             | **Descrição**                            |
|--------------------------|--------------------------------------|------------------------------------------|
| `Windows + Shift + ↑`    | `exec, hyprsunset --temperature 6000` | Ajusta o modo noturno para 6000K.       |
| `Windows + Shift + ↓`    | `exec, hyprsunset --temperature 5000` | Ajusta o modo noturno para 5000K.       |
| `Print`                  | `exec, grim -g "$(slurp)" &`         | Captura uma área da tela com o Grim.     |
| `Windows + C`            | `exec, ~/.config/eww/eww-script`     | Executa o script do Eww configurado.     |

---

Essas combinações oferecem um controle eficiente para trabalhar no Hyprland com produtividade e fluidez.

