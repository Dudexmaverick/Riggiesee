import Foundation

final class KeyboardState {
    var left = false
    var right = false
    var up = false
    var down = false

    var dx: Double {
        (right ? 1.0 : 0.0) - (left ? 1.0 : 0.0)
    }

    var dy: Double {
        (down ? 1.0 : 0.0) - (up ? 1.0 : 0.0)
    }

    func reset() {
        left = false
        right = false
        up = false
        down = false
    }
}
