# Arch Linux

Estes são os meus dotfiles para o **Arch Linux**.

## Modificadores
- **$mainMod**: Tecla `Alt`.
- **SUPER_SHIFT**: Combinação `Alt + Shift`.

---

## Aplicações Principais
| **Combinação**       | **Ação**                            | **Descrição**                                          |
|-----------------------|-------------------------------------|-------------------------------------------------------|
| `Alt + Enter`     | `exec, $terminal`                  | Abre o terminal.                                      |
| `Alt + Q`         | `killactive`                      | Fecha a janela ativa.                                 |
| `Alt + L`         | `exec, hyprlock`                  | Bloqueia a tela.                                      |
| `Alt + Shift + L` | `exec, wlogout`                   | Inicia o Wlogout.                                     |
| `Alt + D`         | `exec, $browser`                  | Abre o navegador configurado.                        |
| `Alt + E`         | `exec, $fileManager`              | Abre o gerenciador de arquivos.                      |
| `Alt + T`         | `exec, $ide`                      | Abre o IDE configurado.                              |
| `Alt + V`         | `togglefloating`                  | Alterna o estado da janela entre flutuante e fixada. |
| `Alt + Space`     | `exec, $menu`                     | Abre o menu configurado.                             |

---

## Janela e Divisões
| **Combinação**       | **Ação**                   | **Descrição**                                      |
|-----------------------|----------------------------|---------------------------------------------------|
| `Alt + J`         | `togglesplit`             | Alterna o layout de divisão da janela.           |
| `Alt + F`         | `fullscreen`              | Alterna o modo de tela cheia para a janela ativa. |
| `Alt + Escape`    | `exec, killall waybar \|\| waybar` | Reinicia o Waybar.                                |
| `Alt + R`         | `exec, hyprctl reload` | Reinicia o Hypr.                             |
| `Alt + Shift + R` | `exec, killall hyprpaper \|\| hyprpaper` | Reinicia o Hyprpaper.                           |

---

## Controle de Áudio
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

## Controle de Tela
| **Combinação**          | **Ação**                          | **Descrição**                 |
|--------------------------|-----------------------------------|--------------------------------|
| `XF86MonBrightnessUp`    | `brightnessctl s 10%+`           | Aumenta o brilho em 10%.      |
| `XF86MonBrightnessDown`  | `brightnessctl s 10%-`           | Reduz o brilho em 10%.        |

---

## Controle de Foco
| **Combinação**       | **Ação**          | **Descrição**                                  |
|-----------------------|-------------------|-----------------------------------------------|
| `Alt + ←`         | `movefocus, l`   | Move o foco para a janela à esquerda.         |
| `Alt + →`         | `movefocus, r`   | Move o foco para a janela à direita.          |
| `Alt + ↑`         | `movefocus, u`   | Move o foco para a janela acima.              |
| `Alt + ↓`         | `movefocus, d`   | Move o foco para a janela abaixo.             |

---

## Workspaces
| **Combinação**                | **Ação**              | **Descrição**                                     |
|--------------------------------|-----------------------|--------------------------------------------------|
| `Alt + 1-9/0`             | `workspace, <n>`     | Vai para o workspace correspondente.            |
| `Alt + Shift + 1-9/0`     | `movetoworkspace, <n>` | Move a janela ativa para o workspace indicado. |

---

## Diversos
| **Combinação**          | **Ação**                             | **Descrição**                            |
|--------------------------|--------------------------------------|------------------------------------------|
| `Alt + Shift + ↑`    | `exec, redshift --temperature 5000` | Ajusta o modo noturno para 5000K.       |
| `Alt + Shift + ↓`    | `exec, redshift --temperature 3000` | Ajusta o modo noturno para 3000K.       |
| `Print`                  | `exec, grim -g "$(slurp)" &`         | Captura uma área da tela com o Grim.     |

---

