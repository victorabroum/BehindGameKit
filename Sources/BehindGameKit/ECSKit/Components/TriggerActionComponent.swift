//
//  TriggerActionComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class TriggerActionComponent: GKComponent {
    
    override public init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Component System
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    public func triggerAction(waitTime timeInterval: TimeInterval = 2, isRecursive recursive: Bool = false, action: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            action?()
            if recursive {
                self.triggerAction(waitTime: timeInterval, isRecursive: recursive, action: action)
            }
        }
        
    }
    
}

