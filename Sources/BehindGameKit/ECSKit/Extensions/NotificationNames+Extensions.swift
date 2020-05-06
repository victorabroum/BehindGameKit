//
//  NotificationNames+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 05/05/20.
//

import Foundation

public extension Notification.Name {
    // MARK: User interaction
    static let keyDownEvent = Notification.Name("keyDownEvent")
    static let keyUpEvent = Notification.Name("keyUpEvent")
    
    // MARK: Entity Manager
    static let removeEntityFromScene = Notification.Name("removeEntityFromScene")
    static let addEntityNotification = Notification.Name("addEntityNotification")
    
    // MARK: Physics delegate
    static let contactDidBegin = Notification.Name("contactDidBegin")
    static let contactDidEnd = Notification.Name("contactDidEnd")
}
