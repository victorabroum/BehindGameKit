import Foundation
import SpriteKit

public extension SKAction {
    public static func flashOpacity(duration: TimeInterval) -> SKAction {
        return .sequence([
            .fadeAlpha(to: 0.2, duration: duration/2),
            .fadeAlpha(to: 1, duration: duration/2)
        ])
    }
    
    public static func repeatFlashOpacity(duration: TimeInterval, count: Int) -> SKAction {
        return .repeat(.flashOpacity(duration: duration), count: count)
    }
    
    public static func shake(duration: TimeInterval, amplitudeX: CGFloat = 10, amplitudeY: CGFloat = 10) -> SKAction {
        let eachShakeDuration = 0.0015
        let numberOfShakes = Int(duration / eachShakeDuration)
        var actionsArray: [SKAction] = []
        
        for _ in 1...numberOfShakes {
            let dx = CGFloat.random(in: -amplitudeX...amplitudeX)
            let dy = CGFloat.random(in: -amplitudeY...amplitudeY)
            let shakeAction = SKAction.moveBy(x: dx, y: dy, duration: eachShakeDuration)
            shakeAction.timingMode = .easeOut
            actionsArray.append(shakeAction)
        }
        
        return SKAction.sequence(actionsArray)
    }
    
    static func bounce(withHeight height: CGFloat, duration: TimeInterval) -> SKAction {
        // Dividir a duração para o movimento de subida e descida
        let halfDuration = duration / 2.0
        
        // Criar a ação de subir
        let moveUp = SKAction.moveBy(x: 0, y: height, duration: halfDuration)
        moveUp.timingMode = .easeOut
        
        // Criar a ação de descer
        let moveDown = SKAction.moveBy(x: 0, y: -height, duration: halfDuration)
        moveDown.timingMode = .easeIn
        
        // Combinar as ações de subir e descer em uma sequência
        let bounce = SKAction.sequence([moveUp, moveDown])
        
        return bounce
    }
}
