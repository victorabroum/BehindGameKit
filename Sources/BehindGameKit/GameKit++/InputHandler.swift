//
//  InputHandler.swift
//  CozyFood
//
//  Created by Victor Vasconcelos on 06/03/24.
//

import Foundation
import GameKit

public class InputHandler: ObservableObject {
    
    @Published public var directionAxis: CGPoint = .zero
    
    @Published public var buttonAPressed: Bool = false
    @Published public var buttonBPressed: Bool = false
    
    @Published public var isConnected: Bool = false
    
    public init() { }
    
    public func observeGameController() {
        NotificationCenter.default.addObserver(self, selector: #selector(didConnectController), name: .GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisconnectController), name: .GCControllerDidDisconnect, object: nil)
    }
    
    @objc func didConnectController() {
        
        for controller in GCController.controllers() {
            if controller.extendedGamepad != nil {
                controller.playerIndex = .index1
                setupGameController(controller)
            }
        }
        
    }
    
    @objc func didDisconnectController() {
        isConnected = false
    }
    
    private func setupGameController(_ controller: GCController) {
        isConnected = true
        controller.extendedGamepad?.valueChangedHandler = {[weak self] (gamepad: GCExtendedGamepad, element: GCControllerElement) in
            
            guard let self else { return }
            
            self.inputDetected(gamepad: gamepad, element: element, index: controller.playerIndex.rawValue)
            
            gamepad.buttonA.pressedChangedHandler = { (bt: GCControllerButtonInput, value: Float, isPressed: Bool) in
                self.buttonAPressed = isPressed
            }
            
            gamepad.buttonB.pressedChangedHandler = { (bt: GCControllerButtonInput, value: Float, isPressed: Bool) in
                self.buttonAPressed = isPressed
            }
            
        }
    }
    
    public func inputDetected(gamepad: GCExtendedGamepad, element: GCControllerElement, index: Int) {
        
        if (gamepad.leftThumbstick == element) {
            
            let xAxis = gamepad.leftThumbstick.xAxis.value // Horizontal Input
            let yAxis = gamepad.leftThumbstick.yAxis.value // Vertical Input
            
            let axis = CGPoint(x: CGFloat(xAxis), y: CGFloat(yAxis))
            
            self.directionAxis = axis
        }
    }
    
    // MARK: Observe Keyboard Inputs
    
    private var keyDownMonitor: Any?
    private var keyUpMonitor: Any?
    private var keysPressed: Set<UInt16> = []
    
    public func observeKeyboardInputs() {
        keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: { [weak self] event in
            self?.handleKey(event: event, isPressed: true)
            return nil
        })
        
        keyUpMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyUp, handler: { [weak self] event in
            self?.handleKey(event: event, isPressed: false)
            return nil
        })
    }
    
    private func handleKey(event: NSEvent, isPressed: Bool) {
        
        
        if isPressed {
            keysPressed.insert(event.keyCode)
        } else {
            keysPressed.remove(event.keyCode)
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if keysPressed.contains(0) || keysPressed.contains(123) { x -= 1 } // A ou ←
        if keysPressed.contains(2) || keysPressed.contains(124) { x += 1 } // D ou →
        if keysPressed.contains(13) || keysPressed.contains(126) { y += 1 } // W ou ↑
        if keysPressed.contains(1) || keysPressed.contains(125) { y -= 1 } // S ou ↓
        
        directionAxis = CGPoint(x: x, y: y)
        
        // Botões
        buttonAPressed = keysPressed.contains(49) // Space
        buttonBPressed = keysPressed.contains(6) // Z Keyboard
    }
}
