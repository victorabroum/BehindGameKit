//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 20/04/24.
//

import Foundation

public extension TimeInterval {
    public static func calculateTravelTime(speed: CGFloat, distance: CGFloat) -> TimeInterval {
        return distance / speed
    }
}
