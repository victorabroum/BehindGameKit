import Foundation

public extension CGVector {
    public func normalized() -> CGVector {
        let length = sqrt(dx * dx + dy * dy)
        guard length != 0 else { return CGVector(dx: 0, dy: 0) } // Evita a divisão por zero
        return CGVector(dx: dx / length, dy: dy / length)
    }
}
