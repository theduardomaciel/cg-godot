<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/.github/cover.png">
  <source media="(prefers-color-scheme: light)" srcset="/.github/cover_light.png">
  <img alt="Banner do projeto" src="/.github/cover_light.png">
</picture>

<br />

# Memorial 3D — Godot (Parte 2)

## 🚶 Sobre o Projeto
Um simulador minimalista em primeira pessoa para explorar o Memorial à República em Maceió–AL como requisito da disciplina de Computação Gráfica (UFAL, 2025.1).

Esta é a Parte 2 do projeto, reimplementada em Godot 4.x.  
A Parte 1 (OpenGL/C++/CMake) serviu como referência de arquitetura e funcionalidades.

Principais arquivos:
- Projeto Godot: [project.godot](project.godot)
- Cena principal: [main_scene.tscn](main_scene.tscn)
- Estrutura do memorial: [structure_v_232.tscn](structure_v_232.tscn)
- Porta (interativa): [door.tscn](door.tscn) + lógica [door.gd](door.gd)
- Bandeira animada: [flag_brasil.tscn](flag_brasil.tscn), shader [flag.gdshader](flag.gdshader) e script [flag_script.gd](flag_script.gd)
- Controlador FPS (addon): [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd)

---

## ⭐ Features
- Controle em primeira pessoa (WASD + olhar com o mouse)
  - Gravidade, pulo, corrida e modo “freefly” (noclip)
  - Captura/liberação do mouse por interação
- Cena principal pronta para executar: [main_scene.tscn](main_scene.tscn)
- Ambiente do memorial carregado via cena: [structure_v_232.tscn](structure_v_232.tscn)
- Bandeira do Brasil com shader de ondulação: [flag.gdshader](flag.gdshader) + [flag_script.gd](flag_script.gd)
- Addon de controle (FPS) configurável: [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd)
  - Atributos exportados para Input Map:
	- [`proto_controller.input_left`](addons/proto_controller/proto_controller.gd), [`proto_controller.input_right`](addons/proto_controller/proto_controller.gd), [`proto_controller.input_forward`](addons/proto_controller/proto_controller.gd), [`proto_controller.input_back`](addons/proto_controller/proto_controller.gd)
	- [`proto_controller.input_jump`](addons/proto_controller/proto_controller.gd), [`proto_controller.input_sprint`](addons/proto_controller/proto_controller.gd), [`proto_controller.input_freefly`](addons/proto_controller/proto_controller.gd)
  - Principais métodos:
	- Olhar: [`proto_controller.rotate_look`](addons/proto_controller/proto_controller.gd)
	- Freefly: [`proto_controller.enable_freefly`](addons/proto_controller/proto_controller.gd) / [`proto_controller.disable_freefly`](addons/proto_controller/proto_controller.gd)
- Integração com Git (addon oficial): [addons/godot-git-plugin](addons/godot-git-plugin)  
  Licenças e terceiros: [addons/godot-git-plugin/LICENSE](addons/godot-git-plugin/LICENSE) e [addons/godot-git-plugin/THIRDPARTY.md](addons/godot-git-plugin/THIRDPARTY.md)

---

## 🗂️ Estrutura
- Raiz
  - [project.godot](project.godot) — configuração do projeto Godot
  - [main_scene.tscn](main_scene.tscn) — ponto de entrada do jogo
  - [structure_v_232.tscn](structure_v_232.tscn) — cena com a estrutura principal
  - [door.tscn](door.tscn), [door.gd](door.gd) — porta e script associado
  - [flag_brasil.tscn](flag_brasil.tscn), [flag.gdshader](flag.gdshader), [flag_script.gd](flag_script.gd) — bandeira e animação
- Addons
  - [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd) — controlador de personagem FPS
  - [addons/godot-git-plugin](addons/godot-git-plugin) — integração Git (opcional)

Pastas auxiliares:
- models/, materials/, textures/, terrain/, terrain_assets/ — assets do cenário

---

## 🛠️ Como Executar
1) Instalar Godot 4.2+ (ou versão compatível).  
2) Abrir o projeto: Godot → “Import” → selecionar [project.godot](project.godot).  
3) Rodar a cena principal: abra [main_scene.tscn](main_scene.tscn) e clique em Run (F5).

Via CLI:
- Linux/macOS:
  - godot4 --path . --scene main_scene.tscn
- Windows:
  - godot4.exe --path . --scene main_scene.tscn

---

## 🕹️ Controles (padrões)
- Movimento: W / A / S / D
- Olhar: Mouse (arrastar)
- Capturar mouse: clique com o botão esquerdo
- Soltar mouse: ESC
- Pular: Space (mapeado em [`proto_controller.input_jump`](addons/proto_controller/proto_controller.gd), padrão “ui_accept”)
- Correr: Shift (se mapeado em [`proto_controller.input_sprint`](addons/proto_controller/proto_controller.gd), ação “sprint”)
- Freefly (noclip): alternar ação [`proto_controller.input_freefly`](addons/proto_controller/proto_controller.gd) (defina a tecla na Input Map)

Observação: Se alguma ação não existir no Input Map, o script desabilita a funcionalidade e informa no Output (ver “checagem de mapeamentos” dentro de [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd)).

---

## 🎛️ Configuração de Input (Project → Project Settings → Input Map)
Crie/valide as ações usadas pelo controlador:
- Navegação: “ui_left”, “ui_right”, “ui_up”, “ui_down”
- Pulo: “ui_accept” (ou remapeie [`proto_controller.input_jump`](addons/proto_controller/proto_controller.gd))
- Corrida: “sprint” (Shift)
- Freefly: “freefly” (sugestão: F)

Os nomes podem ser alterados via propriedades exportadas do script [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd).

---

## ⚙️ Arquitetura (Godot)
- Cena principal contém o Player (CharacterBody3D) com o controlador de FPS do addon.
- Lógica de movimento/rotação:
  - Rotação de câmera: [`proto_controller.rotate_look`](addons/proto_controller/proto_controller.gd)
  - Movimento com gravidade, pulo e corrida no `_physics_process`.
  - Modo livre (noclip): [`proto_controller.enable_freefly`](addons/proto_controller/proto_controller.gd) / [`proto_controller.disable_freefly`](addons/proto_controller/proto_controller.gd)
- Elementos do cenário separados em cenas ([structure_v_232.tscn](structure_v_232.tscn), [door.tscn](door.tscn), [flag_brasil.tscn](flag_brasil.tscn)) para iteração rápida.

---

## 👣 Roadmap
- [x] Primeira pessoa funcional (movimento, pulo, corrida, freefly)
- [x] Cenário base do memorial
- [x] Bandeira com shader animado
- [ ] Colisão e navegação refinadas no cenário completo
- [ ] Interações adicionais (portas, placas, hotspots)
- [ ] UI de ajuda in-game (controles/legendas)

---

## 🧩 Addons e Licenças
- Godot Git Plugin (MIT): [addons/godot-git-plugin/LICENSE](addons/godot-git-plugin/LICENSE)  
  Terceiros inclusos: [addons/godot-git-plugin/THIRDPARTY.md](addons/godot-git-plugin/THIRDPARTY.md)
- Proto Controller (CC0) embutido em [addons/proto_controller/proto_controller.gd](addons/proto_controller/proto_controller.gd)

Demais assets seguem licenças próprias quando aplicável (consulte arquivos/headers dos recursos).

---

## 👥 Equipe
Disciplina ministrada pelo Prof. Dr. Marcelo Costa Oliveira ([@oliveiramc](https://github.com/oliveiramc)).

- [Eduardo Maciel (@theduardomaciel)](https://github.com/theduardomaciel)
- [Josenilton Ferreira (@914joseph)](https://github.com/914joseph)
