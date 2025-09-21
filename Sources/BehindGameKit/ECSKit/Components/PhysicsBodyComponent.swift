//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class PhysicsBodyComponent: GKComponent{
    
    public var physicsBody: SKPhysicsBody
    
    private weak var node: SKNode?
    
    var physicsWorld: SKPhysicsWorld?
    
    public init(body: SKPhysicsBody) {
        self.physicsBody = body
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
    
    public override func didAddToEntity() {
        guard let node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node else {
            fatalError("Should has a Node to use this component")
        }
        node.physicsBody = physicsBody
        self.node = node
    }
    
    public override func willRemoveFromEntity() {
        self.entity?.component(ofType: GKSKNodeComponent.self)?.node.physicsBody = nil
    }
    
    public func setActive(_ value: Bool) {
        node?.physicsBody = value ? self.physicsBody : nil
    }
}
