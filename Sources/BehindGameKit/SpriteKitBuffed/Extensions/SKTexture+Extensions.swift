//
//  SKTexture+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import SpriteKit

public extension Array where Element == SKTexture {
    init (withFormat format: String, range: ClosedRange<Int>) {
        self = range.map({ (index) in
            let imageNamed = String(
                format: format, "\(index)")
            return SKTexture(imageNamed: imageNamed)
        })
    }
}
