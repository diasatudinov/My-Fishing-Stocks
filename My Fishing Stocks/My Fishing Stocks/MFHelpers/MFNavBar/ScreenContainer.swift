//
//  ScreenContainer.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct ScreenContainer<Content: View>: View {
    let topBar: TopBarConfig
    let content: Content

    init(topBar: TopBarConfig, @ViewBuilder content: () -> Content) {
        self.topBar = topBar
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            GradientTopBar(config: topBar)

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
