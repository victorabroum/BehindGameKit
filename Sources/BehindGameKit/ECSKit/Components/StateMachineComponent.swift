//
//  StateMachineComponent.swift
//  
//
//  Created by Victor Vasconcelos on 26/04/20.
//

import Foundation
import GameplayKit

public class StateMachineComponent: GKComponent {
    
    public var stateMachine: GKStateMachine
    
    public init(stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        self.stateMachine = GKStateMachine(states: [])
        super.init(coder: coder)
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
    }
    
}
