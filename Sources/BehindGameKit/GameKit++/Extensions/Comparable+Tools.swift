//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 20/04/24.
//

import Foundation

public extension Comparable {
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
