//
//  File.swift
//
//
//  Created by Victor Vasconcelos on 28/05/24.
//

import Foundation

public extension CGFloat {
    public static func lerp(min: CGFloat, max: CGFloat, t: CGFloat) -> CGFloat {
        let t = (t - min) / (max - min)
        return lerp(a: 0, b: 1, t: t)
    }
    
    public static func lerp(a: CGFloat, b: CGFloat, t: CGFloat) -> CGFloat {
        return (1 - t) * b + t * a
    }
    
    var degreesToRadians: CGFloat {
        return self * .pi / 180.0
    }
    
    var radiansToDegrees: CGFloat {
        return self * 180.0 / .pi
    }
}
