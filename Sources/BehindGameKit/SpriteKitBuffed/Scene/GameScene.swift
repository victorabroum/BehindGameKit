//
//  SKGameScene.swift
//  
//
//  Created by Victor Vasconcelos on 06/05/20.
//

import Foundation
import SpriteKit

open class SKGameScene: SKScene {
    
    public var lastUpdateTime : TimeInterval = 0
    
    open override func sceneDidLoad() {
        self.lastUpdateTime = 0
        SKEntityManager.shared.start(inScene: self)
    }
    
    open override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        SKEntityManager.shared.update(dt)
        
        self.lastUpdateTime = currentTime
    }
}
