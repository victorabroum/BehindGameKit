//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation
import SpriteKit
import GameplayKit

public extension NotificationCenter {
    func postKeyUpEvent(_ keyCode: UInt16) {
        self.post(name: .keyUpEvent, object: nil, userInfo: ["keyCode" : keyCode])
    }
    
    func postKeyDownEvent(_ keyCode: UInt16) {
        self.post(name: .keyDownEvent, object: nil, userInfo: ["keyCode" : keyCode])
    }
    
    func contactDidBeginPost(_ contact: SKPhysicsContact) {
        self.post(name: .contactDidBegin, object: nil, userInfo: [
            "bodyA" : contact.bodyA,
            "bodyB" : contact.bodyB
        ])
    }
    
    func contactDidEndPost(_ contact: SKPhysicsContact) {
        self.post(name: .contactDidEnd, object: nil, userInfo: [
            "bodyA" : contact.bodyA,
            "bodyB" : contact.bodyB
        ])
    }
    
    func removeEntityFromScenePost(_ entity: GKEntity) {
        self.post(name: .removeEntityFromScene, object: nil,
                  userInfo: ["entity": entity])
    }
    
    func addEntityOnScene(_ entity: GKEntity, onParent parent: GKEntity? = nil) {
        
        var userInfo: [AnyHashable: Any] = ["entity": entity]
        
        if let hasParent = parent {
            userInfo["parent"] = hasParent
        }
        
        self.post(name: .addEntityNotification, object: nil, userInfo: userInfo)
    }
}
