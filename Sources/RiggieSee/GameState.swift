
import Foundation

final class GameState {

    var seaLion = SeaLion()

    var level = 1
    var score = 0
    var isPlaying = false

    var worldWidth: Double = 900
    var worldHeight: Double = 500

    var fish: [OceanFish] = []

    func start() {
        seaLion = SeaLion()
        level = 1
        score = 0
        isPlaying = true
        fish = OceanWorld.initialFish()
    }

    // Movimento compatível com os botões existentes.
    func move(dx: Double, dy: Double) {
        move(
            dx: dx,
            dy: dy,
            deltaTime: 0.08
        )
    }

    // Movimento contínuo por tempo.
    func move(
        dx: Double,
        dy: Double,
        deltaTime: Double
    ) {
        guard isPlaying else { return }

        seaLion.move(
            dx: dx,
            dy: dy,
            worldWidth: worldWidth,
            worldHeight: worldHeight,
            deltaTime: deltaTime
        )

        collectFish()
    }

    private func collectFish() {
        fish.removeAll { item in

            let distance = hypot(
                seaLion.x - item.x,
                seaLion.y - item.y
            )

            if distance < 65 {
                score += 10
                seaLion.fishCollected += 1
                return true
            }

            return false
        }

        if fish.isEmpty {
            level += 1
            fish = OceanWorld.initialFish()
        }
    }
}
