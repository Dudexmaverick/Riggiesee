# 🦭 RiggieSee — Ocean Adventure

**Um jogo 2D de aventura submarina desenvolvido em Swift, GTK4 e Cairo.**

## 🌊 Sobre o projeto

RiggieSee — Ocean Adventure é um jogo em que o jogador controla Riggie, um simpático leão-marinho que explora o oceano coletando peixes.

Cada peixe coletado aumenta a pontuação, e o jogador avança de nível conforme completa os objetivos.

O projeto faz parte do meu portfólio de desenvolvimento de software e representa minha experiência prática com Swift, interfaces gráficas e lógica de jogos.

## 🎮 Funcionalidades

- Movimentação contínua pelas setas do teclado
- Controles alternativos por botões
- Coleta de peixes e sistema de pontuação
- Progressão de níveis
- Indicador de vidas
- Reinício da aventura
- Cenário submarino com bolhas, algas, corais e raios de luz
- Renderização gráfica com Cairo

## ⌨️ Controles

| Tecla | Ação |
|---|---|
| ↑ | Subir |
| ↓ | Descer |
| ← | Esquerda |
| → | Direita |

## 🛠️ Tecnologias

- Swift 6
- Swift Package Manager
- SwiftGtk e GTK4
- SwiftCairo
- GLib
- Ubuntu Linux

## 🚀 Como executar

**Pré-requisitos:** Swift 6, GTK4 e as dependências declaradas no projeto.

Clone o repositório:

```bash
git clone https://github.com/Dudexmaverick/Riggiesee.git
cd Riggiesee
```

Compile e execute:

```bash
swift build -j 1
swift run
```

## 📁 Organização do código

- `main.swift` — Interface gráfica e ciclo principal do jogo.
- `GameRenderer.swift` — Desenho do personagem e do cenário.
- `GameState.swift` — Pontuação, níveis e estado do jogo.
- `KeyboardState.swift` — Controles do teclado.
- `OceanWorld.swift` — Elementos do ambiente submarino.
- `SeaLion.swift` — Propriedades e movimentação do Riggie.

## 🔭 Próximas melhorias

- Aprimorar a animação de natação
- Implementar obstáculos e inimigos
- Adicionar efeitos sonoros
- Criar telas de início e fim de jogo

## 👩‍💻 Desenvolvedora

 Eduarda Alves 

Estudante de Engenharia de Telecomunicações no Instituto Federal do Ceará (IFCE).

GitHub: [Dudexmaverick](https://github.com/Dudexmaverick)

## 📌 Status

Protótipo jogável em desenvolvimento.