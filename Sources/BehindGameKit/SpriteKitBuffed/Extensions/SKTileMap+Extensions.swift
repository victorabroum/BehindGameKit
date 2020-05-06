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
}
