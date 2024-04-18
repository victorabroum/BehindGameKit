import Foundation
import SpriteKit

public class TileSheetCropper {
    
    public static func cropSpriteSheet(
        imageNamed: String,
        rows: Int, columns: Int,
        filteringMode: SKTextureFilteringMode = .nearest) -> [SKTexture] {
            var sprites: [SKTexture] = []
#if os(macOS)
            
            guard let image = NSImage(named: imageNamed) else {
                return sprites
            }
            
            guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
                return sprites
            }
            
            let spriteWidth = cgImage.width / columns
            let spriteHeight = cgImage.height / rows
            
            for row in 0..<rows {
                for col in 0..<columns {
                    let xOffset = col * spriteWidth
                    let yOffset = row * spriteHeight
                    
                    let rect = CGRect(x: xOffset, y: yOffset, width: spriteWidth, height: spriteHeight)
                    if let croppedImage = cgImage.cropping(to: rect) {
                        let sprite = NSImage(cgImage: croppedImage, size: NSSize(width: spriteWidth, height: spriteHeight))
                        let texture = SKTexture(image: sprite)
                        texture.filteringMode = filteringMode
                        sprites.append(texture)
                    }
                }
            }
            
            return sprites
#elseif os(iOS)
            
            guard let image = UIImage(named: imageNamed) else { return sprites }
            
            let spriteWidth = image.size.width / CGFloat(columns)
            let spriteHeight = image.size.height / CGFloat(rows)
            
            for row in 0..<rows {
                for col in 0..<columns {
                    let xOffset = CGFloat(col) * spriteWidth
                    let yOffset = CGFloat(row) * spriteHeight
                    
                    let rect = CGRect(x: xOffset, y: yOffset, width: spriteWidth, height: spriteHeight)
                    let croppedImage = image.cgImage?.cropping(to: rect)
                    
                    if let croppedImage = croppedImage {
                        let sprite = UIImage(cgImage: croppedImage)
                        let texture = SKTexture(image: sprite)
                        texture.filteringMode = filteringMode
                        sprites.append(texture)
                    }
                }
            }
            
            return sprites
#endif
        }
}
