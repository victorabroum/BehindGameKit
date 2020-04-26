//
//  TriggerActionComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

@available(OSX 10.12, *)
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
        if (CACurrentMediaTime() - self.lastTimeUpdated > waitTime) {
            self.lastTimeUpdated = CACurrentMediaTime()
            if isRecursive {
                action?()
            }
        }
    }
    
    public func triggerAction(waitTime timeInterval: TimeInterval = 2, isRecursive recursive: Bool = false, action: (() -> Void)? = nil) {
        self.action = action
        self.waitTime = timeInterval
        self.isRecursive = recursive
        self.lastTimeUpdated = 0
        if !recursive {
            action?()
        }
    }
    
    public func changeWaitTime(_ timeInterval: TimeInterval) {
        self.waitTime = timeInterval
    }
}

