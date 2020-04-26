//
//  ListnerComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

@available(OSX 10.12, *)
public class ListnerComponent: GKComponent {
    
    var notificationName: Notification.Name
    @objc var delegate: (_ notification: Notification) -> Void
    
    public init(notificationName: Notification.Name, delegate: @escaping (_ notification: Notification) -> Void) {
        self.notificationName = notificationName
        self.delegate = delegate
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        self.notificationName = Notification.Name.init("")
        self.delegate = { notification in
        }
        super.init(coder: coder)
    }
    
    // Component System
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    override public func didAddToEntity() {
        NotificationCenter.default.addObserver(self, selector: #selector(selector(_:)), name: notificationName, object: nil)
    }
    
    @objc private func selector(_ notification: Notification) {
        delegate(notification)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
