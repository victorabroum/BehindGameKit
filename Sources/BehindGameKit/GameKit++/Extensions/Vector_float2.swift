//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 20/04/24.
//

import Foundation
import SpriteKit

extension vector_float2 {
    public func toCGPoint() -> CGPoint {
        return .init(x: CGFloat(x), y: CGFloat(y))
    }
}
