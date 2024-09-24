//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 02/09/24.
//

import Foundation
import SpriteKit

#if os(iOS)
public class DraggableNode: SKNode {
    
    public var isDragging: Bool = false
    
    public override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setIsDragging(true)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging else { return }
        guard let scene = self.scene, let location = touches.first?.location(in: scene) else { return }
        self.run(.move(to: location, duration: 0.15))
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setIsDragging(false)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        setIsDragging(false)
    }
    
    private func setIsDragging(_ value: Bool) {
        isDragging = value
        if isDragging {
            self.setScale(self.xScale + 0.2)
        } else {
            self.setScale(self.xScale - 0.2)
        }
    }
    
}
#endif
