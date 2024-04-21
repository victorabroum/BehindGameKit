//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 20/04/24.
//

import Foundation
import SpriteKit

public extension SKScene {
    
    public func blackCircularTransitionIn(withDuration: TimeInterval, 
                                          completion: @escaping () -> Void) {
        
        blackCircularTransition(isEnter: true, withDuration: withDuration, completion: completion)
    }
    
    public func blackCircularTransitionOut(withDuration: TimeInterval,
                                          completion: @escaping () -> Void) {
        
        blackCircularTransition(isEnter: false, withDuration: withDuration, completion: completion)
    }
    
    
    private func blackCircularTransition(isEnter: Bool, withDuration: TimeInterval,
                                         completion: @escaping () -> Void) {
        
        
        let blackCircular = SKShapeNode(circleOfRadius: self.size.width)
        
        if self.camera != nil {
            self.camera?.addChild(blackCircular)
        } else {        
            self.addChild(blackCircular)
        }
        
        blackCircular.strokeColor = .clear
        blackCircular.fillColor = .black
        blackCircular.zPosition = .infinity
        blackCircular.setScale(isEnter ? 1 : 0)
        
        blackCircular.run(.sequence([
            .scale(to: isEnter ? 0 : 1, duration: withDuration),
            .run(completion)
        ]))
        
    }
    
}
