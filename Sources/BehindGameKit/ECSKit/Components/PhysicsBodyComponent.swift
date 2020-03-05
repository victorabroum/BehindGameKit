//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class PhysicsBodyComponent: GKComponent {
    
    var physicsBody: SKPhysicsBody
    
    public init(physicsBody: SKPhysicsBody) {
        self.physicsBody = physicsBody
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        self.physicsBody = SKPhysicsBody()
        super.init(coder: coder)
    }
    
    // Component System
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    override public func didAddToEntity() {
        entity?.component(ofType: GKSKNodeComponent.self)?.node.physicsBody = self.physicsBody
    }
}
