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
    
    private var lastTimeUpdated: TimeInterval = 0
    
    private var action: (() -> Void)?
    private var waitTime: TimeInterval = 2
    private var isRecursive: Bool = false
    
    override public init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Component System
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if (CACurrentMediaTime() - self.lastTimeUpdated > 2) {
            self.lastTimeUpdated = CACurrentMediaTime()
            if let action = action {
                action()
            }
        }
    }
    
    public func triggerAction(waitTime timeInterval: TimeInterval = 2, isRecursive recursive: Bool = false, action: (() -> Void)? = nil) {
        action?()
        self.action = action
        self.waitTime = timeInterval
        self.isRecursive = recursive
//        if recursive {
//            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
//                self.triggerAction(waitTime: timeInterval, isRecursive: recursive, action: action)
//            }
//        }
        
    }
}

