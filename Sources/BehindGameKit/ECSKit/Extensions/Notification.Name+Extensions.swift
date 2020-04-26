//
//  Notification.Name+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit

@available(OSX 10.12, *)
extension Notification {
    public func getEntities() -> (GKEntity, GKEntity)? {
        guard let bodyA = self.userInfo?["bodyA"] as? SKPhysicsBody,
            let bodyB = self.userInfo?["bodyB"] as? SKPhysicsBody else {
            return nil
        }
        guard let entityA = bodyA.node?.entity,
            let entityB = bodyB.node?.entity else {
                return nil
        }
        
        return (entityA, entityB)
    }
}
