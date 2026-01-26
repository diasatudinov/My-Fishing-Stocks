//
//  TopBarConfig.swift
//  My Fishing Stocks
//
//


import SwiftUI

struct TopBarConfig {
    var title: String
    var leading: BarItem? = nil

    struct BarItem: Identifiable {
        let id = UUID()
        var systemImage: String
        var action: () -> Void
    }
}
