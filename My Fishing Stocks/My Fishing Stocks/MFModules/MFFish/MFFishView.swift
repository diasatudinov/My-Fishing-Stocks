//
//  MFFishView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFFishView: View {
    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "Профиль",
                leading: .init(systemImage: "arrow.left", action: { print("back") })
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(.fishIconMF)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                        .padding(.horizontal, 50)
                    
                    
                }
                .padding(.bottom, 150)
            }
        }
        .background(
            Image(.appBgMF)
                .resizable()
                .scaledToFill()
        )
    }
}

#Preview {
    MFFishView()
}
