//
//  PlatformMovement2DComponent.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 19/12/24.
//

import GameplayKit
import SpriteKit

public class HorizontalMovementComponent: GKComponent {
    
    var node: SKNode?
    var speed: CGFloat
    var maxSpeed: CGFloat
    var acceleration: CGFloat
    var deceleration: CGFloat
    var velocity: CGPoint
    
    private var direction: CGPoint
    
    public init(speed: CGFloat = 10, maxSpeed: CGFloat = 20, acceleration: CGFloat = 3, deceleration: CGFloat = 2) {
        self.speed = speed
        self.direction = .zero
        self.maxSpeed = maxSpeed
        self.acceleration = acceleration
        self.deceleration = deceleration
        self.velocity = .zero
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        if direction != .zero {
            velocity += CGPoint(x: direction.x * acceleration,
                                y: direction.y * acceleration)
        } else {
            velocity = applyLinearDeceleration(velocity, deceleration: deceleration)
        }
        
        
        let clampVelocity = clampPosition(velocity, maxSpeed: maxSpeed)
        
        velocity = clampVelocity
        
        node?.position += .init(x: clampVelocity.x, y: 0)
        
        node?.xScale = direction.x > 0 ? 0.5 : -0.5
    }
    
    public func change(direction: CGPoint) {
        self.direction = direction
    }
    
    private func clampPosition(_ position: CGPoint, maxSpeed: CGFloat) -> CGPoint {
        let limitedX = max(-maxSpeed, min(position.x, maxSpeed))
        let limitedY = max(-maxSpeed, min(position.y, maxSpeed))
        return CGPoint(x: limitedX, y: limitedY)
    }
    
    private func applyLinearDeceleration(_ velocity: CGPoint, deceleration: CGFloat) -> CGPoint {
        let deceleratedX = velocity.x - sign(velocity.x) * deceleration
        let deceleratedY = velocity.y - sign(velocity.y) * deceleration
        
        // Garante que a velocidade não ultrapasse zero
        let finalX = (velocity.x * deceleratedX < 0) ? 0 : deceleratedX
        let finalY = (velocity.y * deceleratedY < 0) ? 0 : deceleratedY
        
        return CGPoint(x: finalX, y: finalY)
    }
    
    private func applySmoothDeceleration(_ velocity: CGPoint, decelerationFactor: CGFloat) -> CGPoint {
        return CGPoint(
            x: velocity.x * decelerationFactor,
            y: velocity.y * decelerationFactor
        )
    }
}
