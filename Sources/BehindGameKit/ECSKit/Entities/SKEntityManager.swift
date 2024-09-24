//
//  SKEntityManager.swift
//  
//
//  Created by Victor Vasconcelos on 05/03/20.
//

import Foundation
import GameplayKit
import SpriteKit

public class SKEntityManager {
    
    /// Set of All entities in game, this should the only place of the entity is strong reference
    private(set) var entities = Set<GKEntity>()
    
    /// Set for control entities to remove
    private var toRemove = Set<GKEntity> ()
    
    /// Instance for scene where the entity manager will act
    private weak var scene: SKScene?
    
    /// All components systems
    // Insert any entity that needs updating here as a GKComponentSystem
    lazy private var componentSystems: [GKComponentSystem] = {
        return [ ]
    }()
    
    public static var shared = SKEntityManager()

    private init() { }
    
    public func start(inScene scene: SKScene) {
        entities = Set<GKEntity>()
        toRemove = Set<GKEntity>()
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
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node, node.parent == nil {
            
            if let parentNode = parentEntity?.component(ofType: GKSKNodeComponent.self)?.node {
                parentNode.addChild(node)
            } else if let scene = scene {
                scene.addChild(node)
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
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node, node.parent == nil {
            
            if let parentNode = parentEntity?.component(ofType: GKSKNodeComponent.self)?.node {
                parentNode.addChild(node)
            } else if let scene = scene {
                scene.addChild(node)
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
    
    public func addComponentSystem(_ componentSystem: GKComponentSystem<GKComponent>) {
        if !(componentSystems.contains(componentSystem)) {
            componentSystems.append(componentSystem)
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
    
    public func getEntities(ofType type: GKComponent.Type) -> Set<GKEntity> {
        return entities.filter { $0.component(ofType: type) != nil }
    }
    
    public func getEntitiesWithComponent<T>(ofType type: T.Type) -> [T] where T : GKComponent {
        var result: [T] = []
        
        for entity in entities {
            if let comp  = entity.component(ofType: type.self) {
                result.append(comp)
            }
        }
        
        return result
    }
    
    public func getFirstEntityWithComponent<ComponentType>(offType type: ComponentType.Type) -> ComponentType? where ComponentType: GKComponent {
        let entity = entities.first(where: {$0.component(ofType: type.self) != nil})
        return entity?.component(ofType: type.self)
    }
    
    public func getFirstEntity<EntityType>(ofType: EntityType.Type) -> EntityType? where EntityType : GKEntity {
        
        return entities.first { type(of: $0) == ofType } as? EntityType
    }
}
