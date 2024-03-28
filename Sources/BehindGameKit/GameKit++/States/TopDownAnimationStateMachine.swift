//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 25/03/24.
//

import Foundation
import GameplayKit

public class TopDownAnimationStateMachine: GKStateMachine {
    
    var sideState: GKState.Type
    var upState: GKState.Type
    var downState: GKState.Type
    
    public init(sideState: GKState,
         upState: GKState,
         downState: GKState, otherStates: [GKState] = []) {
        self.sideState = type(of: sideState)
        self.upState = type(of: upState)
        self.downState = type(of: downState)
        var states = otherStates
        states.append(contentsOf: [
            sideState,
            upState,
            downState
        ])
        super.init(states: states)
    }
    
    public func handleDirection(_ direction: CGPoint) {
        if (abs(direction.x) + 0.1) > abs(direction.y) {
            // Move Sides
            self.enter(sideState)
        } else {
            // Move up or Down
            if (direction.y <= 0) {
                self.enter(downState)
            } else {
                self.enter(upState)
            }
        }
    }
}
