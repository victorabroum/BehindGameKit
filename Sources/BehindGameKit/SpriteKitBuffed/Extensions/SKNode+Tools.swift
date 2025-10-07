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
    
    open func setHide(_ value: Bool = true) {
        self.alpha = value ? 0 : 1
    }
    
    open func setEnable(_ value: Bool = true) {
        self.alpha = value ? 1 : 0.3
        self.isUserInteractionEnabled = value
    }
}
