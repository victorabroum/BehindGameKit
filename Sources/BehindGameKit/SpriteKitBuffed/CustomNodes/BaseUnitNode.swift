//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 18/05/24.
//

import Foundation
import SpriteKit

open class BaseUnitNode: SKNode {
    
    public var sprite: SKSpriteNode
    
    public var size: CGSize {
        return self.calculateAccumulatedFrame().size
    }
    
    public init(sprite: SKSpriteNode) {
        self.sprite = sprite
        super.init()
        
        self.addChild(sprite)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
