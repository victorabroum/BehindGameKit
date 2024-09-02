//
//  SKTileMapNode+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 06/05/20.
//

import Foundation
import SpriteKit

public extension SKTileMapNode {
    func iterateTroughtTiles(_ action: (
        _ name: String,
        _ position: CGPoint,
        _ tileSize: CGSize) -> Void) {
        
        let tileSize = self.tileSize
        let halfWidth = CGFloat(self.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(self.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<self.numberOfColumns {
            for row in 0..<self.numberOfRows {
                let tileDefinition = self.tileDefinition(atColumn: col, row: row)
                
                let x = (CGFloat(col) * tileSize.width - halfWidth) + tileSize.width / 2
                let y = (CGFloat(row) * tileSize.height - halfHeight) + tileSize.height / 2
                
                if let isHidden = tileDefinition?.userData?["isHidden"] as? Bool,
                    isHidden {
                    tileDefinition?.size = .zero
                }
                
                if let name = tileDefinition?.userData?["name"] as? String {
                    action(name, .init(x: x, y: y), tileSize)
                }
            }
        }
    }
    
    func iterateTroughtTiles(physicsOnTilesNamed: [String], _ action: (
        _ name: String,
        _ position: CGPoint,
        _ tileSize: CGSize) -> Void) {
        
        let tileSize = self.tileSize
        let halfWidth = CGFloat(self.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(self.numberOfRows) / 2.0 * tileSize.height
        
        var tilesAmount: CGFloat = 0
        var initialPosition: CGPoint? = nil
        var tileName: String? = nil
        
        for row in 0..<self.numberOfRows {
            tilesAmount = 0
            tileName = nil
            initialPosition = nil
            for col in 0..<self.numberOfColumns {
                let tileDefinition = self.tileDefinition(atColumn: col, row: row)
                
                let x = (CGFloat(col) * tileSize.width - halfWidth) + tileSize.width / 2
                let y = (CGFloat(row) * tileSize.height - halfHeight) + tileSize.height / 2
                
                if let isHidden = tileDefinition?.userData?["isHidden"] as? Bool,
                    isHidden {
                    tileDefinition?.size = .zero
                }
                
                if let name = tileDefinition?.userData?["name"] as? String {
                    let pos: CGPoint = .init(x: x, y: y)
                    if physicsOnTilesNamed.contains(name) {
                        
                        if tileName == nil || tileName != name {
                            if let name = tileName {
                               addPhysicsOnTile(named: name, initialPosition: initialPosition, tilesAmount: tilesAmount, action)
                               tileName = nil
                               tilesAmount = 0
                               initialPosition = nil
                            }
                            tileName = name
                        }
                        
                        if initialPosition == nil {
                            initialPosition = pos
                        }
                        
                        tilesAmount += 1
                        
                    } else {
                        if let name = tileName {
                            addPhysicsOnTile(named: name, initialPosition: initialPosition, tilesAmount: tilesAmount, action)
                            tileName = nil
                            tilesAmount = 0
                            initialPosition = nil
                        }
                        action(name, .init(x: x, y: y), tileSize)
                    }
                } else {
                    if let name = tileName {
                        
                        addPhysicsOnTile(named: name, initialPosition: initialPosition, tilesAmount: tilesAmount, action)
                        
                        tileName = nil
                        tilesAmount = 0
                        initialPosition = nil
                    }
                }
            }
            
            if let name = tileName {
                addPhysicsOnTile(named: name, initialPosition: initialPosition, tilesAmount: tilesAmount, action)
            }
        }
    }
    
    private func addPhysicsOnTile(named: String,
                                  initialPosition: CGPoint?,
                                  tilesAmount: CGFloat,
                                  _ action: (
                                      _ name: String,
                                      _ position: CGPoint,
                                      _ tileSize: CGSize) -> Void) {
        if let initialPos = initialPosition, tilesAmount >= 1 {
            
            let size = CGSize(
                width: tilesAmount * tileSize.width,
                height: tileSize.height)
            
            let positionCorrected = CGPoint(
                x: initialPos.x + size.width/2 - tileSize.width/2,
                y: initialPos.y)
            
            action(named, positionCorrected, size)
        }
    }
}
