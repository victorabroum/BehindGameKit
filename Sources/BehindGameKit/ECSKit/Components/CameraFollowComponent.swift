//
//  CameraFollow.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 19/12/24.
//

import GameplayKit
import SpriteKit
import BehindGameKit

public class CameraFollowComponent: GKComponent {
    
    var camera: SKCameraNode
    var target: SKNode?
    var offset: CGPoint
    
    public init(camera: SKCameraNode, offset: CGPoint = .zero) {
        self.camera = camera
        self.offset = offset
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        target = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        guard let target else { return }
        let targetPosition = target.position + offset
        camera.run(.move(to: targetPosition, duration: 0.3))
    }
}
