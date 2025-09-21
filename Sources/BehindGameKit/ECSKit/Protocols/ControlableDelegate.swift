//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 06/03/24.
//

import Foundation

public protocol ControlableDelegate {
    func handleMovement(direction: CGPoint)
    func handleButtonAPressed()
    func handleButtonBPressed()
}
