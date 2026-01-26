import SwiftUI

enum Gradients {
    case blue
    case yellow
    case green
    case purple
    case red
    
    var color: Gradient {
        switch self {
        case .blue:
            Gradient(colors: [.blueTop, .blueBottom])
        case .yellow:
            Gradient(colors: [.yellowTop, .yellowBottom])
        case . green:
            Gradient(colors: [.greenTop, .greenBottom])
        case .purple:
            Gradient(colors: [.purpleTop, .purpleBottom])
        case .red:
            Gradient(colors: [.redTop, .redBottom])
        }
    }
    
}