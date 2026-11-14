
import Foundation

struct SeaLion {
    var x: Double = 180
    var y: Double = 250

    // Velocidade em pixels por segundo
    var speed: Double = 220

    var lives: Int = 3
    var fishCollected: Int = 0

    mutating func move(
        dx: Double,
        dy: Double,
        worldWidth: Double,
        worldHeight: Double,
        deltaTime: Double = 1.0 / 60.0
    ) {
        // Normaliza o vetor para evitar velocidade
        // maior durante movimentos diagonais.
        let magnitude = hypot(dx, dy)

        guard magnitude > 0 else { return }

        let normalizedX = dx / magnitude
        let normalizedY = dy / magnitude

        x += normalizedX * speed * deltaTime
        y += normalizedY * speed * deltaTime

        let minX = 100.0
        let maxX = max(minX, worldWidth - 100)

        let minY = 90.0
        let maxY = max(minY, worldHeight - 90)

        x = max(minX, min(maxX, x))
        y = max(minY, min(maxY, y))
    }
}
