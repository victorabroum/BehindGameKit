//
//  SKGameScene.swift
//  
//
//  Created by Victor Vasconcelos on 06/05/20.
//

import Foundation
import SpriteKit

public class SKGameScene: SKScene {
    
    public var entityManager: SKEntityManager?
    private var lastUpdateTime : TimeInterval = 0
    
    public override func sceneDidLoad() {
        self.lastUpdateTime = 0
        self.entityManager = SKEntityManager(self)
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        self.entityManager?.update(dt)
        
        self.lastUpdateTime = currentTime
    }
}
