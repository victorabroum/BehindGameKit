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
}
