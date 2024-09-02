//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/06/24.
//

import Foundation
import SpriteKit

public extension SKNode {
    public var nodeSize: CGSize {
        return calculateAccumulatedFrame().size
    }
}
