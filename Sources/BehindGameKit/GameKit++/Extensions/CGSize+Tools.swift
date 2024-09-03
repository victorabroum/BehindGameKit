//
//  File.swift
//
//
//  Created by Victor Vasconcelos on 29/05/24.
//

import Foundation

public extension CGSize {
    // Adição
    static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    
    static func += (left: inout CGSize, right: CGSize) {
        left = left + right
    }
    
    // Soma Escalar
    static func + (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width + scalar, height: size.height + scalar)
    }
    
    static func + (scalar: CGFloat, size: CGSize) -> CGSize {
        return size + scalar
    }
    
    // Subtração
    static func - (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width - right.width, height: left.height - right.height)
    }
    
    static func -= (left: inout CGSize, right: CGSize) {
        left = left - right
    }
    
    // Multiplicação
    static func * (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width * right.width, height: left.height * right.height)
    }
    
    static func *= (left: inout CGSize, right: CGSize) {
        left = left * right
    }
    
    // Divisão
    static func / (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width / right.width, height: left.height / right.height)
    }
    
    static func /= (left: inout CGSize, right: CGSize) {
        left = left / right
    }
    
    // Multiplicação Escalar
    static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }
    
    static func * (scalar: CGFloat, size: CGSize) -> CGSize {
        return size * scalar
    }
    
    static func *= (size: inout CGSize, scalar: CGFloat) {
        size = size * scalar
    }
    
    // Divisão Escalar
    static func / (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width / scalar, height: size.height / scalar)
    }
    
    static func /= (size: inout CGSize, scalar: CGFloat) {
        size = size / scalar
    }
    
}
