//
//  Gradients.swift
//  My Fishing Stocks
//
//


import SwiftUI

enum Gradients {
    case blue
    case tabBar
    case clear
    case buttonAdd
    case navBar
    
    var color: Gradient {
        switch self {
        case .blue:
            Gradient(colors: [.blue, .blue.opacity(0.9)])
        case .tabBar:
            Gradient(colors: [.gradient1, .gradient2])
        case .clear:
            Gradient(colors: [.clear, .clear])
        case .buttonAdd:
            Gradient(colors: [.buttonGradient1, .buttonGradient2])
        case .navBar:
            Gradient(colors: [.navBarGradient1, .navBarGradient2])

        }
    }
    
}
