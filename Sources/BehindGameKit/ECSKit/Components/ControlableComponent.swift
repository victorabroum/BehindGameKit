//
//  ControlableComponent.swift
//  CozyFood
//
//  Created by Victor Vasconcelos on 06/03/24.
//

import Foundation
import GameplayKit
import SpriteKit
import Combine

@available(iOS 13.0, *)
public class ControlableComponent: GKComponent {
    
    var delegate: ControlableDelegate
    private var subscriptions = Set<AnyCancellable>()
    
    public init(delegate: ControlableDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupController(inputHandler: InputHandler) {
        subscriptions.insert(inputHandler.$directionAxis.sink(receiveValue: { [weak self] direction in
            self?.delegate.handleMovement(direction: direction)
        }))
        
        subscriptions.insert(inputHandler.$buttonAPressed.sink(receiveValue: { [weak self] isPressed in
            if isPressed {
                self?.delegate.handleButtonAPressed()
            }
        }))
    }
    
}
