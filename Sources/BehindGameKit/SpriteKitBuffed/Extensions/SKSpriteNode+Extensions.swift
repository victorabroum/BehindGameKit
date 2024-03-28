import Foundation
import SpriteKit


public extension SKSpriteNode {
    public convenience init(imageNamed: String, filteringMode: SKTextureFilteringMode) {
        self.init(imageNamed: imageNamed)
        self.texture?.filteringMode = filteringMode
    }
}
