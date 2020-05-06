//
//  MoveComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class MoveComponent: GKComponent, MoveProtocol {
    
    public var velocity: CGVector = .zero
    public var speed: CGFloat = 700
    
    private weak var node: SKNode?
    
    public init(velocity: CGVector = .zero, speed: CGFloat = 700) {
        self.velocity = velocity
        self.speed = speed
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func didAddToEntity() {
        guard let node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node else { return }
        node.physicsBody?.velocity = self.velocity
        self.node = node
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        node?.physicsBody?.velocity = self.velocity
    }
    
    public func leftDelegate() {
        node?.xScale = -1
        velocity.dx = -speed
    }
    
    public func rightDelegate() {
        node?.xScale = 1
        velocity.dx = speed
    }
    
    public func upDelegate() {
        velocity.dy = speed
    }
    
    public func downDelegate() {
        velocity.dy = -speed
    }
    
    public func stopMoving(dx: Bool = false, dy: Bool = false) {
        if dx {
            velocity.dx = 0
        }
        
        if dy {
            velocity.dy = 0
        }
    }
    
    public override func willRemoveFromEntity() {
        velocity = .zero
        node?.physicsBody?.velocity = .zero
    }
    
}
