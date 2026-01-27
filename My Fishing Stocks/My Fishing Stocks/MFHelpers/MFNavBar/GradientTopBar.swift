//
//  GradientTopBar.swift
//  My Fishing Stocks
//
//

import SwiftUI

///Example:
///ScreenContainer(
///    topBar: .init(
///        title: "Профиль",
///        leading: .init(systemImage: "arrow.left", action: { /print("back") })
///    )
///) {
///    List {
///        Text("Контент профиля")
///    }
///}

struct GradientTopBar: View {
    let config: TopBarConfig

    var body: some View {
        HStack(spacing: 12) {
            if let leading = config.leading {
                barButton(leading)
            } else {
                Color.clear.frame(width: 44, height: 44)
            }
            
            Text(config.title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal, 16)
        .background(Gradients.navBar.color)
    }

    @ViewBuilder
    private func barButton(_ item: TopBarConfig.BarItem) -> some View {
        Button(action: item.action) {
            Image(systemName: item.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
        }
    }
}
