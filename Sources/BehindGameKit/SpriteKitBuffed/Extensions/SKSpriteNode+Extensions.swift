import Foundation
import SpriteKit


public extension SKSpriteNode {
    public convenience init(imageNamed: String, filteringMode: SKTextureFilteringMode) {
        self.init(imageNamed: imageNamed)
        self.texture?.filteringMode = filteringMode
    }
    
    #if os(iOS)
    public convenience init(image: UIImage, filteringMode: SKTextureFilteringMode) {
        self.init(texture: .init(image: image))
        self.texture?.filteringMode = filteringMode
    }
    #elseif os(macOS)
    public convenience init(image: NSImage, filteringMode: SKTextureFilteringMode) {
        self.init(texture: .init(image: image))
        self.texture?.filteringMode = filteringMode
    }
    #endif
}
