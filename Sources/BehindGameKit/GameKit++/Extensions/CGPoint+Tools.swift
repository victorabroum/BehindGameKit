import Foundation
import SpriteKit

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx*dx + dy*dy)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func * (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x * right.x, y: left.y * right.y)
    }
    
    static func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }
    
    static func *= (left: inout CGPoint, right: CGPoint) {
        left.x *= right.x
        left.y *= right.y
    }
    
    static func / (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x / right.x, y: left.y / right.y)
    }
    
    static func /= (left: inout CGPoint, right: CGPoint) {
        left = left / right
    }
    
    static func / (left: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: left.x / scalar, y: left.y / scalar)
    }
    
    static func /= (size: inout CGPoint, scalar: CGFloat) {
        size = size / scalar
    }
    
    func normalized() -> CGPoint {
        // Calcula o valor absoluto máximo entre x e y
        let absMax = max(abs(self.x), abs(self.y))
        
        guard absMax > 0 else { return .zero }
        
        // Normaliza o valor x para estar entre -1 e 1
        let normalizedX = self.x / absMax
        
        // Normaliza o valor y para estar entre -1 e 1
        let normalizedY = self.y / absMax
        
        return CGPoint(x: normalizedX, y: normalizedY)
    }
    
    func magnitude() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    static func randomPoint(_ range: ClosedRange<CGFloat>) -> CGPoint {
        return .init(
            x: .random(in: range),
            y: .random(in: range))
    }
    
    static func randomPoint(withSafeZone safeZone: CGFloat, range: ClosedRange<CGFloat>) -> CGPoint {
        let angle = CGFloat.random(in: 0...360).degreesToRadians
        let x = (safeZone * cos(angle)) + .random(in: range)
        let y = (safeZone * sin(angle)) + .random(in: range)
        return .init(x: x, y: y)
    }
    
    func toVecto2() -> vector_float2 {
        return .init(Float(x), Float(y))
    }
    
    func calculateAngle(to point: CGPoint) -> CGFloat {
        let deltaX = point.x - self.x
        let deltaY = point.y - self.y
        return atan2(deltaY, deltaX)
    }
}
