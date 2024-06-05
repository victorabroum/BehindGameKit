import Foundation
import SpriteKit


public extension SKSpriteNode {
    public convenience init(imageNamed: String, filteringMode: SKTextureFilteringMode) {
        self.init(imageNamed: imageNamed)
        self.texture?.filteringMode = filteringMode
    }
    
    #if os(iOS) || os(tvOS)
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
    
    public func addShadow() {
        let shadow = SKShapeNode(circleOfRadius: self.size.width/3)
        shadow.fillColor = .black
        shadow.strokeColor = .clear
        shadow.alpha = 0.3
        shadow.zPosition -= 2
        addChild(shadow)
    }
}
