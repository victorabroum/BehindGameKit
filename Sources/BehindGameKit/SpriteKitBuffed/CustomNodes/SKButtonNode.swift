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
    
    public override init() {
        super.init()
        self.setupButtonNode()
    }
    
    public init(background: SKSpriteNode, label: SKLabelNode, delegate: @escaping () -> Void) {
        self.buttonLabel = label
        self.buttonBackground = background
        self.delegate = delegate
        super.init()
        self.addChild(buttonBackground!)
        self.addChild(buttonLabel!)
        self.setupButtonNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButtonNode()
    }
    
    private func setupButtonNode() {
        self.isUserInteractionEnabled = true
    }
    
    
    #if os(iOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?()
    }
    #elseif os(OSX)
    public override func mouseDown(with event: NSEvent) {
        self.delegate?()
    }
    #endif
    
    
}
