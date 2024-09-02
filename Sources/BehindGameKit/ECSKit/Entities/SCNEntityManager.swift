//
//  SCNEntityManager.swift
//  
//
//  Created by Victor Vasconcelos on 20/06/23.
//

import Foundation
import GameplayKit
import SceneKit

public class SCNEntityManager {
    
    /// Set of All entities in game, this should the only place of the entity is strong reference
    private(set) var entities = Set<GKEntity>()
    
    /// Set for control entities to remove
    private var toRemove = Set<GKEntity> ()
    
    /// Instance for scene where the entity manager will act
    private weak var scene: SCNScene?
    
    /// All components systems
    // Insert any entity that needs updating here as a GKComponentSystem
    lazy private var componentSystems: [GKComponentSystem] = {
        return [ ]
    }()

    public init(_ scene: SCNScene) {
        self.scene = scene
    }
    
    /// To Add an Entity
    public func add(_ entity: GKEntity, parentEntity: GKEntity? = nil) {
        
        self.entities.insert(entity)
        
        // Add rigth components systems
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        // If has SpriteComponent, so it's rendered on Scene
        if let node = entity.component(ofType: GKSCNNodeComponent.self)?.node, node.parent == nil {
            
            if let parentNode = parentEntity?.component(ofType: GKSCNNodeComponent.self)?.node {
                parentNode.addChildNode(node)
            } else if let scene = scene {
                scene.rootNode.addChildNode(node)
            }
        }
    }
    
    public func add(_ entities: [GKEntity]) {
        for entity in entities {
            self.add(entity)
        }
    }
    
    /// To Add an Entity
    public func addGet(_ entity: GKEntity, parentEntity: GKEntity? = nil) -> GKEntity {
        
        self.entities.insert(entity)
        
        // Add rigth components systems
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        // If has SpriteComponent, so it's rendered on Scene
        if let node = entity.component(ofType: GKSCNNodeComponent.self)?.node, node.parent == nil {
            
            if let parentNode = parentEntity?.component(ofType: GKSCNNodeComponent.self)?.node {
                parentNode.addChildNode(node)
            } else if let scene = scene {
                scene.rootNode.addChildNode(node)
            }
        }
        
        return entity
    }
    
    /// To Remove an Entity
    public func remove(_ entity: GKEntity) {
        self.toRemove.insert(entity)
    }
    
    /// To remove all entities
    public func removeAll() {
        for entity in self.entities {
            self.toRemove.insert(entity)
        }
    }
    
    public func update(_ deltaTime: CFTimeInterval) {
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }
        
        // Update Components in System
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        // Remove right component
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
            entities.remove(currentRemove)
        }
        toRemove.removeAll()
    }
    
    public func getAllEntities() -> Set<GKEntity> {
        return self.entities
    }
}
