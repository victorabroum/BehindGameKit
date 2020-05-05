//
//  MoveProtocol.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation

public protocol MoveProtocol {
    
    func leftDelegate() -> Void
    func rightDelegate() -> Void
    func upDelegate() -> Void
    func downDelegate() -> Void
    
    func stopMoving(dx: Bool, dy: Bool) -> Void
}
