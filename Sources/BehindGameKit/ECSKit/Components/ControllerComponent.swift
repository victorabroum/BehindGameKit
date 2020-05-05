//
//  ControllerComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation
import GameplayKit

public class ControllerComponent: GKComponent {
    
    public var upFunctions: Set<UInt16> = []
    public var downFunctions: Set<UInt16> = []
    public var leftFunctions: Set<UInt16> = []
    public var rightFunctions: Set<UInt16> = []
    
    override public init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didKeyDownEvent(_:)), name: .keyDownEvent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didKeyUpEvent(_:)), name: .keyUpEvent, object: nil)
    }
    
    public var isEnableGamerMovement: Bool = true {
        didSet {
            if (isEnableGamerMovement) {
                upFunctions.insert(.w)
                downFunctions.insert(.s)
                rightFunctions.insert(.d)
                leftFunctions.insert(.a)
            } else {
                upFunctions.remove(.w)
                downFunctions.remove(.s)
                rightFunctions.remove(.d)
                leftFunctions.remove(.a)
            }
        }
    }
    
    public var isEnableArrowMovement: Bool = true {
        didSet {
            if (isEnableGamerMovement) {
                upFunctions.insert(.upArrow)
                downFunctions.insert(.downArrow)
                rightFunctions.insert(.rightArrow)
                leftFunctions.insert(.leftArrow)
            } else {
                upFunctions.remove(.upArrow)
                downFunctions.remove(.downArrow)
                rightFunctions.remove(.rightArrow)
                leftFunctions.remove(.leftArrow)
            }
        }
    }
    
    @objc private func didKeyDownEvent(_ notification: Notification) {
        guard let keyCode = notification.userInfo?["keyCode"] as? UInt16 else { return }
        
        if (leftFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.leftDelegate()
        } else if (rightFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.rightDelegate()
        } else if (upFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.upDelegate()
        } else if (downFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.downDelegate()
        }
    }
    
    @objc private func didKeyUpEvent(_ notification: Notification) {
        guard let keyCode = notification.userInfo?["keyCode"] as? UInt16 else { return }
        
        if (leftFunctions.contains(keyCode) || rightFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.stopMoving(dx: true)
        }
        
        if (upFunctions.contains(keyCode) || downFunctions.contains(keyCode)) {
            self.entity?.component(ofType: MoveComponent.self)?.stopMoving(dy: true)
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func didAddToEntity() {
         isEnableGamerMovement = true
         isEnableArrowMovement = true
    }
}
