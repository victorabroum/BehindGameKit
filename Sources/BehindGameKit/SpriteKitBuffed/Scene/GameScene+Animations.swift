//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 18/05/24.
//

import Foundation
import SpriteKit

public extension SKGameScene {
    
    public func cameraShake(duration: TimeInterval) {
        self.isCameraShaking = true
        self.camera?.run(.shake(duration: duration, amplitudeX: 1, amplitudeY: 1)) { [weak self] in
            self?.isCameraShaking = false
        }
    }
    
}
