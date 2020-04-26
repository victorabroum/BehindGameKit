//
//  SpawnEntityComponent.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

@available(OSX 10.12, *)
public class SpawnEntityComponent: GKComponent {
    
    public var entitySpawned: GKEntity?
    public weak var entityManagerContext: SKEntityManager?
    
    override public init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func spawn(onParent parent: GKEntity? = nil,
                      changeEntityPosition delegate: ((SKNode)->Void)? = nil) {
        guard let entitySpawned = entitySpawned?.copy() as? GKEntity else { return }
        let node: SKNode?
        if (parent == nil) {
            node = entityManagerContext?.addGet(entitySpawned).component(ofType: GKSKNodeComponent.self)?.node
        } else {
            node = entityManagerContext?.addGet(entitySpawned, parentEntity: parent).component(ofType: GKSKNodeComponent.self)?.node
        }
        if node != nil { delegate?(node!) }
    }
}
