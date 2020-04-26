//
//  GKEntity+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit

@available(OSX 10.12, *)
extension GKEntity {
    public func removeNodes() {
        self.component(ofType: GKSKNodeComponent.self)?.node.removeFromParent()
    }
}
