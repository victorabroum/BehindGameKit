//
//  SKButtonNode.swift
//  
//
//  Created by Victor Vasconcelos on 15/03/20.
//

import Foundation
import SpriteKit

public class SKButtonNode: SKNode {
    
    public var buttonBackground: SKSpriteNode?
    public var buttonLabel: SKLabelNode?
    public var delegate: (()->Void)?
    
    public var clickedTexture: SKTexture?
    public var unClickedTexture: SKTexture?
    
    public var hasHapticFeedback: Bool = false
    
    private var isClicked: Bool = false {
        didSet {
            if isClicked {
                if let texture = clickedTexture {
                    buttonBackground?.run(.sequence([
                        .animate(with: [texture], timePerFrame: 1)
                    ]))
                }
            } else {
                if let texture = unClickedTexture {
                    buttonBackground?.run(.sequence([
                        .animate(with: [texture], timePerFrame: 1)
                    ]))
                }
            }
        }
    }
    
    public override init() {
        super.init()
        self.setupButtonNode()
    }
    
    public init(background: SKSpriteNode,
                label: SKLabelNode,
                clickedTexture: SKTexture? = nil,
                delegate: @escaping () -> Void) {
        self.buttonLabel = label
        self.buttonBackground = background
        self.delegate = delegate
        self.unClickedTexture = background.texture
        self.clickedTexture = clickedTexture
        super.init()
        self.addChild(buttonBackground!)
        self.addChild(buttonLabel!)
        self.setupButtonNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let bg = self.childNode(withName: "button bg") as? SKSpriteNode {
            bg.texture?.filteringMode = .nearest
            self.buttonBackground = bg
            self.unClickedTexture = bg.texture
            
            if let clickedTextureName = self.userData?["clickedTexture"] as? String {
                self.clickedTexture = .init(imageNamed: clickedTextureName)
            }
        }
        
        if let label = self.childNode(withName: "label") as? SKLabelNode {
            self.buttonLabel = label
        }
        
        self.setupButtonNode()
    }
    
    private func setupButtonNode() {
        self.isUserInteractionEnabled = true
    }
    
    
    #if os(iOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasHapticFeedback {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
        self.delegate?()
        isClicked = true
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isClicked = false
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isClicked = false
    }
    #elseif os(OSX)
    public override func mouseDown(with event: NSEvent) {
        self.delegate?()
        isClicked = true
    }
    public override func mouseUp(with event: NSEvent) {
        isClicked = false
    }
    #endif
    
    
}
