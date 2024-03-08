//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 08/03/24.
//

import Foundation
import SpriteKit
import Combine

@available(iOS 13.0, *)
public class VirtualController: ObservableObject {
    
    private var analogNode: AnalogNode
    
    public init(scene: SKScene, analogRadius: CGFloat = 20) {
        analogNode = AnalogNode(radius: analogRadius)
        scene.addChild(analogNode)
        
        setup()
    }
    
    private func setup() {
        analogNode.zPosition = 999
    }
    
    public func createAnalogObserver(delegate: @escaping (CGPoint) -> Void) -> AnyCancellable {
        return analogNode.$direction.sink(receiveValue: delegate)
    }
    
    public func setEnable(value: Bool) {
        analogNode.isHidden = !value
    }
}
