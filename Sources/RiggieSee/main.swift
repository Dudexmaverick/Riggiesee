import Gtk
import Foundation

let status = Application.run(startupHandler: nil) { app in

    let window = ApplicationWindowRef(application: app)

    window.title = "RiggieSee — Ocean Adventure"
    window.setDefaultSize(width: 900, height: 600)

    let layout = BoxRef(
        orientation: .vertical,
        spacing: 20
    )

    let title = LabelRef(str: "RIGGIESEE")
    layout.append(child: title)

    let subtitle = LabelRef(
        str: "🌊 Uma aventura nas profundezas do oceano"
    )
    layout.append(child: subtitle)

    let startButton = ButtonRef(label: "Iniciar aventura")

    startButton.onClicked { _ in
        print("RiggieSee iniciado!")
    }

    layout.append(child: startButton)

    window.set(child: layout)
    window.set(visible: true)
}

print("RiggieSee encerrado: \(String(describing: status))")