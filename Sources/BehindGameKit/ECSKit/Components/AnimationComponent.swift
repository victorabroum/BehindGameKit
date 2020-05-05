//
//  AnimationComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class AnimationComponent: GKComponent {
    override public init() {
        super.init()
    }
    
    public init(onNode node: SKNode? = nil, action: SKAction) {
        super.init()
        
        guard let node = node else {
            guard let rootNode = self.entity?.component(ofType: GKSKNodeComponent.self)?.node else { return }
            self.runAnimation(onNode: rootNode, action: action)
            return
        }
        
        self.runAnimation(onNode: node, action: action)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Component System
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    public func runAnimation(onNode node: SKNode? = nil, action: SKAction, withKey: String = "") {
        
        var runOnNode: SKNode? = node
        
        if node == nil {
            runOnNode = self.entity?.component(ofType: GKSKNodeComponent.self)?.node
        }
        
        runOnNode?.run(action, withKey: withKey)
    }
}
