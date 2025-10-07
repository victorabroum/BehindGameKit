//
//  NodePreview.swift
//  BehindGameKit
//
//  Created by Victor Vasconcelos on 07/10/25.
//

import SwiftUI
import SpriteKit

@available(iOS 14.0, *)
public struct NodePreview: View {
    let node: SKNode
    let size: CGSize
    
    public init(_ node: SKNode, size: CGSize = .init(width: 1080, height: 1920)) {
        self.node = node
        self.size = size
    }
    
    public var body: some View {
        SpriteView(scene: makeScene())
            .ignoresSafeArea()
    }
    
    private func makeScene() -> SKScene {
        let scene = SKScene(size: size)
        scene.scaleMode = .aspectFill
        scene.anchorPoint = .centered
        scene.addChild(node)
        return scene
    }
}
