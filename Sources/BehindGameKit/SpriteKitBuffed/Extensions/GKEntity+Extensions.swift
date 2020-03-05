//
//  GKEntity+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit

extension GKEntity {
    public func removeNodes() {
        self.component(ofType: GKSKNodeComponent.self)?.node.removeFromParent()
    }
}
