import Foundation

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
    
    public func normalized() -> CGPoint {
        // Calcula o valor absoluto máximo entre x e y
        let absMax = max(abs(self.x), abs(self.y))
        
        guard absMax > 0 else { return .zero }
        
        // Normaliza o valor x para estar entre -1 e 1
        let normalizedX = self.x / absMax
        
        // Normaliza o valor y para estar entre -1 e 1
        let normalizedY = self.y / absMax
        
        return CGPoint(x: normalizedX, y: normalizedY)
    }
    
    public func magnitude() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    public static func randomPoint(_ range: ClosedRange<CGFloat>) -> CGPoint {
        return .init(
            x: .random(in: range),
            y: .random(in: range))
    }
}
