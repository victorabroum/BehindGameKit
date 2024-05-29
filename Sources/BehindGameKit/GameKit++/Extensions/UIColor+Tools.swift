//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 29/05/24.
//

import Foundation

#if os(iOS)
import UIKit

public extension UIColor {
    public static func random() -> UIColor {
        return [
            UIColor.green,
            UIColor.gray,
            UIColor.white,
            UIColor.red,
            UIColor.yellow,
            UIColor.blue,
            UIColor.black,
            UIColor.cyan,
            UIColor.systemPink,
            UIColor.purple,
            UIColor.magenta,
        ].randomElement()!
    }
}
#endif
