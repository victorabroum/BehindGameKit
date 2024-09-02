import Foundation

public enum DirectionState {
    case north, northeast, east, southeast, south, southwest, west, northwest, none
    
    public static var allCases: [DirectionState] = [
        .north,
        .northeast,
        .east,
        .southeast,
        .south,
        .southwest,
        .west,
        .northwest,
    ]
    
    public var animationKey: String {
        switch self {
        case .north:
            return "Up"
        case .northeast:
            return "UpRight"
        case .east:
            return "Right"
        case .southeast:
            return "DownRight"
        case .south:
            return "Down"
        case .southwest:
            return "DownLeft"
        case .west:
            return "Left"
        case .northwest:
            return "UpLeft"
        default:
            return "none"
        }
    }
    
    public static func pointToDirectionState(_ point: CGPoint) -> DirectionState {
        
        let x = point.x
        let y = point.y
        
        if abs(x) > 0.5 && abs(y) > 0.5 {
            if x > 0 {
                return y > 0 ? .northeast : .southeast
            } else {
                return y > 0 ? .northwest : .southwest
            }
        } else if abs(x) > abs(y) {
            return x > 0 ? .east : .west
        } else {
            return y > 0 ? .north : .south
        }
        
    }
}
