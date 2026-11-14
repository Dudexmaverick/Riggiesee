
import Foundation
import Cairo

struct GameRenderer {

    @MainActor static var animationTime: Double = 0


    @MainActor static func draw(
        context: Cairo.ContextRef,
        width: Int,
        height: Int,
        game: GameState
    ) {
        let w = Double(width)
        let h = Double(height)

        guard w > 0, h > 0 else { return }

        drawOcean(context, width: w, height: h)
        drawLightRays(context, width: w, height: h)
        drawBubbles(context, width: w, height: h)
        drawSeaFloor(context, width: w, height: h)

        for fish in game.fish {
            drawFish(
                context,
                x: fish.x,
                y: fish.y,
                size: fish.size
            )
        }

        let swimOffset = sin(animationTime * 3.0) * 5.0

        drawSwimmingBubbles(
            context,
            x: game.seaLion.x,
            y: game.seaLion.y
        )

        drawSeaLion(
            context,
            x: game.seaLion.x,
            y: game.seaLion.y + swimOffset
        )
    }

    private static func drawOcean(
        _ cr: Cairo.ContextRef,
        width: Double,
        height: Double
    ) {
        // Oceano azul-turquesa
        cr.setSource(
            red: 0.03,
            green: 0.48,
            blue: 0.77
        )

        cr.rectangle(
            x: 0,
            y: 0,
            width: width,
            height: height
        )
        cr.fill()

        // Parte superior iluminada
        cr.setSource(
            red: 0.14,
            green: 0.76,
            blue: 0.93,
            alpha: 0.48
        )

        cr.rectangle(
            x: 0,
            y: 0,
            width: width,
            height: height * 0.32
        )
        cr.fill()

        // Profundidade
        cr.setSource(
            red: 0.02,
            green: 0.26,
            blue: 0.53,
            alpha: 0.34
        )

        cr.rectangle(
            x: 0,
            y: height * 0.68,
            width: width,
            height: height * 0.32
        )
        cr.fill()
    }

    private static func drawLightRays(
        _ cr: Cairo.ContextRef,
        width: Double,
        height: Double
    ) {
        for i in 0..<7 {
            let x = Double(i) * width / 7

            cr.setSource(
                red: 0.72,
                green: 0.98,
                blue: 1.0,
                alpha: 0.13
            )

            cr.moveTo(x, 0)
            cr.lineTo(x + 45, 0)
            cr.lineTo(x + 165, height)
            cr.lineTo(x + 65, height)
            cr.fill()
        }
    }

    private static func drawBubbles(
        _ cr: Cairo.ContextRef,
        width: Double,
        height: Double
    ) {
        for bubble in OceanWorld.bubbles(
            width: width,
            height: height
        ) {
            cr.setSource(
                red: 0.85,
                green: 0.98,
                blue: 1.0,
                alpha: 0.72
            )

            cr.arc(
                xc: bubble.x,
                yc: bubble.y,
                radius: bubble.radius
            )
            cr.stroke()
        }
    }

    private static func drawSeaFloor(
        _ cr: Cairo.ContextRef,
        width: Double,
        height: Double
    ) {
        // Fundo arenoso azul
        cr.setSource(
            red: 0.10,
            green: 0.56,
            blue: 0.70
        )

        cr.moveTo(0, height - 45)
        cr.curveTo(
            x1: width * 0.25,
            y1: height - 80,
            x2: width * 0.55,
            y2: height - 25,
            x3: width,
            y3: height - 55
        )
        cr.lineTo(width, height)
        cr.lineTo(0, height)
        cr.fill()

        // Algas verdes
        for i in 0..<10 {
            let x = Double(i) * width / 9

            cr.setSource(
                red: 0.15,
                green: 0.72,
                blue: 0.45
            )

            cr.moveTo(x, height - 25)
            cr.curveTo(
                x1: x - 18,
                y1: height - 55,
                x2: x + 22,
                y2: height - 85,
                x3: x + 5,
                y3: height - 115
            )
            cr.stroke()
        }

        // Corais rosados
        for i in 0..<5 {
            let x = Double(i) * width / 4

            cr.setSource(
                red: 0.94,
                green: 0.47,
                blue: 0.71
            )

            cr.moveTo(x, height - 20)
            cr.lineTo(x - 8, height - 65)
            cr.lineTo(x - 20, height - 80)
            cr.stroke()

            cr.moveTo(x - 8, height - 65)
            cr.lineTo(x + 14, height - 90)
            cr.stroke()
        }
    }

    private static func drawFish(
        _ cr: Cairo.ContextRef,
        x: Double,
        y: Double,
        size: Double
    ) {
        cr.save()

        cr.setSource(
            red: 1.0,
            green: 0.82,
            blue: 0.28
        )

        cr.save()
        cr.arc(xc: x, yc: y, radius: size)
        cr.fill()
        cr.restore()

        cr.moveTo(x - size, y)
        cr.lineTo(x - size * 2, y - size)
        cr.lineTo(x - size * 2, y + size)
        cr.fill()

        cr.setSource(
            red: 0.04,
            green: 0.09,
            blue: 0.17
        )

        cr.arc(
            xc: x + size * 0.7,
            yc: y - 2,
            radius: 2
        )
        cr.fill()

        cr.restore()
    }


    @MainActor private static func drawSwimmingBubbles(
        _ cr: Cairo.ContextRef,
        x: Double,
        y: Double
    ) {
        for i in 0..<5 {
            let phase = animationTime * 35 + Double(i) * 24
            let rise = phase.truncatingRemainder(dividingBy: 130)

            let bubbleX = x - 95 - Double(i) * 12
            let bubbleY = y + 25 - rise

            cr.setSource(
                red: 0.88,
                green: 0.98,
                blue: 1.0,
                alpha: 0.65
            )

            cr.arc(
                xc: bubbleX,
                yc: bubbleY,
                radius: Double(i % 3 + 3)
            )
            cr.stroke()
        }
    }

    @MainActor private static func drawSeaLion(
        _ cr: Cairo.ContextRef,
        x: Double,
        y: Double
    ) {
        cr.save()

        // Contorno e cauda
        cr.setSource(
            red: 0.12,
            green: 0.17,
            blue: 0.30
        )

        cr.moveTo(x - 45, y + 5)
        cr.lineTo(x - 96, y - 22)
        cr.lineTo(x - 83, y + 30)
        cr.fill()

        // Corpo azul-acinzentado
        cr.setSource(
            red: 0.38,
            green: 0.48,
            blue: 0.66
        )

        cr.save()
        cr.arc(xc: x, yc: y, radius: 35)
        cr.fill()
        cr.restore()

        // Barriga clara
        cr.setSource(
            red: 0.83,
            green: 0.90,
            blue: 0.97
        )

        cr.save()
        cr.arc(xc: x + 10, yc: y + 13, radius: 29)
        cr.fill()
        cr.restore()

        // Nadadeira principal
        cr.setSource(
            red: 0.30,
            green: 0.40,
            blue: 0.60
        )

        let finMovement = sin(animationTime * 7.0) * 14.0

        cr.moveTo(x - 10, y + 9)
        cr.curveTo(
            x1: x - 20,
            y1: y + 30 + finMovement,
            x2: x - 55,
            y2: y + 60 + finMovement,
            x3: x - 25,
            y3: y + 59 + finMovement
        )
        cr.curveTo(
            x1: x + 5,
            y1: y + 56,
            x2: x + 24,
            y2: y + 24,
            x3: x + 12,
            y3: y + 12
        )
        cr.fill()

        // Cabeça arredondada
        cr.setSource(
            red: 0.47,
            green: 0.55,
            blue: 0.72
        )

        cr.arc(
            xc: x + 44,
            yc: y - 22,
            radius: 30
        )
        cr.fill()

        // Região clara do rosto
        cr.setSource(
            red: 0.85,
            green: 0.91,
            blue: 0.97
        )

        cr.arc(
            xc: x + 61,
            yc: y - 6,
            radius: 18
        )
        cr.fill()

        // Olho grande
        cr.setSource(
            red: 0.05,
            green: 0.08,
            blue: 0.16
        )

        cr.arc(
            xc: x + 51,
            yc: y - 31,
            radius: 10
        )
        cr.fill()

        // Brilho do olho
        cr.setSource(
            red: 1.0,
            green: 1.0,
            blue: 1.0
        )

        cr.arc(
            xc: x + 54,
            yc: y - 35,
            radius: 3.5
        )
        cr.fill()

        // Boca sorridente
        cr.setSource(
            red: 0.12,
            green: 0.08,
            blue: 0.17
        )

        cr.moveTo(x + 57, y + 1)
        cr.curveTo(
            x1: x + 66,
            y1: y + 24,
            x2: x + 79,
            y2: y + 17,
            x3: x + 81,
            y3: y - 1
        )
        cr.fill()

        // Língua rosada
        cr.setSource(
            red: 0.98,
            green: 0.47,
            blue: 0.51
        )

        cr.arc(
            xc: x + 71,
            yc: y + 12,
            radius: 6
        )
        cr.fill()

        // Nariz
        cr.setSource(
            red: 0.08,
            green: 0.10,
            blue: 0.17
        )

        cr.arc(
            xc: x + 78,
            yc: y - 15,
            radius: 5
        )
        cr.fill()

        // Bigodes brancos
        cr.setSource(
            red: 0.96,
            green: 0.98,
            blue: 1.0
        )

        cr.moveTo(x + 72, y - 6)
        cr.lineTo(x + 101, y - 17)
        cr.stroke()

        cr.moveTo(x + 72, y - 3)
        cr.lineTo(x + 105, y - 3)
        cr.stroke()

        cr.moveTo(x + 72, y)
        cr.lineTo(x + 101, y + 13)
        cr.stroke()

        cr.restore()
    }
}
