//
//  SKGameScene.swift
//  
//
//  Created by Victor Vasconcelos on 06/05/20.
//

import Foundation
import SpriteKit
import Combine

open class SKGameScene: SKScene {
    
    public var lastUpdateTime : TimeInterval = 0
    public var virtualController: VirtualController?
    public var inputHandler = InputHandler()
    public var subscriptions = Set<AnyCancellable>()
    public var isCameraShaking: Bool = false

    open override var isPaused: Bool {
        didSet {
            if isPaused {
                lastUpdateTime = 0
            }
        }
    }
    
    open override func sceneDidLoad() {
        self.lastUpdateTime = 0
        SKEntityManager.shared.start(inScene: self)
        inputHandler.observeGameController()
        
        let camera = SKCameraNode()
        addChild(camera)
        self.camera = camera
    }
    
    open func setupVirtualController() {
        virtualController = .init(scene: self, analogRadius: 25)
        virtualController?.setAnalogVisible(value: false)
    }
    
    open override func didMove(to view: SKView) {
        
    }
    
    open override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        SKEntityManager.shared.update(dt)
        
        self.lastUpdateTime = currentTime
    }
    
    #if os(iOS)
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera, let location = touches.first?.location(in: camera) else { return }
        
        if location.x <= 0 {
            virtualController?.setAnalogVisible(value: true)
            virtualController?.changePosition(location)
            virtualController?.touchBegan(touches, with: event)
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera, let location = touches.first?.location(in: camera) else { return }
        
        if location.x <= 0 {
            virtualController?.touchMoved(touches, with: event)
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera, 
                let location = touches.first?.location(in: camera),
              location.x <= 0 else { return }
        virtualController?.touchesEnded(touches, with: event)
        virtualController?.setAnalogVisible(value: false, withDuration: 0.6)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera,
                let location = touches.first?.location(in: camera),
              location.x <= 0 else { return }
        virtualController?.touchesCancelled(touches, with: event)
        virtualController?.setAnalogVisible(value: false, withDuration: 0.6)
    }
    #endif
}
