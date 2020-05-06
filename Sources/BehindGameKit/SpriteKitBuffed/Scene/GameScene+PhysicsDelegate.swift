//
//  GameScene+PhysicsDelegate.swift
//  
//
//  Created by Victor Vasconcelos on 06/05/20.
//

import Foundation
import GameplayKit
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        NotificationCenter.default.contactDidBeginPost(contact)
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        NotificationCenter.default.contactDidEndPost(contact)
    }
}
