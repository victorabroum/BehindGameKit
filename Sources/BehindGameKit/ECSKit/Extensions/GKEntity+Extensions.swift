//
//  GKEntity+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit

public extension GKEntity {
    func removeNodes() {
        self.component(ofType: GKSKNodeComponent.self)?.node.removeFromParent()
    }
    
    func removeFromScene() {
        SKEntityManager.shared.remove(self)
    }
}
