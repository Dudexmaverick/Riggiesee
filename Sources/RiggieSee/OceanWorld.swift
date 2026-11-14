
import Foundation

struct OceanBubble {
    let x: Double
    let y: Double
    let radius: Double
}

struct OceanFish {
    let x: Double
    let y: Double
    let size: Double
}

struct OceanWorld {

    static func bubbles(
        width: Double,
        height: Double
    ) -> [OceanBubble] {
        guard width >= 1, height >= 1 else {
            return []
        }

        return (0..<40).map { index in
            OceanBubble(
                x: Double((index * 97 + 43) % Int(width)),
                y: Double((index * 71 + 29) % Int(height)),
                radius: Double(index % 5 + 2)
            )
        }
    }

    static func initialFish() -> [OceanFish] {
        [
            OceanFish(x: 380, y: 150, size: 12),
            OceanFish(x: 570, y: 300, size: 14),
            OceanFish(x: 740, y: 190, size: 11),
            OceanFish(x: 450, y: 410, size: 13),
            OceanFish(x: 800, y: 380, size: 12)
        ]
    }
}
