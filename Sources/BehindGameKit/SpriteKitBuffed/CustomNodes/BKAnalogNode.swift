//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 07/03/24.
//

import Foundation
import SpriteKit

public class BKAnalogNode: SKNode, ObservableObject {
    
    var background: SKShapeNode
    var knob: SKShapeNode
    
    @Published public var direction: CGPoint = .zero
    
    public init(radius: CGFloat = 20) {
        background = SKShapeNode(circleOfRadius: radius)
        knob = SKShapeNode(circleOfRadius: radius - 5)
        super.init()
        
        self.addChild(background)
        self.addChild(knob)
        
        setup()
        
        self.isUserInteractionEnabled = true
    }
    
    private func setup() {
        background.zPosition = -10
        knob.zPosition = 5
        
        background.alpha = 0.5
        
        knob.fillColor = .white
        background.fillColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func touchesBeganAlias(_ touches: SetTouches, with event: UIEventAlias?) {
        
        let location = getLocation(touches: touches, from: event)
        
        moveKnob(location: location)
        self.removeAction(forKey: "setEnable")
        self.run(.fadeAlpha(to: 1, duration: 0))
    }
    
    public func touchesMovedAlias(_ touches: SetTouches, with event: UIEventAlias?) {
        let location = getLocation(touches: touches, from: event)
        moveKnob(location: location)
    }
    
    public func touchesEndedAlias(_ touches: SetTouches, with event: UIEventAlias?) {
        moveKnob(location: .zero)
        setVisible(value: false, withDuration: 0.6)
    }
    
    public func touchesCancelledAlias(_ touches: SetTouches, with event: UIEventAlias?) {
        moveKnob(location: .zero)
        setVisible(value: false, withDuration: 0.6)
    }
    
    private func moveKnob(location: CGPoint) {
        
        let center = background.position
        let distance = location.distance(to: center)
        let radius = abs(background.frame.width / 2 - knob.frame.width)
        
        if distance <= radius || location == .zero {
            knob.run(.move(to: location, duration: 0.1))
        } else {
            let angle = atan2(location.y - center.y, location.x - center.x)
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            let correctPosition = CGPoint(x: x, y: y)
            knob.run(.move(to: correctPosition, duration: 0.1))
        }
        
        direction = location.normalized()

    }
    
    public func setVisible(value: Bool, withDuration duration: TimeInterval = 0) {
        self.removeAllActions()
        self.run(.fadeAlpha(to: value ? 1 : 0, duration: duration), withKey: "setEnable")
    }
    
    private func getLocation(touches: SetTouches, from event: UIEventAlias?) -> CGPoint {
        #if os(iOS)
        guard let location = touches.first?.location(in: self) else { return .zero }
        #elseif os(macOS)
        guard let location = event?.location(in: self) else { return .zero }
        #endif
        
        return location
    }
}

extension BKAnalogNode {
    
    #if os(macOS)
    public override func touchesBegan(with event: NSEvent) {
        self.touchesBeganAlias(.init(), with: event)
    }
    public override func touchesEnded(with event: NSEvent) {
        self.touchesEndedAlias(.init(), with: event)
    }
    public override func touchesMoved(with event: NSEvent) {
        self.touchesMovedAlias(.init(), with: event)
    }
    public override func touchesCancelled(with event: NSEvent) {
        self.touchesCancelledAlias(.init(), with: event)
    }
    #elseif os(iOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesBeganAlias(touches, with: event)
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMovedAlias(touches, with: event)
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEndedAlias(touches, with: event)
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesCancelledAlias(touches, with: event)
    }
    #endif
}
