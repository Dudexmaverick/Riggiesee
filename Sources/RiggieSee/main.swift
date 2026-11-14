
import Gtk
import Cairo
import Foundation
import CGtk
import GLib
import GLibObject

// MARK: - Estado do jogo

let game = GameState()
game.start()

let keyboard = KeyboardState()

// MARK: - Aplicação GTK4

let status = Application.run(startupHandler: nil) { app in

    // MARK: Janela principal

    let window = ApplicationWindowRef(application: app)
    window.title = "RiggieSee — Ocean Adventure"
    window.setDefaultSize(width: 1000, height: 700)

    // MARK: Layout principal

    let layout = BoxRef(
        orientation: .vertical,
        spacing: 10
    )

    let title = LabelRef(
        str: "🌊 RIGGIESEE — OCEAN ADVENTURE 🦭"
    )

    layout.append(child: title)

    // MARK: Placar

    let scoreLabel = LabelRef(
        str: "Pontos: 0 | Nível: 1 | Vidas: 3"
    )

    layout.append(child: scoreLabel)

    // MARK: Oceano

    let drawingArea = DrawingAreaRef()

    drawingArea.setSizeRequest(
        width: 900,
        height: 480
    )

    drawingArea.setVexpand(expand: true)
    drawingArea.setHexpand(expand: true)

    drawingArea.setDrawFunc { _, context, width, height in

        game.worldWidth = Double(width)
        game.worldHeight = Double(height)

        GameRenderer.draw(
            context: context,
            width: width,
            height: height,
            game: game
        )
    }

    layout.append(child: drawingArea)

    // MARK: Atualização da interface

    let refreshGame = {

        let updatedScore =
            "Pontos: \(game.score) | Nível: \(game.level) | Vidas: \(game.seaLion.lives)"

        scoreLabel.setText(str: updatedScore)

        drawingArea.queueDraw()
    }

    // MARK: Botões existentes

    let controls = BoxRef(
        orientation: .horizontal,
        spacing: 12
    )

    let leftButton = ButtonRef(label: "⬅ Esquerda")
    let rightButton = ButtonRef(label: "Direita ➡")
    let upButton = ButtonRef(label: "⬆ Subir")
    let downButton = ButtonRef(label: "⬇ Descer")

    leftButton.onClicked { _ in
        game.move(dx: -1, dy: 0)
        refreshGame()
    }

    rightButton.onClicked { _ in
        game.move(dx: 1, dy: 0)
        refreshGame()
    }

    upButton.onClicked { _ in
        game.move(dx: 0, dy: -1)
        refreshGame()
    }

    downButton.onClicked { _ in
        game.move(dx: 0, dy: 1)
        refreshGame()
    }

    controls.append(child: leftButton)
    controls.append(child: rightButton)
    controls.append(child: upButton)
    controls.append(child: downButton)

    layout.append(child: controls)

    // MARK: Reiniciar aventura

    let restartButton = ButtonRef(
        label: "🔄 Reiniciar aventura"
    )

    restartButton.onClicked { _ in
        keyboard.reset()
        game.start()
        refreshGame()
    }

    layout.append(child: restartButton)

    // MARK: Controlador de teclado GTK4

    let controller = gtk_event_controller_key_new()

    let keyboardPointer = Unmanaged.passUnretained(
        keyboard
    ).toOpaque()

    let keyPressedCallback:
        @convention(c) (
            UnsafeMutableRawPointer?,
            UInt32,
            UInt32,
            UInt32,
            UnsafeMutableRawPointer?
        ) -> Int32 = { _, keyval, _, _, data in

            guard let data else { return 0 }

            let state = Unmanaged<KeyboardState>
                .fromOpaque(data)
                .takeUnretainedValue()

            switch keyval {
            case 0xff51:
                state.left = true
            case 0xff53:
                state.right = true
            case 0xff52:
                state.up = true
            case 0xff54:
                state.down = true
            default:
                return 0
            }

            return 1
        }

    let keyReleasedCallback:
        @convention(c) (
            UnsafeMutableRawPointer?,
            UInt32,
            UInt32,
            UInt32,
            UnsafeMutableRawPointer?
        ) -> Void = { _, keyval, _, _, data in

            guard let data else { return }

            let state = Unmanaged<KeyboardState>
                .fromOpaque(data)
                .takeUnretainedValue()

            switch keyval {
            case 0xff51:
                state.left = false
            case 0xff53:
                state.right = false
            case 0xff52:
                state.up = false
            case 0xff54:
                state.down = false
            default:
                break
            }
        }

    // Conecta os sinais nativos.
    let pressedHandler = unsafeBitCast(
        keyPressedCallback,
        to: GCallback.self
    )

    let releasedHandler = unsafeBitCast(
        keyReleasedCallback,
        to: GCallback.self
    )

    _ = g_signal_connect_data(
        controller,
        "key-pressed",
        pressedHandler,
        keyboardPointer,
        nil,
        GConnectFlags(rawValue: 0)
    )

    _ = g_signal_connect_data(
        controller,
        "key-released",
        releasedHandler,
        keyboardPointer,
        nil,
        GConnectFlags(rawValue: 0)
    )

    gtk_widget_add_controller(
        window.ptr.assumingMemoryBound(to: GtkWidget.self),
        controller
    )

    // MARK: Atualização contínua

    timeout(add: 16) {

        let dx = keyboard.dx
        let dy = keyboard.dy

        if dx != 0 || dy != 0 {
            game.move(
                dx: dx,
                dy: dy,
                deltaTime: 0.016
            )

            refreshGame()
        }

        return true
    }

    // MARK: Exibir janela

    window.set(child: layout)
    window.set(visible: true)
}

// MARK: Encerramento

print("RiggieSee encerrado: \(String(describing: status))")
