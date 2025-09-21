//
//  DebugOptions.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 21/09/25.
//

import SpriteKit
import SwiftUI

@available(macOS 11.0, *)
extension SpriteView.DebugOptions {
    public static var debugOptions: SpriteView.DebugOptions {
        #if DEBUG
        return [
            .showsDrawCount,
            .showsFPS,
            .showsNodeCount,
            .showsPhysics
        ]
        #else
        return []
        #endif
    }
}
