
#if os(iOS) || os(tvOS)
import UIKit
public typealias SetTouches = Set<UITouch>
public typealias UIEventAlias = UIEvent
#elseif os(macOS)
import AppKit
public typealias SetTouches = Set<NSTouch>
public typealias UIEventAlias = NSEvent
#endif
