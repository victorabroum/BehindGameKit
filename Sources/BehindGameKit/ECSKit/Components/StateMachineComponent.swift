//
//  StateMachineComponent.swift
//  
//
//  Created by Victor Vasconcelos on 26/04/20.
//

import Foundation
import GameplayKit

@available(OSX 10.12, *)
public class StateMachineComponent: GKComponent {
    
    public var stateMachine: GKStateMachine
    
    init(stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self.stateMachine = GKStateMachine(states: [])
        super.init(coder: coder)
    }
    
}
