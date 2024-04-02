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
    
    private var analogNode: BKAnalogNode
    
    public init(scene: SKScene, analogRadius: CGFloat = 20) {
        analogNode = BKAnalogNode(radius: analogRadius)
        
        if (scene.camera != nil) {
            scene.camera?.addChild(analogNode)
        } else {        
            scene.addChild(analogNode)
        }
        
        setup(scene: scene)
    }
    
    private func setup(scene: SKScene) {
        analogNode.zPosition = 999
        
        // Position
        guard let sceneSize = scene.view?.frame.size else { return }
        let analogSize = analogNode.calculateAccumulatedFrame().size
        analogNode.position.x = -sceneSize.width/2 + analogSize.width + sceneSize.width/8
        analogNode.position.y = -sceneSize.height/2 + analogSize.height + sceneSize.height/8
    }
    
    public func createAnalogObserver(delegate: @escaping (CGPoint) -> Void) -> AnyCancellable {
        return analogNode.$direction.sink(receiveValue: delegate)
    }
    
    public func setAnalogVisible(value: Bool, withDuration duration: TimeInterval = 0) {
        analogNode.setVisible(value: value, withDuration: duration)
    }
    
    public func changePosition(_ position: CGPoint) {
        analogNode.position = position
    }
    
    public func getAnalogSize() -> CGSize {
        return analogNode.calculateAccumulatedFrame().size
    }
    
    public func touchBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        analogNode.touchesBegan(touches, with: event)
    }
    
    public func touchMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        analogNode.touchesMoved(touches, with: event)
    }
    
    public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        analogNode.touchesEnded(touches, with: event)
    }
    
    public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        analogNode.touchesCancelled(touches, with: event)
    }
}
