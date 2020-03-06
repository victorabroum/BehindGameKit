//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 06/03/20.
//

import Foundation
import SpriteKit

public class GameStateController {
    public static var isPaused: Bool = false
    
    public static func pauseGame(_ scene: SKScene, isPaused: Bool = true) {
        GameStateController.isPaused = isPaused
        scene.isPaused = isPaused
    }
}
