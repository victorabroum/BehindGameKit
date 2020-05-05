//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation

public extension NotificationCenter {
    func postKeyUpEvent(_ keyCode: UInt16) {
        self.post(name: .keyUpEvent, object: nil, userInfo: ["keyCode" : keyCode])
    }
    
    func postKeyDownEvent(_ keyCode: UInt16) {
        self.post(name: .keyDownEvent, object: nil, userInfo: ["keyCode" : keyCode])
    }
}
