//
//  PhysicsBodyComponent+Factory.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 20/09/25.
//

import GameplayKit
import SpriteKit

public extension PhysicsBodyComponent {
    public static func rectangleBody(ofSize size: CGSize) -> PhysicsBodyComponent {
        let body = SKPhysicsBody(rectangleOf: size)
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsBodyComponent(body: body)
    }
    
    public static func circle(ofRadius radius: CGFloat) -> PhysicsBodyComponent {
        let body = SKPhysicsBody(circleOfRadius: radius)
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsBodyComponent(body: body)
    }
    
    public static func capsule(size: CGSize, cornerRadius: CGFloat) -> PhysicsBodyComponent {
        let body = SKPhysicsBody(polygonFrom: .capsule(size: size, cornerRadius: cornerRadius))
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsBodyComponent(body: body)
    }
}
