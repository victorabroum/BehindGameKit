//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class SKPhysicsBodyComponent: GKComponent {
    
    public var physicsBody: SKPhysicsBody
    
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
    
    public override func willRemoveFromEntity() {
        self.entity?.component(ofType: GKSKNodeComponent.self)?.node.physicsBody = nil
    }
    
    public func turn(on: Bool) {
        let node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        if on {
            node?.physicsBody = self.physicsBody
        } else {
            node?.physicsBody = nil
        }
    }
}
