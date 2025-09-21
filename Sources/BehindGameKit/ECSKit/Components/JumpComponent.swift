//
//  JumpComponent.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 20/09/25.
//

import SpriteKit
import GameplayKit

public class JumpComponent: GKComponent {
    
    var jumpForce: CGFloat
    var node: SKNode?
    var physicsComp: PhysicsBodyComponent?
    
    var isGrounded: Bool = true
    var canDoubleJump: Bool = true
    
    private var groundType: GKComponent.Type = IsGroundComponent.self
    
    public init(jumpForce: CGFloat) {
        self.jumpForce = jumpForce
        super.init()
    }
    
    public override func didAddToEntity() {
        node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node
        physicsComp = self.entity?.component(ofType: PhysicsBodyComponent.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tryJump() {
        guard isGrounded else {
            tryDoubleJump()
            return
        }
        canDoubleJump = true
        
        let jumpImpulse = CGVector(dx: 0, dy: jumpForce)
        
        physicsComp?.physicsBody.applyImpulse(jumpImpulse)
        
        isGrounded = false
    }
    
    private func tryDoubleJump() {
        guard canDoubleJump else { return }
        canDoubleJump = false
        
        let jumpImpulse = CGVector(dx: 0, dy: jumpForce * 0.85)
        physicsComp?.physicsBody.applyImpulse(jumpImpulse)
    }
    
    public func verifyIsOnGround() -> Bool {
        guard let node else { return false }
        let height = node.calculateAccumulatedFrame().size.height
        let rayDistance = CGPoint(x: node.position.x,
                                  y: node.position.y - (height/2) - 10)
        
        return raycast(checkFor: groundType,
                       rayDistance: rayDistance)
    }
    
    private func raycast(checkFor type: GKComponent.Type, rayDistance: CGPoint) -> Bool {
        guard let node else { return false }
        
        var check = false
        
        if physicsComp?.physicsWorld == nil, let physicsWorld = physicsComp?.physicsBody.node?.scene?.physicsWorld {
            physicsComp?.physicsWorld = physicsWorld
        }
        
        let _ = physicsComp?.physicsWorld?.enumerateBodies(alongRayStart: node.position , end: rayDistance, using: { body, _, _, _ in
            // Check if the body founded has Ground Component
            if body.node?.entity?.component(ofType: type) != nil {
                check = true
            }
        })
        
#if DEBUG
        let path = CGMutablePath()
        path.move(to: node.position)
        path.addLine(to: rayDistance)
        let debugNode = SKShapeNode(path: path)
        debugNode.strokeColor = check ? .green : .red
        debugNode.lineWidth = node.nodeSize.width / 10
        node.scene?.addChild(debugNode)
        debugNode.run(.sequence([
            .wait(forDuration: 0.3),
            .removeFromParent()
        ]))
#endif
        return check
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        self.isGrounded = verifyIsOnGround()
    }
    
    public func setGround<T: GKComponent>(type: T.Type) {
        self.groundType = type
    }
    
}
