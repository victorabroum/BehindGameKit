//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 06/03/20.
//

import Foundation
import SpriteKit

public class GameDebug {
    public static func viewDebug(_ view: SKView, swithOn: Bool) {
        view.showsFPS = swithOn
        view.showsNodeCount = swithOn
        view.showsPhysics = swithOn
        view.showsFields = swithOn
        view.showsDrawCount = swithOn
        view.showsQuadCount = swithOn
    }
}
