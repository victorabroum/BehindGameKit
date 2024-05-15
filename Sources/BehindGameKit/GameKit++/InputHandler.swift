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
}
